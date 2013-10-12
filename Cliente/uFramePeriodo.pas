unit uFramePeriodo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Mask, RxToolEdit;

type
  TFramePeriodo = class(TFrame)
    Label1: TLabel;
    deDataInicial: TDateEdit;
    Label3: TLabel;
    deDataFinal: TDateEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
