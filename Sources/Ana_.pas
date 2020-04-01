unit Ana_;

interface

uses
    Windows
  , Messages
  , SysUtils
  , Variants
  , Classes
  , Graphics
  , Controls
  , Forms
  , Dialogs
  , ImgList
  , StdCtrls
  , ComCtrls
  , ExtCtrls
  , Menus
  , Class_Interposer_TreeView_
  , Class_Interposer_MainMenu_
  ;

type
  TAna = class(TForm)
    Panel2: TPanel;
    TV: TTreeView;
    x16: TImageList;
    ed_Search: TEdit;
    Splitter1: TSplitter;
    Panel1: TPanel;
    Button1: TButton;
    StatusBar1: TStatusBar;
    MN: TMainMenu;
    procedure FormCreate(Sender: TObject);
    procedure TVChange(Sender: TObject; Node: TTreeNode);
    procedure TVKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Ana: TAna;

implementation

{$R *.dfm}

procedure TAna.FormCreate(Sender: TObject);
begin
  TV.Icerik ( 'Fihrist                       {selected:-1}                    '#1
            + ' Adres Defteri                {selected:-1,image:1,state:101}  '#1
            + ' Rehber                       {selected:-1,image:2,state:102}  '#1
            + 'M��teri �li�kileri Y�netini   {selected:-1}                    '#1
            + ' Avukatlar                    {selected:-1,image:3,state:201}  '#1
            + ' M�vekkiller                  {selected:-1,image:4,state:202}  '#1
            + ' Vekaletnameler               {selected:-1,image:5,state:203}  '#1
            + 'Muhasebe                      {selected:-1}                    '#1
            + ' Banka Hesaplar�              {selected:-1,image:6,state:301}  '#1
            + ' Faturalar                    {selected:-1}                    '#1
            + '  Al�� Faturalar�             {selected:-1,image:7,state:302}  '#1
            + '  Sat�� Faturalar�            {selected:-1,image:8,state:303}  '#1
            + ' Serbest Meslek Makbuzlar�    {selected:-1}                    '#1
            + '  Al�� SMM                    {selected:-1,image:9,state:304}  '#1
            + '  Sat�� SMM                   {selected:-1,image:10,state:305} '#1
            + ' G�nl�k Banka Defteri         {selected:-1,image:11,state:306} '#1
            + ' G�nl�k Kasa Defteri          {selected:-1,image:12,state:307} '#1
            + ' Hesap Plan�                  {selected:-1,image:13,state:308} '#1
            + ' Yevmiye Defteri              {selected:-1,image:14,state:309} '#1
            + '�r�n ve Hizmetler             {selected:-1}                    '#1
            + 'Lojistik                      {selected:-1}                    '#1
            + '��letme                       {selected:-1}                    '#1
            + '�nsan Kaynaklar�              {selected:-1}                    '#1
            + 'D�k�man Y�netimi              {selected:-1}                    '#1
            + 'Proje ve S�re�ler             {selected:-1}                    '#1
            + 'Tan�mlamalar                  {selected:-1}                    '#1
            + 'Rapor ve �zetler              {selected:-1}                    '#1
            + 'Sistem Y�netimi               {selected:-1}                    '#1
            + 'Yap�sal Nesneler              {selected:-1}                    '#1
            );
  TV.Kurulum(ed_Search, alTop);
  TV.Duzenle;
  TV.IlkeGit;

  MN.Icerik ( 'Fihrist                       {selected:-1}                    '#1
            + ' Adres Defteri                {selected:-1,image:1,state:101}  '#1
            + ' Rehber                       {selected:-1,image:2,state:102}  '#1
            + 'M��teri �li�kileri Y�netini   {selected:-1}                    '#1
            + ' Avukatlar                    {selected:-1,image:3,state:201}  '#1
            + ' M�vekkiller                  {selected:-1,image:4,state:202}  '#1
            + ' Vekaletnameler               {selected:-1,image:5,state:203}  '#1
            + 'Muhasebe                      {selected:-1}                    '#1
            + ' Banka Hesaplar�              {selected:-1,image:6,state:301}  '#1
            + ' Faturalar                    {selected:-1}                    '#1
            + '  Al�� Faturalar�             {selected:-1,image:7,state:302}  '#1
            + '  Sat�� Faturalar�            {selected:-1,image:8,state:303}  '#1
            + ' Serbest Meslek Makbuzlar�    {selected:-1}                    '#1
            + '  Al�� SMM                    {selected:-1,image:9,state:304}  '#1
            + '  Sat�� SMM                   {selected:-1,image:10,state:305} '#1
            + ' G�nl�k Banka Defteri         {selected:-1,image:11,state:306} '#1
            + ' G�nl�k Kasa Defteri          {selected:-1,image:12,state:307} '#1
            + ' Hesap Plan�                  {selected:-1,image:13,state:308} '#1
            + ' Yevmiye Defteri              {selected:-1,image:14,state:309} '#1
            + '�r�n ve Hizmetler             {selected:-1}                    '#1
            + 'Lojistik                      {selected:-1}                    '#1
            + '��letme                       {selected:-1}                    '#1
            + '�nsan Kaynaklar�              {selected:-1}                    '#1
            + 'D�k�man Y�netimi              {selected:-1}                    '#1
            + 'Proje ve S�re�ler             {selected:-1}                    '#1
            + 'Tan�mlamalar                  {selected:-1}                    '#1
            + 'Rapor ve �zetler              {selected:-1}                    '#1
            + 'Sistem Y�netimi               {selected:-1}                    '#1
            + 'Yap�sal Nesneler              {selected:-1}                    '#1
            );
  MN.Kurulum;
  MN.Duzenle;

end;

procedure TAna.TVChange(Sender: TObject; Node: TTreeNode);
begin
  Caption := IntToStr(Node.StateIndex);
end;

procedure TAna.TVKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  Caption := inttostr(Key);
end;

end.
