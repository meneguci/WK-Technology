unit uFuncoes;

interface
uses
  Forms, FMTBcd, SqlExpr, Controls, StdCtrls, ExtCtrls, Variants,
  IdIPWatch, Classes, Graphics, Provider, Dialogs, Messages, Windows, Tlhelp32,
  SysUtils, SqlTimSt, ShlObj, DateUtils, ShellAPI;

  function fPergunta(vText: WideString): Boolean;
  procedure pMensagemInf(vText: WideString);
  procedure pMensagemAtencao(vText: WideString);
  procedure pMensagemErro(vText: WideString);
  function iif(condicao: Boolean; verdadeiro, falso: variant): variant;
implementation

function iif(condicao: Boolean; verdadeiro, falso: variant): variant;
begin
  if condicao then
    result := verdadeiro
  else
    result := falso;
end;

function fPergunta(vText: WideString): Boolean;
begin
  result := (Application.MessageBox(pWideChar(vText), 'Confirma',
    MB_ICONQUESTION + MB_YESNO) = mrYes);
end;

procedure pMensagemInf(vText: WideString);
begin
  Application.MessageBox(pWideChar(vText), 'Informação',
    MB_ICONINFORMATION or MB_OK);
end;

procedure pMensagemAtencao(vText: WideString);
begin
  Application.MessageBox(pWideChar(vText), 'Atenção', MB_ICONWARNING or MB_OK);
end;

procedure pMensagemErro(vText: WideString);
begin
  Application.MessageBox(pWideChar(vText), 'Erro', MB_ICONSTOP or MB_OK);
end;

end.
