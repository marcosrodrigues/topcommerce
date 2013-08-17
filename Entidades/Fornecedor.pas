unit Fornecedor;

interface

type
  TFornecedor = class
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

{ TFornecedor }

constructor TFornecedor.Create;
begin

end;

constructor TFornecedor.Create(Codigo: string);
begin
  Self.Codigo   := Codigo;
end;

constructor TFornecedor.Create(Codigo, Nome, Telefone: string);
begin
  Self.Codigo   := Codigo;
  Self.Nome     := Nome;
  Self.Telefone := Telefone;
end;

end.
