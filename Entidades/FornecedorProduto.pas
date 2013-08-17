unit FornecedorProduto;

interface

uses
  Fornecedor, DBXJSONReflect, RTTI, DBXPlatform;

type
  TDoubleInterceptor = class(TJSONInterceptor)
  public
    function StringConverter(Data: TObject; Field: string): string; override;
    procedure StringReverter(Data: TObject; Field: string; Arg: string); override;
  end;

  TFornecedorProduto = class
  private
    FFornecedor: TFornecedor;
    [JSONReflect(ctString, rtString, TDoubleInterceptor, nil, true)]
    FPrecoCompra: Currency;
  public
    property Fornecedor: TFornecedor read FFornecedor write FFornecedor;
    property PrecoCompra: Currency read FPrecoCompra write FPrecoCompra;

    constructor Create; overload;
    constructor Create(Fornecedor: TFornecedor; PrecoCompra: Currency); overload;
  end;

implementation

{ TFornecedorProduto }

constructor TFornecedorProduto.Create;
begin

end;

constructor TFornecedorProduto.Create(Fornecedor: TFornecedor; PrecoCompra: Currency);
begin
  Self.Fornecedor  := Fornecedor;
  Self.FPrecoCompra := PrecoCompra;
end;

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
