unit DXPSelectBrowser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, StdCtrls, DXPEdit, DXPMaskEdit;

type
  TFrmDXPSelectBrowser = class(TForm)
    grdSelectBrowser: TDBGrid;
    procedure grdSelectBrowserKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grdSelectBrowserDblClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grdSelectBrowserKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    FEditKey: TCustomEdit;
    FKey: string;
    FCaption: string;
    FOnSelect: TNotifyEvent;
    //
    procedure Select;
    { Private declarations }
  public
    procedure ShowBrowser;

    property EditKey: TCustomEdit read FEditKey write FEditKey;
    property Key: string read FKey write FKey;
    property Caption: string read FCaption write FCaption;
    //
    property OnSelect: TNotifyEvent read FOnSelect write FOnSelect;
    { Public declarations }
  end;

var
  FrmDXPSelectBrowser: TFrmDXPSelectBrowser;

implementation

{$R *.dfm}

{ TFrmDXPSelectBrowser }

procedure TFrmDXPSelectBrowser.FormCreate(Sender: TObject);
begin
  SetWindowLong(Handle,GWL_STYLE, GetWindowLong(Handle, GWL_STYLE ) and not WS_CAPTION);
end;

procedure TFrmDXPSelectBrowser.FormDeactivate(Sender: TObject);
begin
  Close;
  TCustomEdit( Owner ).SetFocus;
end;

procedure TFrmDXPSelectBrowser.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: Close;
  end;
end;

procedure TFrmDXPSelectBrowser.grdSelectBrowserDblClick(Sender: TObject);
begin
  if grdSelectBrowser.SelectedIndex <> - 1 then
    Select;
end;

procedure TFrmDXPSelectBrowser.grdSelectBrowserKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_UP: if grdSelectBrowser.DataSource.DataSet.RecNo = 1 then
                TButtonedEdit( Owner ).SetFocus;
  end;
end;

procedure TFrmDXPSelectBrowser.grdSelectBrowserKeyPress(Sender: TObject; var Key: Char);
begin
  if Ord(Key) = 13 then
    Select;
end;

procedure TFrmDXPSelectBrowser.Select;
begin
  // Setar o codigo no edit associado ao buttonededit
  if not( csDesigning in ComponentState ) and ( FCaption = '' ) then
    raise Exception.Create( 'Não foi informado o Field para o caption.' );

  FOnSelect( Self );
  TCustomEdit( Owner ).Text := grdSelectBrowser.DataSource.DataSet.FieldByName( FCaption ).AsString;
  Close;
end;

procedure TFrmDXPSelectBrowser.ShowBrowser;
begin
  if not( Assigned( grdSelectBrowser.DataSource ) ) then
    raise Exception.Create( 'Nenhum DataSource foi ligado ao DXPSelect.' );

  grdSelectBrowser.DataSource.DataSet.Filtered := False;
  Left := TCustomEdit( Owner ).ClientToScreen( Point( 0,0 ) ).X;
  Top  := TCustomEdit( Owner ).ClientToScreen( Point( 0,0 ) ).Y + TCustomEdit( Owner ).Height;
  Show;
end;

end.
