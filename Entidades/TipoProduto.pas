unit TipoProduto;

interface

type
  TTipoProduto = class
  private
    FCodigo: string;
    FDescricao: string;
  public
    property Codigo: string read FCodigo write FCodigo;
    property Descricao: string read FDescricao write FDescricao;

    constructor Create; overload;
    constructor Create(Codigo: string); overload;
    constructor Create(Codigo, Descricao: string); overload;
  end;

implementation

{ TTipoProduto }

constructor TTipoProduto.Create;
begin

end;

constructor TTipoProduto.Create(Codigo: string);
begin
  Self.Codigo := Codigo;
end;

constructor TTipoProduto.Create(Codigo, Descricao: string);
begin
  Self.Codigo    := Codigo;
  Self.Descricao := Descricao;
end;

end.
