unit uFrmLocalizarPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmSimples, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons;

type
  TFrmLocalizarPedido = class(TFrmSimples)
    Panel1: TPanel;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    BitBtn1: TBitBtn;
    dtInicio: TDateTimePicker;
    dtFim: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    btnSelecionar: TBitBtn;
    dsPesquisar: TDataSource;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnSelecionarClick(Sender: TObject);
  private
    { Private declarations }
  public
    pedidoId: integer;
  end;

var
  FrmLocalizarPedido: TFrmLocalizarPedido;

implementation

{$R *.dfm}

uses uDm;

procedure TFrmLocalizarPedido.BitBtn1Click(Sender: TObject);
begin
  inherited;
  dm.qryPesquisarPedido.Close();
  dm.qryPesquisarPedido.ParamByName('dt_ini').AsDateTime := dtInicio.Date;
  dm.qryPesquisarPedido.ParamByName('dt_fim').AsDateTime := dtFim.Date + 1;
  dm.qryPesquisarPedido.Open();
end;

procedure TFrmLocalizarPedido.btnSelecionarClick(Sender: TObject);
begin
  inherited;
  pedidoId := dm.qryPesquisarPedido.FieldByName('id').AsInteger;
  dm.qryPesquisarPedido.Close();
end;

end.
