unit UDemoDialogs;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ScrollBox, FMX.Memo,
  FMX.EditBox, FMX.SpinBox, FMX.Layouts, FMX.Objects, FMX.Edit, FMX.Controls.Presentation,
  FMX.StdCtrls,FMX.VirtualKeyboard, FMX.ListBox, FMX.Colors;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    PanelShowMessage: TPanel;
    ButSM1: TButton;
    ButSM2: TButton;
    ButSM5: TButton;
    ButSM4: TButton;
    ButSM3: TButton;
    PanelSetting: TPanel;
    ColorPanel1: TColorPanel;
    ButSetColorDialog: TButton;
    ButSetColorButton: TButton;
    ButSetColorHeader: TButton;
    Text1: TText;
    SpinBFontSizeDetail: TSpinBox;
    SpinBFontSizeHeader: TSpinBox;
    Text2: TText;
    SpinBFontSizeButton: TSpinBox;
    Text5: TText;
    ComboBox1: TComboBox;
    Text6: TText;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    RectColorDialog: TRectangle;
    RectColorButton: TRectangle;
    RectColorHeader: TRectangle;
    Button5: TButton;
    PanelFlashMessag: TPanel;
    ButFlashDial1: TButton;
    ButFlashDial3: TButton;
    ButFlashDial2: TButton;
    Button7: TButton;
    PanelInputDialog: TPanel;
    Button8: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    MemoInputDialog: TMemo;
    Text7: TText;
    SpiinBInputEdit: TSpinBox;
    PanelQuestDialog: TPanel;
    Button14: TButton;
    MemoQuestDialog: TMemo;
    Button15: TButton;
    Button16: TButton;
    Button6: TButton;
    Button9: TButton;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButSetColorDialogClick(Sender: TObject);
    procedure ButSetColorHeaderClick(Sender: TObject);
    procedure ButSetColorButtonClick(Sender: TObject);
    procedure SpinBFontSizeDetailChange(Sender: TObject);
    procedure SpinBFontSizeHeaderChange(Sender: TObject);
    procedure SpinBFontSizeButtonChange(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure ButFlashDial1Click(Sender: TObject);
    procedure ButFlashDial2Click(Sender: TObject);
    procedure ButFlashDial3Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure ButSM1Click(Sender: TObject);
    procedure ButSM2Click(Sender: TObject);
    procedure ButSM3Click(Sender: TObject);
    procedure ButSM4Click(Sender: TObject);
    procedure ButSM5Click(Sender: TObject);
  private
    { Private declarations }
    Procedure ShowAnswerQuestion(Sender: TObject);
    Procedure ShowAnswerInput(Sender: TObject);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  InputMes: array of string;
  InputMesNum: array of integer;

implementation

{$R *.fmx}

uses UModernDialogsAkro;

{ TForm1 }

procedure TForm1.ButFlashDial1Click(Sender: TObject);
begin
  TModernDialogs.FlashDialog('Подсветка','Эта кнопка очень важна',ButFlashDial1);
end;

procedure TForm1.ButFlashDial2Click(Sender: TObject);
begin
  TModernDialogs.FlashDialog('Некоторая область на экране',100, 200);
end;

procedure TForm1.ButFlashDial3Click(Sender: TObject);
begin
  TModernDialogs.FlashDialog('Подсветка','Первый пошел',ButFlashDial1);
  TModernDialogs.FlashDialog('Подсветка','Второй следом',ButFlashDial2);
  TModernDialogs.FlashDialog('Подсветка','Третий отстает',ButFlashDial3);
end;

procedure TForm1.ButSetColorButtonClick(Sender: TObject);
begin
  RectColorButton.Fill.Color := ColorPanel1.Color;
  SetColorButtonDialogs(RectColorButton.Fill.Color);
end;

procedure TForm1.ButSetColorDialogClick(Sender: TObject);
begin
  RectColorDialog.Fill.Color := ColorPanel1.Color;
  SetColorDialogs(RectColorDialog.Fill.Color);
end;

procedure TForm1.ButSetColorHeaderClick(Sender: TObject);
begin
  RectColorHeader.Fill.Color := ColorPanel1.Color;
  SetColorFillHeaderDialogs(RectColorHeader.Fill.Color);
end;

procedure TForm1.ButSM1Click(Sender: TObject);
begin
  TModernDialogs.ShowMessage('Заголовок','Обычный житейский текст');
end;

procedure TForm1.ButSM2Click(Sender: TObject);
begin
  TModernDialogs.ShowMessage('Обычный житейский текст без заголовка');
end;

procedure TForm1.ButSM3Click(Sender: TObject);
  var Text: String;
begin
  Text := 'Обычный житейский текст который расстянули на миллионы лет вперед дабы отсрочить кончину Delphi! Не дадим узурпаторам заменить наши правила, не дадим им сломать волю нашу! Вообщем длинный текст получился';
  TModernDialogs.ShowMessage('Заголовок',Text);
end;

procedure TForm1.ButSM4Click(Sender: TObject);
begin
  TModernDialogs.ShowMessage('Заголовок','Здесь может быть ваша реклама',Image1.Bitmap);
end;

procedure TForm1.ButSM5Click(Sender: TObject);
begin
  TModernDialogs.ShowMessage('Короче','Не нажимай',nil,True);
end;

procedure TForm1.Button11Click(Sender: TObject);
  var i: Integer;
      IDL: TInputDialogValueList;
begin
  IDL := TInputDialogValueList.NewList('Введите:',ShowAnswerInput);
  SetLength(InputMes,Round(SpiinBInputEdit.Value));
  SetLength(InputMesNum,0);

  for I := 0 to Round(SpiinBInputEdit.Value)-1 do
    begin
      InputMes[i] := '';
      IDL.AddNew('Edit' + I.ToString,'Текст №' + I.ToString,'',InputMes[i],TTypeInputSymbols.LettersAndNumbers,0,True);
    end;

  TModernDialogs.NewInputDialog(IDL);

end;

procedure TForm1.Button12Click(Sender: TObject);
  var i: Integer;
      IDL: TInputDialogValueList;
begin
  IDL := TInputDialogValueList.NewList('Введите:',ShowAnswerInput);
  SetLength(InputMes,Round(SpiinBInputEdit.Value));
  SetLength(InputMesNum,0);

  for I := 0 to Round(SpiinBInputEdit.Value)-1 do
    begin
      InputMes[i] := '';
      IDL.AddNew('Edit' + I.ToString,'Текст №' + I.ToString,'',InputMes[i],TTypeInputSymbols.LettersAndNumbers,5);
    end;

  TModernDialogs.NewInputDialog(IDL);

end;

procedure TForm1.Button13Click(Sender: TObject);
begin
  PanelInputDialog.Visible := False;
end;

procedure TForm1.Button14Click(Sender: TObject);
begin
  PanelQuestDialog.Visible := False;
end;

procedure TForm1.Button15Click(Sender: TObject);
begin
  TModernDialogs.QuestDialog('Вопрос','Есть ли жизнь после Delphi?',ShowAnswerQuestion);
end;

procedure TForm1.Button16Click(Sender: TObject);
begin
  PanelSetting.Visible := True;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  PanelShowMessage.Visible := True;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  PanelFlashMessag.Visible := True;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  PanelQuestDialog.Visible := True;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  PanelInputDialog.Visible := True;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  PanelSetting.Visible := False;
end;

procedure TForm1.Button6Click(Sender: TObject);
  var i: Integer;
      IDL: TInputDialogValueList;
begin
  IDL := TInputDialogValueList.NewList('Введите:',ShowAnswerInput);
  SetLength(InputMes,0);
  SetLength(InputMesNum,Round(SpiinBInputEdit.Value));

  for I := 0 to Round(SpiinBInputEdit.Value) - 1 do
    begin
      InputMesNum[i] := 0;
      IDL.AddNew('Edit' + I.ToString,'Текст №' + I.ToString,InputMesNum[i].ToString,InputMesNum[i]);
    end;

  TModernDialogs.NewInputDialog(IDL);

end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  PanelFlashMessag.Visible := False;
end;

procedure TForm1.Button8Click(Sender: TObject);
  var i: Integer;
      IDL: TInputDialogValueList;
begin
  IDL := TInputDialogValueList.NewList('Введите:',ShowAnswerInput);
  SetLength(InputMes,Round(SpiinBInputEdit.Value));
    SetLength(InputMesNum,0);

  for I := 0 to Round(SpiinBInputEdit.Value) - 1 do
    begin
      InputMes[i] := '';
      IDL.AddNew('Edit' + I.ToString,'Текст №' + I.ToString,'',InputMes[i],TTypeInputSymbols.Letters,0);
    end;

  TModernDialogs.NewInputDialog(IDL);

end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  PanelShowMessage.Visible := False;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  if ComboBox1.ItemIndex > 0 then
    SetFontFamilyDialog(ComboBox1.Selected.Text);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
end;

procedure TForm1.ShowAnswerInput(Sender: TObject);
  var i: Integer;
begin
  MemoInputDialog.Lines.Clear;
  for I := Low(InputMes) to High(InputMes) do
    MemoInputDialog.Lines.Add(I.ToString + ' ответ: ' + InputMes[i]);
  for I := Low(InputMesNum) to High(InputMesNum) do
    MemoInputDialog.Lines.Add(I.ToString + ' ответ: ' + InputMesNum[i].ToString);
end;

procedure TForm1.ShowAnswerQuestion(Sender: TObject);
begin
  MemoQuestDialog.Lines.Clear;
  MemoQuestDialog.Lines.Add('Ответ на ваш вопрос...да кто его знает?');
end;

procedure TForm1.SpinBFontSizeButtonChange(Sender: TObject);
begin
  SetFontSizeButtonDialog(Round(SpinBFontSizeButton.Value));
end;

procedure TForm1.SpinBFontSizeDetailChange(Sender: TObject);
begin
  SetFontSizeDetailDialog(Round(SpinBFontSizeDetail.Value));
end;

procedure TForm1.SpinBFontSizeHeaderChange(Sender: TObject);
begin
  SetFontSizeHeaderDialog(Round(SpinBFontSizeHeader.Value));
end;

end.
