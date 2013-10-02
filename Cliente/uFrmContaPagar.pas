unit uFrmContaPagar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCrudBase, DB, DBClient, StdCtrls, Grids, DBGrids, Buttons,
  ExtCtrls, uContaPagarDAOClient;

type
  TFrmContaPagar = class(TFrmCrudBase)
    cdsCrudID: TIntegerField;
    cdsCrudFORNECEDOR_CODIGO: TStringField;
    cdsCrudVENCIMENTO: TDateTimeField;
    cdsCrudVALOR: TCurrencyField;
    cdsCrudOBSERVACOES: TStringField;
    cdsCrudBAIXADA: TBooleanField;
    cdsCrudNOME: TStringField;
    sbtBaixarConta: TSpeedButton;
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

uses DataUtils, uFrmDadosContaPagar, TypesUtils, MensagensUtils, ContaPagar;

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
    //if (DAOClient.Delete(TContaPagar.Create(cdsCrudCODIGO.AsString))) then
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
    {f.Cliente.Codigo := cdsCrudCODIGO.AsString;
    f.Cliente.Nome   := cdsCrudNOME.AsString;
    f.Cliente.Telefone := cdsCrudTELEFONE.AsString;}

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
