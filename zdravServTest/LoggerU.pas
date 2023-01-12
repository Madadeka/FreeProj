unit LoggerU;

interface

uses
   Windows,
   SysUtils,
   Classes;

type

  TLogger = class
    public
      constructor Create();
      destructor Destroy(); override;

      procedure addLogStr(str: String);
  end;

implementation

{ TLogger }

procedure TLogger.addLogStr(str: String);
var
  s: String;
  sl: TStringList;
begin
  sl:= TStringList.Create;
  try
    if FileExists('journal.txt') then
      sl.LoadFromFile('journal.txt');
    DateTimeToString(s, '[dd.mm.yyyy] [hh:mm:ss]', Now);
    s:= s + ': ' + str;
    sl.Append(s);
    sl.SaveToFile('journal.txt');
  finally
    FreeAndNil(sl);
  end;

end;

constructor TLogger.Create();
begin
  inherited Create;

end;

destructor TLogger.Destroy;
begin

  inherited;
end;

end.
