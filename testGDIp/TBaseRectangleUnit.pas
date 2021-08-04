unit TBaseRectangleUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, GdiPlus, GdiPlusHelpers, StdCtrls, BlurShadowUnit;

type
  TBaseRectangle = class(TObject)

    brush: TGPSolidBrush;
    pen: TGPPen;
    rectanglePath: IGPGraphicsPath;

    shadowBitmap: IGPBitmap;
  public
    //для начала просто соберу прямоугольник
    constructor Create();
    destructor Destroy(); override;

    procedure moveRectangle(x: Single; y: Single);
    function getTop(): Single;
    function getLeft(): Single;

  private
    //topLeftArc
    topLeftArcX, topLeftArcY, topLeftArcStart: Single;
    // common arc
    arcW, arcH, arcDeltaAngle: Single;
    //bottomLeftArc
    bottomLeftArcX, bottomLeftArcY, bottomLeftArcStart: Single;
    //bottomRightArc
    bottomRightArcX, bottomRightArcY, bottomRightArcStart: Single;
    //topRightArc
    topRightArcX, topRightArcY, topRightArcStart: Single;

    //leftLine
    leftLineX, leftLineY, leftLineEndX, leftLineEndY: Single;
    //bottomLine
    bottomLineX, bottomLineY, bottomLineEndX, bottomLineEndY: Single;
    //rightLine
    rightLineX, rightLineY, rightLineEndX, rightLineEndY: Single;
    //topLine
//    topLineX, topLineY, topLineEndX, topLineEndY: Single;

    function createRect(x, y: Single): IGPGraphicsPath;
    procedure shiftRect(dX,dY: single);

  end;

implementation

{ TBaseRectangle }

constructor TBaseRectangle.Create;
var
  gr: IGPGraphics;
  brushSh: TGPSolidBrush;
begin
  inherited Create();

  //можно нарисовать подругому
  arcW:= 50;
  arcH:= 50;
  arcDeltaAngle:= -90;

  topLeftArcX:= 100; //<-!  //(100, 100, 50, 50, 270, -90);
  topLeftArcY:= 100; //<-!
  topLeftArcStart:= 270;

  bottomLeftArcX:= 100;    //(100, 275, 50, 50, 180, -90);
  bottomLeftArcY:= 275;
  bottomLeftArcStart:= 180;

  bottomRightArcX:= 250;       //(250, 275, 50, 50, 90, -90);
  bottomRightArcY:= 275;
  bottomRightArcStart:= 90;

  topRightArcX:= 250;          //(250, 100, 50, 50, 0, -90);
  topRightArcY:= 100;
  topRightArcStart:= 0;

  leftLineX:= 100;
  leftLineY:= 125;            //(100, 125, 100, 275);
  leftLineEndX:= 100;
  leftLineEndY:= 275;

  bottomLineX:= 125;         //(125, 325, 275, 325);
  bottomLineY:= 325;
  bottomLineEndX:= 275;
  bottomLineEndY:= 325;

  rightLineX:= 300;          //(300, 300, 300, 150);
  rightLineY:= 300;
  rightLineEndX:= 300;
  rightLineEndY:= 150;

  rectanglePath := createRect(0,0);
  brush:= TGPSolidBrush.Create(TGPColor.YellowGreen);
  pen := TGPPen.Create(TGPColor.Aquamarine,4);

  shadowBitmap:= TGPBitmap.Create(225, 225, PixelFormat32bppARGB);
  gr := TGPGraphics.FromImage(shadowBitmap);
  brushSh:= TGPSolidBrush.Create(TGPColor.Gray);              //цвет тени основной TGPColor.Gray
  gr.FillPath(brushSh, createRect(-100,-100));
  shadowBitmap:= CreateBlurShadow(shadowBitmap,6, 1, clGray); //цвет тени размытый clGray

  brushSh.Free;
end;

//создаю область фигуры (x,y- на случай если нужно сдвинуть фигуру не трогая основные координаты)
function TBaseRectangle.createRect(x, y: Single): IGPGraphicsPath;
begin
  Result := TGPGraphicsPath.Create;
  Result.StartFigure;
  Result.AddArc(topLeftArcX + x, topLeftArcY + y, arcW, arcH, topLeftArcStart, arcDeltaAngle);
  Result.AddLine(leftLineX + x, leftLineY + y, leftLineEndX + x, leftLineEndY + y);
  Result.AddArc(bottomLeftArcX + x, bottomLeftArcY + y, arcW, arcH, bottomLeftArcStart, arcDeltaAngle);
  Result.AddLine(bottomLineX + x, bottomLineY + y, bottomLineEndX + x, bottomLineEndY + y);
  Result.AddArc(bottomRightArcX + x, bottomRightArcY + y, arcW, arcH, bottomRightArcStart, arcDeltaAngle);
  Result.AddLine(rightLineX + x, rightLineY + y, rightLineEndX + x, rightLineEndY + y);
  Result.AddArc(topRightArcX + x, topRightArcY + y, arcW, arcH, topRightArcStart, arcDeltaAngle);
  Result.CloseFigure;
end;

destructor TBaseRectangle.Destroy;
begin
  brush.Destroy;
  pen.Destroy;
  inherited;
end;

function TBaseRectangle.getLeft: Single;
begin
  result:= topLeftArcX;
end;

function TBaseRectangle.getTop: Single;
begin
  result:= topLeftArcY;
end;

//создаю область фигуры со смещением x,y
procedure TBaseRectangle.moveRectangle(x, y: Single);
begin
  shiftRect(x,y);
  rectanglePath := createRect(0,0);
end;

//сдвиг частей фигуры на dX, dY
procedure TBaseRectangle.shiftRect(dX, dY: single);
begin

  topLeftArcX:= topLeftArcX + dX;
  topLeftArcY:= topLeftArcY + dY;

  leftLineX:= leftLineX + dX;
  leftLineY:= leftLineY + dY;
  leftLineEndX:= leftLineEndX + dX;
  leftLineEndY:= leftLineEndY + dY;

  bottomLeftArcX:= bottomLeftArcX + dX;
  bottomLeftArcY:= bottomLeftArcY + dY;

  bottomLineX:= bottomLineX + dX;
  bottomLineY:= bottomLineY + dY;
  bottomLineEndX:= bottomLineEndX + dX;
  bottomLineEndY:= bottomLineEndY + dY;

  bottomRightArcX:= bottomRightArcX + dX;
  bottomRightArcY:= bottomRightArcY + dY;

  rightLineX:= rightLineX + dX;
  rightLineY:= rightLineY + dY;
  rightLineEndX:= rightLineEndX + dX;
  rightLineEndY:= rightLineEndY + dY;

  topRightArcX:= topRightArcX + dX;
  topRightArcY:= topRightArcY + dY;
end;

end.
