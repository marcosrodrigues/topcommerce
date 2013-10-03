unit ContaPagar;

interface

uses
  DBXJSONReflect, RTTI, DBXPlatform, Generics.Collections, ItemPedidoVenda, Fornecedor;

type
  TDoubleInterceptor = class(TJSONInterceptor)
  public
    function StringConverter(Data: TObject; Field: string): string; override;
    procedure StringReverter(Data: TObject; Field: string; Arg: string); override;
  end;

  TContaPagar = class
  private
    FId: integer;
    FFornecedor: TFornecedor;
    [JSONReflect(ctString, rtString, TDoubleInterceptor, nil, true)]
    FVencimento: TDateTime;
    [JSONReflect(ctString, rtString, TDoubleInterceptor, nil, true)]
    FValor: Currency;
    FObservacoes: string;
    FBaixada: Boolean;
  public
    property Id: integer read FId write FId;
    property Fornecedor: TFornecedor read FFornecedor write FFornecedor;
    property Vencimento: TDateTime read FVencimento write FVencimento;
    property Valor: Currency read FValor write FValor;
    property Observacoes: string read FObservacoes write FObservacoes;
    property Baixada: Boolean read FBaixada write FBaixada;

    constructor Create; overload;
    constructor Create(Id: integer); overload;
    destructor Destroy; override;
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

{ TContaPagar }

constructor TContaPagar.Create;
begin

end;

constructor TContaPagar.Create(Id: integer);
begin
  Self.Id := Id;
end;

destructor TContaPagar.Destroy;
begin
  if Assigned(FFornecedor) then
    FFornecedor.Free;
  inherited;
end;

end.
