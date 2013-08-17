unit uFornecedorDAOClient;

interface

uses DBXCommon, DBXClient, DBXJSON, DSProxy, Classes, SysUtils, DB, SqlExpr, DBXDBReaders, Fornecedor, DBXJSONReflect;

type
  TFornecedorDAOClient = class(TDSAdminClient)
  private
    FListCommand: TDBXCommand;
    FNextCodigoCommand: TDBXCommand;
    FInsertCommand: TDBXCommand;
    FUpdateCommand: TDBXCommand;
    FDeleteCommand: TDBXCommand;
    FFindByCodigoCommand: TDBXCommand;
    FListagemFornecedoresCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function List: TDBXReader;
    function NextCodigo: string;
    function Insert(Fornecedor: TFornecedor): Boolean;
    function Update(Fornecedor: TFornecedor): Boolean;
    function Delete(Fornecedor: TFornecedor): Boolean;
    function FindByCodigo(Codigo: string): TFornecedor;
    function ListagemFornecedores(CodigoProduto: string): TDBXReader;
  end;

implementation

function TFornecedorDAOClient.List: TDBXReader;
begin
  if FListCommand = nil then
  begin
    FListCommand := FDBXConnection.CreateCommand;
    FListCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FListCommand.Text := 'TFornecedorDAO.List';
    FListCommand.Prepare;
  end;
  FListCommand.ExecuteUpdate;
  Result := FListCommand.Parameters[0].Value.GetDBXReader(FInstanceOwner);
end;

function TFornecedorDAOClient.NextCodigo: string;
begin
  if FNextCodigoCommand = nil then
  begin
    FNextCodigoCommand := FDBXConnection.CreateCommand;
    FNextCodigoCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FNextCodigoCommand.Text := 'TFornecedorDAO.NextCodigo';
    FNextCodigoCommand.Prepare;
  end;
  FNextCodigoCommand.ExecuteUpdate;
  Result := FNextCodigoCommand.Parameters[0].Value.GetWideString;
end;

function TFornecedorDAOClient.Insert(Fornecedor: TFornecedor): Boolean;
begin
  if FInsertCommand = nil then
  begin
    FInsertCommand := FDBXConnection.CreateCommand;
    FInsertCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FInsertCommand.Text := 'TFornecedorDAO.Insert';
    FInsertCommand.Prepare;
  end;
  if not Assigned(Fornecedor) then
    FInsertCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FInsertCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FInsertCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Fornecedor), True);
      if FInstanceOwner then
        Fornecedor.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FInsertCommand.ExecuteUpdate;
  Result := FInsertCommand.Parameters[1].Value.GetBoolean;
end;

function TFornecedorDAOClient.Update(Fornecedor: TFornecedor): Boolean;
begin
  if FUpdateCommand = nil then
  begin
    FUpdateCommand := FDBXConnection.CreateCommand;
    FUpdateCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FUpdateCommand.Text := 'TFornecedorDAO.Update';
    FUpdateCommand.Prepare;
  end;
  if not Assigned(Fornecedor) then
    FUpdateCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FUpdateCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FUpdateCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Fornecedor), True);
      if FInstanceOwner then
        Fornecedor.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FUpdateCommand.ExecuteUpdate;
  Result := FUpdateCommand.Parameters[1].Value.GetBoolean;
end;

function TFornecedorDAOClient.Delete(Fornecedor: TFornecedor): Boolean;
begin
  if FDeleteCommand = nil then
  begin
    FDeleteCommand := FDBXConnection.CreateCommand;
    FDeleteCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FDeleteCommand.Text := 'TFornecedorDAO.Delete';
    FDeleteCommand.Prepare;
  end;
  if not Assigned(Fornecedor) then
    FDeleteCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FDeleteCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDeleteCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Fornecedor), True);
      if FInstanceOwner then
        Fornecedor.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FDeleteCommand.ExecuteUpdate;
  Result := FDeleteCommand.Parameters[1].Value.GetBoolean;
end;

function TFornecedorDAOClient.FindByCodigo(Codigo: string): TFornecedor;
begin
  if FFindByCodigoCommand = nil then
  begin
    FFindByCodigoCommand := FDBXConnection.CreateCommand;
    FFindByCodigoCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FFindByCodigoCommand.Text := 'TFornecedorDAO.FindByCodigo';
    FFindByCodigoCommand.Prepare;
  end;
  FFindByCodigoCommand.Parameters[0].Value.SetWideString(Codigo);
  FFindByCodigoCommand.ExecuteUpdate;
  if not FFindByCodigoCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FFindByCodigoCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFornecedor(FUnMarshal.UnMarshal(FFindByCodigoCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FFindByCodigoCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TFornecedorDAOClient.ListagemFornecedores(CodigoProduto: string): TDBXReader;
begin
  if FListagemFornecedoresCommand = nil then
  begin
    FListagemFornecedoresCommand := FDBXConnection.CreateCommand;
    FListagemFornecedoresCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FListagemFornecedoresCommand.Text := 'TFornecedorDAO.ListagemFornecedores';
    FListagemFornecedoresCommand.Prepare;
  end;
  FListagemFornecedoresCommand.Parameters[0].Value.SetWideString(CodigoProduto);
  FListagemFornecedoresCommand.ExecuteUpdate;
  Result := FListagemFornecedoresCommand.Parameters[1].Value.GetDBXReader(FInstanceOwner);
end;

constructor TFornecedorDAOClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;


constructor TFornecedorDAOClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;


destructor TFornecedorDAOClient.Destroy;
begin
  FreeAndNil(FListCommand);
  FreeAndNil(FNextCodigoCommand);
  FreeAndNil(FInsertCommand);
  FreeAndNil(FUpdateCommand);
  FreeAndNil(FDeleteCommand);
  FreeAndNil(FFindByCodigoCommand);
  FreeAndNil(FListagemFornecedoresCommand);
  inherited;
end;

end.

