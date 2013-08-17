unit uProdutoDAOClient;

interface

uses DBXCommon, DBXClient, DBXJSON, DSProxy, Classes, SysUtils, DB, SqlExpr, DBXDBReaders, Produto, DBXJSONReflect,
  Generics.Collections, FornecedorProduto, Validade;

type
  TProdutoDAOClient = class(TDSAdminClient)
  private
    FListCommand: TDBXCommand;
    FNextCodigoCommand: TDBXCommand;
    FNextCodigoBarrasCommand: TDBXCommand;
    FInsertCommand: TDBXCommand;
    FUpdateCommand: TDBXCommand;
    FDeleteCommand: TDBXCommand;
    FFindByCodigoCommand: TDBXCommand;
    FListFornecedoresByProdutoCommand: TDBXCommand;
    FListValidadesByProdutoCommand: TDBXCommand;
    FListagemProdutosCommand: TDBXCommand;
    FExisteCodigoBarrasCommand: TDBXCommand;
    FListProdutosPertoVencimentoCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function List: TDBXReader;
    function NextCodigo: string;
    function NextCodigoBarras: string;
    function Insert(produto: TProduto): Boolean;
    function Update(produto: TProduto): Boolean;
    function Delete(produto: TProduto): Boolean;
    function FindByCodigo(Codigo: string): TProduto;
    function ListFornecedoresByProduto(Codigo: string): TList<TFornecedorProduto>;
    function ListValidadesByProduto(Codigo: string): TList<TValidade>;
    function ListagemProdutos(CodigoTipoProduto: string; CodigoFornecedor: string; Estoque: Integer): TDBXReader;
    function ExisteCodigoBarras(CodigoBarras: string): Boolean;
    function ListProdutosPertoVencimento: TDBXReader;
  end;

implementation

function TProdutoDAOClient.List: TDBXReader;
begin
  if FListCommand = nil then
  begin
    FListCommand := FDBXConnection.CreateCommand;
    FListCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FListCommand.Text := 'TProdutoDAO.List';
    FListCommand.Prepare;
  end;
  FListCommand.ExecuteUpdate;
  Result := FListCommand.Parameters[0].Value.GetDBXReader(FInstanceOwner);
end;

function TProdutoDAOClient.NextCodigo: string;
begin
  if FNextCodigoCommand = nil then
  begin
    FNextCodigoCommand := FDBXConnection.CreateCommand;
    FNextCodigoCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FNextCodigoCommand.Text := 'TProdutoDAO.NextCodigo';
    FNextCodigoCommand.Prepare;
  end;
  FNextCodigoCommand.ExecuteUpdate;
  Result := FNextCodigoCommand.Parameters[0].Value.GetWideString;
end;

function TProdutoDAOClient.NextCodigoBarras: string;
begin
  if FNextCodigoBarrasCommand = nil then
  begin
    FNextCodigoBarrasCommand := FDBXConnection.CreateCommand;
    FNextCodigoBarrasCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FNextCodigoBarrasCommand.Text := 'TProdutoDAO.NextCodigoBarras';
    FNextCodigoBarrasCommand.Prepare;
  end;
  FNextCodigoBarrasCommand.ExecuteUpdate;
  Result := FNextCodigoBarrasCommand.Parameters[0].Value.GetWideString;
end;

function TProdutoDAOClient.Insert(produto: TProduto): Boolean;
begin
  if FInsertCommand = nil then
  begin
    FInsertCommand := FDBXConnection.CreateCommand;
    FInsertCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FInsertCommand.Text := 'TProdutoDAO.Insert';
    FInsertCommand.Prepare;
  end;
  if not Assigned(produto) then
    FInsertCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FInsertCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FInsertCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(produto), True);
      if FInstanceOwner then
        produto.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FInsertCommand.ExecuteUpdate;
  Result := FInsertCommand.Parameters[1].Value.GetBoolean;
end;

function TProdutoDAOClient.Update(produto: TProduto): Boolean;
begin
  if FUpdateCommand = nil then
  begin
    FUpdateCommand := FDBXConnection.CreateCommand;
    FUpdateCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FUpdateCommand.Text := 'TProdutoDAO.Update';
    FUpdateCommand.Prepare;
  end;
  if not Assigned(produto) then
    FUpdateCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FUpdateCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FUpdateCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(produto), True);
      if FInstanceOwner then
        produto.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FUpdateCommand.ExecuteUpdate;
  Result := FUpdateCommand.Parameters[1].Value.GetBoolean;
end;

function TProdutoDAOClient.Delete(produto: TProduto): Boolean;
begin
  if FDeleteCommand = nil then
  begin
    FDeleteCommand := FDBXConnection.CreateCommand;
    FDeleteCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FDeleteCommand.Text := 'TProdutoDAO.Delete';
    FDeleteCommand.Prepare;
  end;
  if not Assigned(produto) then
    FDeleteCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FDeleteCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDeleteCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(produto), True);
      if FInstanceOwner then
        produto.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FDeleteCommand.ExecuteUpdate;
  Result := FDeleteCommand.Parameters[1].Value.GetBoolean;
end;

function TProdutoDAOClient.FindByCodigo(Codigo: string): TProduto;
begin
  if FFindByCodigoCommand = nil then
  begin
    FFindByCodigoCommand := FDBXConnection.CreateCommand;
    FFindByCodigoCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FFindByCodigoCommand.Text := 'TProdutoDAO.FindByCodigo';
    FFindByCodigoCommand.Prepare;
  end;
  FFindByCodigoCommand.Parameters[0].Value.SetWideString(Codigo);
  FFindByCodigoCommand.ExecuteUpdate;
  if not FFindByCodigoCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FFindByCodigoCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TProduto(FUnMarshal.UnMarshal(FFindByCodigoCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FFindByCodigoCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TProdutoDAOClient.ListFornecedoresByProduto(Codigo: string): TList<TFornecedorProduto>;
begin
  if FListFornecedoresByProdutoCommand = nil then
  begin
    FListFornecedoresByProdutoCommand := FDBXConnection.CreateCommand;
    FListFornecedoresByProdutoCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FListFornecedoresByProdutoCommand.Text := 'TProdutoDAO.ListFornecedoresByProduto';
    FListFornecedoresByProdutoCommand.Prepare;
  end;
  FListFornecedoresByProdutoCommand.Parameters[0].Value.SetWideString(Codigo);
  FListFornecedoresByProdutoCommand.ExecuteUpdate;
  if not FListFornecedoresByProdutoCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FListFornecedoresByProdutoCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TList<FornecedorProduto.TFornecedorProduto>(FUnMarshal.UnMarshal(FListFornecedoresByProdutoCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FListFornecedoresByProdutoCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TProdutoDAOClient.ListValidadesByProduto(Codigo: string): TList<TValidade>;
begin
  if FListValidadesByProdutoCommand = nil then
  begin
    FListValidadesByProdutoCommand := FDBXConnection.CreateCommand;
    FListValidadesByProdutoCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FListValidadesByProdutoCommand.Text := 'TProdutoDAO.ListValidadesByProduto';
    FListValidadesByProdutoCommand.Prepare;
  end;
  FListValidadesByProdutoCommand.Parameters[0].Value.SetWideString(Codigo);
  FListValidadesByProdutoCommand.ExecuteUpdate;
  if not FListValidadesByProdutoCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FListValidadesByProdutoCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TList<Validade.TValidade>(FUnMarshal.UnMarshal(FListValidadesByProdutoCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FListValidadesByProdutoCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TProdutoDAOClient.ListagemProdutos(CodigoTipoProduto: string; CodigoFornecedor: string; Estoque: Integer): TDBXReader;
begin
  if FListagemProdutosCommand = nil then
  begin
    FListagemProdutosCommand := FDBXConnection.CreateCommand;
    FListagemProdutosCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FListagemProdutosCommand.Text := 'TProdutoDAO.ListagemProdutos';
    FListagemProdutosCommand.Prepare;
  end;
  FListagemProdutosCommand.Parameters[0].Value.SetWideString(CodigoTipoProduto);
  FListagemProdutosCommand.Parameters[1].Value.SetWideString(CodigoFornecedor);
  FListagemProdutosCommand.Parameters[2].Value.SetInt32(Estoque);
  FListagemProdutosCommand.ExecuteUpdate;
  Result := FListagemProdutosCommand.Parameters[3].Value.GetDBXReader(FInstanceOwner);
end;

function TProdutoDAOClient.ExisteCodigoBarras(CodigoBarras: string): Boolean;
begin
  if FExisteCodigoBarrasCommand = nil then
  begin
    FExisteCodigoBarrasCommand := FDBXConnection.CreateCommand;
    FExisteCodigoBarrasCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FExisteCodigoBarrasCommand.Text := 'TProdutoDAO.ExisteCodigoBarras';
    FExisteCodigoBarrasCommand.Prepare;
  end;
  FExisteCodigoBarrasCommand.Parameters[0].Value.SetWideString(CodigoBarras);
  FExisteCodigoBarrasCommand.ExecuteUpdate;
  Result := FExisteCodigoBarrasCommand.Parameters[1].Value.GetBoolean;
end;

function TProdutoDAOClient.ListProdutosPertoVencimento: TDBXReader;
begin
  if FListProdutosPertoVencimentoCommand = nil then
  begin
    FListProdutosPertoVencimentoCommand := FDBXConnection.CreateCommand;
    FListProdutosPertoVencimentoCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FListProdutosPertoVencimentoCommand.Text := 'TProdutoDAO.ListProdutosPertoVencimento';
    FListProdutosPertoVencimentoCommand.Prepare;
  end;
  FListProdutosPertoVencimentoCommand.ExecuteUpdate;
  Result := FListProdutosPertoVencimentoCommand.Parameters[0].Value.GetDBXReader(FInstanceOwner);
end;

constructor TProdutoDAOClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;


constructor TProdutoDAOClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TProdutoDAOClient.Destroy;
begin
  FreeAndNil(FListCommand);
  FreeAndNil(FNextCodigoCommand);
  FreeAndNil(FInsertCommand);
  FreeAndNil(FUpdateCommand);
  FreeAndNil(FDeleteCommand);
  FreeAndNil(FFindByCodigoCommand);
  FreeAndNil(FListFornecedoresByProdutoCommand);
  FreeAndNil(FListagemProdutosCommand);
  inherited;
end;

end.

