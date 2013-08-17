unit Validade;

interface

type
  TValidade = class
  private
    FData: TDateTime;
  public
    property Data: TDateTime read FData write FData;

    constructor Create; overload;
    constructor Create(Data: TDateTime); overload;
  end;

implementation

{ TValidade }

constructor TValidade.Create;
begin

end;

constructor TValidade.Create(Data: TDateTime);
begin
  Self.Data := Data;
end;

end.
