unit PedidoVenda;

interface

uses
  DBXJSONReflect, RTTI, DBXPlatform, Generics.Collections, ItemPedidoVenda, Cliente;

type
  TDoubleInterceptor = class(TJSONInterceptor)
  public
    function StringConverter(Data: TObject; Field: string): string; override;
    procedure StringReverter(Data: TObject; Field: string; Arg: string); override;
  end;

  TPedidoVenda = class
  private
    FCodigo: string;
    [JSONReflect(ctString, rtString, TDoubleInterceptor, nil, true)]
    FData: TDateTime;
    FCliente: TCliente;
    FNomeClienteAvulso: string;
    [JSONReflect(ctString, rtString, TDoubleInterceptor, nil, true)]
    FDesconto: Currency;
    FTipoPagamento: Integer;
    FItens: TList<TItemPedidoVenda>;
    FFechada: Boolean;
    [JSONReflect(ctString, rtString, TDoubleInterceptor, nil, true)]
    FDescontoPercentual: Currency;
    [JSONReflect(ctString, rtString, TDoubleInterceptor, nil, true)]
    FTotal: Currency;
    FCancelada: Boolean;
    [JSONReflect(ctString, rtString, TDoubleInterceptor, nil, true)]
    FRecebido: Currency;
    [JSONReflect(ctString, rtString, TDoubleInterceptor, nil, true)]
    FTroco: Currency;
    FLoginUsuario: string;
  public
    property Codigo: string read FCodigo write FCodigo;
    property Data: TDateTime read FData write FData;
    property Cliente: TCliente read FCliente write FCliente;
    property NomeClienteAvulso: string read FNomeClienteAvulso write FNomeClienteAvulso;
    property Desconto: Currency read FDesconto write FDesconto;
    property TipoPagamento: Integer read FTipoPagamento write FTipoPagamento;
    property Itens: TList<TItemPedidoVenda> read FItens write FItens;
    property Fechada: Boolean read FFechada write FFechada;
    property DescontoPercentual: Currency read FDescontoPercentual write FDescontoPercentual;
    property Total: Currency read FTotal write FTotal;
    property Cancelada: Boolean read FCancelada write FCancelada;
    property Recebido: Currency read FRecebido write FRecebido;
    property Troco: Currency read FTroco write FTroco;
    property LoginUsuario: string read FLoginUsuario write FLoginUsuario;
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
