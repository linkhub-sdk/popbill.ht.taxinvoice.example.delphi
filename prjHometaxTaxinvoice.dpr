program prjHometaxTaxinvoice;

uses
  Forms,
  PopbillHTTaxinvoice in 'PopbillHTTaxinvoice\PopbillHTTaxinvoice.pas',
  Linkhub in 'Linkhub\Linkhub.pas',
  Popbill in 'Popbill\Popbill.pas',
  Example in 'Example.pas' {TfrmExample};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TTfrmExample, TfrmExample);
  Application.Run;
end.
