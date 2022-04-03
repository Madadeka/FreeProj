unit TWorkThreadUnit;

interface

uses
  System.Classes,
  Winapi.WinSock,
  System.SysUtils,
  System.DateUtils,
  SyncObjs,
  Generics.Collections;

type
  TGetNumber = function: Integer of Object;
  TWriteNumber = procedure(num: Integer) of Object;

  TWorkThread = class(TThread)
  private
    FTreadID: Integer;
    FIsRunning: Boolean;

    procedure SetThreadID(n: Integer);
    procedure SetIsRunning(value: Boolean);

  public
    tf: TextFile;

    WriteNumber: TWriteNumber;
    GetNumber : TGetNumber;

    property ID: Integer read FTreadID write SetThreadID;
    property IsRunning: Boolean read FIsRunning write SetIsRunning;

    constructor Create(n: Integer);
    destructor Destroy(); override;

  protected
    procedure Execute; override;

  end;

implementation

{ TWorkThread }

constructor TWorkThread.Create(n: integer);
begin
  inherited Create(True);

  id:= n;

  AssignFile(tf, 'Thread' + IntToStr(id) + '.txt');
  ReWrite(tf);
  IsRunning:= True;
end;

destructor TWorkThread.Destroy;
begin
  Closefile(tf);
  inherited;
end;

procedure TWorkThread.Execute;
var
  n: INteger;
begin
  inherited;
  while IsRunning do
    begin
      n:= GetNumber;
      if n = -1 then
        begin
          IsRunning:= false;
          break;
        end;
      WriteNumber(n);
      write(tf, intToStr(n) + ' ');
    end;
end;

procedure TWorkThread.SetIsRunning(value: Boolean);
begin
  FIsRunning:= value;
end;

procedure TWorkThread.SetThreadID(n: Integer);
begin
  FTreadID:= n;
end;

end.

