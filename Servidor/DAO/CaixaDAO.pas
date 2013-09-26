unit CaixaDAO;

interface

uses
  Classes, DBXCommon, SqlExpr, Usuario, SysUtils, Caixa, BaseDAO;

{
  Origem: 1 - Venda
  Operacao: 1 - Entrada
}

type
  TCaixaDAO = class(TBaseDAO)
  public
    function Abrir(Caixa: TCaixa): Boolean;
    function CaixaAberto: TCaixa;
    function RegistrarMovimentacao(Origem: integer; Valor: Currency; Operacao: Integer): Boolean;
  end;


implementation

uses uSCPrincipal, StringUtils;

{ TCaixaDAO }

function TCaixaDAO.Abrir(Caixa: TCaixa): Boolean;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    //
    query.SQL.Text := 'INSERT INTO CAIXAS (DATA, FECHADO, VALOR_ABERTURA) VALUES (:DATA, :FECHADO, :VALOR_ABERTURA)';
    //
    query.ParamByName('DATA').AsDateTime := Caixa.Data;
    query.ParamByName('FECHADO').AsBoolean := Caixa.Fechado;
    query.ParamByName('VALOR_ABERTURA').AsCurrency := Caixa.ValorAbertura;
    //
    try
      query.ExecSQL;
      Result := True;
    except
      Result := False;
    end;
  finally
    query.Free;
  end;
end;

function TCaixaDAO.CaixaAberto: TCaixa;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    //
    query.SQL.Text := 'SELECT * FROM CAIXAS WHERE FECHADO = 0';
    query.Open;
    //
    Result := TCaixa.Create;
    Result.Id := query.FieldByName('ID').AsInteger;
    Result.Data := query.FieldByName('DATA').AsDateTime;
    Result.Fechado := False;
    Result.ValorAbertura := query.FieldByName('VALOR_ABERTURA').AsCurrency;
  finally
    query.Free;
  end;
end;

function TCaixaDAO.RegistrarMovimentacao(Origem: integer; Valor: Currency; Operacao: Integer): Boolean;
var
  query: TSQLQuery;
  Caixa: TCaixa;
begin
  Caixa := CaixaAberto;

  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    //
    query.SQL.Text := 'INSERT INTO MOVIMENTACOES_CAIXA (CAIXA_ID, ORIGEM, VALOR, OPERACAO) VALUES (:CAIXA_ID, :ORIGEM, :VALOR, :OPERACAO)';
    //
    query.ParamByName('CAIXA_ID').AsInteger := Caixa.Id;
    query.ParamByName('ORIGEM').AsInteger := Origem;
    query.ParamByName('VALOR').AsCurrency := Valor;
    query.ParamByName('OPERACAO').AsInteger := Operacao;
    //
    try
      query.ExecSQL;
      Result := True;
    except
      Result := False;
    end;
  finally
    query.Free;
  end;
end;

end.
