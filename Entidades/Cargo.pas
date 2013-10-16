unit Cargo;

interface

type
  TCargo = class
  private
    FId: Integer;
    FDescricao: string;
  public
    property Id: Integer read FId write FId;
    property Descricao: string read FDescricao write FDescricao;

    constructor Create; overload;
    constructor Create(Id: Integer); overload;
    constructor Create(Id: Integer; Descricao: string); overload;
  end;

implementation

{ TCliente }

constructor TCargo.Create;
begin

end;

constructor TCargo.Create(Id: Integer);
begin
  Self.FId := Id;
end;

constructor TCargo.Create(Id: Integer; Descricao: string);
begin
  Self.FId        := Id;
  Self.FDescricao := Descricao;
end;

end.
