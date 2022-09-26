unit fCustomCalendar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Shapes, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtCtrls;

const
  MonthStr: array [1 .. 12] of string = ('January', 'February', 'March',
    'April', 'May', 'June', 'July', 'August', 'September', 'October',
    'November', 'December');

type
  TForm2 = class(TForm)
    btn_NextMonth: TButton;
    btn_ProvMonth: TButton;
    calendar1: TRectShape;
    calendar2: TRectShape;
    calendar3: TRectShape;
    calendar4: TRectShape;
    calendar5: TRectShape;
    calendar6: TRectShape;
    calendar7: TRectShape;
    calendar8: TRectShape;
    calendar9: TRectShape;
    calendar10: TRectShape;
    calendar11: TRectShape;
    calendar12: TRectShape;
    calendar13: TRectShape;
    calendar14: TRectShape;
    calendar15: TRectShape;
    calendar16: TRectShape;
    calendar17: TRectShape;
    calendar18: TRectShape;
    calendar19: TRectShape;
    calendar20: TRectShape;
    calendar21: TRectShape;
    calendar22: TRectShape;
    calendar23: TRectShape;
    calendar24: TRectShape;
    calendar25: TRectShape;
    calendar26: TRectShape;
    calendar27: TRectShape;
    calendar28: TRectShape;
    calendar29: TRectShape;
    calendar30: TRectShape;
    calendar31: TRectShape;
    calendar32: TRectShape;
    calendar33: TRectShape;
    calendar34: TRectShape;
    calendar35: TRectShape;
    CmbMonth: TComboBox;
    CmbYear: TComboBox;
    Button1: TButton;
    lbl_SelectedDate: TLabel;
    RectShapeSun: TRectShape;
    RectShapeSat: TRectShape;
    RectShapeFri: TRectShape;
    RectShapeThu: TRectShape;
    RectShapeWed: TRectShape;
    RectShapeTue: TRectShape;
    RectShapeMon: TRectShape;
    RectShape7: TShape;
    RectShape1: TShape;
    RectShape2: TShape;
    RectShape3: TShape;
    RectShape4: TShape;
    RectShape5: TShape;
    RectShape9: TShape;
    RectShape11: TShape;
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CmbYearChange(Sender: TObject);
    procedure CmbMonthChange(Sender: TObject);
    procedure btn_ProvMonthClick(Sender: TObject);
    procedure btn_NextMonthClick(Sender: TObject);
  private
    { Private declarations }
    FYear, FMonth, FDay: Word;
    FSelectedDate: TDate;
    FBoxDaySelected: TRectShape;
    function ConvertDateStrToDate(ADateStr: String): TDate;
    procedure CreateCalendar(const AYear: Word; const AMonth: Word);
    procedure calendarCustomClick(Sender: TObject);
    procedure InitCalendarBoxClick;
  public
    { Public declarations }

  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

Uses DateUtils;

procedure TForm2.btn_NextMonthClick(Sender: TObject);
begin
  if CmbMonth.ItemIndex < Pred(CmbMonth.Items.Count) then
  begin
    CmbMonth.ItemIndex := CmbMonth.ItemIndex + 1;
    CmbMonthChange(nil);
  end
  else
  begin
    if CmbYear.ItemIndex < Pred(CmbYear.Items.Count) then
    begin
      CmbYear.ItemIndex := (CmbYear.ItemIndex + 1);
      CmbMonth.ItemIndex := 0;
      CmbYearChange(nil);
    end
  end;
end;

procedure TForm2.btn_ProvMonthClick(Sender: TObject);
begin
  if CmbMonth.ItemIndex > 0 then
  begin
    CmbMonth.ItemIndex := CmbMonth.ItemIndex - 1;
    CmbMonthChange(nil);
  end
  else
  begin
    if CmbYear.ItemIndex > 0 then
    begin
      CmbYear.ItemIndex := (CmbYear.ItemIndex - 1);
      CmbMonth.ItemIndex := Pred(CmbMonth.Items.Count);
      CmbYearChange(nil);
    end
  end;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  CmbYear.ItemIndex := CmbYear.Items.IndexOf(format('%d', [FYear]));
  CmbMonth.ItemIndex := CmbMonth.Items.IndexOf
    (format('%s', [MonthStr[FMonth]]));
  CreateCalendar(StrToInt(CmbYear.Text), 1 + CmbMonth.ItemIndex);
end;

procedure TForm2.calendarCustomClick(Sender: TObject);
begin
  if Length((Sender as TRectShape).Hint) > 0 then
  begin
    FSelectedDate := ConvertDateStrToDate((Sender as TRectShape).Hint);
    lbl_SelectedDate.Caption := formatdatetime('YYYY-MM-DD', FSelectedDate);

    RectShape1.Visible := True;
    RectShape2.Visible := True;
    RectShape3.Visible := True;
    RectShape4.Visible := True;
    RectShape5.Visible := True;
    RectShape7.Visible := True;
    RectShape9.Visible := True;
    RectShape11.Visible := True;

    RectShape1.Left := (Sender as TCustomShape).BoundsRect.Right -
      (RectShape1.Width div 2);
    RectShape1.Top := (Sender as TCustomShape).BoundsRect.Top +
      (((Sender as TCustomShape).BoundsRect.Bottom - (Sender as TCustomShape)
      .BoundsRect.Top) - RectShape1.Height) div 2;

    RectShape2.Left := (Sender as TCustomShape).BoundsRect.Left -
      (RectShape2.Width div 2);
    RectShape2.Top := (Sender as TCustomShape).BoundsRect.Top +
      (((Sender as TCustomShape).BoundsRect.Bottom - (Sender as TCustomShape)
      .BoundsRect.Top) - RectShape2.Height) div 2;

    RectShape3.Left := (Sender as TCustomShape).Left +
      (((Sender as TCustomShape).BoundsRect.Right - (Sender as TCustomShape)
      .BoundsRect.Left) - RectShape3.Width) div 2;
    RectShape3.Top := (Sender as TCustomShape).Top - (RectShape3.Height div 2);

    RectShape4.Left := (Sender as TCustomShape).Left +
      (((Sender as TCustomShape).BoundsRect.Right - (Sender as TCustomShape)
      .BoundsRect.Left) - RectShape4.Width) div 2;
    RectShape4.Top := (Sender as TCustomShape).BoundsRect.Bottom -
      (RectShape4.Height div 2);

    RectShape5.Left := (Sender as TCustomShape).BoundsRect.Left -
      (RectShape5.Width div 2);
    RectShape5.Top := (Sender as TCustomShape).Top - (RectShape5.Height div 2);

    RectShape7.Left := (Sender as TCustomShape).BoundsRect.Right -
      (RectShape7.Width div 2);
    RectShape7.Top := (Sender as TCustomShape).Top - (RectShape7.Height div 2);

    RectShape9.Left := (Sender as TCustomShape).BoundsRect.Right -
      (RectShape9.Width div 2);
    RectShape9.Top := (Sender as TCustomShape).BoundsRect.Bottom -
      (RectShape9.Height div 2);

    RectShape11.Left := (Sender as TCustomShape).Left -
      (RectShape11.Width div 2);
    RectShape11.Top := (Sender as TCustomShape).BoundsRect.Bottom -
      (RectShape11.Height div 2);
  end;
end;

procedure TForm2.CmbMonthChange(Sender: TObject);
begin
CreateCalendar(StrToInt(CmbYear.Text), 1 + CmbMonth.ItemIndex);
end;

procedure TForm2.CmbYearChange(Sender: TObject);
begin
  CreateCalendar(StrToInt(CmbYear.Text), 1 + CmbMonth.ItemIndex);
end;

function TForm2.ConvertDateStrToDate(ADateStr: String): TDate;
var
  y, m, d: String;
begin
  y := Copy(ADateStr, 1, 4);
  m := Copy(ADateStr, 6, 2);
  d := Copy(ADateStr, 9, 2);
  try
    Result := EncodeDate(StrToInt(y), StrToInt(m), StrToInt(d));
  Except
    on E: exception do
    begin
      Result := Date;
    end;
  end;
end;

procedure TForm2.CreateCalendar(const AYear, AMonth: Word);
var
  currDate: TDate;
  y, m, d: Word;
  CurrDay: Word;
  i, j: integer;
  DaysOfmonth: Word;
  currDateStr: String;
  IsCurrMonthYear: Boolean;
  function IsCurrentMonthYear(ADate, BDate: TDate): Boolean;
  var
    y1, m1, d1, y2, m2, d2: Word;
  begin
    DecodeDate(ADate, y1, m1, d1);
    DecodeDate(BDate, y2, m2, d2);

    Result := ((y1 = y2) and (m1 = m2));
  end;

begin
  currDateStr := formatdatetime('YYYY-MM-DD', Date);
  currDate := EncodeDate(AYear, AMonth, 1);
  DecodeDate(currDate, y, m, d);

  CurrDay := DayOfTheWeek(EncodeDate(y, m, 1));
  DaysOfmonth := DaysInMonth(currDate);
  IsCurrMonthYear := IsCurrentMonthYear(Date, currDate);

  for i := 0 to Pred(Self.ComponentCount) do
  begin
    if (Self.Components[i] is TRectShape) then
    begin
      if (((Self.Components[i] as TRectShape).tag > 0) and
         ((Self.Components[i] as TRectShape).tag <= 35)) then
      begin
        (Self.Components[i] as TRectShape).Caption := '';
        (Self.Components[i] as TRectShape).Brush.Color := clwhite;
        (Self.Components[i] as TRectShape).Hint := '';
        (Self.Components[i] as TRectShape).ShowHint := False;
      end;
    end;
  end;
  for i := CurrDay to (DaysOfmonth + CurrDay) - 1 do
  begin
    for j := 0 to Pred(Self.ComponentCount) do
    begin
      if (Self.Components[j] is TRectShape) then
      begin
        if ((Self.Components[j] as TRectShape).tag = i) then
        begin
          (Self.Components[j] as TRectShape).Caption :=
            format('%d', [i - (CurrDay - 1)]);
          (Self.Components[j] as TRectShape).ShowHint := True;
          (Self.Components[j] as TRectShape).Hint :=
            format('%s-%s-%s', [CmbYear.Text, formatfloat('00',
            (CmbMonth.ItemIndex + 1)), formatfloat('00', (i - (CurrDay - 1)))]);
          if (currDateStr = (Self.Components[j] as TRectShape).Hint) then
          begin
            (Self.Components[j] as TRectShape).Brush.Color := clLime;
            (Self.Components[j] as TRectShape).Click;
            FBoxDaySelected:= (Self.Components[j] as TRectShape);
          end;

          if ((i = CurrDay) and (IsCurrMonthYear = False)) then begin
            (Self.Components[j] as TRectShape).Click;
            FBoxDaySelected:= (Self.Components[j] as TRectShape);
          end;

          Break;
        end;
      end;
    end;
  end;

  for i := 0 to Pred(Self.ComponentCount) do
  begin
    if (Self.Components[i] is TRectShape) then
    begin
      if (Self.Components[i] as TRectShape).tag > 0 then
        if (Self.Components[i] as TRectShape).Caption = '' then
          (Self.Components[i] as TRectShape).Brush.Color := $00E2E2E2;
    end;
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  DecodeDate(Date, FYear, FMonth, FDay);
  CmbYear.ItemIndex := CmbYear.Items.IndexOf(format('%d', [FYear]));
  CmbMonth.ItemIndex := CmbMonth.Items.IndexOf
    (format('%s', [MonthStr[FMonth]]));

  InitCalendarBoxClick;
  CreateCalendar(StrToInt(CmbYear.Text), 1 + CmbMonth.ItemIndex);
end;

procedure TForm2.FormResize(Sender: TObject);
var
  eachWidth, eachHeight: integer;
  i: integer;
  parent: TRectShape;
begin
  eachWidth := (Self.Width - ((btn_ProvMonth.Width*2) + 50)) div 7;
  eachHeight := (Self.Height - 150) div 5;

  parent := calendar1;

  for i := 0 to Pred(Self.ComponentCount) do
  begin
    if Components[i] is TRectShape then
    begin
      if ((Components[i] as TRectShape).tag)> 100 then
         (Components[i] as TRectShape).Width := eachWidth
      else begin
        (Components[i] as TRectShape).Width := eachWidth;
        (Components[i] as TRectShape).Height := eachHeight;
      end;
    end;
  end;

  for i := 0 to Pred(Self.ComponentCount) do
  begin
    if (Components[i] is TRectShape) then
    begin
      if (Components[i] as TRectShape).Tag <= 7 then
      begin
        if (Components[i] as TRectShape).Tag = 1 then
        begin
          (Components[i] as TRectShape).Left := btn_ProvMonth.Width+10;
          (Components[i] as TRectShape).Top := 100;
          parent := (Components[i] as TRectShape);
        end
        else if (Components[i] as TRectShape).Tag = 2 then
        begin
          (Components[i] as TRectShape).Left := parent.BoundsRect.Right;
          (Components[i] as TRectShape).Top := parent.Top;
          parent := (Components[i] as TRectShape);
        end
        else if (Components[i] as TRectShape).Tag = 3 then
        begin
          (Components[i] as TRectShape).Left := parent.BoundsRect.Right;
          (Components[i] as TRectShape).Top := parent.Top;
          parent := (Components[i] as TRectShape);
        end
        else if (Components[i] as TRectShape).Tag = 4 then
        begin
          (Components[i] as TRectShape).Left := parent.BoundsRect.Right;
          (Components[i] as TRectShape).Top := parent.Top;
          parent := (Components[i] as TRectShape);
        end

        else if (Components[i] as TRectShape).Tag = 5 then
        begin
          (Components[i] as TRectShape).Left := parent.BoundsRect.Right;
          (Components[i] as TRectShape).Top := parent.Top;
          parent := (Components[i] as TRectShape);
        end

        else if (Components[i] as TRectShape).Tag = 6 then
        begin
          (Components[i] as TRectShape).Left := parent.BoundsRect.Right;
          (Components[i] as TRectShape).Top := parent.Top;
          parent := (Components[i] as TRectShape);
        end

        else if (Components[i] as TRectShape).Tag = 7 then
        begin
          (Components[i] as TRectShape).Left := parent.BoundsRect.Right;
          (Components[i] as TRectShape).Top := parent.Top;
          parent := (Components[i] as TRectShape);
        end;
      end
      else if ((Components[i] as TRectShape).Tag >= 8) and ((Components[i] as
        TRectShape).Tag <= 14) then
      begin
        if (Components[i] as TRectShape).Tag = 8 then
        begin
          (Components[i] as TRectShape).Left := calendar1.Left;
          (Components[i] as TRectShape).Top := calendar1.BoundsRect.Bottom ;
          parent := (Components[i] as TRectShape);
        end

        else if (Components[i] as TRectShape).Tag = 9 then
        begin
          (Components[i] as TRectShape).Left := parent.BoundsRect.Right;
          (Components[i] as TRectShape).Top := parent.Top;
          parent := (Components[i] as TRectShape);
        end

        else if (Components[i] as TRectShape).Tag = 10 then
        begin
          (Components[i] as TRectShape).Left := parent.BoundsRect.Right;
          (Components[i] as TRectShape).Top := parent.Top;
          parent := (Components[i] as TRectShape);
        end

        else if (Components[i] as TRectShape).Tag = 11 then
        begin
          (Components[i] as TRectShape).Left := parent.BoundsRect.Right;
          (Components[i] as TRectShape).Top := parent.Top;
          parent := (Components[i] as TRectShape);
        end

        else if (Components[i] as TRectShape).Tag = 12 then
        begin
          (Components[i] as TRectShape).Left := parent.BoundsRect.Right;
          (Components[i] as TRectShape).Top := parent.Top;
          parent := (Components[i] as TRectShape);
        end

        else if (Components[i] as TRectShape).Tag = 13 then
        begin
          (Components[i] as TRectShape).Left := parent.BoundsRect.Right;
          (Components[i] as TRectShape).Top := parent.Top;
          parent := (Components[i] as TRectShape);
        end

        else if (Components[i] as TRectShape).Tag = 14 then
        begin
          (Components[i] as TRectShape).Left := parent.BoundsRect.Right;
          (Components[i] as TRectShape).Top := parent.Top;
          parent := (Components[i] as TRectShape);
        end;
      end

      else if ((Components[i] as TRectShape).Tag >= 15) and ((Components[i] as
        TRectShape).Tag <= 21) then
      begin
        if (Components[i] as TRectShape).Tag = 15 then
        begin
          (Components[i] as TRectShape).Left := calendar8.Left;
          (Components[i] as TRectShape).Top := calendar8.BoundsRect.Bottom;
          parent := (Components[i] as TRectShape);
        end

        else if (Components[i] as TRectShape).Tag = 16 then
        begin
          (Components[i] as TRectShape).Left := parent.BoundsRect.Right;
          (Components[i] as TRectShape).Top := parent.Top;
          parent := (Components[i] as TRectShape);
        end

        else if (Components[i] as TRectShape).Tag = 17 then
        begin
          (Components[i] as TRectShape).Left := parent.BoundsRect.Right;
          (Components[i] as TRectShape).Top := parent.Top;
          parent := (Components[i] as TRectShape);
        end

        else if (Components[i] as TRectShape).Tag = 18 then
        begin
          (Components[i] as TRectShape).Left := parent.BoundsRect.Right;
          (Components[i] as TRectShape).Top := parent.Top;
          parent := (Components[i] as TRectShape);
        end

        else if (Components[i] as TRectShape).Tag = 19 then
        begin
          (Components[i] as TRectShape).Left := parent.BoundsRect.Right;
          (Components[i] as TRectShape).Top := parent.Top;
          parent := (Components[i] as TRectShape);
        end

        else if (Components[i] as TRectShape).Tag = 20 then
        begin
          (Components[i] as TRectShape).Left := parent.BoundsRect.Right;
          (Components[i] as TRectShape).Top := parent.Top;
          parent := (Components[i] as TRectShape);
        end

        else if (Components[i] as TRectShape).Tag = 21 then
        begin
          (Components[i] as TRectShape).Left := parent.BoundsRect.Right;
          (Components[i] as TRectShape).Top := parent.Top;
          parent := (Components[i] as TRectShape);
        end;
      end

      else if ((Components[i] as TRectShape).Tag >= 22) and ((Components[i] as
        TRectShape).Tag <= 28) then
      begin
        if (Components[i] as TRectShape).Tag = 22 then
        begin
          (Components[i] as TRectShape).Left := calendar15.Left;
          (Components[i] as TRectShape).Top := calendar15.BoundsRect.Bottom;
          parent := (Components[i] as TRectShape);
        end

        else if (Components[i] as TRectShape).Tag = 23 then
        begin
          (Components[i] as TRectShape).Left := parent.BoundsRect.Right;
          (Components[i] as TRectShape).Top := parent.Top;
          parent := (Components[i] as TRectShape);
        end

        else if (Components[i] as TRectShape).Tag = 24 then
        begin
          (Components[i] as TRectShape).Left := parent.BoundsRect.Right;
          (Components[i] as TRectShape).Top := parent.Top;
          parent := (Components[i] as TRectShape);
        end

        else if (Components[i] as TRectShape).Tag = 25 then
        begin
          (Components[i] as TRectShape).Left := parent.BoundsRect.Right;
          (Components[i] as TRectShape).Top := parent.Top;
          parent := (Components[i] as TRectShape);
        end

        else if (Components[i] as TRectShape).Tag = 26 then
        begin
          (Components[i] as TRectShape).Left := parent.BoundsRect.Right;
          (Components[i] as TRectShape).Top := parent.Top;
          parent := (Components[i] as TRectShape);
        end

        else if (Components[i] as TRectShape).Tag = 27 then
        begin
          (Components[i] as TRectShape).Left := parent.BoundsRect.Right;
          (Components[i] as TRectShape).Top := parent.Top;
          parent := (Components[i] as TRectShape);
        end

        else if (Components[i] as TRectShape).Tag = 28 then
        begin
          (Components[i] as TRectShape).Left := parent.BoundsRect.Right;
          (Components[i] as TRectShape).Top := parent.Top;
          parent := (Components[i] as TRectShape);
        end;
      end

      else if ((Components[i] as TRectShape).Tag >= 29) and ((Components[i] as
        TRectShape).Tag <= 35) then
      begin
        if (Components[i] as TRectShape).Tag = 29 then
        begin
          (Components[i] as TRectShape).Left := calendar22.Left;
          (Components[i] as TRectShape).Top := calendar22.BoundsRect.Bottom ;
          parent := (Components[i] as TRectShape);
        end

        else if (Components[i] as TRectShape).Tag = 30 then
        begin
          (Components[i] as TRectShape).Left := parent.BoundsRect.Right;
          (Components[i] as TRectShape).Top := parent.Top;
          parent := (Components[i] as TRectShape);
        end

        else if (Components[i] as TRectShape).Tag = 31 then
        begin
          (Components[i] as TRectShape).Left := parent.BoundsRect.Right;
          (Components[i] as TRectShape).Top := parent.Top;
          parent := (Components[i] as TRectShape);
        end

        else if (Components[i] as TRectShape).Tag = 32 then
        begin
          (Components[i] as TRectShape).Left := parent.BoundsRect.Right;
          (Components[i] as TRectShape).Top := parent.Top;
          parent := (Components[i] as TRectShape);
        end

        else if (Components[i] as TRectShape).Tag = 33 then
        begin
          (Components[i] as TRectShape).Left := parent.BoundsRect.Right;
          (Components[i] as TRectShape).Top := parent.Top;
          parent := (Components[i] as TRectShape);
        end

        else if (Components[i] as TRectShape).Tag = 34 then
        begin
          (Components[i] as TRectShape).Left := parent.BoundsRect.Right;
          (Components[i] as TRectShape).Top := parent.Top;
          parent := (Components[i] as TRectShape);
        end

        else if (Components[i] as TRectShape).Tag = 35 then
        begin
          (Components[i] as TRectShape).Left := parent.BoundsRect.Right;
          (Components[i] as TRectShape).Top := parent.Top;
          parent := (Components[i] as TRectShape);
        end;
      end;
    end;
  end;

  RectShapeMon.Left:= calendar1.Left;
  RectShapeTue.Left:= calendar2.Left;
  RectShapeWed.Left:= calendar3.Left;
  RectShapeThu.Left:= calendar4.Left;
  RectShapeFri.Left:= calendar5.Left;
  RectShapeSat.Left:= calendar6.Left;
  RectShapeSun.Left:= calendar7.Left;

  if assigned(FBoxDaySelected) then
   FBoxDaySelected.Click;

  Button1.Left := calendar1.Left;
  lbl_SelectedDate.Left := RectShapeTue.Left;
  CmbYear.Width:= RectShapeSat.Width div 2;
  CmbYear.Left := (RectShapeSat.BoundsRect.Right - (RectShapeSat.Width div 2))-2;

  CmbMonth.Width:= RectShapeSun.Width;
  CmbMonth.Left :=  RectShapeSun.BoundsRect.right-RectShapeSun.Width;
btn_ProvMonth.Left := calendar15.BoundsRect.Left - btn_ProvMonth.Width;
btn_ProvMonth.Top := calendar15.Top+((calendar15.BoundsRect.Bottom - calendar15.BoundsRect.Top)-btn_ProvMonth.Height) div 2;

btn_NextMonth.Left := calendar21.BoundsRect.Right;
btn_NextMonth.Top  := calendar21.BoundsRect.Top+((calendar21.BoundsRect.Bottom - calendar21.BoundsRect.Top) - btn_NextMonth.Height) div  2;

end;

procedure TForm2.InitCalendarBoxClick;
var
  i: Word;
begin
  for i := 0 to Pred(Self.ComponentCount) do
  begin
    if (Self.Components[i] is TRectShape) then
    begin
      if (((Self.Components[i] as TRectShape).tag > 0) and ( (Self.Components[i] as TRectShape).tag <= 35)) then
      begin
        (Self.Components[i] as TRectShape).OnClick := calendarCustomClick;
      end;
    end;
  end;
end;

end.
