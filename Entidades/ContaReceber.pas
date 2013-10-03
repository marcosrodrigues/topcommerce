unit ContaReceber;

interface

uses
  DBXJSONReflect, RTTI, DBXPlatform, Generics.Collections, ItemPedidoVenda, Cliente;

type
  TDoubleInterceptor = class(TJSONInterceptor)
  public
    function StringConverter(Data: TObject; Field: string): string; override;
    procedure StringReverter(Data: TObject; Field: string; Arg: string); override;
  end;

  TContaReceber = class
  private
    FId: integer;
    FCliente: TCliente;
    FNomeClienteAvulso: string;
    [JSONReflect(ctString, rtString, TDoubleInterceptor, nil, true)]
    FVencimento: TDateTime;
    [JSONReflect(ctString, rtString, TDoubleInterceptor, nil, true)]
    FValor: Currency;
    FObservacoes: string;
    FBaixada: Boolean;
  public
    property Id: integer read FId write FId;
    property Cliente: TCliente read FCliente write FCliente;
    property NomeClienteAvulso: string read FNomeClienteAvulso write FNomeClienteAvulso;
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

{ TContaReceber }

constructor TContaReceber.Create;
begin

end;

constructor TContaReceber.Create(Id: integer);
begin
  Self.FId := Id;
end;

destructor TContaReceber.Destroy;
begin
  if Assigned(FCliente) then
    FCliente.Free;
  inherited;
end;

end.
