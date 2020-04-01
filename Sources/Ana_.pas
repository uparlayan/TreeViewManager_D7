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
            + 'Müþteri Ýliþkileri Yönetini   {selected:-1}                    '#1
            + ' Avukatlar                    {selected:-1,image:3,state:201}  '#1
            + ' Müvekkiller                  {selected:-1,image:4,state:202}  '#1
            + ' Vekaletnameler               {selected:-1,image:5,state:203}  '#1
            + 'Muhasebe                      {selected:-1}                    '#1
            + ' Banka Hesaplarý              {selected:-1,image:6,state:301}  '#1
            + ' Faturalar                    {selected:-1}                    '#1
            + '  Alýþ Faturalarý             {selected:-1,image:7,state:302}  '#1
            + '  Satýþ Faturalarý            {selected:-1,image:8,state:303}  '#1
            + ' Serbest Meslek Makbuzlarý    {selected:-1}                    '#1
            + '  Alýþ SMM                    {selected:-1,image:9,state:304}  '#1
            + '  Satýþ SMM                   {selected:-1,image:10,state:305} '#1
            + ' Günlük Banka Defteri         {selected:-1,image:11,state:306} '#1
            + ' Günlük Kasa Defteri          {selected:-1,image:12,state:307} '#1
            + ' Hesap Planý                  {selected:-1,image:13,state:308} '#1
            + ' Yevmiye Defteri              {selected:-1,image:14,state:309} '#1
            + 'Ürün ve Hizmetler             {selected:-1}                    '#1
            + 'Lojistik                      {selected:-1}                    '#1
            + 'Ýþletme                       {selected:-1}                    '#1
            + 'Ýnsan Kaynaklarý              {selected:-1}                    '#1
            + 'Döküman Yönetimi              {selected:-1}                    '#1
            + 'Proje ve Süreçler             {selected:-1}                    '#1
            + 'Tanýmlamalar                  {selected:-1}                    '#1
            + 'Rapor ve Özetler              {selected:-1}                    '#1
            + 'Sistem Yönetimi               {selected:-1}                    '#1
            + 'Yapýsal Nesneler              {selected:-1}                    '#1
            );
  TV.Kurulum(ed_Search, alTop);
  TV.Duzenle;
  TV.IlkeGit;

  MN.Icerik ( 'Fihrist                       {selected:-1}                    '#1
            + ' Adres Defteri                {selected:-1,image:1,state:101}  '#1
            + ' Rehber                       {selected:-1,image:2,state:102}  '#1
            + 'Müþteri Ýliþkileri Yönetini   {selected:-1}                    '#1
            + ' Avukatlar                    {selected:-1,image:3,state:201}  '#1
            + ' Müvekkiller                  {selected:-1,image:4,state:202}  '#1
            + ' Vekaletnameler               {selected:-1,image:5,state:203}  '#1
            + 'Muhasebe                      {selected:-1}                    '#1
            + ' Banka Hesaplarý              {selected:-1,image:6,state:301}  '#1
            + ' Faturalar                    {selected:-1}                    '#1
            + '  Alýþ Faturalarý             {selected:-1,image:7,state:302}  '#1
            + '  Satýþ Faturalarý            {selected:-1,image:8,state:303}  '#1
            + ' Serbest Meslek Makbuzlarý    {selected:-1}                    '#1
            + '  Alýþ SMM                    {selected:-1,image:9,state:304}  '#1
            + '  Satýþ SMM                   {selected:-1,image:10,state:305} '#1
            + ' Günlük Banka Defteri         {selected:-1,image:11,state:306} '#1
            + ' Günlük Kasa Defteri          {selected:-1,image:12,state:307} '#1
            + ' Hesap Planý                  {selected:-1,image:13,state:308} '#1
            + ' Yevmiye Defteri              {selected:-1,image:14,state:309} '#1
            + 'Ürün ve Hizmetler             {selected:-1}                    '#1
            + 'Lojistik                      {selected:-1}                    '#1
            + 'Ýþletme                       {selected:-1}                    '#1
            + 'Ýnsan Kaynaklarý              {selected:-1}                    '#1
            + 'Döküman Yönetimi              {selected:-1}                    '#1
            + 'Proje ve Süreçler             {selected:-1}                    '#1
            + 'Tanýmlamalar                  {selected:-1}                    '#1
            + 'Rapor ve Özetler              {selected:-1}                    '#1
            + 'Sistem Yönetimi               {selected:-1}                    '#1
            + 'Yapýsal Nesneler              {selected:-1}                    '#1
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
