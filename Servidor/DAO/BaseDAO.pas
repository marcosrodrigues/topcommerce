unit BaseDAO;

interface

uses
  Classes, SqlExpr, DBXCommon;

type
  {$MethodInfo ON}
  TBaseDAO = class(TPersistent)
  protected
    FComm: TDBXCommand;

    procedure PrepareCommand;
  end;

implementation

uses uSCPrincipal;

{ TBaseDAO }

{ TBaseDAO }

procedure TBaseDAO.PrepareCommand;
begin
  if not(Assigned(FComm)) then
  begin
    if not(SCPrincipal.ConnTopCommerce.Connected) then
      SCPrincipal.ConnTopCommerce.Open;
    FComm := SCPrincipal.ConnTopCommerce.DBXConnection.CreateCommand;
    FComm.CommandType := TDBXCommandTypes.DbxSQL;
    if not(FComm.IsPrepared) then
      FComm.Prepare;
  end;
end;

end.
