unit uFrmExcluirItem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, pngimage;

type
  TFrmExcluirItem = class(TForm)
    grdItens: TDBGrid;
    Panel1: TPanel;
    Image19: TImage;
    procedure grdItensKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Image19Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Excluir: Boolean;
  end;

var
  FrmExcluirItem: TFrmExcluirItem;

implementation

uses uFrmPrincipal;

{$R *.dfm}

procedure TFrmExcluirItem.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: Close;
  end;
end;

procedure TFrmExcluirItem.grdItensKeyPress(Sender: TObject; var Key: Char);
begin
  if (Ord(Key) = 13) then
  begin
    Excluir := True;
    Close;
  end;
end;

procedure TFrmExcluirItem.Image19Click(Sender: TObject);
begin
  Self.Close;
end;

end.
