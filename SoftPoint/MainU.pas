unit MainU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DataU, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, LoggerU, Generics.Collections;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    eServer: TEdit;
    Label2: TLabel;
    ePort: TEdit;
    Label3: TLabel;
    eUser: TEdit;
    Label4: TLabel;
    ePass: TEdit;
    Label5: TLabel;
    ePeriod: TEdit;
    btnStop: TButton;
    btnStart: TButton;
    sgTestObjects: TStringGrid;
    tUpdateQuery: TTimer;
    procedure EditExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure FillMainGridHeader();
    procedure FillMainGrid();
    procedure CrearMainGrid();
    procedure tUpdateQueryTimer(Sender: TObject);
  private
    { Private declarations }
    FOptions: TOptions;
    FLog: TLogger;

  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.btnStartClick(Sender: TObject);
var
  str: string;
begin
  str := 'Connection ok';
  if DataModule1.CreateConnection(FOptions) = sRetErr then
    begin
      ShowMessage('Connection error');
      str := 'Connection error';
    end;
  FLog.AddLogStr(str);
  CrearMainGrid;
  FillMainGrid;
  tUpdateQuery.Interval := FOptions.oPeriod;
  FLog.AddLogStr('timer start');
  tUpdateQuery.Enabled := True;
end;

procedure TMainForm.btnStopClick(Sender: TObject);
begin
  tUpdateQuery.Enabled := False;
  FLog.AddLogStr('timer stop');
  DataModule1.aqTestObjects.Close;
  DataModule1.cDBCon.Close;
end;

procedure TMainForm.CrearMainGrid;
var
  i: Integer;
begin
  for I := sgTestObjects.RowCount - 1 downto 1 do
  begin
    sgTestObjects.Cells[0, i] := '';
    sgTestObjects.Cells[1, i] := '';
    sgTestObjects.Cells[2, i] := '';
    sgTestObjects.Cells[3, i] := '';
  end;
  sgTestObjects.RowCount := 2;
end;

procedure TMainForm.EditExit(Sender: TObject);
begin
  case TComponent(Sender).tag of
    //Server
    0:
      FOptions.oServer := eServer.Text;
    //Port
    1:
      FOptions.oPort := StrToInt(ePort.Text);
    //User
    2:
      FOptions.oUser := eUser.Text;
    //Pass
    3:
      FOptions.oPass := ePass.Text;
    //Period
    4:
      FOptions.oPeriod := StrToInt(ePeriod.Text);
  end;
end;

procedure TMainForm.FillMainGrid;
var
  itemList: TList<TTestObject>;
  i, j: Integer;
begin
  itemList := TList<TTestObject>.Create;
  try
    if DataModule1.ReadObjectList(itemList) = sRetOk then
    begin
      i := 1;
      while i <= itemList.Count do
      begin
        sgTestObjects.Cells[0,sgTestObjects.RowCount - 1] := itemList.Items[i - 1].oName;
        sgTestObjects.Cells[1,sgTestObjects.RowCount - 1] := itemList.Items[i - 1].oInfo;
        j := 0;
        while j < Length(itemList.Items[i - 1].oVal) do
        begin
          sgTestObjects.RowCount := sgTestObjects.RowCount +1;
          sgTestObjects.Cells[2,sgTestObjects.RowCount - 1] := VarToStr(itemList.Items[i - 1].oVal[j].oValue);
          sgTestObjects.Cells[3,sgTestObjects.RowCount - 1] := DateTimeToStr(itemList.Items[i - 1].oVal[j].oDate);

          inc(j);
        end;
        sgTestObjects.RowCount := sgTestObjects.RowCount +1;
        inc(i);
      end;
    end
    else
      ShowMessage('Data read error');
  finally
    FreeAndNil(itemList);
  end;
end;

procedure TMainForm.FillMainGridHeader;
begin
  sgTestObjects.Cells[0,0] := 'Объект';
  sgTestObjects.Cells[1,0] := 'Информация';
  sgTestObjects.Cells[2,0] := 'Значение';
  sgTestObjects.Cells[3,0] := 'Дата';
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FLog.WriteOptions(FOptions);
  FLog.AddLogStr('Application stop');
  FreeAndNil(FLog);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FLog := TLogger.Create('log.txt');
  FLog.AddLogStr('Application start');
  FOptions := FLog.GetOptions;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  eServer.Text := FOptions.oServer;
  ePort.Text := IntToStr(FOptions.oPort);
  eUser.Text := FOptions.oUser;
  ePass.Text := FOptions.oPass;
  ePeriod.Text := IntToStr(FOptions.oPeriod);
  FillMainGridHeader;
end;

procedure TMainForm.tUpdateQueryTimer(Sender: TObject);
begin
  FLog.AddLogStr('update sgTestObjects');
  CrearMainGrid;
  FillMainGrid;
end;

initialization
  ReportMemoryLeaksOnShutdown := true;

end.
