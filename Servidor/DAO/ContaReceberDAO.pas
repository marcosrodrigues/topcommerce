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
    function BaixarConta(ContaReceber: TContaReceber; Data: TDateTime; Valor: Currency; FormaPagamento: Integer): Boolean;
    function Relatorio(DataInicial, DataFinal: TDateTime; ClienteCodigo: string; Situacao: Integer): TDBXReader;
  end;


implementation

uses uSCPrincipal, StringUtils;

{ TClienteDAO }

function TContaReceberDAO.List: TDBXReader;
begin
  PrepareCommand;
  FComm.Text := 'SELECT C.ID, C.CLIENTE_CODIGO, L.NOME, C.NOME_CLIENTE_AVULSO, C.VENCIMENTO, C.VALOR, C.OBSERVACOES, C.BAIXADA, C.RESTANTE '+
                'FROM CONTAS_RECEBER C '+
                'LEFT JOIN CLIENTES L ON L.CODIGO = C.CLIENTE_CODIGO '+
                'WHERE C.BAIXADA = 0 '+
                'ORDER BY C.VENCIMENTO, C.CLIENTE_CODIGO';
  Result := FComm.ExecuteQuery;
end;

function TContaReceberDAO.Relatorio(DataInicial, DataFinal: TDateTime; ClienteCodigo: string; Situacao: Integer): TDBXReader;
begin
  PrepareCommand;
  FComm.Text := 'SELECT C.ID, C.CLIENTE_CODIGO, L.NOME, C.NOME_CLIENTE_AVULSO, C.VENCIMENTO, C.VALOR, C.OBSERVACOES, C.BAIXADA, C.RESTANTE '+
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
      query.SQL.Text := 'INSERT INTO CONTAS_RECEBER (CLIENTE_CODIGO, VENCIMENTO, VALOR, OBSERVACOES, BAIXADA, RESTANTE) VALUES (:CLIENTE_CODIGO, :VENCIMENTO, :VALOR, :OBSERVACOES, :BAIXADA, :RESTANTE)';
      query.ParamByName('CLIENTE_CODIGO').AsString := ContaReceber.Cliente.Codigo;
    end
    else
    begin
      query.SQL.Text := 'INSERT INTO CONTAS_RECEBER (NOME_CLIENTE_AVULSO, VENCIMENTO, VALOR, OBSERVACOES, BAIXADA, RESTANTE) VALUES (:NOME_CLIENTE_AVULSO, :VENCIMENTO, :VALOR, :OBSERVACOES, :BAIXADA, :RESTANTE)';
      query.ParamByName('NOME_CLIENTE_AVULSO').AsString := ContaReceber.NomeClienteAvulso;
    end;

    query.ParamByName('VENCIMENTO').AsDateTime := ContaReceber.Vencimento;
    query.ParamByName('VALOR').AsCurrency      := ContaReceber.Valor;
    query.ParamByName('OBSERVACOES').AsString  := ContaReceber.Observacoes;
    query.ParamByName('BAIXADA').AsBoolean     := ContaReceber.Baixada;
    query.ParamByName('RESTANTE').AsCurrency   := ContaReceber.Valor;
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

function TContaReceberDAO.BaixarConta(ContaReceber: TContaReceber; Data: TDateTime; Valor: Currency; FormaPagamento: Integer): Boolean;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    //
    query.SQL.Text := 'INSERT INTO BAIXAS_CONTA_RECEBER (CONTA_RECEBER_ID, DATA, VALOR, FORMA_PAGAMENTO) VALUES (:CONTA_RECEBER_ID, :DATA, :VALOR, :FORMA_PAGAMENTO)';
    query.ParamByName('CONTA_RECEBER_ID').AsInteger := ContaReceber.Id;
    query.ParamByName('DATA').AsDateTime := Data;
    query.ParamByName('VALOR').AsCurrency := Valor;
    query.ParamByName('FORMA_PAGAMENTO').AsInteger := FormaPagamento;
    query.ExecSQL;

    query.SQL.Text := 'SELECT SUM(VALOR) AS TOTAL_PAGO FROM BAIXAS_CONTA_RECEBER WHERE CONTA_RECEBER_ID = :ID';
    query.ParamByName('ID').AsInteger := ContaReceber.Id;
    query.Open;

    Result := False;
    if ContaReceber.Valor <= query.FieldByName('TOTAL_PAGO').AsCurrency then
    begin
      query.SQL.Text := 'UPDATE CONTAS_RECEBER SET BAIXADA = 1 WHERE ID = :ID';
      query.ParamByName('ID').AsInteger := ContaReceber.Id;
      query.ExecSQL;

      Result := True;
    end
    else
    begin
      query.SQL.Text := 'UPDATE CONTAS_RECEBER SET RESTANTE = :VALOR WHERE ID = :ID';
      query.ParamByName('VALOR').AsCurrency := ContaReceber.Valor - Valor;
      query.ParamByName('ID').AsInteger     := ContaReceber.Id;
      query.ExecSQL;
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
