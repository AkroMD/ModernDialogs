unit UAkroDialogs;

interface

  uses FMX.edit, System.Generics.Collections, System.Classes, FMX.Layouts, FMX.Objects,
      FMX.Types, System.UITypes, FMX.Graphics, System.SysUtils, System.Types,
      FMX.ani, FMX.Controls, FMX.StdCtrls, FMX.Forms
      {$IFDEF ANDROID}
      , FMX.FontGlyphs.Android
      , FMX.VirtualKeyboard
      , FMX.Platform
      {$ENDIF};


  type

  TTypeInputSymbols = (Letters,LettersAndNumbers,Numbers);

  TInputDialogValue = class(TObject)
    Name: String;
    TextEdit: String;
    DefaultText: String;
    TypeInputSymbols: TTypeInputSymbols;
    ChangeText: ^String;
    ChangeNumber: ^Integer;
    MaxSymbols: byte;
    Necessarily: Boolean;
  end;

  TInputDialogValueList = class(TObjectList<TInputDialogValue>)
  private
    ShowEvent: TNotifyEvent;
    Header: string;
    Procedure AddShowEvent(ANotifyEvent: TNotifyEvent);
    Procedure GetNewValueOnEdit(AEdit: TEdit; Name: String);
    procedure AddNewAll(AName, ANameEdit, ADefaultText:String; ATypeInputSymbols: TTypeInputSymbols; AMaxSymbols: byte; Necessarily: Boolean);
  public
    procedure AddNew(AName, ANameEdit, ADefaultText:String;var AChangeText: String; ATypeInputSymbols: TTypeInputSymbols; AMaxSymbols: byte); overload;
    procedure AddNew(AName, ANameEdit, ADefaultText:String;var AChangeText: Integer; AMaxSymbols: byte); overload;
    procedure AddNew(AName, ANameEdit, ADefaultText:String;var AChangeText: String; ATypeInputSymbols: TTypeInputSymbols; AMaxSymbols: byte; Necessarily: Boolean); overload;
    procedure AddNew(AName, ANameEdit, ADefaultText:String;var AChangeText: Integer); overload;
    procedure AddNew(AName, ANameEdit, ADefaultText:String;var AChangeText: String); overload;
    Constructor NewList(AName: String;ANotifyEvent: TNotifyEvent);
  end;

  TMessage = class(TObject)
    Header: String;
    Text: String;
    Bitmap: TBitmap;
    Critical: Boolean;
    Destructor Destroy; override;
  end;

  TFlashMessege = Class(TObject)
    Header: String;
    Text: String;
    X: Single;
    Y: Single;
    Width: Single;
    Height: Single;
  End;

  TDialog = Class(TComponent)
  private
    [weak] Panel: TRectangle;
    [weak] LayButton: TLayout;
    [weak] RRButtonOk: TRoundRect;
    [weak] TextButtonOk: TText;
    [weak] IconButtonOk: TText;
    [weak] LayMain: TScrollBox;
    [weak] ButtonSelected: TRoundRect;
    [weak] Header: TText;
    [weak] BackLay: TPaintBox;
    APath: TPathData;
    [weak] BackHeader: TRectangle;
    Procedure ButtonOkClick(Sender: TObject); virtual;
    Procedure ButtonOnEnter(Sender: TObject); virtual;
    Procedure ButtonOnLeave(Sender: TObject); virtual;
    Procedure OnPaintAll(Sender: TObject; Canvas: TCanvas); virtual;
    Constructor NewDialog(AName: String); virtual;
    Destructor Destroy; override;
    Procedure Clear; virtual;
  public
  End;

  TInputDialog = class(TDialog)
  private
     LayValues: TObjectList<TLayout>;
     TextEdits: TObjectList<TText>;
     Edits: TObjectList<TEdit>;
    [weak] RRButtonCancel: TRoundRect;
    [weak] TextButtonCancel: TText;
    [weak] IconButtonCancel: TText;
    [weak] TextName: TText;
    [weak] EditSelected: TRectangle;
    ValueList: TInputDialogValueList;
    PositionY: Single;
    Procedure ButtonOkClick(Sender: TObject); override;
    Procedure ButtonCancelClick(Sender: TObject);
    Procedure ChangeTrackingEdit(Sender: TObject);
    Procedure EditOnEnter(Sender: TObject);
    Procedure EditOnLeave(Sender: TObject);
    Procedure FormVirtualKeyboardShown(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
    Procedure FormVirtualKeyboardHidden(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
    Function NewValue: String;
    Function GetValue(AName: String): String;
    Function CheckExisting(AName: String): Boolean;
    Procedure SetFocus(AName: String);
    Destructor Destroy; override;
    Procedure Clear; override;
  public
    Constructor NewInputDialog(AValueList: TInputDialogValueList);
  end;

  TShowMessageDialog = Class(TDialog)
  private
    [weak] Image: TCircle;
    [weak] Detail: TText;
    Messeges: TObjectList<TMessage>;
    Procedure ButtonOkClick(Sender: TObject); override;
    Destructor Destroy; override;
    Procedure Clear; override;
  public
    Procedure AddMessage(Header, Text: String; Bitmap: TBitmap; Critical: Boolean);
    Constructor NewDialog(AName: String); override;
    Procedure Show;
  End;

  TQuestionDialog = Class(TDialog)
  private
    [weak] Detail: TText;
    [weak] RRButtonNo: TRoundRect;
    [weak] TextIcon: TText;
    [weak] TextButtonNo: TText;
    [weak] IconButtonNo: TText;
    OkEvent: TNotifyEvent;
    Procedure ButtonOkClick(Sender: TObject); override;
    Procedure ButtonNoClick(Sender: TObject);
    Destructor Destroy; override;
    Constructor NewDialog(AName: String); override;
    Procedure Clear; override;
  public
    Constructor NewQuestDialog(AHeader, AText: String; OnOkEvent: TNotifyEvent);
  End;

  TFlashDialog = Class(TDialog)
  private
    [weak] Detail: TText;
    FlashMessages: TObjectList<TFlashMessege>;
    Procedure ButtonOkClick(Sender: TObject); override;
    Destructor Destroy; override;
    Procedure Clear; override;
  public
    Procedure AddFlashMessage(AHeader,AText: String; AX,AY, AWidth, AHeight: Single);
    Constructor NewDialog(AName: String); override;
    Procedure Show;
  End;

  Function CheckTrueSymbol(Symbol: Char; TrueChars: array of Char): Boolean;
  Procedure FontAwesomeAssign(aControl: TFmxObject);
  Function GetAbsPosition(AControl: TFmxObject): TPointF;
  Function GetHeightText(var Text: String; FontSize, Width: Single): Single;

  const

      RightChar : array[0..58] of Char = ('a','b','c','d','q','w','e','r','t','y','u','i','o','p','s','f',
                                            'g','h','j','k','l','x','v','n','m','z','а','б','в','г','д','е',
                                            'ж','з','и','к','л','м','н','о','п','р','с','т','у','ф','х','ч',
                                            'ш','щ','ь','ъ','э','ю','я','й','ё','ц','ы');

      RightCharAdd : array[0..68] of Char = ('0','1','2','3','4','5','6','7','8','9','a','b','c','d','q','w',
                                            'e','r','t','y','u','i','o','p','s','f','g','h','j','k','l','x',
                                            'v','n','m','z','а','б','в','г','д','е','ж','з','и','к','л','м',
                                            'н','о','п','р','с','т','у','ф','х','ч','ш','щ','ь','ъ','э','ю',
                                            'я','й','ё','ц','ы');

      RightCharNumber: array[0..9] of Char = ('0','1','2','3','4','5','6','7','8','9');

      VowelsChar: array[0..10] of Char = ('а','е','и','о','у','э','ю','я','й','ё','ы');

      fa_check = widechar($F00C);
      fa_thumbs_down = widechar($F165);
      fa_question_circle = widechar($F059);
      fa_ban = widechar($F05E);

      FontAwesomeName = 'FontAwesome';

   var MsgDialog: TShowMessageDialog;
       FlhDialog: TFlashDialog;
       ColorDialog: TAlphaColor = TAlphaColors.LtGray;
       ColorButton: TAlphaColor = TAlphaColors.Lightgrey;
       ColorFillHeader: TAlphaColor = TAlphaColors.LtGray;
       FontDialog: TFontName = 'Calibry';
       FontSizeDetail: Integer = 12;
       FontSizeHeader: Integer = 18;
       FontSizeButton: Integer = 14;
       CornersPanel: TCorners = [TCorner.TopRight,TCorner.BottomLeft,TCorner.BottomRight];
       PanelWidth: Integer = 250;
       PanelHeight: Integer = 250;

implementation

function CheckTrueSymbol(Symbol: Char; TrueChars: array of Char): Boolean;
    var i: Integer;
begin
  //Полагаем что символ валиден
  Result := True;
  for I := Low(TrueChars) to High(TrueChars) do
    if Symbol = TrueChars[i] then Exit;
  //Если не нашли в массиве, то считаем его невалидным
  Result := False;
end;

Function GetAbsPosition(AControl: TFmxObject): TPointF;
  var FmxOb: TFmxObject;
begin
  if AControl is TControl then
    Result := GetAbsPosition(AControl.Parent) + TControl(AControl).Position.Point
  else Result := PointF(0,0);
end;

Function GetHeightText(var Text: String; FontSize, Width: Single): Single;

  Function FindVowel(Text: String): Integer;
    var I: Integer;
        Checking: Boolean;
  begin
    Checking := False;
    for I := Low(Text) to High(Text) do
      if CheckTrueSymbol(Text[i],VowelsChar) then
        begin
          if Checking then Checking := False
          else Checking := True;
        end
      else
        if Checking then
          begin
            Result := I;
            Exit;
          end;
  end;

  var Words: array of String;
      HeightStroke: Single;
      CountSymbolsStroke: Integer;
      CurrentWidth: Single;
      I: Integer;
      StartPos, EndPos: Integer;
      TmpText: String;
begin

  Result := 0;

  //Удаляем лишние пробелы
  TmpText := Trim(Text);

  While pos('  ',TmpText) <> 0 do
    TmpText := StringReplace(TmpText,'  ',' ',[rfreplaceall]);
  //

  //Разбиваем на слова
  StartPos := Low(TmpText);
  for I := Low(TmpText) to High(TmpText) do
    begin
      if (TmpText[i] = ' ') then
        begin
          SetLength(Words,Length(Words) + 1);
          {$IFDEF MSWINDOWS}
          EndPos := i;
          {$ELSE}
          EndPos := i + 1;
          {$ENDIF}
          Words[High(Words)] := Copy(TmpText,StartPos,EndPos - StartPos);
          {$IFDEF MSWINDOWS}
          StartPos := i + 1;
          {$ELSE}
          StartPos := i + 2;
          {$ENDIF}
        end;
      if (i = High(TmpText)) then
        begin
          SetLength(Words,Length(Words) + 1);
          {$IFDEF MSWINDOWS}
          EndPos := i + 1;
          {$ELSE}
          EndPos := i + 2;
          {$ENDIF}
          Words[High(Words)] := Copy(TmpText,StartPos,EndPos - StartPos);
        end;
    end;
  //

  if Length(Words) = 0 then Exit;

  //Рассчитываем константы
    //Количество символов в строке
    CountSymbolsStroke := Round((Width * 1.7) / FontSize);
    //
    //Высота одной строк
    HeightStroke := FontSize * 5 / 3;
    //
  //

  //Считаем высоту строки
  CurrentWidth := 0;
  Result := HeightStroke;
  Text := '';
  for I := Low(Words) to High(Words) do
    begin
      if Length(Words[i]) > CountSymbolsStroke then
        begin
          SetLength(Words,Length(Words) + 1);
          EndPos := low(Words[i]) + Length(Words[i]) - CountSymbolsStroke - Round(CurrentWidth) - 1;
          TmpText := Words[i];
          Words[i] := Copy(TmpText,Low(TmpText),EndPos - Low(TmpText)) + '-';
          Words[i+1] := Copy(TmpText,EndPos,Length(TmpText) - Length(Words[i]) - 1);
        end;

      if CurrentWidth + Length(Words[i]) >= CountSymbolsStroke then
        begin
          CurrentWidth := 0;
          Result := Result + HeightStroke;
        end
      else CurrentWidth := CurrentWidth + Length(Words[i]);

      Text := Text + Words[i];
      if i < high(Words) then Text := Text + ' ';
    end;
  //

end;

procedure FontAwesomeAssign(aControl: TFmxObject); //By Zubu
const
  aStyledSettings: TStyledSettings = [{TStyledSetting.Size, TStyledSetting.FontColor, TStyledSetting.Style, TStyledSetting.Other}];
var
  aPresentedClass: TPresentedTextControl;
  aEdit: TEdit;
  aTextClass: TTextControl;
  aTextControlClass: TText;
  aButon: TCustomButton;
begin
  if (aControl is TText) then
  begin
    aTextControlClass := aControl as TText;
    // aTextControlClass.TextSettings.VertAlign := TTextAlign.Center;
    aTextControlClass.TextSettings.Font.Family := FontAwesomeName;
  end
  else if (aControl is TPresentedTextControl) then
  begin
    aPresentedClass := aControl as TPresentedTextControl;
    aPresentedClass.StyledSettings := aStyledSettings;
    // aPresentedClass.TextSettings.VertAlign := TTextAlign.Center;
    aPresentedClass.TextSettings.Font.Family := FontAwesomeName;
  end
  else if (aControl is TTextControl) then
  begin
    aTextClass := aControl as TTextControl;
    aTextClass.StyledSettings := aStyledSettings;
    // aTextClass.TextSettings.VertAlign := TTextAlign.Center;
    aTextClass.TextSettings.Font.Family := FontAwesomeName;
  end
  else if (aControl is TEdit) then
  begin
    aEdit := aControl as TEdit;
    aEdit.StyledSettings := aStyledSettings;
    // aEdit.TextSettings.VertAlign := TTextAlign.Center;
    aEdit.TextSettings.Font.Family := FontAwesomeName;
  end;
end;        //


{ TInputDialogValueList }

procedure TInputDialogValueList.AddNew(AName, ANameEdit, ADefaultText: String;
   var AChangeText: String; ATypeInputSymbols: TTypeInputSymbols; AMaxSymbols: byte);
begin
  AddNewAll(AName,ANameEdit,ADefaultText,ATypeInputSymbols,AMaxSymbols,False);
  Last.ChangeText := @AChangeText;
end;

procedure TInputDialogValueList.AddNew(AName, ANameEdit, ADefaultText: String;
   var AChangeText: Integer; AMaxSymbols: byte);
begin
  AddNewAll(AName,ANameEdit,ADefaultText,Numbers,AMaxSymbols,True);
  Last.ChangeNumber := @AChangeText;
end;

procedure TInputDialogValueList.AddNew(AName, ANameEdit, ADefaultText: String;
   var AChangeText: String; ATypeInputSymbols: TTypeInputSymbols; AMaxSymbols: byte; Necessarily: Boolean);
begin
  AddNewAll(AName,ANameEdit,ADefaultText,ATypeInputSymbols,AMaxSymbols,Necessarily);
  Last.ChangeText := @AChangeText;
end;

procedure TInputDialogValueList.AddNew(AName, ANameEdit, ADefaultText: String;
   var AChangeText: Integer);
begin
  AddNewAll(AName,ANameEdit,ADefaultText,Numbers,0,True);
  Last.ChangeNumber := @AChangeText;
end;

procedure TInputDialogValueList.AddNew(AName, ANameEdit, ADefaultText: String;
   var AChangeText: String);
begin
  AddNewAll(AName,ANameEdit,ADefaultText,LettersAndNumbers,0,False);
  Last.ChangeText := @AChangeText;
end;

procedure TInputDialogValueList.AddShowEvent(ANotifyEvent: TNotifyEvent);
begin
  ShowEvent := ANotifyEvent;
end;


procedure TInputDialogValueList.GetNewValueOnEdit(AEdit: TEdit; Name: String);
  var AinDiValue: TInputDialogValue;
begin
  for AinDiValue in Self do
    if AinDiValue.Name.Equals(Name) then
      begin
        if Assigned(AinDiValue.ChangeText) then AinDiValue.ChangeText^ := AEdit.Text
          else AinDiValue.ChangeNumber^ := AEdit.Text.ToInteger;
        Break;
      end;
end;

constructor TInputDialogValueList.NewList(AName: String; ANotifyEvent: TNotifyEvent);
begin
  Create;
  ShowEvent := ANotifyEvent;
  Header := AName;
end;

procedure TInputDialogValueList.AddNewAll(AName, ANameEdit, ADefaultText: String; ATypeInputSymbols: TTypeInputSymbols;
  AMaxSymbols: byte; Necessarily: Boolean);
  var AinDiValue: TInputDialogValue;
begin
  AinDiValue := TInputDialogValue.Create;
  AinDiValue.Name := AName;
  AinDiValue.TextEdit := ANameEdit;
  AinDiValue.DefaultText := ADefaultText;
  AinDiValue.TypeInputSymbols := ATypeInputSymbols;
  AinDiValue.MaxSymbols := AMaxSymbols;
  AinDiValue.Necessarily := Necessarily;
  AinDiValue.ChangeText := nil;
  AinDiValue.ChangeNumber := nil;
  Add(AinDiValue);
end;

{ TInputDialog }

procedure TInputDialog.ButtonCancelClick(Sender: TObject);
begin
  Clear;
end;

procedure TInputDialog.ButtonOkClick(Sender: TObject);
  var AResult: String;
begin

  AResult := NewValue;
  if Length(AResult) > 0 then
    begin
      TextName.Text := 'Не может быть пустым';
      SetFocus(AResult);
      Exit;
    end;

  if Assigned(ValueList.ShowEvent) then
      ValueList.ShowEvent(Panel.Parent);

  inherited;
end;

procedure TInputDialog.ChangeTrackingEdit(Sender: TObject);
  var Symbols: String;
      TypeSymbols: byte;
      Result: Boolean;
begin

  //TagString используем как временное хранилище
  if (TEdit(Sender).text.Equals(TEdit(Sender).TagString)) then Exit;

  if (Length(TEdit(Sender).text) = 0) then
    begin
      TEdit(Sender).TagString := '';
      Exit;
    end;

  Symbols := TEdit(Sender).Text[high(TEdit(Sender).Text)];
  Symbols := AnsiLowerCase(Symbols);
  TypeSymbols := TEdit(Sender).Tag;

  case TypeSymbols of
    0: Result := CheckTrueSymbol(Symbols[low(Symbols)],RightChar);
    1: Result := CheckTrueSymbol(Symbols[low(Symbols)],RightCharAdd);
    2: Result := CheckTrueSymbol(Symbols[low(Symbols)],RightCharNumber);
  end;

  //Text - используем для вывода сообщений
  if not Result then
    begin
      TextName.Text := 'Недопустимые символы';
      TextName.TextSettings.FontColor := TAlphaColors.Red;
      (Sender as TEdit).Text := TEdit(Sender).TagString;
    end
  else
    begin
      TEdit(Sender).TagString := (Sender as TEdit).Text;
      TextName.Text := '';
    end;
end;

function TInputDialog.CheckExisting(AName: String): Boolean;
  var AEdit: TEdit;
begin
  for AEdit in Edits do
    begin
      if AEdit.Name = AName then
        begin
          if Length(AEdit.Text) = 0 then Result := False
            else Result := True;
          Break;
        end;
    end;
end;

procedure TInputDialog.Clear;
begin
  TForm(Owner).OnVirtualKeyboardShown := nil;
  TForm(Owner).OnVirtualKeyboardHidden := nil;
  RRButtonCancel.OnMouseLeave := nil;
  RRButtonCancel.OnMouseEnter := nil;
  RRButtonCancel.OnClick := nil;
  inherited;
end;

destructor TInputDialog.Destroy;
begin
  ValueList.Free;
  ValueList := nil;
  Edits.Free;
  Edits := nil;
  TextEdits.Free;
  TextEdits := nil;
  LayValues.Free;
  LayValues := nil;
  inherited;
end;

procedure TInputDialog.EditOnEnter(Sender: TObject);
begin
  EditSelected.Visible := True;
  EditSelected.Position.Y := TLayout(TEdit(Sender).Parent).Position.Y;
  EditSelected.Position.X := TEdit(Sender).Position.X;
  EditSelected.Width := TEdit(Sender).Width;
  EditSelected.Height := TEdit(Sender).Height;
end;

procedure TInputDialog.EditOnLeave(Sender: TObject);
begin
  if Assigned(EditSelected) then
    EditSelected.Visible := False;
end;

procedure TInputDialog.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  TAnimator.AnimateFloat(Panel,'Position.Y',PositionY,0.3,TAnimationType.&In,TInterpolationType.Linear);
end;

procedure TInputDialog.FormVirtualKeyboardShown(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  TAnimator.AnimateFloat(Panel,'Position.Y',Bounds.Top - Panel.Height,0.3,TAnimationType.&In,TInterpolationType.Linear);
end;

function TInputDialog.GetValue(AName: String): String;
  var AEdit: TEdit;
begin
  for AEdit in Edits do
    begin
      if AEdit.Name = AName then
        begin
          Result := AEdit.Text;
          Break;
        end;
    end;
end;

constructor TInputDialog.NewInputDialog(AValueList: TInputDialogValueList);
  var AValue: TInputDialogValue;
      AText: TText;
      ALayout: TLayout;
      AEdit: TEdit;
begin

  NewDialog(AValueList.Header);

  ValueList := AValueList;

  RRButtonCancel := TRoundRect.Create(LayButton);
  RRButtonCancel.Parent := LayButton;
  RRButtonCancel.OnClick := ButtonCancelClick;
  {$IFDEF MSWINDOWS}
  RRButtonCancel.OnMouseEnter := ButtonOnEnter;
  RRButtonCancel.OnMouseLeave := ButtonOnLeave;
  {$ENDIF}
  RRButtonCancel.Align := TAlignLayout.Right;
  RRButtonCancel.Width := 100;
  RRButtonCancel.Fill.Color := ColorButton;
  //RRButtonCancel.Stroke.Thickness := 2;
  RRButtonCancel.Stroke.Kind := TBrushKind.None;

  IconButtonCancel := TText.Create(RRButtonCancel);
  FontAwesomeAssign(IconButtonCancel);
  IconButtonCancel.Parent := RRButtonCancel;
  IconButtonCancel.Align := TAlignLayout.Left;
  IconButtonCancel.HitTest := False;
  IconButtonCancel.Text := fa_ban;
  IconButtonCancel.Font.Size := FontSizeButton;
  IconButtonCancel.Width := 15;
  IconButtonCancel.TextSettings.FontColor := $FFA61300;
  IconButtonCancel.Margins.Left := 7;

  TextButtonCancel := TText.Create(RRButtonCancel);
  TextButtonCancel.Parent := RRButtonCancel;
  TextButtonCancel.Align := TAlignLayout.Client;
  TextButtonCancel.HitTest := False;
  TextButtonCancel.Text := 'Отмена';
  TextButtonCancel.TextSettings.HorzAlign := TTextAlign.Leading;
  TextButtonCancel.Font.Size := FontSizeButton;
  TextButtonCancel.Margins.Left := 3;
  TextButtonCancel.Font.Family := FontDialog;

  TextName := TText.Create(Panel);
  TextName.Parent := Panel;
  TextName.Align := TAlignLayout.Bottom;
  TextName.Height := 14;
  TextName.Text := '';
  TextName.Margins.Bottom := 5;
  TextName.Font.Size := 12;
  TextName.Font.Family := FontDialog;

  LayValues := TObjectList<TLayout>.Create;
  TextEdits := TObjectList<TText>.Create;
  Edits := TObjectList<TEdit>.Create;

  LayMain.BeginUpdate;

  for AValue in ValueList do
    begin
      ALayout := TLayout.Create(LayMain);
      ALayout.Parent := LayMain;
      ALayout.Align := TAlignLayout.Top;
      ALayout.Height := 30;
      ALayout.Margins.Top := 5;

      AText := TText.Create(ALayout);
      AText.Parent := ALayout;
      AText.Align := TAlignLayout.Left;
      AText.Text := AValue.TextEdit;
      AText.Width := 100;
      AText.Font.Family := FontDialog;
      AText.Font.Size := FontSizeDetail;

      AEdit := TEdit.Create(ALayout);
      AEdit.Parent := ALayout;
      AEdit.Align := TAlignLayout.Client;
      AEdit.Text := AValue.DefaultText;
        case AValue.TypeInputSymbols of
          Letters: AEdit.Tag := 0;
          LettersAndNumbers: AEdit.Tag := 1;
          Numbers: AEdit.Tag := 2;
        end;
      AEdit.OnChangeTracking := ChangeTrackingEdit;
      AEdit.OnEnter := EditOnEnter;
      AEdit.OnExit := EditOnLeave;
      AEdit.Name := AValue.Name;
      AEdit.MaxLength := AValue.MaxSymbols;
      AEdit.Margins.Left := 10;
      AEdit.Font.Family := FontDialog;
      AEdit.Font.Size := FontSizeDetail;
      AEdit.StyledSettings := [];

      LayValues.Add(ALayout);
      TextEdits.Add(AText);
      Edits.Add(AEdit);
    end;

  Panel.Height := LayButton.Height + Header.Height + TextName.Height +
                  LayValues.Count * 35 + 30 + Header.Margins.Top + TextName.Margins.Bottom +
                  LayButton.Margins.Bottom + LayButton.Margins.Top;

  if Panel.Height > PanelHeight then Panel.Height := PanelHeight;

  Panel.Align := TAlignLayout.None;
  PositionY := Panel.Position.Y;

  TForm(Owner).OnVirtualKeyboardShown := FormVirtualKeyboardShown;
  TForm(Owner).OnVirtualKeyboardHidden := FormVirtualKeyboardHidden;

  EditSelected := TRectangle.Create(LayMain);
  EditSelected.Parent := LayMain;
  EditSelected.Fill.Kind := TBrushKind.None;
  EditSelected.Stroke.Thickness := 3;
  EditSelected.Stroke.Color := $FF66A3D2;
  EditSelected.Visible := False;
  LayMain.EndUpdate;

  Edits.First.SetFocus;

end;

Function TInputDialog.NewValue: String;
  var NameValue: string;
      Aindi: TInputDialogValue;
begin
  Result := '';
  for Aindi in ValueList do
    begin
      NameValue := Aindi.Name;
      if (Aindi.Necessarily) and (not CheckExisting(NameValue)) then
        begin
          Result := NameValue;
          Exit;
        end;
      if Assigned(Aindi.ChangeText) then Aindi.ChangeText^ := GetValue(NameValue)
        else Aindi.ChangeNumber^ := GetValue(NameValue).ToInteger;
    end;
end;

procedure TInputDialog.SetFocus(AName: String);
  var AEdit: TEdit;
begin
  for AEdit in Edits do
    begin
      if AEdit.Name = AName then
        begin
          AEdit.SetFocus;
          Break;
        end;
    end;
end;

{ TDialog }

procedure TDialog.ButtonOkClick(Sender: TObject);
begin
  Clear;
end;

procedure TDialog.ButtonOnEnter(Sender: TObject);
begin
  ButtonSelected.Position.Point := RectF(LayButton.Position.X + TRoundRect(Sender).Position.X,
                                         LayButton.Position.Y + TRoundRect(Sender).Position.Y,
                                         LayButton.Position.X + TRoundRect(Sender).Position.X + TRoundRect(Sender).Width,
                                         LayButton.Position.Y + TRoundRect(Sender).Position.Y + TRoundRect(Sender).Height).CenterPoint -
                                   PointF(ButtonSelected.Width / 2, ButtonSelected.Height / 2);
  ButtonSelected.Visible := True;
end;

procedure TDialog.ButtonOnLeave(Sender: TObject);
begin
  if Assigned(ButtonSelected) then
    ButtonSelected.Visible := False;
end;

procedure TDialog.Clear;
begin
  RRButtonOk.OnMouseLeave := nil;
  RRButtonOk.OnMouseEnter := nil;
  RRButtonOk.OnClick := nil;
  Owner.RemoveComponent(Self);
  {$IFDEF MSWINDOWS}
  Destroy;
  {$ENDIF}
end;

destructor TDialog.Destroy;
begin
  BackLay.Parent := nil;
  BackLay.OnPaint := nil;
  APath.Free;
  APath := nil;
  inherited;
end;

constructor TDialog.NewDialog(AName: String);
begin
  Create(Application.MainForm);

  BackLay := TPaintBox.Create(Application.MainForm);
  BackLay.Parent := TFmxObject(Application.MainForm);
  BackLay.Align := TAlignLayout.Contents;
  BackLay.HitTest := True;
  BackLay.Opacity := 0;
  BackLay.OnPaint := OnPaintAll;

  Panel := TRectangle.Create(BackLay);
  Panel.Parent := BackLay;
  Panel.Align := TAlignLayout.Center;
  Panel.Corners := CornersPanel;
  Panel.Width := PanelWidth;
  Panel.Height := PanelWidth;
  Panel.XRadius := 25;
  Panel.YRadius := 25;
  Panel.HitTest := False;
  Panel.Fill.Color := ColorDialog;
  Panel.Stroke.Kind := TBrushKind.None;
  Panel.Opacity := 0;

  BackHeader := TRectangle.Create(Panel);
  BackHeader.Parent := Panel;
  BackHeader.Align := TAlignLayout.Top;
  BackHeader.Height := 40;
  BackHeader.HitTest := False;
  BackHeader.Fill.Color := ColorFillHeader;
  BackHeader.Stroke.Kind := TBrushKind.None;
  if (TCorner.TopLeft in CornersPanel) and (TCorner.TopRight in CornersPanel) then
    BackHeader.Corners := [TCorner.TopLeft,TCorner.TopRight]
  else
    if (TCorner.TopLeft in CornersPanel) then BackHeader.Corners := [TCorner.TopLeft]
  else
    if (TCorner.TopRight in CornersPanel) then BackHeader.Corners := [TCorner.TopRight];

  BackHeader.XRadius := Panel.XRadius;
  BackHeader.YRadius := Panel.YRadius;

  Header := TText.Create(BackHeader);
  Header.Parent := BackHeader;
  Header.Align := TAlignLayout.Client;
  Header.Height := 20;
  Header.Text := AName;
  Header.Height := FontSizeHeader*1.2;
  Header.Margins.Top := 10;
  Header.Font.Size := FontSizeHeader;
  Header.Font.Family := FontDialog;
  Header.HitTest := False;

  if Length(Header.Text) = 0 then BackHeader.Visible := False
    else BackHeader.Visible := True;

  LayMain := TScrollBox.Create(Panel);
  LayMain.Parent := Panel;
  LayMain.Align := TAlignLayout.Client;
  LayMain.Margins.Left := 10;
  LayMain.Margins.Right := 10;
  LayMain.Margins.Top := 5;
  LayMain.HitTest := False;

  LayButton := TLayout.Create(Panel);
  LayButton.Parent := Panel;
  LayButton.Align := TAlignLayout.Bottom;
  LayButton.Height := 35;
  LayButton.Margins.Left := 20;
  LayButton.Margins.Right := 20;
  LayButton.Margins.Bottom := 10;
  LayButton.Margins.Top := 10;
  LayButton.HitTest := False;

  RRButtonOk := TRoundRect.Create(LayButton);
  RRButtonOk.Parent := LayButton;
  RRButtonOk.OnClick := ButtonOkClick;
  {$IFDEF MSWINDOWS}
  RRButtonOk.OnMouseEnter := ButtonOnEnter;
  RRButtonOk.OnMouseLeave := ButtonOnLeave;
  {$ENDIF}
  RRButtonOk.Align := TAlignLayout.Left;
  RRButtonOk.Width := 100 + (FontSizeButton - 14) * 5;
  RRButtonOk.Fill.Color := ColorButton;
  //RRButtonOk.Stroke.Thickness := 1;
  RRButtonOk.Stroke.Kind := TBrushKind.None;
  RRButtonOk.HitTest := True;

  IconButtonOk := TText.Create(RRButtonOk);
  FontAwesomeAssign(IconButtonOk);
  IconButtonOk.Parent := RRButtonOk;
  IconButtonOk.Align := TAlignLayout.Left;
  IconButtonOk.HitTest := False;
  IconButtonOk.Text := fa_check;
  IconButtonOk.Font.Size := FontSizeButton;
  IconButtonOk.Width := 15;
  IconButtonOk.Margins.Left := 20;
  IconButtonOk.TextSettings.FontColor := $FF138900;

  TextButtonOk := TText.Create(RRButtonOk);
  TextButtonOk.Parent := RRButtonOk;
  TextButtonOk.Align := TAlignLayout.Client;
  TextButtonOk.HitTest := False;
  TextButtonOk.Text := 'Ок';
  TextButtonOk.TextSettings.HorzAlign := TTextAlign.Leading;
  TextButtonOk.Font.Size := FontSizeButton;
  TextButtonOk.Margins.Left := 3;
  TextButtonOk.Font.Family := FontDialog;

 {$IFDEF MSWINDOWS}
  ButtonSelected := TRoundRect.Create(Panel);
  ButtonSelected.Parent := Panel;
  ButtonSelected.Width := RRButtonOk.Width / 1.2;
  ButtonSelected.Fill.Color := $FF66A3D2;
  ButtonSelected.Opacity := 0.4;
  ButtonSelected.Height := LayButton.Height / 1.3;
  ButtonSelected.Visible := False;
  ButtonSelected.Stroke.Kind := TBrushKind.None;
  ButtonSelected.HitTest := False;
  {$ENDIF}

  APath := TPathData.Create;
  APath.Clear;
  APath.MoveTo(PointF(0,0));
  APath.LineTo(PointF(TForm(Owner).Width,0));
  APath.LineTo(PointF(TForm(Owner).Width,TForm(Owner).Height));
  APath.LineTo(PointF(0,TForm(Owner).Height));
  APath.LineTo(PointF(0,0));

  TAnimator.AnimateFloat(BackLay,'Opacity',1,0.3,TAnimationType.&In,TInterpolationType.Linear);
  TAnimator.AnimateFloat(Panel,'Opacity',1,0.3,TAnimationType.&In,TInterpolationType.Linear);
  Panel.BringToFront;
end;

procedure TDialog.OnPaintAll(Sender: TObject; Canvas: TCanvas);
begin
  if not (Assigned(APath)) then Exit;

  TPaintBox(Sender).Canvas.Fill.Kind := TBrushKind.Solid;
  TPaintBox(Sender).Canvas.Fill.Color := TAlphaColors.Black;
  TPaintBox(Sender).Canvas.BeginScene();
  TPaintBox(Sender).Canvas.FillPath(APath,0.4);
  TPaintBox(Sender).Canvas.EndScene;
end;

{ TShowMessageDialog }

procedure TShowMessageDialog.AddMessage(Header, Text: String; Bitmap: TBitmap;
  Critical: Boolean);
  var AMessage: TMessage;
begin

  AMessage := TMessage.Create;
  AMessage.Header := Header;
  AMessage.Text := Text;
  if not (Bitmap = nil) then
    begin
      AMessage.Bitmap := TBitmap.Create;
      AMessage.Bitmap.Assign(Bitmap);
    end;
  AMessage.Critical := Critical;
  Messeges.Add(AMessage);

end;

procedure TShowMessageDialog.ButtonOkClick(Sender: TObject);

begin
  if Messeges.First.Critical then Application.Terminate;

  Messeges.Delete(0);

  TAnimator.AnimateFloat(Panel,'opacity',0.5,0.3,TAnimationType.&In,TInterpolationType.Linear);

  if Messeges.Count > 0 then Show
    else Clear;
end;

procedure TShowMessageDialog.Clear;
begin
  RRButtonOk.OnMouseLeave := nil;
  RRButtonOk.OnMouseEnter := nil;
  RRButtonOk.OnClick := nil;
  Owner.RemoveComponent(Self);
  MsgDialog.Free;
end;

destructor TShowMessageDialog.Destroy;
begin
  Messeges.Free;
  Messeges := nil;
  MsgDialog := nil;
  inherited;
end;

Constructor TShowMessageDialog.NewDialog(AName: String);
begin
  inherited;

  Image := TCircle.Create(LayMain);
  Image.Parent := LayMain;
  Image.Align := TAlignLayout.Top;
  Image.Height := 50;
  Image.Stroke.Thickness := 0;
  Image.Fill.Kind := TBrushKind.Bitmap;
  Image.Fill.Bitmap.WrapMode := TWrapMode.TileStretch;

  Detail := TText.Create(LayMain);
  Detail.Parent := LayMain;
  Detail.Align := TAlignLayout.Top;
  Detail.Font.Size := FontSizeDetail;
  Detail.Font.Family := FontDialog;
  Detail.VertTextAlign := TTextAlign.Leading;

  Messeges := TObjectList<TMessage>.Create;

end;

Procedure TShowMessageDialog.Show;
  var NewText: String;
begin

  NewText := Messeges.First.Text;

  Detail.Height := GetHeightText(NewText,Detail.Font.Size,LayMain.Width);
  Detail.Text := NewText;

  Header.Text := Messeges.First.Header;

  if Length(Header.Text) = 0 then BackHeader.Visible := False
    else BackHeader.Visible := True;

  if Messeges.First.Bitmap = nil then Image.Visible := False
    else
      begin
        Image.Visible := True;
        Image.Fill.Bitmap.Bitmap.Assign(Messeges.First.Bitmap);
      end;

  if BackHeader.Visible then Panel.Height := BackHeader.Height
    else Panel.Height := 0;

  if Image.Visible then Panel.Height := Panel.Height + Image.Height
    else Panel.Height := Panel.Height;

  Panel.Height := Panel.Height + LayMain.Margins.Top + Detail.Height
                  + LayButton.Height + LayButton.Margins.Top + LayButton.Margins.Bottom
                  + 10;
  if Panel.Height > PanelHeight then Panel.Height := PanelHeight;

   TAnimator.AnimateFloat(Panel,'opacity',1,0.3,TAnimationType.&In,TInterpolationType.Linear);

end;

{ TQuestionDialog }

procedure TQuestionDialog.ButtonNoClick(Sender: TObject);
begin
  Clear;
end;

procedure TQuestionDialog.ButtonOkClick(Sender: TObject);
begin
  if Assigned(OkEvent) then OkEvent(Panel.Parent);
  inherited;
end;

procedure TQuestionDialog.Clear;
begin
  RRButtonNo.OnMouseLeave := nil;
  RRButtonNo.OnMouseEnter := nil;
  RRButtonNo.OnClick := nil;
  inherited;
end;

destructor TQuestionDialog.Destroy;
begin

  inherited;
end;

constructor TQuestionDialog.NewDialog(AName: String);
begin
  inherited;

  RRButtonNo := TRoundRect.Create(LayButton);
  RRButtonNo.Parent := LayButton;
  RRButtonNo.OnClick := ButtonNoClick;
  {$IFDEF MSWINDOWS}
  RRButtonNo.OnMouseEnter := ButtonOnEnter;
  RRButtonNo.OnMouseLeave := ButtonOnLeave;
  {$ENDIF}
  RRButtonNo.Align := TAlignLayout.Right;
  RRButtonNo.Width := 100 + (FontSizeButton - 14) * 5;
  RRButtonNo.Fill.Color := ColorButton;
  RRButtonNo.Stroke.Kind := TBrushKind.None;

  IconButtonNo := TText.Create(RRButtonNo);
  FontAwesomeAssign(IconButtonNo);
  IconButtonNo.Parent := RRButtonNo;
  IconButtonNo.Align := TAlignLayout.Left;
  IconButtonNo.HitTest := False;
  IconButtonNo.Text := fa_thumbs_down;
  IconButtonNo.Font.Size := FontSizeButton;
  IconButtonNo.Width := 15;
  IconButtonNo.Margins.Left := 20;
  IconButtonNo.TextSettings.FontColor := $FFA61300;

  TextButtonNo := TText.Create(RRButtonNo);
  TextButtonNo.Parent := RRButtonNo;
  TextButtonNo.Align := TAlignLayout.Client;
  TextButtonNo.HitTest := False;
  TextButtonNo.Text := 'Нет';
  TextButtonNo.TextSettings.HorzAlign := TTextAlign.Leading;
  TextButtonNo.Font.Size := FontSizeButton;
  TextButtonNo.Margins.Left := 3;
  TextButtonNo.Font.Family := FontDialog;

  TextButtonOk.Text := 'Да';

  TextIcon := TText.Create(LayMain);
  TextIcon.Parent := LayMain;
  TextIcon.Align := TAlignLayout.None;
  TextIcon.Text := fa_question_circle;
  FontAwesomeAssign(TextIcon);
  TextIcon.Font.Size := 30;
  TextIcon.Height := 30;
  TextIcon.Position.Y := 0;
  TextIcon.Position.X := 0;
  TextIcon.Width := LayMain.Width;
  TextIcon.TextSettings.HorzAlign := TTextAlign.Trailing;

  Detail := TText.Create(LayMain);
  Detail.Parent := LayMain;
  Detail.Align := TAlignLayout.Top;
  Detail.Font.Size := FontSizeDetail;
  Detail.Font.Family := FontDialog;

end;

constructor TQuestionDialog.NewQuestDialog(AHeader,
  AText: String; OnOkEvent: TNotifyEvent);
  var NewText: String;
begin
  NewDialog(AHeader);

  NewText := AText;

  Detail.Height := GetHeightText(NewText,Detail.Font.Size,LayMain.Width);
  Detail.Text := NewText;

  if Length(Header.Text) = 0 then BackHeader.Visible := False
    else BackHeader.Visible := True;

  if BackHeader.Visible then Panel.Height := BackHeader.Height
    else Panel.Height := 0;

  Panel.Height := Panel.Height + LayMain.Margins.Top + Detail.Height
                  + LayButton.Height + LayButton.Margins.Top + LayButton.Margins.Bottom
                  + 10;
  if Panel.Height > PanelHeight then Panel.Height := PanelHeight;

  OkEvent := OnOkEvent;

end;

{ TFlashDialog }

procedure TFlashDialog.AddFlashMessage(AHeader, AText: String; AX, AY, AWidth,
  AHeight: Single);
  var AFlashMessage: TFlashMessege;
begin

  AFlashMessage := TFlashMessege.Create;
  AFlashMessage.Header := AHeader;
  AFlashMessage.Text := AText;
  AFlashMessage.X := AX;
  AFlashMessage.Y := AY;
  AFlashMessage.Width := AWidth;
  AFlashMessage.Height := AHeight;
  FlashMessages.Add(AFlashMessage);

end;

procedure TFlashDialog.ButtonOkClick(Sender: TObject);
begin
  FlashMessages.Delete(0);

  TAnimator.AnimateFloat(Panel,'opacity',0.5,0.3,TAnimationType.&In,TInterpolationType.Linear);

  if FlashMessages.Count > 0 then Show
  else Clear;
end;

procedure TFlashDialog.Clear;
begin
  RRButtonOk.OnMouseLeave := nil;
  RRButtonOk.OnMouseEnter := nil;
  RRButtonOk.OnClick := nil;
  Owner.RemoveComponent(Self);
  FlhDialog.Free;
end;

destructor TFlashDialog.Destroy;
begin
  FlashMessages.Free;
  FlashMessages := nil;
  FlhDialog := nil;
  inherited;
end;

constructor TFlashDialog.NewDialog(AName: String);
begin
  inherited;

  Detail := TText.Create(LayMain);
  Detail.Parent := LayMain;
  Detail.Align := TAlignLayout.Top;
  Detail.Font.Size := FontSizeDetail;
  Detail.Font.Family := FontDialog;

  FlashMessages := TObjectList<TFlashMessege>.Create();

end;

procedure TFlashDialog.Show;
  var NewText: String;
begin

  NewText := FlashMessages.First.Text;

  Detail.Height := GetHeightText(NewText,Detail.Font.Size,LayMain.Width);
  Detail.Text := NewText;

  if Length(Header.Text) = 0 then BackHeader.Visible := False
    else BackHeader.Visible := True;

  if BackHeader.Visible then Panel.Height := BackHeader.Height
    else Panel.Height := 0;


  Panel.Height := Panel.Height + LayMain.Margins.Top + Detail.Height
                  + LayButton.Height + LayButton.Margins.Top + LayButton.Margins.Bottom
                  + 10;
  if Panel.Height > PanelHeight then Panel.Height := PanelHeight;

  APath.Clear;
  APath.MoveTo(PointF(0,0));
  APath.LineTo(PointF(TForm(Owner).Width,0));
  APath.LineTo(PointF(TForm(Owner).Width,TForm(Owner).Height));
  APath.LineTo(PointF(0,TForm(Owner).Height));
  APath.LineTo(PointF(0,0));
  APath.MoveTo(PointF(FlashMessages.First.X,FlashMessages.First.Y + FlashMessages.First.Height / 2));
  APath.CurveTo(PointF(FlashMessages.First.X,FlashMessages.First.Y + FlashMessages.First.Height / 2),PointF(FlashMessages.First.X,FlashMessages.First.Y),PointF(FlashMessages.First.X + FlashMessages.First.Width / 2, FlashMessages.First.Y));
  APath.CurveTo(PointF(FlashMessages.First.X + FlashMessages.First.Width / 2, FlashMessages.First.Y),PointF(FlashMessages.First.X + FlashMessages.First.Width,FlashMessages.First.Y),PointF(FlashMessages.First.X + FlashMessages.First.Width, FlashMessages.First.Y + FlashMessages.First.Height / 2));
  APath.CurveTo(PointF(FlashMessages.First.X + FlashMessages.First.Width, FlashMessages.First.Y + FlashMessages.First.Height / 2),PointF(FlashMessages.First.X + FlashMessages.First.Width,FlashMessages.First.Y + FlashMessages.First.Height),PointF(FlashMessages.First.X + FlashMessages.First.Width / 2, FlashMessages.First.Y + FlashMessages.First.Height));
  APath.CurveTo(PointF(FlashMessages.First.X + FlashMessages.First.Width / 2, FlashMessages.First.Y + FlashMessages.First.Height),PointF(FlashMessages.First.X,FlashMessages.First.Y + FlashMessages.First.Height),PointF(FlashMessages.First.X, FlashMessages.First.Y + FlashMessages.First.Height / 2));

  Panel.Align := TAlignLayout.None;

  //Размещение
  if FlashMessages.First.X < TForm(Owner).Width / 2
    then
      begin
        if FlashMessages.First.X + FlashMessages.First.Width / 2 + Panel.Width > TForm(Owner).Width
          then
            begin
              Panel.Position.X := TForm(Owner).Width - Panel.Width - 20;
            end
          else Panel.Position.X := FlashMessages.First.X + FlashMessages.First.Width / 2;
      end
    else Panel.Position.X := FlashMessages.First.X - Panel.Width / 2;

  if FlashMessages.First.Y < TForm(Owner).Height / 2
    then Panel.Position.Y := FlashMessages.First.Y + FlashMessages.First.Height + 20
    else Panel.Position.Y := FlashMessages.First.Y - Panel.Height - 20;
  //

  TAnimator.AnimateFloat(Panel,'opacity',1,0.3,TAnimationType.&In,TInterpolationType.Linear);
  BackLay.Repaint;

end;

{ TMessage }

destructor TMessage.Destroy;
begin
  if Assigned(Bitmap) then Bitmap.Free;
  Bitmap := nil;
  inherited;
end;

end.
