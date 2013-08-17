unit Estoque;

interface

uses
  Produto;

type
  TEstoque = class
  private
    FProduto: TProduto;
    FQuantidade: Integer;
  public
    property Produto: TProduto read FProduto write FProduto;
    property Quantidade: Integer read FQuantidade write FQuantidade;

    constructor Create; overload;
    constructor Create(Produto: TProduto); overload;
    constructor Create(Produto: TProduto; Quantidade: Integer); overload;
    destructor Destroy; override;
  end;

implementation

{ TEstoque }

constructor TEstoque.Create;
begin

end;

constructor TEstoque.Create(Produto: TProduto);
begin
  Self.FProduto := Produto;
end;

constructor TEstoque.Create(Produto: TProduto; Quantidade: Integer);
begin
  Self.FProduto   := Produto;
  Self.Quantidade := Quantidade;
end;

destructor TEstoque.Destroy;
begin
  if (Assigned(FProduto)) then
    FProduto.Free;
  inherited;
end;

end.
