unit Funcionario;

interface

uses Cargo;

type
  TFuncionario = class
  private
    FCodigo: string;
    FNome: string;
    FCargo: TCargo;
  public
    property Codigo: string read FCodigo write FCodigo;
    property Nome: string read FNome write FNome;
    property Cargo: TCargo read FCargo write FCargo;

    constructor Create; overload;
    constructor Create(Codigo: string); overload;
    constructor Create(Codigo, Nome: string; Cargo: TCargo); overload;
  end;

implementation

{ TFuncionario }

constructor TFuncionario.Create;
begin
  Self.Cargo := TCargo.Create;
end;

constructor TFuncionario.Create(Codigo: string);
begin
  Self.FCodigo := Codigo;
end;

constructor TFuncionario.Create(Codigo, Nome: string; Cargo: TCargo);
begin
  Self.FCodigo := Codigo;
  Self.FNome   := Nome;
  Self.FCargo  := Cargo;
end;

end.
