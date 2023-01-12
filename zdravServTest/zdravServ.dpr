program zdravServ;

uses
  Vcl.Forms,
  MainU in 'MainU.pas' {Form1},
  LoggerU in 'LoggerU.pas',
  DBReaderU in 'DBReaderU.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
