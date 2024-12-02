program Resource78213;
uses
  Forms, Interfaces, MainForm;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Title:='Resource76213 - NEC uPD78213 Disassembler';
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

