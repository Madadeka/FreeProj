unit TCoreUnit;

interface

uses
  System.SysUtils,
  Winapi.Windows,
  System.Classes,
  SyncObjs,
  Generics.Collections,
  TWorkThreadUnit;

type
  TCore = class(TObject)
  public
    NumQueue: TQueue<Integer>;
    constructor Create();
    destructor Destroy(); override;
    procedure CWriteNumber(num: Integer);
  private
    cs: TCriticalSection;
    ThreadList: TList<TWorkThread>;

    tf: TextFile;

    function CGetNumber(): Integer;
    function CalcSimple(n: Integer): TQueue<Integer>;
  end;

implementation

{ TCore }

function TCore.CalcSimple(n: Integer): TQueue<Integer>;
var
  tempArr: TArray<Boolean>;
  I: Integer;
  j: Integer;
begin
  SetLength(tempArr, n + 1);
  for I := 2 to n do
    begin
      if tempArr[i] = false then
        begin
          if i * i > length(tempArr) then  break;
          j:= 0;
          while i * (i + j) <= length(tempArr) do
            begin
              tempArr[i * (i + j)]:= true;
              inc(j);
            end;
        end;
    end;

  result:= TQueue<Integer>.Create();
  for i  := 2 to n do
    begin
      if tempArr[i] = false then result.Enqueue(i);
    end;

end;

function TCore.CGetNumber: Integer;
begin
  cs.Enter;
  if NumQueue.Count > 0
  then result:= NumQueue.Extract
    else result:= -1;
  cs.Leave;
end;

procedure TCore.CWriteNumber(num: Integer);
begin
  cs.Enter;
  try
    Write(tf, intToStr(num) + ' ');
    Writeln(intToStr(num) + ' ');
  finally
    cs.Leave;
  end;
end;

constructor TCore.Create;
var
  i: Integer;
  Thread: TWorkThread;
begin
  cs:= TCriticalSection.Create;
  NumQueue:= CalcSimple(1000000);

  AssignFile(tf, 'Result.txt');
  ReWrite(tf);

  ThreadList:= TList<TWorkThread>.Create();
  for i := 0 to 1 do
    begin
      Thread:= TWorkThread.Create(i + 1);
      Thread.FreeOnTerminate:= False;
      Thread.Priority:= tpHigher;
      Thread.GetNumber:= CGetNumber;
      Thread.WriteNumber:= CWriteNumber;
      ThreadList.Add(Thread);
      Thread.Start;
    end;
end;

destructor TCore.Destroy;
var
  item: TWorkThread;
begin
  FreeAndNil(cs);
  Closefile(tf);
  try
    for item in ThreadList do
      begin
        if item.IsRunning = True then
          begin
            item.IsRunning:= False;
            sleep(10);
          end;
        item.Terminate;
      end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  ThreadList.Clear;
  FreeAndNil(ThreadList);
end;

end.

