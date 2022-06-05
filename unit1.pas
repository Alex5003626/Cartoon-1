unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  angle, MOONangle, ClDelta, BG1, VokDeltaX, LineAngle, n: integer;

implementation

{$R *.lfm}

{ TForm1 }


procedure rotate(var x : integer; var y : integer; angle : double);
var
  xbuf : double;
  rangle : double;
begin
   rangle := angle * pi / 180;
   xbuf := x * cos(rangle) + y * sin(rangle);
   y := Trunc(-x * sin(rangle) + y * cos(rangle));
   x := Trunc(xbuf);
end;


procedure TForm1.Button1Click(Sender: TObject);
begin
  Timer1.Enabled:=True;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  clientWidth:= 1200;
  ClientHeight:= 600;
  angle:=200;
  MOONangle := 200;
  ClDelta:= 0;
  BG1:= 0;
  VokDeltaX:= -800;
  LineAngle:= 0;
end;

procedure background3(Canvas: Tcanvas);
var
  i, DeltaX, x, y: integer;
begin
  DeltaX:= -1000;
  x:=300;
  y:=300;
  rotate(x, y, angle);

  if n < 30 then
    Canvas.Brush.Color:= RGBToColor(153, 213, 253);                               // фон //
    Canvas.FillRect(0, 0, 1200, 1000);

  if (n > 29) and (n < 60) then
    Canvas.Brush.Color:= RGBToColor(4, 149, 244);
    Canvas.FillRect(0, 0, 1200, 1000);

  if (n > 59) and (n < 100) then
    Canvas.Brush.Color:= RGBToColor(0, 95, 189);
    Canvas.FillRect(0, 0, 1200, 1000);

  if (n > 99) and (n < 110) then
    Canvas.Brush.Color:= RGBToColor(116, 113, 242);
    Canvas.FillRect(0, 0, 1200, 1000);

  if (n > 109)  then
      Canvas.Brush.Color:= RGBToColor(146, 192, 250);
      Canvas.FillRect(0, 0, 1200, 1000);




  Canvas.Pen.Color:= clWhite;                                                   // солнце //
  Canvas.Brush.Color:= clYellow;
  Canvas.Ellipse(550+ x, 500 + y - 100,650 + x,500 + y);

  rotate(x, y, MOONangle);

  Canvas.Pen.Color:= clCream;                                                   // луна //
  Canvas.Brush.Color:= clWhite;
  Canvas.Ellipse(550+ x, 500 + y - 100,650 + x,500 + y);


  for i:= 0 to 10 do                                                            // облака //
  begin
    Canvas.Brush.Color:= clCream;
    Canvas.Pen.Color:= clCream;
    Canvas.Ellipse(50 + DeltaX + ClDelta, 80, 200 + DeltaX +  ClDelta, 150);
    Canvas.Ellipse(130 + DeltaX + ClDelta, 50, 240 + DeltaX + ClDelta, 100);
    Canvas.Ellipse(220 + DeltaX + ClDelta, 80, 320 + DeltaX + ClDelta, 150);
    Canvas.Polygon([point(100 + DeltaX + ClDelta, 140), point(300 + DeltaX + ClDelta, 120), point(160 + DeltaX + ClDelta, 60)] );
    DeltaX:= DeltaX + 400;
  end;

  angle:= angle - 3;
  ClDelta:= ClDelta + 2;
end;

procedure background2(canvas: Tcanvas);
begin
  Canvas.Brush.Color:= RGBToColor(179, 251, 181);
  Canvas.FillRect(0, 300, 1200, 1000);
end;

procedure background1(canvas: Tcanvas);
var
  DeltaX, i: integer;
begin
  if n >= 120 then
      begin
        BG1:= 0;
        DeltaX:= -2000;
      end;
  DeltaX:= -2000;

  Canvas.Brush.Color:= RGBToColor(118, 248, 39);
  Canvas.FillRect(0, 350, 1200, 1000);

  for i:= 0 to 5 do begin
    Canvas.Pen.Color:= clBlack;
    Canvas.Brush.Color:= RGBToColor(198, 166, 120);                                // дом //
    Canvas.Rectangle(400 + DeltaX + BG1, 375, 500 + DeltaX + BG1, 420);
    Canvas.Polygon([point(400 + DeltaX + BG1, 375), point(450 + DeltaX + BG1,  320), point(500 + DeltaX + BG1, 375)]);

    Canvas.Pen.Color:= clWhite;                                                    // окно //
    Canvas.Brush.Color:= RGBToColor(59, 131, 189);
    Canvas.Rectangle(425 + DeltaX + BG1, 390, 460 + DeltaX + BG1, 410);

    Canvas.Pen.Color:= clBlack;                                                    // дверь //
    Canvas.Brush.Color:= RGBToColor(76, 47, 39);
    Canvas.Rectangle(470 + DeltaX + BG1, 390, 490 + DeltaX + BG1, 420);

    DeltaX:= DeltaX + 300;
    BG1:= BG1 + 10;
  end;






end;

procedure foreground(Canvas: Tcanvas);
begin
  Canvas.Pen.Color:= clBlack;
  Canvas.Pen.Width:= 1;
  Canvas.Brush.Color:= clGray;
  Canvas.Rectangle(0 , 0, 150, 1000);
  Canvas.Rectangle(1200 - 150 , 0, 1200, 1000);
  Canvas.Rectangle(0 , 0, 1200, 20);
  Canvas.Rectangle(0 , 500, 1200, 1000);





end;

procedure Vokzal(Canvas: TCanvas);
var
  x, y: integer;
begin
  if n >= 120 then
      begin
        VokDeltaX:= -800;
      end;
  x:=20;
  y:=20;
  rotate(x, y, LineAngle);


  Canvas.Pen.Color:= clBlack;
  Canvas.Brush.Color:= clCream;
  Canvas.Pen.Width:= 1;

  Canvas.Rectangle(250 + VokDeltaX, 400, 900 + VokDeltaX, 800);

  Canvas.Pen.Color:= clGray;
  Canvas.Pen.Width:= 10;

  Canvas.Line(900 + VokDeltaX - 80, 440, 900 + VokDeltaX - 80, 350);


  Canvas.Brush.Color:= clWhite;
  Canvas.Pen.Width:= 4;
  Canvas.Ellipse(900 - 80 - 30 + VokDeltaX , 295, 900 - 80 + 30 + VokDeltaX , 355);


  Canvas.Pen.Width:= 3;
  Canvas.Pen.Color:= clBlack;
  Canvas.Line(900 - 80  + VokDeltaX, 0 + 325, 900 - 80  + x + VokDeltaX, y + 325);


  LineAngle:= LineAngle - 15;


  if (n < 60) then
    VokDeltaX:= VokDeltaX + 15;

  if (n > 80) then
    VokDeltaX:= VokDeltaX + 30;


end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  background3(Canvas);
  background2(Canvas);
  background1(Canvas);
  if (n > 40) then
     Vokzal(Canvas);
  foreground(Canvas);
  if n >= 120 then
      n:= 0;
  n:= n + 1;
end;


end.

