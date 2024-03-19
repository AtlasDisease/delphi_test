program Starter;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Forms,
  uMainForm in 'uMainForm.pas' {Form1},
  Mod1 in '..\..\teneod4\Mod1.pas' {dmMod1: TDataModule},
  TapeOutTbls in '..\..\teneod4\TapeOutTbls.pas' {frmTapeOutTbls};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TdmMod1, dmMod1);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
