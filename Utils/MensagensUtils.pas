unit MensagensUtils;

interface

uses
  Dialogs;

function Confirma(mensagem: string): Boolean;
procedure Informacao(mensagem: string);
procedure Erro(mensagem: string);
procedure Atencao(mensagem: string);

implementation

function Confirma(mensagem: string): Boolean;
begin
  Result := MessageDlg(mensagem, mtConfirmation, mbYesNo, 1) = 6;
end;

procedure Informacao(mensagem: string);
begin
  MessageDlg(mensagem, mtInformation, [mbOK], 1);
end;

procedure Erro(mensagem: string);
begin
  MessageDlg(mensagem, mtError, [mbOK], 1);
end;

procedure Atencao(mensagem: string);
begin
  MessageDlg(mensagem, mtWarning, [mbOK], 1);
end;

end.
