unit UWorkThread;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Classes, System.SysUtils,
  System.Variants, IOUtils, SyncObjs, Vcl.Forms;

type

  TTestThreadData = class
  public
    CountExecute: Integer;	//количество циклов
    DateTime: TDateTime;	//последнее время записи в файл
  end;

  TWorkThread = class(TThread)
  private
    { Private declarations }
    FCount: Integer;
  protected
    procedure Execute; override;
  public
    id: Integer;
    FileName: string;
    DataObj: TTestThreadData;
    CriticalSection: TCriticalSection;
    STime: Integer;
    procedure WriteDataFile(const ACount: integer; const ANow: TDateTime);
    procedure WriteDataThread(const ACount: integer; const ANow: TDateTime);
  end;

  TDemoThread = class(TThread)
  protected
    procedure Execute; override;
  public
    CriticalSection: TCriticalSection;
    FileName: string;
    DataObj: TTestThreadData;
    FMainForm: TForm;
    function ReadDataFile(): string;
    function ReadDataThread(): string;
  end;

implementation

{ WorkThread }

uses
  UMain;

procedure TWorkThread.Execute;
var
  lNow: TDateTime;
begin
  FCount:= 0;
  while not Terminated do
  begin
    lNow := Now;
    WriteDataFile(FCount, lNow);
    WriteDataThread(FCount, lNow);
    inc(FCount);
    Sleep(STime);
  end;
end;

procedure TWorkThread.WriteDataFile(const ACount: integer; const ANow: TDateTime);
var
  str: string;
  tempStringList: TStringList;
begin
  CriticalSection.Enter;
  try
    DateTimeToString(str, '[dd.mm.yyyy hh:mm:ss]', ANow);
    str := str + ' (Thread ' + IntToStr(Self.id) + '): cycle count = ' + IntToStr(ACount);
    tempStringList := TStringList.Create;
    try
      tempStringList.LoadFromFile(GetCurrentDir + '\' + FileName);
      tempStringList.Append(str);
      tempStringList.SaveToFile(GetCurrentDir + '\' + FileName);
    finally
      FreeAndNil(tempStringList);
    end;
  finally
    CriticalSection.Leave;
  end;
end;

procedure TWorkThread.WriteDataThread(const ACount: integer; const ANow: TDateTime);
begin
  CriticalSection.Enter;
  try
    DataObj.DateTime := ANow;
    DataObj.CountExecute := ACount;
  finally
    CriticalSection.Leave;
  end;
end;

{ TDemoThread }

procedure TDemoThread.Execute;
var
  str: string;
begin
  while not Terminated do
  begin
    str := ReadDataFile;
    Synchronize(procedure
                begin
                  TMainForm(FMainForm).ShowData(str);
                end);
    str := ReadDataThread;
    Synchronize(procedure
                begin
                  TMainForm(FMainForm).ShowData(str);
                end);
    Sleep(3000);
  end;
end;

function TDemoThread.ReadDataFile: string;
var
  tempStringList: TStringList;
begin
  CriticalSection.Enter;
  try
    tempStringList := TStringList.Create;
    try
      tempStringList.LoadFromFile(GetCurrentDir + '\' + FileName);
      if tempStringList.Count > 0 then
        Result := tempStringList.Strings[tempStringList.Count - 1];
    finally
      FreeAndNil(tempStringList);
    end;
  finally
    CriticalSection.Leave;
  end;
end;

function TDemoThread.ReadDataThread: string;
begin
  CriticalSection.Enter;
  try
    Result := DateTimeToStr(DataObj.DateTime) + ' \ ' + IntToStr(DataObj.CountExecute);
  finally
    CriticalSection.Leave;
  end;
end;

end.
