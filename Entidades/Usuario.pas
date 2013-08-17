unit Usuario;

interface

type
  TUsuario = class
  private
    FLogin: string;
    FSenha: string;
    FUltimoAcesso: TDateTime;
  public
    property Login: string read FLogin write FLogin;
    property Senha: string read FSenha write FSenha;
    property UltimoAcesso: TDateTime read FUltimoAcesso write FUltimoAcesso;

    constructor Create; overload;
    constructor Create(Login, Senha: string); overload;
    constructor Create(Login, Senha: string; UltimoAcesso: TDateTime); overload;
  end;

implementation

{ TUsuario }

constructor TUsuario.Create;
begin

end;

constructor TUsuario.Create(Login, Senha: string);
begin
  Self.FLogin := Login;
  Self.FSenha := Senha;
end;

constructor TUsuario.Create(Login, Senha: string; UltimoAcesso: TDateTime);
begin
  Self.FLogin       := Login;
  Self.FSenha       := Senha;
  Self.UltimoAcesso := UltimoAcesso;
end;

end.
