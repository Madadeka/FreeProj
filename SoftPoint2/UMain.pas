unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, UWorkThread,
  SyncObjs, IOUtils;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btnStart: TButton;
    btnStop: TButton;
    mMainInfo: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
  private
    { Private declarations }
    Worker1: TWorkThread;
    Worker2: TWorkThread;
    DataObj: TTestThreadData;
    Demonstrator: TDemoThread;
    CriticalSection: TCriticalSection;
    FFileName: string;
  public
    { Public declarations }
    procedure ShowData(const AStringData: string);
    procedure StartTestThreads();
    procedure StopTestThreads();
  end;

const
  DELAY_TIME = 3000;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.btnStartClick(Sender: TObject);
begin
  StartTestThreads();
end;

procedure TMainForm.btnStopClick(Sender: TObject);
begin
  StopTestThreads();
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  tempFile: TextFile;
begin
  CriticalSection := TCriticalSection.Create;
  FFileName := 'TestData.txt';
  DataObj := TTestThreadData.Create;
  AssignFile(tempFile, GetCurrentDir + '\' + FFileName);
  Rewrite(tempFile);
  CloseFile(tempFile);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(CriticalSection);
  FreeAndNil(DataObj);
end;

procedure TMainForm.ShowData(const AStringData: string);
begin
  Self.mMainInfo.Lines.Add(AStringData);
end;

procedure TMainForm.StartTestThreads();
begin
  Worker1 := TWorkThread.Create(True);
  Worker1.id := 1;
  Worker1.FileName := FFileName;
  Worker1.DataObj := DataObj;
  Worker1.CriticalSection := CriticalSection;
  Worker1.STime := DELAY_TIME;
  Worker1.FreeOnTerminate := True;
  Worker1.Priority:=tpNormal;

  Worker2 := TWorkThread.Create(True);
  Worker2.id := 2;
  Worker2.FileName := FFileName;
  Worker2.DataObj := DataObj;
  Worker2.CriticalSection := CriticalSection;
  Worker2.STime := DELAY_TIME;
  Worker2.FreeOnTerminate := True;
  Worker2.Priority:=tpNormal;

  Demonstrator := TDemoThread.Create(True);
  Demonstrator.FileName := FFileName;
  Demonstrator.DataObj := DataObj;
  Demonstrator.CriticalSection := CriticalSection;
  Demonstrator.FreeOnTerminate := True;
  Demonstrator.Priority:=tpNormal;
  Demonstrator.FMainForm := Self;

  Worker1.Start;
  Worker2.Start;
  Demonstrator.Start;
end;

procedure TMainForm.StopTestThreads;
begin
  Worker1.Terminate;
  Worker2.Terminate;
  Demonstrator.Terminate;
end;

initialization
  ReportMemoryLeaksOnShutdown := true;

end.
