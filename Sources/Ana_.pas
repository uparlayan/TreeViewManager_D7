/// <summary>
///   TTreeView ve TMainMenu nesneleri i�in �rnek bir proje �al��mas�d�r.
/// </summary>
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
  {$IFDEF VER330}
  , System.ImageList
  {$ENDIF}
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
    /// <summary>
    ///   �rnek men�lerin ve men� a�ac�n�n olu�turuldu�u, d�zenlendi�i ve haz�rland��� metodlar�n �a��r�ld��� b�l�md�r.
    ///   <list type="bullet">
    ///     <item>
    ///       TV, bir TTreeView nesnesini temsil eder.
    ///     </item>
    ///     <item>
    ///       MN ise bir TMainMenu nesnesini temsil etmektedir.
    ///     </item>
    ///   </list>
    /// </summary>
    procedure FormCreate(Sender: TObject);
    /// <summary>
    ///   Farkl� bir TTreeView ��esi se�ildi�inde bu olay tetiklenmi� olur.
    /// </summary>
    procedure TVChange(Sender: TObject; Node: TTreeNode);
    /// <summary>
    ///   �rnek olmas� amac�yla TMenuItem nesnelerinin �a��rd��� Notify Event'tir.
    /// </summary>
    procedure Test(Sender: TObject);
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

  MN.Sablon ( 'Fihrist                    {default:true}    '#1
            + ' Adres Defteri             {image:1,tag:101,shortcut:Ctrl+F} '#1
            + ' -                         {}                '#1
            + ' Rehber                    {image:2,tag:102} '#1
            + 'M��teri �li�kileri Y�netini{}                '#1
            + ' Avukatlar                 {image:3,tag:201} '#1
            + ' -                         {}                '#1
            + ' Vekaletnameler            {image:5,tag:203} '#1
            + ' M�vekkiller               {image:4,tag:202,checked:true,default:true} '#1
            + 'Muhasebe                   {}                '#1
            + ' Faturalar                 {image:9}         '#1
            + '  Al�� Faturalar�          {image:7,tag:302} '#1
            + '  Sat�� Faturalar�         {image:8,tag:303} '#1
            + ' Serbest Meslek Makbuzlar� {image:9}         '#1
            + '  Al�� SMM                 {image:9,tag:304} '#1
            + '  Sat�� SMM                {image:10,tag:305}'#1
            + ' Defterler                 {image:9}         '#1
            + '  G�nl�k Banka Defteri     {image:11,tag:306}'#1
            + '  G�nl�k Kasa Defteri      {image:12,tag:307}'#1
            + ' Banka Hesaplar�           {image:6,tag:301} '#1
            + ' Hesap Plan�               {image:13,tag:308}'#1
            + ' Yevmiye Defteri           {image:14,tag:309}'#1
            (*
            + '�r�n ve Hizmetler          {}                '#1
            + 'Lojistik                   {}                '#1
            + '��letme                    {}                '#1
            + '�nsan Kaynaklar�           {}                '#1
            + 'D�k�man Y�netimi           {}                '#1
            + 'Proje ve S�re�ler          {}                '#1
            + 'Tan�mlamalar               {}                '#1
            + 'Rapor ve �zetler           {}                '#1
            + 'Sistem Y�netimi            {}                '#1
            + 'Yap�sal Nesneler           {}                '#1
            *)
            );
  MN.Ayarla(Test);
  MN.Yerlestir;
end;

procedure TAna.Test(Sender: TObject);
begin
  Caption := 'Clicked By Main Menu > ' + TMenuItem(Sender).Caption + ' <' + IntToStr(TMenuItem(Sender).Tag) + '>' ;
end;

procedure TAna.TVChange(Sender: TObject; Node: TTreeNode);
begin
  Caption := 'Clicked By Tree View > ' + Node.Text + ' <' + IntToStr(Node.StateIndex) + '>' ;
end;

end.
