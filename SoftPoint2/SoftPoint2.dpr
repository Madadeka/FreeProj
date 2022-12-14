program SoftPoint2;

uses
  Vcl.Forms,
  UMain in 'UMain.pas' {MainForm},
  UWorkThread in 'UWorkThread.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
