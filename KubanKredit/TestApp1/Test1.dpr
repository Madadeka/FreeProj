program Test1;

uses
  Vcl.Forms,
  UMain in 'UMain.pas' {Form1},
  UFrame in 'UFrame.pas' {TestFrame: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
