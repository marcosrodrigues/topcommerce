unit uFrmExcluirItem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids;

type
  TFrmExcluirItem = class(TForm)
    grdItens: TDBGrid;
    procedure grdItensKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

end.
