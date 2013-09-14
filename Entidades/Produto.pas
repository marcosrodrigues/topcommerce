unit Produto;

interface

uses
  DBXJSONReflect, RTTI, DBXPlatform, TipoProduto, Generics.Collections,
  FornecedorProduto, Validade;

type
  TDoubleInterceptor = class(TJSONInterceptor)
  public
    function StringConverter(Data: TObject; Field: string): string; override;
    procedure StringReverter(Data: TObject; Field: string; Arg: string); override;
  end;

  TProduto = class
  private
    FCodigo: string;
    FTipoProduto: TTipoProduto;
    FDescricao: string;
    FCodigoBarras: string;
    [JSONReflect(ctString, rtString, TDoubleInterceptor, nil, true)]
    FPrecoVenda: Currency;
    FQuantidadeEstoque: Integer;
    FFornecedores: TList<TFornecedorProduto>;
    FValidades: TList<TValidade>;
    FEstoqueMinimo: Integer;
  public
    property Codigo: string read FCodigo write FCodigo;
    property TipoProduto: TTipoProduto read FTipoProduto write FTipoProduto;
    property Descricao: string read FDescricao write FDescricao;
    property CodigoBarras: string read FCodigoBarras write FCodigoBarras;
    property PrecoVenda: Currency read FPrecoVenda write FPrecoVenda;
    property QuantidadeEstoque: Integer read FQuantidadeEstoque write FQuantidadeEstoque;
    property Fornecedores: TList<TFornecedorProduto> read FFornecedores write FFornecedores;
    property Validades: TList<TValidade> read FValidades write FValidades;
    property EstoqueMinimo: Integer read FEstoqueMinimo write FEstoqueMinimo;

    constructor Create; overload;
    constructor Create(Codigo: string); overload;
    constructor Create(Codigo: string; TipoProduto: TTipoProduto; Descricao,
      CodigoBarras: string; PrecoVenda: Currency; EstoqueMinimo: Integer; Fornecedores: TList<TFornecedorProduto>; Validades: TList<TValidade>); overload;

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

{ TProduto }

constructor TProduto.Create;
begin

end;

constructor TProduto.Create(Codigo: string);
begin
  Self.FCodigo := Codigo;
end;

constructor TProduto.Create(Codigo: string; TipoProduto: TTipoProduto; Descricao,
  CodigoBarras: string; PrecoVenda: Currency; EstoqueMinimo: Integer; Fornecedores: TList<TFornecedorProduto>;
  Validades: TList<TValidade>);
begin
  Self.FCodigo        := Codigo;
  Self.FTipoProduto   := TipoProduto;
  Self.FDescricao     := Descricao;
  Self.FCodigoBarras  := CodigoBarras;
  Self.FPrecoVenda    := PrecoVenda;
  Self.FEstoqueMinimo := EstoqueMinimo;
  Self.FFornecedores  := Fornecedores;
  Self.FValidades     := Validades;
end;

destructor TProduto.Destroy;
begin
  if (Assigned(FTipoProduto)) then
    FTipoProduto.Free;
  inherited;
end;

end.
