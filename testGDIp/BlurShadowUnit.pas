unit BlurShadowUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, GdiPlus, GdiPlusHelpers, StdCtrls, Math;

  function CreateBlurShadow(ABitmap: IGPBitmap; ARadius: Integer; AOpacity: Double; AColor: TColor = clNone): IGPBitmap;


implementation

function CreateBlurShadow(ABitmap: IGPBitmap; ARadius: Integer; AOpacity: Double; AColor: TColor = clNone): IGPBitmap;

  procedure BoxBlur(const AData1, AData2: TGPBitmapData; AWidth, AHeight, ARadius: Integer);
  const
    CHANNELS = 4;
  var
    LScan1, LScan2: PByte;
    LSum, LFirstValue, LLastValue: array [0..CHANNELS-1] of Integer;
    LRadius2, LStride, LStart, LChannel, LLeft, LRight, LBottom, LTop, LRow, LColumn: Integer;
  begin
    LScan1 := AData1.Scan0;
    LScan2 := AData2.Scan0;
    LRadius2 := (2 * ARadius) + 1;
    LStride := AData1.Stride;
    for LRow := 0 to AHeight-1 do
    begin
      LStart := LRow * LStride;
      LLeft := LStart;
      LRight := LStart + ARadius * CHANNELS;
      for LChannel := 0 to CHANNELS-1 do
      begin
        LFirstValue[LChannel] := LScan1[LStart + LChannel];
        LLastValue[LChannel] := LScan1[LStart + ((AWidth - 1) * CHANNELS) + LChannel];
        LSum[LChannel] := (ARadius + 1) * LFirstValue[LChannel];
      end;
      for LColumn := 0 to ARadius-1 do
        for LChannel := 0 to CHANNELS-1 do
          LSum[LChannel] := LSum[LChannel] + LScan1[LStart + (LColumn * CHANNELS) + LChannel];
      for LColumn := 0 to ARadius do
      begin
        for LChannel := 0 to CHANNELS-1 do
        begin
          LSum[LChannel] := LSum[LChannel] + LScan1[LRight + LChannel] - LFirstValue[LChannel];
          LScan2[LStart + LChannel] := Byte(LSum[LChannel] div LRadius2);
        end;
        Inc(LRight, CHANNELS);
        Inc(LStart, CHANNELS);
      end;
      for LColumn := ARadius + 1 to AWidth-ARadius-1 do
      begin
        for LChannel := 0 to CHANNELS-1 do
        begin
          LSum[LChannel] := LSum[LChannel] + LScan1[LRight + LChannel] - LScan1[LLeft + LChannel];
          LScan2[LStart + LChannel] := Byte(LSum[LChannel] div LRadius2);
        end;
        Inc(LLeft, CHANNELS);
        Inc(LRight, CHANNELS);
        Inc(LStart, CHANNELS);
      end;
      for LColumn := AWidth-ARadius to AWidth-1 do
      begin
        for LChannel := 0 to CHANNELS-1 do
        begin
          LSum[LChannel] := LSum[LChannel] + LLastValue[LChannel] - LScan1[LLeft + LChannel];
          LScan2[LStart + LChannel] := Byte(LSum[LChannel] div LRadius2);
        end;
        Inc(LLeft, CHANNELS);
        Inc(LStart, CHANNELS);
      end;
    end;
    LStride := AData2.Stride;
    for LColumn := 0 to AWidth-1 do
    begin
      LStart := LColumn * CHANNELS;
      LTop := LStart;
      LBottom := LStart + (ARadius * LStride);
      for LChannel := 0 to CHANNELS-1 do
      begin
        LFirstValue[LChannel] := LScan2[LStart + LChannel];
        LLastValue[LChannel] := LScan2[LStart + ((AHeight - 1) * LStride) + LChannel];
        LSum[LChannel] := (ARadius + 1) * LFirstValue[LChannel];
      end;
      for LRow := 0 to ARadius-1 do
        for LChannel := 0 to CHANNELS-1 do
          LSum[LChannel] := LSum[LChannel] + LScan2[LStart + (LRow * LStride) + LChannel];
      for LRow := 0 to ARadius do
      begin
        for LChannel := 0 to CHANNELS-1 do
        begin
          LSum[LChannel] := LSum[LChannel] + LScan2[LBottom + LChannel] - LFirstValue[LChannel];
          LScan1[LStart + LChannel] := Byte(LSum[LChannel] div LRadius2);
        end;
        Inc(LBottom, LStride);
        Inc(LStart, LStride);
      end;
      for LRow := ARadius + 1 to AHeight - ARadius - 1 do
      begin
        for LChannel := 0 to CHANNELS-1 do
        begin
          LSum[LChannel] := LSum[LChannel] + LScan2[LBottom + LChannel] - LScan2[LTop + LChannel];
          LScan1[LStart + LChannel] := Byte(LSum[LChannel] div LRadius2);
        end;
        Inc(LTop, LStride);
        Inc(LBottom, LStride);
        Inc(LStart, LStride);
      end;
      for LRow := AHeight - ARadius to AHeight-1 do
      begin
        for LChannel := 0 to CHANNELS-1 do
        begin
          LSum[LChannel] := LSum[LChannel] + LLastValue[LChannel] - LScan2[LTop + LChannel];
          LScan1[LStart + LChannel] := Byte(LSum[LChannel] div LRadius2);
        end;
        Inc(LTop, LStride);
        Inc(LStart, LStride);
      end;
    end;
  end;

const
  INITIAL_MATRIX: array [0..4, 0..4] of Single =
   ((0.5,   0,   0, 0, 0),
    (0,   0.5,   0, 0, 0),
    (0,     0, 0.5, 0, 0),
    (0,     0,   0, 1, 0),
    (0,     0,   0, 0, 1));
var
  LMatrix: TGPColorMatrix;
  LImageAttributes: IGPImageAttributes;
  LShadow, LClone: IGPBitmap;
  LGraphics: IGPGraphics;
  LShadowData, LCloneData: TGPBitmapData;
  LColor: TGPColor;
begin
  ARadius := Max(ARadius, 0);
  LShadow := TGPBitmap.Create(ABitmap.Width + (4 * Cardinal(ARadius)),
    ABitmap.Height + (4 * Cardinal(ARadius)), PixelFormat32bppARGB);
  LGraphics := TGPGraphics.FromImage(LShadow);
  LGraphics.DrawImage(ABitmap, TGPRect.Create(2 * ARadius, 2 * ARadius,
    ABitmap.Width, ABitmap.Height), 0, 0, ABitmap.Width, ABitmap.Height,
    TGPUnit.UnitPixel);
  LClone := LShadow.Clone;
  LShadowData := LShadow.LockBits(TGPRect.Create(0, 0, LShadow.Width, LShadow.Height),
    [ImageLockModeRead, ImageLockModeWrite], PixelFormat32bppARGB);
  LCloneData := LClone.LockBits(TGPRect.Create(0, 0, LClone.Width, LClone.Height),
    [ImageLockModeRead, ImageLockModeWrite], PixelFormat32bppARGB);
  try
    BoxBlur(LShadowData, LCloneData, LShadow.Width, LShadow.Height, ARadius - 1);
    BoxBlur(LShadowData, LCloneData, LShadow.Width, LShadow.Height, ARadius - 1);
    BoxBlur(LShadowData, LCloneData, LShadow.Width, LShadow.Height, ARadius);
  finally
    LShadow.UnlockBits(LShadowData);
    LClone.UnlockBits(LCloneData);
  end;
  if (AColor = clNone) and (AOpacity = 1.0) then
    Result := LShadow
  else
  begin
    LColor := TGPColor.CreateFromColorRef(ColorToRGB(AColor));
    Move(INITIAL_MATRIX[0, 0], LMatrix.M[0, 0], SizeOf(INITIAL_MATRIX));
    LMatrix.M[4, 0] := Min((Integer(LColor.R) - 127) / 127, 1.0);
    LMatrix.M[4, 1] := Min((Integer(LColor.G) - 127) / 127, 1.0);
    LMatrix.M[4, 2] := Min((Integer(LColor.B) - 127) / 127, 1.0);
    LMatrix.M[4, 3] := AOpacity-1;
    LImageAttributes := TGPImageAttributes.Create;
    LImageAttributes.SetColorMatrix(LMatrix, TGPColorMatrixFlags.ColorMatrixFlagsDefault,
      TGPColorAdjustType.ColorAdjustTypeBitmap);
    Result := TGPBitmap.Create(LShadow.Width, LShadow.Height, PixelFormat32bppARGB);
    LGraphics := TGPGraphics.FromImage(Result);
    LGraphics.DrawImage(LShadow, TGPRect.Create(0, 0, LShadow.Width, LShadow.Height),
      0, 0, Result.Width, Result.Height, TGPUnit.UnitPixel, LImageAttributes);
  end;
end;

end.
