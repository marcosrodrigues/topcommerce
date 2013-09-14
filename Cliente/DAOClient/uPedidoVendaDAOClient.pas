unit uPedidoVendaDAOClient;

interface

uses DBXCommon, DBXClient, DBXJSON, DSProxy, Classes, SysUtils, DB, SqlExpr, DBXDBReaders, Generics.Collections, PedidoVenda, ItemPedidoVenda, DBXJSONReflect;

type
  TPedidoVendaDAOClient = class(TDSAdminClient)
  private
    FNextCodigoCommand: TDBXCommand;
    FInsertCommand: TDBXCommand;
    FDeleteCommand: TDBXCommand;
    FUpdateCommand: TDBXCommand;
    FInsertItemNoPedidoCommand: TDBXCommand;
    FDeleteItemDoPedidoCommand: TDBXCommand;
    FAtualizaItemDoPedidoCommand: TDBXCommand;
    FRelatorioPedidosVendaCommand: TDBXCommand;
    FVendasFechadasCommand: TDBXCommand;
    FVendasAbertasCommand: TDBXCommand;
    FReciboCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function NextCodigo: string;
    function Insert(PedidoVenda: TPedidoVenda): Boolean;
    function Delete(CodigoPedidoVenda: string): Boolean;
    function Update(PedidoVenda: TPedidoVenda): Boolean;
    function InsertItemNoPedido(CodigoPedidoVenda: string; Item: TItemPedidoVenda): Boolean;
    function DeleteItemDoPedido(CodigoProduto: string; CodigoPedidoVenda: string): Boolean;
    function AtualizaItemDoPedido(CodigoPedidoVenda: string; Item: TItemPedidoVenda): Boolean;
    function RelatorioPedidosVenda(DataInicial, DataFinal: TDateTime): TDBXReader;
    function VendasFechadas: TDBXReader;
    function VendasAbertas: TDBXReader;
    function Recibo(CodigoPedidoVenda: string): TDBXReader;
  end;

implementation

function TPedidoVendaDAOClient.NextCodigo: string;
begin
  if FNextCodigoCommand = nil then
  begin
    FNextCodigoCommand := FDBXConnection.CreateCommand;
    FNextCodigoCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FNextCodigoCommand.Text := 'TPedidoVendaDAO.NextCodigo';
    FNextCodigoCommand.Prepare;
  end;
  FNextCodigoCommand.ExecuteUpdate;
  Result := FNextCodigoCommand.Parameters[0].Value.GetWideString;
end;

function TPedidoVendaDAOClient.Insert(PedidoVenda: TPedidoVenda): Boolean;
begin
  if FInsertCommand = nil then
  begin
    FInsertCommand := FDBXConnection.CreateCommand;
    FInsertCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FInsertCommand.Text := 'TPedidoVendaDAO.Insert';
    FInsertCommand.Prepare;
  end;
  if not Assigned(PedidoVenda) then
    FInsertCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FInsertCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FInsertCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(PedidoVenda), True);
      if FInstanceOwner then
        PedidoVenda.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FInsertCommand.ExecuteUpdate;
  Result := FInsertCommand.Parameters[1].Value.GetBoolean;
end;

function TPedidoVendaDAOClient.Delete(CodigoPedidoVenda: string): Boolean;
begin
  if FDeleteCommand = nil then
  begin
    FDeleteCommand := FDBXConnection.CreateCommand;
    FDeleteCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FDeleteCommand.Text := 'TPedidoVendaDAO.Delete';
    FDeleteCommand.Prepare;
  end;
  FDeleteCommand.Parameters[0].Value.SetWideString(CodigoPedidoVenda);
  FDeleteCommand.ExecuteUpdate;
  Result := FDeleteCommand.Parameters[1].Value.GetBoolean;
end;

function TPedidoVendaDAOClient.InsertItemNoPedido(CodigoPedidoVenda: string; Item: TItemPedidoVenda): Boolean;
begin
  if FInsertItemNoPedidoCommand = nil then
  begin
    FInsertItemNoPedidoCommand := FDBXConnection.CreateCommand;
    FInsertItemNoPedidoCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FInsertItemNoPedidoCommand.Text := 'TPedidoVendaDAO.InsertItemNoPedido';
    FInsertItemNoPedidoCommand.Prepare;
  end;
  FInsertItemNoPedidoCommand.Parameters[0].Value.SetWideString(CodigoPedidoVenda);
  if not Assigned(Item) then
    FInsertItemNoPedidoCommand.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FInsertItemNoPedidoCommand.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FInsertItemNoPedidoCommand.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(Item), True);
      if FInstanceOwner then
        Item.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FInsertItemNoPedidoCommand.ExecuteUpdate;
  Result := FInsertItemNoPedidoCommand.Parameters[2].Value.GetBoolean;
end;

function TPedidoVendaDAOClient.DeleteItemDoPedido(CodigoProduto: string; CodigoPedidoVenda: string): Boolean;
begin
  if FDeleteItemDoPedidoCommand = nil then
  begin
    FDeleteItemDoPedidoCommand := FDBXConnection.CreateCommand;
    FDeleteItemDoPedidoCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FDeleteItemDoPedidoCommand.Text := 'TPedidoVendaDAO.DeleteItemDoPedido';
    FDeleteItemDoPedidoCommand.Prepare;
  end;
  FDeleteItemDoPedidoCommand.Parameters[0].Value.SetWideString(CodigoProduto);
  FDeleteItemDoPedidoCommand.Parameters[1].Value.SetWideString(CodigoPedidoVenda);
  FDeleteItemDoPedidoCommand.ExecuteUpdate;
  Result := FDeleteItemDoPedidoCommand.Parameters[2].Value.GetBoolean;
end;

function TPedidoVendaDAOClient.Recibo(CodigoPedidoVenda: string): TDBXReader;
begin
  if FReciboCommand = nil then
  begin
    FReciboCommand := FDBXConnection.CreateCommand;
    FReciboCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FReciboCommand.Text := 'TPedidoVendaDAO.Recibo';
    FReciboCommand.Prepare;
  end;
  FReciboCommand.Parameters[0].Value.AsString := CodigoPedidoVenda;
  FReciboCommand.ExecuteUpdate;
  Result := FReciboCommand.Parameters[1].Value.GetDBXReader(FInstanceOwner);
end;

function TPedidoVendaDAOClient.RelatorioPedidosVenda(DataInicial, DataFinal: TDateTime): TDBXReader;
begin
  if FRelatorioPedidosVendaCommand = nil then
  begin
    FRelatorioPedidosVendaCommand := FDBXConnection.CreateCommand;
    FRelatorioPedidosVendaCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FRelatorioPedidosVendaCommand.Text := 'TPedidoVendaDAO.RelatorioPedidosVenda';
    FRelatorioPedidosVendaCommand.Prepare;
  end;
  FRelatorioPedidosVendaCommand.Parameters[0].Value.AsDateTime := DataInicial;
  FRelatorioPedidosVendaCommand.Parameters[1].Value.AsDateTime := DataFinal;
  FRelatorioPedidosVendaCommand.ExecuteUpdate;
  Result := FRelatorioPedidosVendaCommand.Parameters[2].Value.GetDBXReader(FInstanceOwner);
end;

function TPedidoVendaDAOClient.Update(PedidoVenda: TPedidoVenda): Boolean;
begin
  if FUpdateCommand = nil then
  begin
    FUpdateCommand := FDBXConnection.CreateCommand;
    FUpdateCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FUpdateCommand.Text := 'TPedidoVendaDAO.Update';
    FUpdateCommand.Prepare;
  end;
  if not Assigned(PedidoVenda) then
    FUpdateCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FUpdateCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FUpdateCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(PedidoVenda), True);
      if FInstanceOwner then
        PedidoVenda.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FUpdateCommand.ExecuteUpdate;
  Result := FUpdateCommand.Parameters[1].Value.GetBoolean;
end;

function TPedidoVendaDAOClient.VendasAbertas: TDBXReader;
begin
  if FVendasAbertasCommand = nil then
  begin
    FVendasAbertasCommand := FDBXConnection.CreateCommand;
    FVendasAbertasCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FVendasAbertasCommand.Text := 'TPedidoVendaDAO.VendasAbertas';
    FVendasAbertasCommand.Prepare;
  end;
  FVendasAbertasCommand.ExecuteUpdate;
  Result := FVendasAbertasCommand.Parameters[0].Value.GetDBXReader(FInstanceOwner);
end;

function TPedidoVendaDAOClient.VendasFechadas: TDBXReader;
begin
  if FVendasFechadasCommand = nil then
  begin
    FVendasFechadasCommand := FDBXConnection.CreateCommand;
    FVendasFechadasCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FVendasFechadasCommand.Text := 'TPedidoVendaDAO.VendasFechadas';
    FVendasFechadasCommand.Prepare;
  end;
  FVendasFechadasCommand.ExecuteUpdate;
  Result := FVendasFechadasCommand.Parameters[0].Value.GetDBXReader(FInstanceOwner);
end;

constructor TPedidoVendaDAOClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

function TPedidoVendaDAOClient.AtualizaItemDoPedido(CodigoPedidoVenda: string; Item: TItemPedidoVenda): Boolean;
begin
  if FAtualizaItemDoPedidoCommand = nil then
  begin
    FAtualizaItemDoPedidoCommand := FDBXConnection.CreateCommand;
    FAtualizaItemDoPedidoCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FAtualizaItemDoPedidoCommand.Text := 'TPedidoVendaDAO.AtualizaItemDoPedido';
    FAtualizaItemDoPedidoCommand.Prepare;
  end;
  FAtualizaItemDoPedidoCommand.Parameters[0].Value.SetWideString(CodigoPedidoVenda);
  if not Assigned(Item) then
    FAtualizaItemDoPedidoCommand.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FAtualizaItemDoPedidoCommand.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FAtualizaItemDoPedidoCommand.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(Item), True);
      if FInstanceOwner then
        Item.Free
    finally
      FreeAndNil(FMarshal)
    end;
  end;
  FAtualizaItemDoPedidoCommand.ExecuteUpdate;
  Result := FAtualizaItemDoPedidoCommand.Parameters[2].Value.GetBoolean;
end;

constructor TPedidoVendaDAOClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;


destructor TPedidoVendaDAOClient.Destroy;
begin
  FreeAndNil(FNextCodigoCommand);
  FreeAndNil(FInsertCommand);
  FreeAndNil(FDeleteCommand);
  FreeAndNil(FUpdateCommand);
  FreeAndNil(FInsertItemNoPedidoCommand);
  FreeAndNil(FDeleteItemDoPedidoCommand);
  FreeAndNil(FAtualizaItemDoPedidoCommand);
  FreeAndNil(FRelatorioPedidosVendaCommand);
  FreeAndNil(FVendasFechadasCommand);
  FreeAndNil(FVendasAbertasCommand);
  FreeAndNil(FReciboCommand);
  inherited;
end;

end.
