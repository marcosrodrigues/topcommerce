unit uFrmContaReceber;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCrudBase, DB, DBClient, StdCtrls, Grids, DBGrids, Buttons,
  ExtCtrls, uContaReceberDAOClient;

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

uses DataUtils, MensagensUtils, uFrmDadosContaReceber, TypesUtils;

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
    //if (DAOClient.Delete(TContaReceber.Create(cdsCrudCODIGO.AsString))) then
      cdsCrud.Delete
    else
      Erro('Ocorreu algum erro durante a exlus�o.');
end;

procedure TFrmContaReceber.OnEdit;
var
  f: TFrmDadosContaReceber;
begin
  inherited;
  f := TFrmDadosContaReceber.Create(Self);
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

end.