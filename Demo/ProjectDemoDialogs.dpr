program ProjectDemoDialogs;

uses
  System.StartUpCopy,
  FMX.Forms,
  UDemoDialogs in 'UDemoDialogs.pas' {Form1},
  FMX.FontGlyphs.Android in 'Dialogs\FMX.FontGlyphs.Android.pas',
  FMX.FontGlyphs in 'Dialogs\FMX.FontGlyphs.pas',
  UAkroDialogs in 'Dialogs\UAkroDialogs.pas',
  UModernDialogsAkro in 'Dialogs\UModernDialogsAkro.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
