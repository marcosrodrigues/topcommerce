unit ItemPedidoVenda;

interface

uses
  Produto, DBXJSONReflect, RTTI, DBXPlatform;

type
  TDoubleInterceptor = class(TJSONInterceptor)
  public
    function StringConverter(Data: TObject; Field: string): string; override;
    procedure StringReverter(Data: TObject; Field: string; Arg: string); override;
  end;

  TItemPedidoVenda = class
  private
    FProduto: TProduto;
    FQuantidade: Integer;
    [JSONReflect(ctString, rtString, TDoubleInterceptor, nil, true)]
    FDescontoValor: Currency;
    [JSONReflect(ctString, rtString, TDoubleInterceptor, nil, true)]
    FDescontoPercentual: Currency;
    [JSONReflect(ctString, rtString, TDoubleInterceptor, nil, true)]
    FValor: Currency;
  public
    property Produto: TProduto read FProduto write FProduto;
    property Quantidade: Integer read FQuantidade write FQuantidade;
    property DescontoValor: Currency read FDescontoValor write FDescontoValor;
    property DescontoPercentual: Currency read FDescontoPercentual write FDescontoPercentual;
    property Valor: Currency read FValor write FValor;
  end;

implementation

{ TDoubleInterceptor }

function TDoubleInterceptor.StringConverter(Data: TObject; Field: string): string;
var
  LRttiContext: TRttiContext;
  LValue: Double;
begin
  LValue := LRttiContext.GetType(Data.ClassType).GetField(Field).GetValue(Data).AsType<Double>;
  Result := TDBXPlatform.JsonFloat(LValue);
end;

procedure TDoubleInterceptor.StringReverter(Data: TObject; Field, Arg: string);
var
  LRttiContext: TRttiContext;
  LValue: Double;
begin
  LValue := TDBXPlatform.JsonToFloat(Arg);
  LRttiContext.GetType(Data.ClassType).GetField(Field).SetValue(Data, TValue.From<Double>(LValue));
end;

end.
