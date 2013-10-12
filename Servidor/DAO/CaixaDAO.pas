unit CaixaDAO;

interface

uses
  Classes, DBXCommon, SqlExpr, Usuario, SysUtils, Caixa, BaseDAO;

{
  Origem: 1 - Venda
  Operacao: 1 - Entrada
}

//TODO: Criar a possibilidade de ter mais de um caixa aberto

type
  TCaixaDAO = class(TBaseDAO)
  public
    function Abrir(Caixa: TCaixa): Boolean;
    function CaixaAberto: TCaixa;
    function RegistrarMovimentacao(Origem: integer; Valor: Currency; Operacao: Integer): Boolean;
    function Fechar: Boolean;
    function Relatorio(DataInicial, DataFinal: TDateTime): TDBXReader;
    function List: TDBXReader;
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
    if query.IsEmpty then
    begin
      Result := nil;
      Exit;
    end;

    Result := TCaixa.Create;
    Result.Id := query.FieldByName('ID').AsInteger;
    Result.Data := query.FieldByName('DATA').AsDateTime;
    Result.Fechado := False;
    Result.ValorAbertura := query.FieldByName('VALOR_ABERTURA').AsCurrency;
  finally
    query.Free;
  end;
end;

function TCaixaDAO.Fechar: Boolean;
var
  query: TSQLQuery;
  Caixa: TCaixa;
begin
  Caixa := CaixaAberto;

  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    //
    query.SQL.Text := 'UPDATE CAIXAS SET FECHADO = 1 WHERE ID = :ID';
    //
    query.ParamByName('ID').AsInteger := Caixa.Id;
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

function TCaixaDAO.List: TDBXReader;
begin
  PrepareCommand;
  FComm.Text := 'SELECT C.ID, C.DATA, C.FECHADO, C.VALOR_ABERTURA, M.ORIGEM, M.VALOR, M.OPERACAO '+
                'FROM CAIXAS C '+
                'LEFT JOIN MOVIMENTACOES_CAIXA M ON M.CAIXA_ID = C.ID '+
                'ORDER BY C.ID DESC, C.DATA DESC';
  Result := FComm.ExecuteQuery;
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

function TCaixaDAO.Relatorio(DataInicial, DataFinal: TDateTime): TDBXReader;
begin
  PrepareCommand;
  FComm.Text := 'SELECT C.ID, C.DATA, C.FECHADO, C.VALOR_ABERTURA, M.ORIGEM, M.VALOR, M.OPERACAO '+
                'FROM CAIXAS C '+
                'LEFT JOIN MOVIMENTACOES_CAIXA M ON M.CAIXA_ID = C.ID '+
                'WHERE C.ID <> 0 ';
  if (DataInicial <> 0) then
    FComm.Text := FComm.Text + 'AND CONVERT(CHAR(8), DATA, 112) >= '+FormatDateTime('yyyymmdd', DataInicial)+' ';
  if (DataFinal <> 0) then
    FComm.Text := FComm.Text + 'AND CONVERT(CHAR(8), DATA, 112) <= '+FormatDateTime('yyyymmdd', DataFinal)+' ';

  Result := FComm.ExecuteQuery;
end;

end.
