unit ContaReceberDAO;

interface

uses
  DBXCommon, SqlExpr, BaseDAO, ContaReceber;

type
  TContaReceberDAO = class(TBaseDAO)
  public
    function List: TDBXReader;
    function Insert(ContaReceber: TContaReceber): Boolean;
    function Update(ContaReceber: TContaReceber): Boolean;
    function Delete(ContaReceber: TContaReceber): Boolean;
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
                'ORDER BY C.VENCIMENTO DESC';
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
      query.SQL.Text := 'INSERT INTO CONTAS_RECEBER (CLIENTE_CODIGO, VENCIMENTO, VALOR, OBSERVACOES, BAIXADA) VALUES (:FORNECEDOR_CODIGO, :VENCIMENTO, :VALOR, :OBSERVACOES, :BAIXADA)';
      query.ParamByName('CLIENTE_CODIGO').AsString := ContaReceber.Cliente.Codigo;
    end
    else
    begin
      query.SQL.Text := 'INSERT INTO CONTAS_RECEBER (NOME_CLIENTE_AVULSO, VENCIMENTO, VALOR, OBSERVACOES, BAIXADA) VALUES (:FORNECEDOR_CODIGO, :VENCIMENTO, :VALOR, :OBSERVACOES, :BAIXADA)';
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
    FComm.Text := 'DELETE FROM CONTAS_RECEBER WHERE ID = :ID';
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
