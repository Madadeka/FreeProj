program SimpleNumbers;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  TCoreUnit in 'TCoreUnit.pas',
  TWorkThreadUnit in 'TWorkThreadUnit.pas';

var
  Core: TCore;
begin
  Core:= TCore.Create;
  try
    try
      while Core.NumQueue.Count > 0 do
        begin
          sleep(10);
        end;
    except
      on E: Exception do
        Writeln(E.ClassName, ': ', E.Message);
    end;
  finally
    FreeAndNil(Core);
    WriteLn('press enter to exit...');
    readln;
  end;
end.
