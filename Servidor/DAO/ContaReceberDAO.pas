unit ContaReceberDAO;

interface

uses
  DBXCommon, SqlExpr, BaseDAO, ContaReceber, SysUtils;

type
  TContaReceberDAO = class(TBaseDAO)
  public
    function List: TDBXReader;
    function Insert(ContaReceber: TContaReceber): Boolean;
    function Update(ContaReceber: TContaReceber): Boolean;
    function Delete(ContaReceber: TContaReceber): Boolean;
    function BaixarConta(ContaReceber: TContaReceber): Boolean;
    function Relatorio(DataInicial, DataFinal: TDateTime; ClienteCodigo: string; Situacao: Integer): TDBXReader;
  end;


implementation

uses uSCPrincipal, StringUtils;

{ TClienteDAO }

function TContaReceberDAO.List: TDBXReader;
begin
  PrepareCommand;
  FComm.Text := 'SELECT C.ID, C.CLIENTE_CODIGO, L.NOME, C.NOME_CLIENTE_AVULSO, C.VENCIMENTO, C.VALOR, C.OBSERVACOES, C.BAIXADA '+
                'FROM CONTAS_RECEBER C '+
                'LEFT JOIN CLIENTES L ON L.CODIGO = C.CLIENTE_CODIGO '+
                'WHERE C.BAIXADA = 0 '+
                'ORDER BY C.VENCIMENTO, C.CLIENTE_CODIGO';
  Result := FComm.ExecuteQuery;
end;

function TContaReceberDAO.Relatorio(DataInicial, DataFinal: TDateTime; ClienteCodigo: string; Situacao: Integer): TDBXReader;
begin
  PrepareCommand;
  FComm.Text := 'SELECT C.ID, C.CLIENTE_CODIGO, L.NOME, C.NOME_CLIENTE_AVULSO, C.VENCIMENTO, C.VALOR, C.OBSERVACOES, C.BAIXADA '+
                'FROM CONTAS_RECEBER C '+
                'LEFT JOIN CLIENTES L ON L.CODIGO = C.CLIENTE_CODIGO '+
                'WHERE C.ID <> 0 ';

  if DataInicial <> 0 then
    FComm.Text := FComm.Text + 'AND CONVERT(CHAR(8), C.VENCIMENTO, 112) >= '+FormatDateTime('yyyymmdd', DataInicial)+' ';

  if DataFinal <> 0 then
    FComm.Text := FComm.Text + 'AND CONVERT(CHAR(8), C.VENCIMENTO, 112) <= '+FormatDateTime('yyyymmdd', DataFinal)+' ';

  if ClienteCodigo <> '' then
    FComm.Text := FComm.Text + 'AND C.CLIENTE_CODIGO = '''+ClienteCodigo+''' ';

  if Situacao = 1 then
    FComm.Text := FComm.Text + 'AND C.BAIXADA = 0 ';

  if Situacao = 2 then
    FComm.Text := FComm.Text + 'AND C.BAIXADA = 1 ';

  FComm.Text := FComm.Text + 'ORDER BY C.VENCIMENTO, C.CLIENTE_CODIGO';

  Result := FComm.ExecuteQuery;
end;

function TContaReceberDAO.Insert(ContaReceber: TContaReceber): Boolean;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    //
    if ContaReceber.Cliente <> nil then
    begin
      query.SQL.Text := 'INSERT INTO CONTAS_RECEBER (CLIENTE_CODIGO, VENCIMENTO, VALOR, OBSERVACOES, BAIXADA) VALUES (:CLIENTE_CODIGO, :VENCIMENTO, :VALOR, :OBSERVACOES, :BAIXADA)';
      query.ParamByName('CLIENTE_CODIGO').AsString := ContaReceber.Cliente.Codigo;
    end
    else
    begin
      query.SQL.Text := 'INSERT INTO CONTAS_RECEBER (NOME_CLIENTE_AVULSO, VENCIMENTO, VALOR, OBSERVACOES, BAIXADA) VALUES (:NOME_CLIENTE_AVULSO, :VENCIMENTO, :VALOR, :OBSERVACOES, :BAIXADA)';
      query.ParamByName('NOME_CLIENTE_AVULSO').AsString := ContaReceber.NomeClienteAvulso;
    end;

    query.ParamByName('VENCIMENTO').AsDateTime := ContaReceber.Vencimento;
    query.ParamByName('VALOR').AsCurrency      := ContaReceber.Valor;
    query.ParamByName('OBSERVACOES').AsString  := ContaReceber.Observacoes;
    query.ParamByName('BAIXADA').AsBoolean     := ContaReceber.Baixada;
    //
    try
      query.ExecSQL;
      Result := True;
    except
      Result := False;
    end;
  finally
    query.Free;
  end;
end;

function TContaReceberDAO.Update(ContaReceber: TContaReceber): Boolean;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    //
    if ContaReceber.Cliente <> nil then
    begin
      query.SQL.Text := 'UPDATE CONTAS_RECEBER SET CLIENTE_CODIGO = :CLIENTE_CODIGO, VENCIMENTO = :VENCIMENTO, VALOR = :VALOR, OBSERVACOES = :OBSERVACOES, BAIXADA = :BAIXADA '+
                        'WHERE ID = :ID';
      query.ParamByName('CLIENTE_CODIGO').AsString := ContaReceber.Cliente.Codigo;
    end
    else
    begin
      query.SQL.Text := 'UPDATE CONTAS_RECEBER SET NOME_CLIENTE_AVULSO = :NOME_CLIENTE_AVULSO, VENCIMENTO = :VENCIMENTO, VALOR = :VALOR, OBSERVACOES = :OBSERVACOES, BAIXADA = :BAIXADA '+
                        'WHERE ID = :ID';
      query.ParamByName('NOME_CLIENTE_AVULSO').AsString := ContaReceber.NomeClienteAvulso;
    end;
    //
    query.ParamByName('VENCIMENTO').AsDateTime := ContaReceber.Vencimento;
    query.ParamByName('VALOR').AsCurrency      := ContaReceber.Valor;
    query.ParamByName('OBSERVACOES').AsString  := ContaReceber.Observacoes;
    query.ParamByName('BAIXADA').AsBoolean     := ContaReceber.Baixada;
    query.ParamByName('ID').AsInteger          := ContaReceber.Id;
    //
    try
      query.ExecSQL;
      Result := True;
    except
      Result := False;
    end;
  finally
    query.Free;
  end;
end;

function TContaReceberDAO.BaixarConta(ContaReceber: TContaReceber): Boolean;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    //
    query.SQL.Text := 'UPDATE CONTAS_RECEBER SET BAIXADA = 1 WHERE ID = :ID';
    //
    query.ParamByName('ID').AsInteger := ContaReceber.Id;
    //
    try
      query.ExecSQL;
      Result := True;
    except
      Result := False;
    end;
  finally
    query.Free;
  end;
end;

function TContaReceberDAO.Delete(ContaReceber: TContaReceber): Boolean;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    //
    query.SQL.Text := 'DELETE FROM CONTAS_RECEBER WHERE ID = :ID';
    //
    query.ParamByName('ID').AsInteger := ContaReceber.Id;
    //
    try
      query.ExecSQL;
      Result := True;
    except
      Result := False;
    end;
  finally
    query.Free;
  end;
end;

end.
