program SoftPoint;

uses
  Vcl.Forms,
  MainU in 'MainU.pas' {MainForm},
  DataU in 'DataU.pas' {DataModule1: TDataModule},
  LoggerU in 'LoggerU.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
