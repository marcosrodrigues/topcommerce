unit ItemPedidoVenda;

interface

uses
  Produto;

type
  TItemPedidoVenda = class
  private
    FProduto: TProduto;
    FQuantidade: Integer;
  public
    property Produto: TProduto read FProduto write FProduto;
    property Quantidade: Integer read FQuantidade write FQuantidade;
  end;

implementation

end.
