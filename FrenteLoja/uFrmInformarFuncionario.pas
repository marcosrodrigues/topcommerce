unit uFrmInformarFuncionario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DXPControl, DXPButtons, StdCtrls, pngimage, ExtCtrls, Funcionario, Cargo;

type
  TFrmInformarFuncionario = class(TForm)
    Label5: TLabel;
    Label1: TLabel;
    Panel1: TPanel;
    Image19: TImage;
    edFuncionario: TEdit;
    btnPesquisarFuncionario: TDXPButton;
    btnLimpar: TDXPButton;
    btnInformar: TDXPButton;
    procedure btnInformarClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnPesquisarFuncionarioClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Image19Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Funcionario: TFuncionario;
    Salvar: Boolean;
  end;

var
  FrmInformarFuncionario: TFrmInformarFuncionario;

implementation

uses MensagensUtils, uFrmConsultaFuncionarios;

{$R *.dfm}

procedure TFrmInformarFuncionario.btnInformarClick(Sender: TObject);
begin
  if edFuncionario.Text = '' then
  begin
    Atencao('Informe o funcionário responsável pela venda.');
    Exit;
  end;

  Salvar := True;
  Close;
end;

procedure TFrmInformarFuncionario.btnLimparClick(Sender: TObject);
begin
  edFuncionario.Clear;
  Funcionario := nil;
end;

procedure TFrmInformarFuncionario.btnPesquisarFuncionarioClick(Sender: TObject);
var
  fConsultaFuncionarios: TFrmConsultaFuncionarios;
begin
  fConsultaFuncionarios := TFrmConsultaFuncionarios.Create(Self);
  try
    fConsultaFuncionarios.ShowModal;
    if Assigned(fConsultaFuncionarios.Funcionario) then
    begin
      Funcionario := TFuncionario.Create(fConsultaFuncionarios.Funcionario.Codigo, fConsultaFuncionarios.Funcionario.Nome, TCargo.Create(fConsultaFuncionarios.Funcionario.Cargo.Id, fConsultaFuncionarios.Funcionario.Cargo.Descricao));

      edFuncionario.Text := Funcionario.Nome;

      btnInformar.SetFocus;
    end;
  finally
    fConsultaFuncionarios.Free;
  end;
end;

procedure TFrmInformarFuncionario.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if edFuncionario.Text = '' then
  begin
    Atencao('Informe o funcionário responsável pela venda.');
    CanClose := False;
  end;
end;

procedure TFrmInformarFuncionario.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F6 then
    btnPesquisarFuncionario.Click;
end;

procedure TFrmInformarFuncionario.Image19Click(Sender: TObject);
begin
  Self.Close;
end;

end.
