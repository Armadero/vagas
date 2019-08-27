program ServerLog;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  ServerView in 'View\ServerView.pas' {Form1},
  WebModel in 'Model\WebModel.pas' {wmdWebModule: TWebModule},
  LogControl in 'Control\LogControl.pas',
  DAO in 'DAO\DAO.pas' {dmDAO: TDataModule},
  LogDAO in 'DAO\LogDAO.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TdmDAO, dmDAO);
  Application.Run;
end.
