unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, GdiPlus, GdiPlusHelpers, StdCtrls, TBaseRectangleUnit,BlurShadowUnit;

type
  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox1Paint(Sender: TObject);

  private
    Graphics: IGPGraphics;
    r: TBaseRectangle;
    currentX,currentY: integer;
    oldX,oldY: integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.FormDestroy(Sender: TObject);
begin
  r.Free;
end;

procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    begin
      if r <> nil then
        begin
          if (x > r.getLeft) and (x < r.getLeft + 200) and
              (y > r.getTop) and (y < r.getTop + 200) then
            begin
              oldX:= x;
              oldY:= y;
              Form1.Timer1.Enabled:= true;
            end;
        end;
    end;
end;

procedure TForm1.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  currentX:= x;
  currentY:= y;
end;

procedure TForm1.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
      Form1.Timer1.Enabled:= false;
end;

//инициализация графики
procedure TForm1.PaintBox1Paint(Sender: TObject);
begin
  Form1.PaintBox1.Align:= alClient;
  Graphics:= Form1.PaintBox1.ToGPGraphics;
  Graphics.Clear(TGPColor.White);

  r:= TBaseRectangle.Create();
  Graphics.DrawImage(r.shadowBitmap,
                      r.getLeft ,
                      r.getTop ,
                      r.shadowBitmap.Width,
                      r.shadowBitmap.Height);
  Graphics.DrawPath(r.pen, r.rectanglePath);
  Graphics.FillPath(r.brush,r.rectanglePath);

end;

// ререрисовка фигуры по таймеру
procedure TForm1.Timer1Timer(Sender: TObject);
var
   dx, dy: Single;
begin
  Graphics:= Form1.PaintBox1.ToGPGraphics;
  Graphics.Clear(TGPColor.White);
  dx:= currentX - oldX;
  dy:= currentY - oldY;

  r.moveRectangle(dx, dy);

  Graphics.DrawImage(r.shadowBitmap,
                      r.getLeft ,
                      r.getTop ,
                      r.shadowBitmap.Width,
                      r.shadowBitmap.Height);

  Graphics.DrawPath(r.pen, r.rectanglePath);
  Graphics.FillPath(r.brush,r.rectanglePath);

  oldX:= currentX;
  oldY:= currentY;
end;

end.
