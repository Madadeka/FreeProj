unit MAIN;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.Menus, Vcl.StdCtrls, Vcl.Dialogs, Vcl.Buttons, Winapi.Messages,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdActns, Vcl.ActnList, Vcl.ToolWin,
  Vcl.ImgList, System.ImageList, System.Actions, FireDAC.Phys.PGDef,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.PG, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, TFrmOperatorU, TFrmStatistU;

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    miOperator: TMenuItem;
    miStatist: TMenuItem;
    ImageList1: TImageList;
    plChoiseARM: TPanel;
    plChClient: TPanel;
    btnARMOperator: TButton;
    btnARMStatist: TButton;
    plChLeft: TPanel;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    taConn: TFDConnection;
    procedure FileExit1Execute(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure BtnClic(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses CHILDWIN;

procedure TMainForm.BtnClic(Sender: TObject);
var
  childOperator: TMDIChild;
  childStatist: TFrmStatist;
begin
  plChoiseARM.Visible:= False;
  case TComponent(Sender).Tag of
    0:
      begin
        //выбран Оператор
        childOperator:= TFrmOperator.Create(Application);
        childOperator.Conn:= taConn;
        childOperator.Caption:= 'АРМ Оператора';
      end;
    1:
      begin
        //выбран статист
        childStatist:= TFrmStatist.Create(Application);
        childStatist.Conn:= taConn;
        childStatist.Caption:= 'АРМ Статиста';
      end;
    else
      begin
        //
      end;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown:= true;
{$ENDIF}
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  plChLeft.Width:= plChoiseARM.Width div 2;
end;

procedure TMainForm.FileExit1Execute(Sender: TObject);
begin
  Close;
end;

end.
