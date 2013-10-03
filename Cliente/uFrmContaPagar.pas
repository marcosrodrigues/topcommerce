unit uFrmContaPagar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCrudBase, DB, DBClient, StdCtrls, Grids, DBGrids, Buttons,
  ExtCtrls, uContaPagarDAOClient;

type
  TFrmContaPagar = class(TFrmCrudBase)
    cdsCrudFORNECEDOR_CODIGO: TStringField;
    cdsCrudVENCIMENTO: TDateTimeField;
    cdsCrudVALOR: TCurrencyField;
    cdsCrudOBSERVACOES: TStringField;
    cdsCrudBAIXADA: TBooleanField;
    cdsCrudNOME: TStringField;
    sbtBaixarConta: TSpeedButton;
    cdsCrudID: TIntegerField;
  private
    { Private declarations }
    DAOClient: TContaPagarDAOClient;
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
  FrmContaPagar: TFrmContaPagar;

implementation

uses DataUtils, uFrmDadosContaPagar, TypesUtils, MensagensUtils, ContaPagar,
  uFornecedorDAOClient, Fornecedor;

{$R *.dfm}

{ TFrmContaPagar }

procedure TFrmContaPagar.CreateDAOClient;
begin
  inherited;
  DAOClient := TContaPagarDAOClient.Create(DBXConnection);
end;

procedure TFrmContaPagar.DestroyDAOClient;
begin
  DAOClient.Free;
  inherited;
end;

procedure TFrmContaPagar.OnDelete;
begin
  inherited;
  if (Confirma('Deseja excluir esta Conta a Pagar?')) then
    if (DAOClient.Delete(TContaPagar.Create(cdsCrudID.AsInteger))) then
      cdsCrud.Delete
    else
      Erro('Ocorreu algum erro durante a exlusão.');
end;

procedure TFrmContaPagar.OnEdit;
var
  f: TFrmDadosContaPagar;
begin
  inherited;
  f := TFrmDadosContaPagar.Create(Self);
  try
    f.ContaPagar.Id := cdsCrudID.AsInteger;
    f.ContaPagar.Fornecedor := TFornecedor.Create(cdsCrudFORNECEDOR_CODIGO.AsString, cdsCrudNOME.AsString, '');
    f.ContaPagar.Vencimento := cdsCrudVENCIMENTO.AsDateTime;
    f.ContaPagar.Valor := cdsCrudVALOR.AsCurrency;
    f.ContaPagar.Observacoes := cdsCrudOBSERVACOES.AsString;

    f.Operacao := opEdit;
    f.ShowModal;
  finally
    f.Free;
  end;
end;

procedure TFrmContaPagar.OnInsert;
var
  f: TFrmDadosContaPagar;
begin
  inherited;
  f := TFrmDadosContaPagar.Create(Self);
  try
    f.Operacao := opInsert;
    f.ShowModal;
  finally
    f.Free;
  end;
end;

procedure TFrmContaPagar.OnPesquisar;
begin
  inherited;
  cdsCrud.Filtered := False;
  cdsCrud.Filter   := 'UPPER(NOME) LIKE ' + QuotedStr('%'+UpperCase(edtPesquisar.Text)+'%');
  cdsCrud.Filtered := True;
end;

procedure TFrmContaPagar.OnShow;
begin
  inherited;
  CopyReaderToClientDataSet(DAOClient.List, cdsCrud);
end;

end.
