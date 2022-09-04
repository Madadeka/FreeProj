program Mdiapp;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  ChildWin in 'ChildWin.pas' {MDIChild},
  TFrmOperatorU in 'TFrmOperatorU.pas' {FrmOperator},
  DBReaderU in 'DBReaderU.pas',
  TfrmAddU in 'TfrmAddU.pas' {frmAdd},
  TFrmStatistU in 'TFrmStatistU.pas' {FrmStatist};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
