unit ContaPagarDAO;

interface

uses
  DBXCommon, SqlExpr, BaseDAO, ContaPagar, SysUtils;

type
  TContaPagarDAO = class(TBaseDAO)
  public
    function List: TDBXReader;
    function Insert(ContaPagar: TContaPagar): Boolean;
    function Update(ContaPagar: TContaPagar): Boolean;
    function Delete(ContaPagar: TContaPagar): Boolean;
    function BaixarConta(ContaPagar: TContaPagar): Boolean;
    function Relatorio(DataInicial, DataFinal: TDateTime; FornecedorCodigo: string; Situacao: Integer): TDBXReader;
  end;


implementation

uses uSCPrincipal, StringUtils;

{ TClienteDAO }

function TContaPagarDAO.List: TDBXReader;
begin
  PrepareCommand;
  FComm.Text := 'SELECT C.ID, C.FORNECEDOR_CODIGO, F.NOME, C.VENCIMENTO, C.VALOR, C.OBSERVACOES, C.BAIXADA '+
                'FROM CONTAS_PAGAR C '+
                'INNER JOIN FORNECEDORES F ON F.CODIGO = C.FORNECEDOR_CODIGO '+
                'WHERE C.BAIXADA = 0 '+
                'ORDER BY C.FORNECEDOR_CODIGO, C.VENCIMENTO';
  Result := FComm.ExecuteQuery;
end;

function TContaPagarDAO.Relatorio(DataInicial, DataFinal: TDateTime; FornecedorCodigo: string; Situacao: Integer): TDBXReader;
begin
  PrepareCommand;
  FComm.Text := 'SELECT C.ID, C.FORNECEDOR_CODIGO, F.NOME, C.VENCIMENTO, C.VALOR, C.OBSERVACOES, C.BAIXADA '+
                'FROM CONTAS_PAGAR C '+
                'INNER JOIN FORNECEDORES F ON F.CODIGO = C.FORNECEDOR_CODIGO '+
                'WHERE C.ID <> 0 ';

  if DataInicial <> 0 then
    FComm.Text := FComm.Text + 'AND CONVERT(CHAR(8), C.VENCIMENTO, 112) >= '+FormatDateTime('yyyymmdd', DataInicial)+' ';

  if DataFinal <> 0 then
    FComm.Text := FComm.Text + 'AND CONVERT(CHAR(8), C.VENCIMENTO, 112) <= '+FormatDateTime('yyyymmdd', DataFinal)+' ';

  if FornecedorCodigo <> '' then
    FComm.Text := FComm.Text + 'AND C.FORNECEDOR_CODIGO = '''+FornecedorCodigo+''' ';

  if Situacao = 1 then
    FComm.Text := FComm.Text + 'AND C.BAIXADA = 0 ';

  if Situacao = 2 then
    FComm.Text := FComm.Text + 'AND C.BAIXADA = 1 ';

  FComm.Text := FComm.Text + 'ORDER BY C.FORNECEDOR_CODIGO, C.VENCIMENTO';

  Result := FComm.ExecuteQuery;
end;

function TContaPagarDAO.Insert(ContaPagar: TContaPagar): Boolean;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    //
    query.SQL.Text := 'INSERT INTO CONTAS_PAGAR (FORNECEDOR_CODIGO, VENCIMENTO, VALOR, OBSERVACOES, BAIXADA) VALUES (:FORNECEDOR_CODIGO, :VENCIMENTO, :VALOR, :OBSERVACOES, :BAIXADA)';
    //
    query.ParamByName('FORNECEDOR_CODIGO').AsString := ContaPagar.Fornecedor.Codigo;
    query.ParamByName('VENCIMENTO').AsDateTime      := ContaPagar.Vencimento;
    query.ParamByName('VALOR').AsCurrency           := ContaPagar.Valor;
    query.ParamByName('OBSERVACOES').AsString       := ContaPagar.Observacoes;
    query.ParamByName('BAIXADA').AsBoolean          := ContaPagar.Baixada;
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

function TContaPagarDAO.Update(ContaPagar: TContaPagar): Boolean;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    //
    query.SQL.Text := 'UPDATE CONTAS_PAGAR SET FORNECEDOR_CODIGO = :FORNECEDOR_CODIGO, VENCIMENTO = :VENCIMENTO, VALOR = :VALOR, OBSERVACOES = :OBSERVACOES, BAIXADA = :BAIXADA '+
                      'WHERE ID = :ID';
    //
    query.ParamByName('FORNECEDOR_CODIGO').AsString := ContaPagar.Fornecedor.Codigo;
    query.ParamByName('VENCIMENTO').AsDateTime      := ContaPagar.Vencimento;
    query.ParamByName('VALOR').AsCurrency           := ContaPagar.Valor;
    query.ParamByName('OBSERVACOES').AsString       := ContaPagar.Observacoes;
    query.ParamByName('BAIXADA').AsBoolean          := ContaPagar.Baixada;
    query.ParamByName('ID').AsInteger               := ContaPagar.Id;
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

function TContaPagarDAO.BaixarConta(ContaPagar: TContaPagar): Boolean;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    //
    query.SQL.Text := 'UPDATE CONTAS_PAGAR SET BAIXADA = 1 WHERE ID = :ID';
    //
    query.ParamByName('ID').AsInteger := ContaPagar.Id;
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

function TContaPagarDAO.Delete(ContaPagar: TContaPagar): Boolean;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    //
    query.SQL.Text := 'DELETE FROM CONTAS_PAGAR WHERE ID = :ID';
    //
    query.ParamByName('ID').AsInteger := ContaPagar.Id;
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
