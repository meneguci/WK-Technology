program projWKTeste;

uses
  Vcl.Forms,
  uFrmSimples in 'uFrmSimples.pas' {FrmSimples},
  uDm in 'uDm.pas' {dm: TDataModule},
  uFrmPedido in 'uFrmPedido.pas' {FrmPedido},
  uProduto in 'uProduto.pas',
  uFuncoes in 'uFuncoes.pas',
  uFrmLocalizarPedido in 'uFrmLocalizarPedido.pas' {FrmLocalizarPedido};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPedido, FrmPedido);
  Application.CreateForm(Tdm, dm);
  Application.Run;
end.
