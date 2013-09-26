unit Caixa;

interface

uses
  DBXJSONReflect, RTTI, DBXPlatform, Generics.Collections, ItemPedidoVenda, Cliente;

type
  TDoubleInterceptor = class(TJSONInterceptor)
  public
    function StringConverter(Data: TObject; Field: string): string; override;
    procedure StringReverter(Data: TObject; Field: string; Arg: string); override;
  end;

  TCaixa = class
  private
    FId: integer;
    [JSONReflect(ctString, rtString, TDoubleInterceptor, nil, true)]
    FData: TDateTime;
    FFechado: Boolean;
    [JSONReflect(ctString, rtString, TDoubleInterceptor, nil, true)]
    FValorAbertura: Currency;
  public
    property Id: integer read FId write FId;
    property Data: TDateTime read FData write FData;
    property Fechado: Boolean read FFechado write FFechado;
    property ValorAbertura: Currency read FValorAbertura write FValorAbertura;
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
