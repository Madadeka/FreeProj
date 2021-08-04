program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  GdiPlus in 'GdiPlus.pas',
  GdiPlusHelpers in 'GdiPlusHelpers.pas',
  TBaseRectangleUnit in 'TBaseRectangleUnit.pas',
  BlurShadowUnit in 'BlurShadowUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
