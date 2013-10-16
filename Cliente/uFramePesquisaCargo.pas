unit uFramePesquisaCargo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TFramePesquisaCargo = class(TFrame)
    Label3: TLabel;
    edtIdCargo: TEdit;
    bbtConsultarCargo: TBitBtn;
    edtDescricaoCargo: TEdit;
    procedure bbtConsultarCargoClick(Sender: TObject);
    procedure edtIdCargoExit(Sender: TObject);
    procedure edtIdCargoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure ConsultaCargo;
  public
    { Public declarations }
  end;

implementation

uses uCargoDAOClient, uFrmPrincipal, uFrmConsultaCargo;

{$R *.dfm}

{ TFramePesquisaCargo }

procedure TFramePesquisaCargo.bbtConsultarCargoClick(Sender: TObject);
var
  f: TFrmConsultaCargo;
begin
  f := TFrmConsultaCargo.Create(Self);
  try
    f.ShowModal;
    if (Assigned(f.Cargo)) then
    begin
      edtIdCargo.Text        := IntToStr(f.Cargo.Id);
      edtDescricaoCargo.Text := f.Cargo.Descricao;
    end;
  finally
    f.Free;
  end;
end;

procedure TFramePesquisaCargo.ConsultaCargo;
var
  DAOClient: TCargoDAOClient;
begin
  if (edtIdCargo.Text <> '') then
  begin
    DAOClient := TCargoDAOClient.Create(FrmPrincipal.ConnServidor.DBXConnection);
    try
      edtDescricaoCargo.Text := DAOClient.FindById(StrToIntDef(edtIdCargo.Text,0)).Descricao;
    finally
      DAOClient.Free;
    end;
  end
  else
    edtDescricaoCargo.Clear;
end;

procedure TFramePesquisaCargo.edtIdCargoExit(Sender: TObject);
begin
  ConsultaCargo;
end;

procedure TFramePesquisaCargo.edtIdCargoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Ord(Key) = 13) then
    ConsultaCargo;
end;

end.
