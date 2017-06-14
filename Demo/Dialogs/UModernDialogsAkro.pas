unit UModernDialogsAkro;  //Versions 1.0.0 14.06.17

//By AkroMD
{
Перед использованием убедитесь, что вам действительно это нужно, а то мало ли....
Обязательна установка шрифта FontAwesome: под Windows копируем в шрифты,
под Android в Deployment заливаем в .\assets\internal
}
//



interface

  uses System.Classes, FMX.Graphics, System.UITypes, FMX.Controls, FMX.Types,
        UAkroDialogs;

  type
  //Для добавления данных в диалог ввода
  TInputDialogValueList = class(UAkroDialogs.TInputDialogValueList)
  end;

  //Тип вводимых символов
  TTypeInputSymbols = UAkroDialogs.TTypeInputSymbols;

  TModernDialogs = class abstract
  private
    //Диалог простого сообщения
    Procedure MesgDialog(AHeader, AText: String; ABitmap: TBitmap; ACritical: Boolean);
    //Диалог сообщения с вводом
    Procedure InpDialog(AValueList: TInputDialogValueList);
    //Диалог с вопросом
    Procedure QstDialog(AHeader, AText: String; OnOkEvent: TNotifyEvent);
    //Диалог с подсветкой
    Procedure FlshDialog(AHeader, AText: String; AX, AY, AWidth, AHeight: Single);
  public
    Constructor ShowMessage(AHeader, AText: String; ABitmap: TBitmap; ACritical: Boolean); overload;
    Constructor ShowMessage(AText: String); overload;
    Constructor ShowMessage(AText: String; ABitmap: TBitmap); overload;
    Constructor ShowMessage(AHeader, AText: String; ABitmap: TBitmap); overload;
    Constructor ShowMessage(AHeader, AText: String); overload;
    Constructor NewInputDialog(AValueList: TInputDialogValueList);
    Constructor QuestDialog(AHeader, AText: String; OnOkEvent: TNotifyEvent); overload;
    Constructor QuestDialog(AText: String; OnOkEvent: TNotifyEvent); overload;
    Constructor FlashDialog(AHeader, AText: String; SelectedObject: TControl); overload;
    Constructor FlashDialog(AText: String; AX,AY: Single); overload;
    Constructor FlashDialog(AHeader, AText: String; AX, AY, AWidth, AHeight: Single); overload;
  end;

    Procedure SetColorDialogs(AColor: TAlphaColor);
    Procedure SetColorButtonDialogs(AColor: TAlphaColor);
    Procedure SetColorFillHeaderDialogs(AColor: TAlphaColor);
    Procedure SetFontFamilyDialog(AFontFamily: TFontName);
    Procedure SetFontSizeHeaderDialog(AFontSize: Integer);
    Procedure SetFontSizeDetailDialog(AFontSize: Integer);
    Procedure SetFontSizeButtonDialog(AFontSize: Integer);
    Procedure SetPanelCornersDialog(ACorners: TCorners);
    Procedure SetPanelWidthDialog(AWidth: Integer);
    Procedure SetPanelHeightDialog(AHeight: Integer);

implementation

{ TModernDialogs }

Constructor TModernDialogs.FlashDialog(AHeader, AText: String;
  SelectedObject: TControl);
  var PosX,PosY: Single;
      AWidth,AHeight: Single;
begin

  AWidth := SelectedObject.Width;
  AHeight := SelectedObject.Height;

  PosX := GetAbsPosition(SelectedObject).X;
  PosY := GetAbsPosition(SelectedObject).Y;

  FlshDialog(AHeader,AText,PosX,PosY,AWidth,AHeight);
end;

Constructor TModernDialogs.FlashDialog(AText: String; AX, AY: Single);
begin
  FlshDialog('',AText,AX,AY,100,100);
end;

constructor TModernDialogs.FlashDialog(AHeader, AText: String; AX, AY, AWidth,
  AHeight: Single);
begin
  FlshDialog('',AText,AX,AY,AWidth,AHeight);
end;

procedure TModernDialogs.FlshDialog(AHeader, AText: String;
  AX, AY, AWidth, AHeight: Single);
begin
  if not Assigned(FlhDialog) then
    FlhDialog := TFlashDialog.NewDialog(AHeader);
  FlhDialog.AddFlashMessage(AHeader,AText,AX,AY,AWidth,AHeight);
  FlhDialog.Show;
  Free;
end;

procedure TModernDialogs.InpDialog(AValueList: TInputDialogValueList);
begin
  TInputDialog.NewInputDialog(UAkroDialogs.TInputDialogValueList(AValueList));
  Free;
end;

procedure TModernDialogs.MesgDialog(AHeader, AText: String;
  ABitmap: TBitmap; ACritical: Boolean);
begin
  if not Assigned(MsgDialog) then
    MsgDialog := TShowMessageDialog.NewDialog(AHeader);
  MsgDialog.AddMessage(AHeader,AText,ABitmap,ACritical);
  MsgDialog.show;
  Free;
end;

Constructor TModernDialogs.NewInputDialog(AValueList: TInputDialogValueList);
begin
  InpDialog(AValueList);
end;

procedure TModernDialogs.QstDialog(AHeader, AText: String;
  OnOkEvent: TNotifyEvent);
begin
  TQuestionDialog.NewQuestDialog(AHeader,AText,OnOkEvent);
  Free;
end;

Constructor TModernDialogs.QuestDialog(AText: String; OnOkEvent: TNotifyEvent);
begin
  QstDialog('',AText,OnOkEvent);
end;

Constructor TModernDialogs.QuestDialog(AHeader, AText: String;
  OnOkEvent: TNotifyEvent);
begin
  QstDialog(AHeader,AText,OnOkEvent);
end;

procedure SetColorButtonDialogs(AColor: TAlphaColor);
begin
  ColorButton := AColor;
end;

procedure SetColorDialogs(AColor: TAlphaColor);
begin
  ColorDialog := AColor;
end;

Procedure SetColorFillHeaderDialogs(AColor: TAlphaColor);
begin
  ColorFillHeader := AColor;
end;

procedure SetFontFamilyDialog(AFontFamily: TFontName);
begin
  FontDialog := AFontFamily;
end;

Procedure SetFontSizeHeaderDialog(AFontSize: Integer);
begin
  FontSizeHeader := AFontSize;
end;

Procedure SetFontSizeDetailDialog(AFontSize: Integer);
begin
  FontSizeDetail := AFontSize;
end;

Procedure SetFontSizeButtonDialog(AFontSize: Integer);
begin
  FontSizeButton := AFontSize;
end;

Procedure SetPanelCornersDialog(ACorners: TCorners);
begin
  CornersPanel := ACorners;
end;

Procedure SetPanelWidthDialog(AWidth: Integer);
begin
  PanelWidth := AWidth;
end;

Procedure SetPanelHeightDialog(AHeight: Integer);
begin
  PanelHeight := AHeight;
end;



Constructor TModernDialogs.ShowMessage(AHeader, AText: String);
begin
  MesgDialog(AHeader,AText,nil,False);
end;

constructor TModernDialogs.ShowMessage(AText: String; ABitmap: TBitmap);
begin
  MesgDialog('',AText,ABitmap,False);
end;

constructor TModernDialogs.ShowMessage(AHeader, AText: String;
  ABitmap: TBitmap);
begin
  MesgDialog(AHeader,AText,ABitmap,False);
end;

Constructor TModernDialogs.ShowMessage(AText: String);
begin
  MesgDialog('',AText,nil,False);
end;

Constructor TModernDialogs.ShowMessage(AHeader, AText: String; ABitmap: TBitmap;
  ACritical: Boolean);
begin
  MesgDialog(AHeader,AText,ABitmap,ACritical);
end;

end.
