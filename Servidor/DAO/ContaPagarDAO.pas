unit ContaPagarDAO;

interface

uses
  DBXCommon, SqlExpr, BaseDAO, ContaPagar;

type
  TContaPagarDAO = class(TBaseDAO)
  public
    function List: TDBXReader;
    function Insert(ContaPagar: TContaPagar): Boolean;
    function Update(ContaPagar: TContaPagar): Boolean;
    function Delete(ContaPagar: TContaPagar): Boolean;
    function BaixarConta(ContaPagar: TContaPagar): Boolean;
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
                'ORDER BY C.VENCIMENTO';
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
