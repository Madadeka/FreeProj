unit LoggerU;

interface

uses
   Windows, SysUtils, Classes, IniFiles;

type
  TOptions = record
    oServer: string;
    oPort: integer;
    oUser: string;
    oPass: string;
    oPeriod: Integer;
  end;

  TLogger = class
  private
    FFileNeme: string;
    FLogLines: TStringList;
  public
    constructor Create(const AFileName: string);
    destructor Destroy(); override;

    procedure AddLogStr(aStr: String);
    function GetOptions(): TOptions;
    procedure WriteOptions(const aOptions: TOptions);
  end;

implementation

{ TLogger }

procedure TLogger.addLogStr(aStr: String);
var
  s: String;
begin
  DateTimeToString(s, '[dd.mm.yyyy hh:mm:ss]', Now);
  s:= s + ': ' + aStr;
  FLogLines.Append(s);
end;

constructor TLogger.Create(const AFileName: string);
begin
  inherited Create;

  FFileNeme := GetCurrentDir + '\' + AFileName;
  FLogLines := TStringList.Create;
  if FileExists(FFileNeme) then
    FLogLines.LoadFromFile(FFileNeme);
end;

destructor TLogger.Destroy;
begin
  FLogLines.SaveToFile(FFileNeme);
  FreeAndNil(FLogLines);
  inherited;
end;

function TLogger.GetOptions: TOptions;
var
  OptionsFile: string;
  OptIni: TIniFile;
begin
  OptionsFile := GetCurrentDir + '\' + 'options.ini';
  OptIni := TIniFile.Create(OptionsFile);
   try
     Result.oServer := OptIni.ReadString('ServerOptions', 'Server', '127.0.0.1');
     Result.oPort := OptIni.ReadInteger('ServerOptions', 'Port', 1434);
     Result.oUser := OptIni.ReadString('ServerOptions', 'User', '1');
     Result.oPass := OptIni.ReadString('ServerOptions', 'Password', '111');
     Result.oPeriod := OptIni.ReadInteger('UpdateOptions', 'Period', 5000);
   finally
     OptIni.Free;
   end;
end;

procedure TLogger.WriteOptions(const aOptions: TOptions);
var
  OptionsFile: string;
  OptIni: TIniFile;
begin
  OptionsFile := GetCurrentDir + '\' + 'options.ini';
  OptIni := TIniFile.Create(OptionsFile);
  try
    OptIni.WriteString('ServerOptions', 'Server', aOptions.oServer);
    OptIni.WriteInteger('ServerOptions', 'Port', aOptions.oPort);
    OptIni.WriteString('ServerOptions', 'User', aOptions.oUser);
    OptIni.WriteString('ServerOptions', 'Password', aOptions.oPass);
    OptIni.WriteInteger('UpdateOptions', 'Period', aOptions.oPeriod);
  finally
    OptIni.Free;
  end;
end;

end.
