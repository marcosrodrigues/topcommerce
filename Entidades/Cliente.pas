unit Cliente;

interface

type
  TCliente = class
  private
    FCodigo: string;
    FNome: string;
    FTelefone: string;
  public
    property Codigo: string read FCodigo write FCodigo;
    property Nome: string read FNome write FNome;
    property Telefone: string read FTelefone write FTelefone;

    constructor Create; overload;
    constructor Create(Codigo: string); overload;
    constructor Create(Codigo, Nome, Telefone: string); overload;
  end;

implementation

{ TCliente }

constructor TCliente.Create;
begin

end;

constructor TCliente.Create(Codigo: string);
begin
  Self.FCodigo := Codigo;
end;

constructor TCliente.Create(Codigo, Nome, Telefone: string);
begin
  Self.FCodigo   := Codigo;
  Self.FNome     := Nome;
  Self.FTelefone := Telefone;
end;

end.
