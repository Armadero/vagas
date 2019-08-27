{
  > Autor: Bruno Alves Guerreiro

  > Aplicativo Client.exe

  > Essa aplicação, de forma simples, realiza o cadastro de produtos e cada
  alteração cadastro é registrado o log do evento. Requisição realizada por
  REST Full.

  > Essa aplicação Client não está utilizando modelos, orientação a objetos e
  módularizada dos recuros em pacotes bpl/dll.

  > Entendi pela solicitação que o foco seria o módulo Servidor.
  Sendo assim, não vi a necessidade de criar modelos para menu principal, modelos
  para telas de consultas e de cadastros.

  > Normalmente utilizamos modelos ou componentes para padronizar e facilitar a
  criação de novos cadastros, consultas, relatórios, assistentes e telas de
  processamentos.

  > Não foi utilizado componente de terceiros para que possa realizar a
  compilação sem a necessidade de instalação de pacotes de componentes. Normalmente
  utilizo DevExpress para deixar a aplicação mais rica em recursos e facilidade de
  manutenção e criação.

  ** Importante: Não foi possível conseguir o tempo de 10ms por requisição. Isso por
  o servidor ser em Win32 GUI. A Embarcadero recomenda que o servidor criado em
  Delphi seja criado em Apache/Linux. Assim a aplicação servidora terá uma
  velocidade muito melhor. Possívelmente atendendo a solicitação de 10ms por
  requisição.

}

unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.ToolWin, Vcl.Menus, Vcl.ButtonGroup,
  Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinsDefaultPainters, cxTextEdit, cxMaskEdit, cxSpinEdit, Vcl.Samples.Spin,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Stan.StorageJSON,
  FireDAC.Stan.StorageBin, REST.Response.Adapter, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, REST.Types, Data.Bind.DBScope,System.JSON,StrUtils,
  dxGDIPlusClasses;

type
  TOperacao = (opBrowser,opAdd, opEdit, opDel);

  TfrmMain = class(TForm)
    tlbMenu: TToolBar;
    btnProdutos: TToolButton;
    btnSep: TToolButton;
    btnLog: TToolButton;
    shpSep: TShape;
    pgcTelas: TPageControl;
    sbStatus: TStatusBar;
    tsProdutos: TTabSheet;
    tsHome: TTabSheet;
    tsLog: TTabSheet;
    ilIcones32: TImageList;
    ilIcones16: TImageList;
    btnSimulador: TToolButton;
    tsSimulador: TTabSheet;
    CategoryPanelGroup1: TCategoryPanelGroup;
    CategoryPanel1: TCategoryPanel;
    CategoryPanel2: TCategoryPanel;
    ButtonGroup1: TButtonGroup;
    ButtonGroup2: TButtonGroup;
    pnlCadastroProduto: TPanel;
    lblProdutoCaption: TLabel;
    pnlProdutosBotoes: TPanel;
    btnConfirmar: TButton;
    btnCancelar: TButton;
    bvlSep: TBevel;
    pnlProdutoCadastro: TPanel;
    bvlSep1: TBevel;
    pnlGrid: TPanel;
    grdProdutos: TDBGrid;
    edtpro_codigo: TSpinEdit;
    edtpro_nome: TEdit;
    edtpro_valor: TEdit;
    lblId: TLabel;
    lblNome: TLabel;
    lblQtd: TLabel;
    lblValor: TLabel;
    edtpro_qtd: TSpinEdit;
    dsProdutos: TDataSource;
    mdProdutos: TFDMemTable;
    mdProdutospro_id: TStringField;
    mdProdutospro_codigo: TIntegerField;
    mdProdutospro_nome: TStringField;
    mdProdutospro_qtd: TIntegerField;
    mdProdutospro_valor: TCurrencyField;
    StorageBin: TFDStanStorageBinLink;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    RESTResponseDataSetAdapter: TRESTResponseDataSetAdapter;
    mdLog: TFDMemTable;
    mdLogid: TIntegerField;
    mdLogtable: TStringField;
    mdLogfield: TStringField;
    mdLogold_value: TStringField;
    mdLognew_value: TStringField;
    mdLoguser_id: TIntegerField;
    mdLogop: TIntegerField;
    dsLog: TDataSource;
    CategoryPanelGroup2: TCategoryPanelGroup;
    CategoryPanel3: TCategoryPanel;
    ButtonGroup3: TButtonGroup;
    CategoryPanel4: TCategoryPanel;
    ButtonGroup4: TButtonGroup;
    mdLogtable_id: TStringField;
    RESTClient: TRESTClient;
    BindSourceDB1: TBindSourceDB;
    pnlLog: TPanel;
    grdLog: TDBGrid;
    CategoryPanelGroup3: TCategoryPanelGroup;
    CategoryPanel5: TCategoryPanel;
    ButtonGroup5: TButtonGroup;
    edtSimularAddMs: TSpinEdit;
    lblSimularMs: TLabel;
    edtSimularEditMs: TSpinEdit;
    Label2: TLabel;
    rbSimularAdd: TRadioButton;
    rbSimularEdit: TRadioButton;
    tmrSimular: TTimer;
    edtSimularExec: TSpinEdit;
    lblSimularExec: TLabel;
    mdLogdata_reg: TStringField;
    mdLogsystem_id: TIntegerField;
    CategoryPanel6: TCategoryPanel;
    ButtonGroup6: TButtonGroup;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure btnProdutosClick(Sender: TObject);
    procedure btnSimuladorClick(Sender: TObject);
    procedure btnLogClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure ButtonGroup1Items0Click(Sender: TObject);
    procedure ButtonGroup1Items1Click(Sender: TObject);
    procedure ButtonGroup1Items2Click(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure ButtonGroup2Items0Click(Sender: TObject);
    procedure ButtonGroup2Items1Click(Sender: TObject);
    procedure grdProdutosDblClick(Sender: TObject);
    procedure ButtonGroup3Items0Click(Sender: TObject);
    procedure ButtonGroup4Items0Click(Sender: TObject);
    procedure ButtonGroup4Items1Click(Sender: TObject);
    procedure tmrSimularTimer(Sender: TObject);
    procedure ButtonGroup5Items0Click(Sender: TObject);
    procedure ButtonGroup5Items1Click(Sender: TObject);
    procedure mdLogopGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure ButtonGroup6Items0Click(Sender: TObject);
  private
    FOperacao: TOperacao;
    //
    procedure DataSetToFrame;
    procedure FrameToDataSet;
    procedure ClearFrame;
    //
    procedure OpenProcutos;
    procedure CommitProdutos;
    //
    function Validar:Boolean;
    procedure Salvar;
    procedure RegLog(ADataSet: TFDMemTable; AFieldName: String);
    //
    function NewGUID(ASomenteNumeros: Boolean = True): String;
  public
    { Public declarations }
  end;

const
  cBaseURL = 'http://localhost:8080/datasnap/rest/TLogControl';
  cTabela = 'produtos';
  cChave = 'pro_id';
var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btnCancelarClick(Sender: TObject);
begin
  FOperacao := opBrowser;
  pnlCadastroProduto.Visible := False;
end;

procedure TfrmMain.btnConfirmarClick(Sender: TObject);
begin
  if Validar then
  begin
    Salvar;
    pnlCadastroProduto.Visible := False;
  end; // if
end;

procedure TfrmMain.btnLogClick(Sender: TObject);
begin
  if not tsLog.TabVisible then
  begin
    tsLog.TabVisible := True;
  end; // if
  // Ativa a tela de Log
  pgcTelas.ActivePage := tsLog;
end;

procedure TfrmMain.btnProdutosClick(Sender: TObject);
begin
  if not tsProdutos.TabVisible then
  begin
    tsProdutos.TabVisible := True;
    OpenProcutos;
  end; // if
  // Ativa a tela dfe Produtos
  pgcTelas.ActivePage := tsProdutos;
end;

procedure TfrmMain.btnSimuladorClick(Sender: TObject);
begin
  if not tsSimulador.TabVisible then
  begin
    tsSimulador.TabVisible := True;
  end; // if
  // Ativa a tela de simulação
  pgcTelas.ActivePage := tsSimulador;
end;

procedure TfrmMain.ButtonGroup1Items0Click(Sender: TObject);
begin
  lblProdutoCaption.Caption := 'Novo produto';
  ClearFrame;
  pnlCadastroProduto.Visible := True;
  if edtpro_codigo.CanFocus then
    edtpro_codigo.SetFocus;
  FOperacao := opAdd;
end;

procedure TfrmMain.ButtonGroup1Items1Click(Sender: TObject);
begin
  DataSetToFrame;
  lblProdutoCaption.Caption := 'Alterar produto';
  pnlCadastroProduto.Visible := True;
  if edtpro_codigo.CanFocus then
    edtpro_codigo.SetFocus;
  FOperacao := opEdit;
end;

procedure TfrmMain.ButtonGroup1Items2Click(Sender: TObject);
begin
  FOperacao := opDel;
  Salvar;
end;

procedure TfrmMain.ButtonGroup2Items0Click(Sender: TObject);
begin
  mdProdutos.First;
end;

procedure TfrmMain.ButtonGroup2Items1Click(Sender: TObject);
begin
  mdProdutos.Last;
end;

procedure TfrmMain.ButtonGroup3Items0Click(Sender: TObject);
var
  TempoIni: TDatetime;
  TempoFin: TDatetime;
begin
  // Inicia e configura os componentes
  RESTClient.ResetToDefaults;
  RESTRequest.ResetToDefaults;
  RESTResponse.ResetToDefaults;
  RESTClient.BaseURL := cBaseURL;
  RESTRequest.Resource := '/log';
  RESTRequest.Method := TRESTRequestMethod.rmGET;

  // Registra o tempo para estatística
  TempoIni:= now;

  // Tenta executar a requisição
  try
    RESTRequest.Execute;
  except
    MessageDlg('Não foi possível realizar a conxão com o servidor. ' +
      #13#10 + 'Verifique sua conexão ou se o serviço está iniciado.',
      mtError, [mbOK], 0);
    Abort;
  end;

  // Registra o tempo para estatística
  TempoFin:= now;

  // Mostra o status e estatíticas
  sbStatus.Panels.Items[1].Text := RESTResponse.StatusCode.ToString;
  sbStatus.Panels.Items[3].Text := 'sec:ms '+FormatDateTime('ss:zz',TempoFin-TempoIni);

end;

procedure TfrmMain.ButtonGroup4Items0Click(Sender: TObject);
begin
  mdLog.First;
end;

procedure TfrmMain.ButtonGroup4Items1Click(Sender: TObject);
begin
  mdLog.Last;
end;

procedure TfrmMain.ButtonGroup5Items0Click(Sender: TObject);
begin
  tsProdutos.Enabled := False;
  tsHome.Enabled := False;
  tsLog.Enabled := False;
  //
  if rbSimularAdd.Checked then
  begin
    tmrSimular.Interval := edtSimularAddMs.Value;
  end // if
  else
  begin
    tmrSimular.Interval := edtSimularEditMs.Value;
  end; // else
  // Inicia a simulação
  btnProdutosClick(nil);
  btnSimuladorClick(nil);
  edtSimularExec.Value := 0;
  tmrSimular.Enabled := True;
end;

procedure TfrmMain.ButtonGroup5Items1Click(Sender: TObject);
begin
  tsProdutos.Enabled := True;
  tsHome.Enabled := True;
  tsLog.Enabled := True;
  //
  tmrSimular.Enabled := False;
end;

procedure TfrmMain.ButtonGroup6Items0Click(Sender: TObject);
begin
  if MessageDlg('Todos os produtos serão apagados. ' + #13#10 +
    'Deseja continuar?',  mtWarning, [mbYes, mbNo], 0) = mrYes then
  begin
    mdProdutos.Close;
    mdProdutos.Open;
    CommitProdutos;
  end;

end;

procedure TfrmMain.ClearFrame;
var
  I: Integer;
  AControl: TComponent;
begin
  // Passa por cada campo do dataset
  for I := 0 to mdProdutos.Fields.Count - 1 do
  begin
    // Localizo no container o objeto com o nome do campo
    AControl := FindComponent('edt'+mdProdutos.Fields.Fields[i].FieldName);

    // Se encontrou componente com o mesmo nome de campo
    if Assigned(AControl) then
    begin
      TCustomEdit(AControl).Clear;
    end; // if
  end; // for
end;

procedure TfrmMain.CommitProdutos;
begin
  // Grava os dados em arquivo dat
  mdProdutos.SaveToFile(GetCurrentDir+'\Data\dados.dat');
end;

procedure TfrmMain.DataSetToFrame;
var
  I: Integer;
  AControl: TComponent;
begin
  // Passa por cada campo do dataset
  for I := 0 to mdProdutos.Fields.Count - 1 do
  begin
    // Localizo no container o objeto com o nome do campo
    AControl := FindComponent('edt'+mdProdutos.Fields.Fields[i].FieldName);

    // Se encontrou componente com o mesmo nome de campo
    if Assigned(AControl) then
    begin
      // Como apenas estou usando Edti e SpinEdit, vou implementar apenas esses dois
      if AControl is TEdit then
      begin
        TEdit(AControl).Text := mdProdutos.Fields.Fields[i].Value;
      end; // if
      //
      if AControl is TSpinEdit then
      begin
        TSpinEdit(AControl).Value := mdProdutos.Fields.Fields[i].Value;
      end;// if

      // Implementar mais tipos

    end; // if
  end; // for
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  // Inicia as telas
  tsHome.TabVisible := True;
  tsProdutos.TabVisible := False;
  tsSimulador.TabVisible := False;
  tsLog.TabVisible := False;
  // Inicia a operação como Browser
  FOperacao := opBrowser;
end;

procedure TfrmMain.FrameToDataSet;
var
  I: Integer;
  AControl: TComponent;
begin
  // Passa por cada campo do dataset
  for I := 0 to mdProdutos.Fields.Count - 1 do
  begin
    // Localizo no container o objeto com o nome do campo
    AControl := FindComponent('edt'+mdProdutos.Fields.Fields[i].FieldName);

    // Se encontrou componente com o mesmo nome de campo
    if Assigned(AControl) then
    begin
      // Como apenas estou usando Edti e SpinEdit, vou implementar apenas esses dois
      if AControl is TEdit then
      begin
         mdProdutos.Fields.Fields[i].Value := TEdit(AControl).Text;
      end; // if
      //
      if AControl is TSpinEdit then
      begin
        mdProdutos.Fields.Fields[i].Value := TSpinEdit(AControl).Value;
      end; // if

      // Implementar mais tipos

    end; // if
  end; // for
end;

procedure TfrmMain.grdProdutosDblClick(Sender: TObject);
begin
  // Se não for vazio, abre como edição
  if not mdProdutos.IsEmpty then
  begin
    ButtonGroup1Items1Click(nil);
  end // if
  // Se for vazio, abre como inserção
  else
  begin
    ButtonGroup1Items0Click(nil);
  end; // else
end;

procedure TfrmMain.mdLogopGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  if mdLogop.AsInteger = 1 then
    Text := 'Incluído'
  else if mdLogop.AsInteger = 2 then
    Text := 'Alterado'
  else if mdLogop.AsInteger = 3 then
    Text := 'Excluído'
end;

procedure TfrmMain.OpenProcutos;
begin
  if FileExists(GetCurrentDir+'\Data\dados.dat') then
  begin
    mdProdutos.Open;
    mdProdutos.LoadFromFile(GetCurrentDir+'\Data\dados.dat');
  end; // if
end;

procedure TfrmMain.RegLog(ADataSet: TFDMemTable; AFieldName: String);
var
  VJSONObject: TJSONObject;
  TempoIni: TDatetime;
  TempoFin: TDatetime;

  function FieldToJSONLog: TJSONObject;
  var
    AControl: TComponent;
    AOld: string;
    ANew: string;
  begin

    AControl := FindComponent('edt'+AFieldName);
    //
    AOld := '';
    ANew := '';
    //
    if Assigned(AControl) then
    begin
      AOld := ADataSet.FieldByName(AFieldName).Value;
      //
      if FOperacao = opEdit then
      begin
        ANew := TCustomEdit(AControl).Text;
      end; // if
    end; // if
    //
    if (AOld <> ANew)
    or (FOperacao in [opAdd, opDel]) then
    begin
      Result := TJSONObject.Create();
      Result.AddPair(TJSONPair.Create('table_name', cTabela));
      Result.AddPair(TJSONPair.Create('table_id', ADataSet.FieldByName(cChave).AsString));
      Result.AddPair(TJSONPair.Create('field_name', AFieldName));
      Result.AddPair(TJSONPair.Create('old_value', AOld));
      Result.AddPair(TJSONPair.Create('new_value', ANew));
      Result.AddPair(TJSONPair.Create('user_id', '1'));
      Result.AddPair(TJSONPair.Create('system_id', '1'));
      Result.AddPair(TJSONPair.Create('op', Ord(FOperacao).ToString));
      Result.AddPair(TJSONPair.Create('data_reg', FormatDateTime('yyyy-mm-dd hh:mm:ss',now)));
    end // if
    else
    begin
      Result := nil;
    end; // else

  end; // FieldToJSONLog

begin
  if FOperacao <> opBrowser then
  begin
    VJSONObject := FieldToJSONLog;
    //
    if VJSONObject <> nil then
    begin
      // Inicia e configura objetos
      RESTClient.ResetToDefaults;
      RESTRequest.ResetToDefaults;
      RESTResponse.ResetToDefaults;
      RESTClient.BaseURL := cBaseURL;
      RESTRequest.Resource := '/log';
      RESTRequest.Method := TRESTRequestMethod.rmPUT;

      // Atribui o body para a requisição
      RESTRequest.AddBody(VJSONObject.ToString, ContentTypeFromString('application/json'));

      // Registro tempo para estatisticas
      TempoIni:= now;

      // Tenta executar a requisição
      try
        RESTRequest.Execute;
      except
        MessageDlg('Não foi possível realizar a conxão com o servidor. ' +
          #13#10 + 'Verifique sua conexão ou se o serviço está iniciado.',
          mtError, [mbOK], 0);
        Abort;
      end;

      // Registro tempo para estatisticas
      TempoFin:= now;

      // Mostra o status e estatiticas
      sbStatus.Panels.Items[1].Text := RESTResponse.StatusCode.ToString;
      sbStatus.Panels.Items[3].Text := 'sec:ms '+FormatDateTime('ss:zz',TempoFin-TempoIni);
    end; // if
    // Libera objeto
    if Assigned(VJSONObject) then
    begin
      VJSONObject.DisposeOf;
    end; // if
  end;
end;

procedure TfrmMain.Salvar;

  // Método que passa por cada campo e compara se foi alterado ou não.
  procedure RegistraLog;
  var i: integer;
  begin
    for I := 0 to mdProdutos.Fields.Count - 1 do
    begin
      // Se for o campo chave não é necessário registros uma linha no log.
      if mdProdutos.Fields.Fields[i].FieldName = cChave then
        Continue;
      // Registra se esse campo houve alteração
      RegLog(mdProdutos,mdProdutos.Fields.Fields[i].FieldName);
    end; // for
  end; // RegistraLog

begin
  try
  finally
    case FOperacao of
      opAdd: begin
        // Registra o novo item
        mdProdutos.Insert;
        mdProdutospro_id.Value := NewGUID;
        FrameToDataSet;
        mdProdutos.Post;
        // Grava o log desta nova inserção
        RegistraLog;
      end; // add
      opEdit: begin
        // Grava o log antes de alterar o item, para que eu possa comparar o valor antigo com o novo
        RegistraLog;
        // Altera o item
        mdProdutos.Edit;
        FrameToDataSet;
        mdProdutos.Post;
      end; // edit
      opDel: begin
        if MessageDlg('Deseja realmente excluir esse registro?',  mtConfirmation,
          [mbYes, mbNo], 0) = mrYes then
        begin
          // Grava o log do registro antes de excluir
          RegistraLog;
          // Exclui o item
          mdProdutos.Delete;
        end;
      end; // del
    end; // case
  end; // try/finally
  // Volta a operação como browse
  FOperacao := opBrowser;
  // Salva os dados em arquivo
  CommitProdutos;
end;

procedure TfrmMain.tmrSimularTimer(Sender: TObject);
var
  r: integer;
begin
  Application.ProcessMessages;
  // faz o processo de inclusão ou edição
  if rbSimularAdd.Checked then
  begin
    // Simula alteração no regitro
    ButtonGroup1Items0Click(nil);
    edtpro_codigo.Value := 100;
    edtpro_nome.Text    := 'produto '+edtpro_codigo.Text;
    edtpro_valor.Text   := '100';
    edtpro_qtd.Value    := 100;
    btnConfirmarClick(nil);
  end // if
  else
  begin
    // Sortei o registro que será alterado
    Randomize;
    r := Random(mdProdutos.RecordCount);
    mdProdutos.RecNo := r;
    // Simula alteração no regitro
    ButtonGroup1Items1Click(nil);
    edtpro_qtd.Value := edtpro_qtd.Value + 1;
    btnConfirmarClick(nil);
    //
  end; // else
  // Incrementa o número de eventos realizados
  edtSimularExec.Value := edtSimularExec.Value + 1;
end;

function TfrmMain.Validar: Boolean;
begin
  // Inicia o retorno sempre como verdadeiro/validado
  Result := True;

  if (Result) and (edtpro_codigo.Value <= 0) then
  begin
    MessageDlg('O campo Código deve ser informado.',  mtWarning, [mbOK], 0);
    edtpro_codigo.SetFocus;
    Result := False;
  end; // if

  if (Result) and (trim(edtpro_nome.Text) = '') then
  begin
    MessageDlg('O campo Nome deve ser informado.',  mtWarning, [mbOK], 0);
    edtpro_nome.SetFocus;
    Result := False;
  end; // if

  if (Result) and (edtpro_qtd.Value <= 0) then
  begin
    MessageDlg('O campo Quantidade deve ser informado.',  mtWarning, [mbOK], 0);
    edtpro_qtd.SetFocus;
    Result := False;
  end; // if

  if (Result) and (StrToCurrDef(edtpro_valor.Text,-1) = -1) then
  begin
    MessageDlg('O campo Valor deve ser informado corretamente.',  mtWarning, [mbOK], 0);
    edtpro_valor.SetFocus;
    Result := False;
  end; // if

end;

function TfrmMain.NewGUID(ASomenteNumeros: Boolean = True): String;
var AUid: TGuid;
    AResult: HResult;
begin
  AResult := CreateGuid(AUid);
  if AResult = S_OK then
  begin
    Result := GuidToString(AUid);
    if ASomenteNumeros then
    begin
      Result := StringReplace(Result,'{','',[rfReplaceAll]);
      Result := StringReplace(Result,'}','',[rfReplaceAll]);
      Result := StringReplace(Result,'-','',[rfReplaceAll]);
    end; // if
  end; // if
end;


end.
