unit MensagensUtils;

interface

uses
  Dialogs, Forms, Graphics, StdCtrls, Windows, SysUtils, Controls, uFrmConfirm;

function Confirma(mensagem: string): Boolean;
procedure Informacao(mensagem: string);
procedure Erro(mensagem: string);
procedure Atencao(mensagem: string);

function MessageDlgCustom(const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; ToCaptions: array of string; customFont: TFont) : integer;
procedure ModifyDialog(var frm: TForm; ToCaptions : array of string; customFont : TFont = nil);

implementation

uses uFrmInformation, uFrmError, uFrmWarning;

function Confirma(mensagem: string): Boolean;
var
  f: TFrmConfirm;
begin
  Result := False;

  f := TFrmConfirm.Create(nil);
  try
    f.Mensagem := mensagem;
    case f.ShowModal of
      mrYes: Result := True;
      mrNo: Result := False;
    end;
  finally
    f.Free;
  end;
end;

procedure Informacao(mensagem: string);
var
  f: TFrmInformation;
begin
  f := TFrmInformation.Create(nil);
  try
    f.Mensagem := mensagem;
    f.ShowModal;
  finally
    f.Free;
  end;
end;

procedure Erro(mensagem: string);
var
  f: TFrmError;
begin
  f := TFrmError.Create(nil);
  try
    f.Mensagem := mensagem;
    f.ShowModal;
  finally
    f.Free;
  end;
end;

procedure Atencao(mensagem: string);
var
  f: TFrmWarning;
begin
  f := TFrmWarning.Create(nil);
  try
    f.Mensagem := mensagem;
    f.ShowModal;
  finally
    f.Free;
  end;
end;

function GetTextWidth(s: string; fnt: TFont; HWND: THandle): integer;
var
  canvas: TCanvas;
begin
  canvas := TCanvas.Create;
  try
    canvas.Handle := GetWindowDC(HWND);
    canvas.Font := fnt;
    Result := canvas.TextWidth(s);
  finally
    ReleaseDC(HWND,canvas.Handle);
    FreeAndNil(canvas);
  end;
end;

function MessageDlgCustom(const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; ToCaptions: array of string; customFont: TFont): integer;
var
  dialog : TForm;
begin
  try
    dialog := CreateMessageDialog(Msg, DlgType, Buttons);
    dialog.Position := poScreenCenter;
    ModifyDialog(dialog,ToCaptions,customFont);
    Result := dialog.ShowModal;
  finally
    dialog.Release;
  end;
end;

procedure ModifyDialog(var frm: TForm; ToCaptions: array of string; customFont: TFont);
const
  c_BtnMargin = 20;
var
  i,oldButtonWidth,newButtonWidth,btnCnt : integer;
begin
  oldButtonWidth := 0;
  newButtonWidth := 0;
  btnCnt := 0;
  for i := 0 to frm.ComponentCount - 1 do begin
    //if they asked for a custom font, assign it here
    if customFont <> nil then begin
      if frm.Components[i] is TLabel then begin
        TLabel(frm.Components[i]).Font := customFont;
      end;
      if frm.Components[i] is TButton then begin
        TButton(frm.Components[i]).Font := customFont;
      end;
    end;
    if frm.Components[i] is TButton then begin
      //check buttons for a match with a "from" (default) string
      //if found, replace with a "to" (custom) string
      Inc(btnCnt);

      //record the button width *before* we changed the caption
      oldButtonWidth := oldButtonWidth + TButton(frm.Components[i]).Width;

      //change the caption
      TButton(frm.Components[i]).Caption := ToCaptions[btnCnt - 1];

      //auto-size the button for the new caption
      TButton(frm.Components[i]).Width :=
        GetTextWidth(TButton(frm.Components[i]).Caption,
          TButton(frm.Components[i]).Font,frm.Handle) + c_BtnMargin;

      //the first button can stay where it is.
      //all other buttons need to slide over to the right of the one b4.
      if (1 < btnCnt) and (0 < i) then
      begin
        TButton(frm.Components[i]).Left :=
          TButton(frm.Components[i-1]).Left +
          TButton(frm.Components[i-1]).Width + c_BtnMargin;
      end;

      //record the button width *after* changing the caption
      newButtonWidth := newButtonWidth + TButton(frm.Components[i]).Width;
    end;  //if TButton
  end;  //for i

  //whatever we changed the buttons by, widen / shrink the form accordingly
  frm.Width := Round(frm.Width + (newButtonWidth - oldButtonWidth) + (c_BtnMargin * btnCnt));
end;

end.
