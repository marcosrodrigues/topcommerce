unit uFrmContaReceber;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCrudBase, DB, DBClient, StdCtrls, Grids, DBGrids, Buttons,
  ExtCtrls, uContaReceberDAOClient, ContaReceber, Cliente;

type
  TFrmContaReceber = class(TFrmCrudBase)
    cdsCrudID: TIntegerField;
    cdsCrudVENCIMENTO: TDateTimeField;
    cdsCrudVALOR: TCurrencyField;
    cdsCrudOBSERVACOES: TStringField;
    cdsCrudBAIXADA: TBooleanField;
    cdsCrudCLIENTE_CODIGO: TStringField;
    cdsCrudNOME: TStringField;
    cdsCrudNOME_CLIENTE_AVULSO: TStringField;
    sbtBaixarConta: TSpeedButton;
    cdsCrudRESTANTE: TCurrencyField;
    procedure sbtBaixarContaClick(Sender: TObject);
  private
    { Private declarations }
    DAOClient: TContaReceberDAOClient;
  protected
    procedure CreateDAOClient; override;
    procedure DestroyDAOClient; override;
    procedure OnShow; override;
    procedure OnInsert; override;
    procedure OnEdit; override;
    procedure OnDelete; override;
    procedure OnPesquisar; override;
  public
    { Public declarations }
  end;

var
  FrmContaReceber: TFrmContaReceber;

implementation

uses DataUtils, MensagensUtils, uFrmDadosContaReceber, TypesUtils,
  uFrmBaixarContaReceber;

{$R *.dfm}

{ TFrmContaReceber }

procedure TFrmContaReceber.CreateDAOClient;
begin
  inherited;
  DAOClient := TContaReceberDAOClient.Create(DBXConnection);
end;

procedure TFrmContaReceber.DestroyDAOClient;
begin
  DAOClient.Free;
  inherited;
end;

procedure TFrmContaReceber.OnDelete;
begin
  inherited;
  if (Confirma('Deseja excluir esta Conta a Pagar?')) then
    if (DAOClient.Delete(TContaReceber.Create(cdsCrudID.AsInteger))) then
      cdsCrud.Delete
    else
      Erro('Ocorreu algum erro durante a exlusão.');
end;

procedure TFrmContaReceber.OnEdit;
var
  f: TFrmDadosContaReceber;
begin
  inherited;
  f := TFrmDadosContaReceber.Create(Self);
  try
    f.ContaReceber.Id := cdsCrudID.AsInteger;
    f.ContaReceber.Cliente := TCliente.Create(cdsCrudCLIENTE_CODIGO.AsString, cdsCrudNOME.AsString, '');
    f.ContaReceber.Vencimento := cdsCrudVENCIMENTO.AsDateTime;
    f.ContaReceber.Valor := cdsCrudVALOR.AsCurrency;
    f.ContaReceber.Observacoes := cdsCrudOBSERVACOES.AsString;

    f.Operacao := opEdit;
    f.ShowModal;
  finally
    f.Free;
  end;
end;

procedure TFrmContaReceber.OnInsert;
var
  f: TFrmDadosContaReceber;
begin
  inherited;
  f := TFrmDadosContaReceber.Create(Self);
  try
    f.Operacao := opInsert;
    f.ShowModal;
  finally
    f.Free;
  end;
end;

procedure TFrmContaReceber.OnPesquisar;
begin
  inherited;
  cdsCrud.Filtered := False;
  cdsCrud.Filter   := 'UPPER(NOME) LIKE ' + QuotedStr('%'+UpperCase(edtPesquisar.Text)+'%') + ' OR UPPER(NOME_CLIENTE_AVULSO) LIKE ' + QuotedStr('%'+UpperCase(edtPesquisar.Text)+'%');
  cdsCrud.Filtered := True;
end;

procedure TFrmContaReceber.OnShow;
begin
  inherited;
  CopyReaderToClientDataSet(DAOClient.List, cdsCrud);
end;

procedure TFrmContaReceber.sbtBaixarContaClick(Sender: TObject);
var
  f: TFrmBaixarContaReceber;
begin
  if cdsCrud.IsEmpty then
  begin
    Atencao('Nenhum conta a receber selecionado.');
    Exit;
  end;

  f := TFrmBaixarContaReceber.Create(Self);
  try
    f.ContaReceberId := cdsCrudID.AsInteger;
    f.ValorRestante  := cdsCrudRESTANTE.AsCurrency;
    f.ValorTotal     := cdsCrudVALOR.AsCurrency;
    f.deData.Date    := Now;
    f.cedValor.Value := cdsCrudRESTANTE.AsCurrency;
    f.ShowModal;

    if f.Baixou then
    begin
      if f.BaixaTotal then
        cdsCrud.Delete
      else
      begin
        cdsCrud.Edit;
        cdsCrudRESTANTE.AsCurrency := cdsCrudRESTANTE.AsCurrency - f.cedValor.Value;
        cdsCrud.Post;
      end;
    end;
  finally
    f.Free;
  end;
end;

end.
