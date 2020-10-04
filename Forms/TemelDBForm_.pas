unit TemelDBForm_;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, TemelForm_, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TTemelDBForm = class(TTemelForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TemelDBForm: TTemelDBForm;

implementation

{$R *.dfm}

end.
