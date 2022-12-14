unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  UFrame;

type



  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btnClose: TButton;
    btnNewWindow: TButton;
    pcMainPages: TPageControl;
    procedure btnNewWindowClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CloseFrame(Sender: TObject);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.btnNewWindowClick(Sender: TObject);
var
  tempTabSheet : TTabSheet;
  tempFrame: TTestFrame;
begin
  if pcMainPages.PageCount < 5 then
  begin
    tempTabSheet := TTabSheet.Create(Self);
    tempTabSheet.Caption:= 'Страница ' + IntToStr(pcMainPages.PageCount + 1);

    tempFrame := TTestFrame.Create(nil);
    tempFrame.Parent := tempTabSheet;
    tempFrame.Align := alClient;
    tempFrame.Name := 'tempFrame';
    tempFrame.btnClose.OnClick := CloseFrame;

    tempTabSheet.PageControl:= pcMainPages;
  end;

end;

procedure TForm1.CloseFrame(Sender: TObject);
var
  i: Integer;
  tempFrame: TTestFrame;
  tempTabSheet : TTabSheet;
begin
  if pcMainPages.PageCount > 0 then
  begin
    tempFrame := TTestFrame(pcMainPages.ActivePage.FindChildControl('tempFrame'));
    if Assigned(tempFrame) then
      FreeAndNil(tempFrame);
    tempTabSheet := pcMainPages.ActivePage;
    FreeAndNil(tempTabSheet);
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: Integer;
begin
  if pcMainPages.PageCount > 0 then
  begin
    for i := 0 to pcMainPages.PageCount - 1 do
      CloseFrame(Sender);
  end;
end;

initialization
  ReportMemoryLeaksOnShutdown := true;

end.
