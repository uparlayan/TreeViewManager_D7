unit Class_Interposer_MainMenu_;

interface

uses
    Menus
  , Classes         //  TStringList
  ;

type
  TMainMenu = class(Menus.TMainMenu)
    private
      FAyrac        : Char;
      FAyracBasi    : Char;
      FAyracSonu    : Char;
      FElemanAyrac  : Char;
      FIcerik       : TStringList;
      FEleman       : TStringList;
      FOnClick      : TNotifyEvent;
    protected
      /// <summary>
      ///   TR: Yeni bir Men� eleman� olu�turur.
      /// </summary>
      function New(aCaption: String; aTag: Integer; aImageIndex: Integer = -1; aShortCut: String = ''; aDefault: Boolean = False; aChecked: Boolean = False): TMenuItem;
      /// <summary>
      ///   TR: GetValue i�inde kullan�l�r. Atomik Ayrac�n sa��ndakini veya solundakini bulmaya yarar.
      /// </summary>
      function Ayristir(aString: String; aSagdakini: Boolean = False): String;
      /// <summary>
      ///   TR: Belirtilen sat�rdaki Ayra� Ba�� ve Ayra� sonu karakterlerinin aras�nda kalan k�sm� verir.
      /// </summary>
      function GetProps(aString: String): String;
      /// <summary>
      ///   TR: Belirtilen sat�r�n Ayra� ba��na kadar olan k�sm�n� Trimleyerek verir.
      /// </summary>
      function GetBaslik(aString: string): String;
      /// <summary>
      ///   TR: GetProps ile al�nan de�erleri �nce bir listeye �evirir, sonra o listenin i�inden istenen ba�l�ktaki de�eri ��kt� olarak verir.
      /// </summary>
      function GetValue(aItem, aString: String): String;
      /// <summary>
      ///   TR: Belirtilen sat�rdaki Soldan girinti miktar�n� verir.
      /// </summary>
      function GetLevel(aString: String): Integer;
    public
      /// <param name="aOwner">
      ///   TComponent nesnesinin torunlar�ndan herhangi birisi fakat kastedilen bir TForm nesnesidir.
      /// </param>
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;
      /// <summary>
      ///   <para>
      ///     Men�n�n i�eri�ini, elemanlar�n�, k�s�tlanm�� baz� �zelliklerini tek bir string ile belirtmenizi sa�lar.
      ///     Her bir sat�r tek bir men� ��esini temsil eder. Sat�rlar "#1" karakteri ile birbirinden ayr�l�r. (Veya
      ///     yazmaktan zevk al�yorsan�z her sat�r�n sonuna #13#10 i�aretlerini de koyabilirsiniz)
      ///   </para>
      ///   <para>
      ///     Parantez i�ine al�nm�� olan k�s�m, o sat�rdaki men� ��esinin kendine has �zelliklerini ifade eder.
      ///     Bunlar k�saca ��yledir;
      ///   </para>
      ///   <list type="bullet">
      ///     <item>
      ///       <b>Shortcut</b>: (String) Klavyedeki bir tu� kombinasyonunu men� ��esine ataman�z� sa�lar.
      ///       Mesela"Ctrl+N" gibi...<br/><br/><b>NOT</b>: "Tag" de�eri olmayan ��elerin ShortCut sahibi olmas�n�n bir anlam� olmad���ndan g�rmezden gelinir.
      ///     </item>
      ///     <item>
      ///       <b>Checked</b>: (Boolean) True ise men� ��esinin ba��na bir i�aret ekler.
      ///     </item>
      ///     <item>
      ///       <b>Default</b>: (Boolean) True ise men� ��esinin varsay�lan oldu�unu vurgulamak i�in metni Kal�n
      ///       yapar. UNUTMAYIN, her alt men�de en FAZLA 1 tane default ��e olmal�d�r.
      ///     </item>
      ///     <item>
      ///       <b>tag</b>: (Integer) men� ��esine say�sal bir de�er tan�mlaman�z� sa�lar. Bu, men� ��esine bir
      ///       referans de�er tan�mlayabilmeniz a��s�ndan �nemlidir.
      ///     </item>
      ///     <item>
      ///       <b>Image</b>: (Integer) Men�n�z bir ImageList nesnesine ba�lant� i�eriyor ise, o ImageList
      ///       nesnesindeki resimciklere ba�lant� vermenizi sa�lar.
      ///     </item>
      ///   </list>
      ///   <para>
      ///     Parantezli b�lgenin d���nda VE solundaki k�s�m men� ��esinin ba�l���n� ifade eder. Bu k�sm�n solunda
      ///     b�rak�lan bo�luklar ise bir �nceki sat�rda belirtilen men� ��esinin bir alt eleman� m� yoksa sonraki
      ///     ko�m�usu mu oldu�unu belirtir.
      ///   </para>
      ///   <para>
      ///     A�a��da verilen �rnek, bir Pull Down men�n�n bu sistemde (varsay�lan parametrelerle birlikte) nas�l
      ///     tan�mlanmas� gerekti�ini g�sterir.
      ///   </para>
      /// </summary>
      /// <remarks>
      ///   <b>UYARI</b>: Parantezli k�s�m bir JSON verisi de�ildir. Varsay�lan ayra� parametreleri ile �yleymi� gibi zannedebilirsiniz fakat bu k�s�m bir JSON verisi olarak yorumlanmaz.
      /// </remarks>
      /// <param name="aString">
      ///   Men� i�eri�inin yaz�ld��� parametredir.
      /// </param>
      /// <example>
      ///   <pre lang="Pascal">with MainMenu1 do begin
      ///   Sablon( 'Dosya     {default:true}                    '#1 // Ana seviye
      ///         + ' Yeni     {image:1,tag:101}                 '#1 // 2. seviye
      ///         + ' A�       {image:2,tag:102,shortcut:Ctrl+O} '#1 // 2. seviye
      ///         + ' Kaydet   {image:3,tag:103,checked:true}    '#1 // 2. seviye
      ///         + ' -        {}                                '#1 // 2. seviye ve grup ayrac�
      ///         + ' ��k��    {image:4,tag:104}                 '#1 // 2. seviye
      ///         + 'D�zenle   {}                                '#1 // Ana seviye
      ///         + ' Kes      {image:5,tag:201}                 '#1 // 2. seviye
      ///         + ' Kopyala  {image:6,tag:202}                 '#1 // 2. seviye
      ///         + ' Yap��t�r {image:7,tag:203}                 '#1 // 2. seviye
      ///         + 'Yard�m    {}                                '#1 // Ana seviye
      ///         + ' Hakk�nda {image:8,tag:301}                 '#1 // 2. seviye
      ///         + ' -        {}                                '#1 // 2. seviye ve grup ayrac�
      ///         + ' Konular  {image:8,tag:301}                 '#1 // 2. seviye
      ///         );
      ///   Ayarla(Test);
      ///   Yerlestir;
      /// end;</pre>
      /// </example>
      procedure Sablon(aString: String);
      /// <summary>
      ///   �ablonu, TMainMenu nesnesine uygular...
      /// </summary>
      procedure Yerlestir;
      /// <summary>
      ///   �n tan�ml� di�er parametrelerin tan�mlamam�z� sa�lar.
      /// </summary>
      procedure Ayarla(aOnClick: TNotifyEvent; aAyrac: Char = ','; aAyracBasi: Char = '{'; aAyracSonu: Char = '}'; aElemanAyrac: Char = ':');
      /// <summary>
      ///   Parantez ba�lang�c�n� temsil eden ba�lang�� ayrac�d�r. Yani, bu bir { veya ( ya da [ gibi bir i�aret olabilir.
      /// </summary>
      property AyracBasi  : Char read FAyracBasi    write FAyracBasi;
      /// <summary>
      ///   Parantez sonunu / bitti�i yeri temsil eden biti� ayrac�d�r. Yani, bu bir } veya ) ya da ] gibi bir i�aret olabilir.
      /// </summary>
      property AyracSonu  : Char read FAyracSonu    write FAyracSonu;
      /// <summary>
      ///   Parantez i�indeki elemanlar�n anahtar ve de�er ikilisini bir arada tutacak �ekilde di�erlerinden ay�racak olan ayrac� temsil eder. Yani bu bir , veya ; gibi bir i�aret olabilir...
      /// </summary>
      property Ayrac      : Char read FAyrac        write FAyrac;
      /// <summary>
      ///   Elemanlar�n tan�mlam�� oldu�u Anahtar ve De�er ikilisindeki e�le�meyi temsil eder. Bu ayrac�n solundaki k�s�m Ahantar�, sa� taraf�ndaki k�s�m ise Veriyi, de�eri ifade eder. Dolay�s�yla bu bir : veya = gibi bir i�aret olabilir...
      /// </summary>
      property ElemanAyrac: Char read FElemanAyrac  write FElemanAyrac;
  end;

implementation

uses
    SysUtils
  , Dialogs
  ;

{ TMainMenu }

procedure TMainMenu.Yerlestir;
var
  Satir: String;
  I, L: Integer;
  _Tag, _Image: Integer;
  _ShortCut: String;
  _Checked, _Default: Boolean;
  LV0, LV1, LV2, LV3, LV4, LV5, LV6, LV7, LV8, LV9: TMenuItem;
begin
  Items.Clear;
  LV0:= nil;
  LV1:= nil;
  LV2:= nil;
  LV3:= nil;
  LV4:= nil;
  LV5:= nil;
  LV6:= nil;
  LV7:= nil;
  LV8:= nil;
//  LV9:= nil;
  for I := 0 to FIcerik.Count - 1 do begin
      Satir := FIcerik.Strings[I];
      if (Trim(Satir) <> '') then begin
          L := GetLevel(Satir);
          _Tag      := StrToIntDef(GetValue('tag', GetProps(Satir)), 0);
          _Image    := StrToIntDef(GetValue('image', GetProps(Satir)), -1);
          _ShortCut := GetValue('shortcut', GetProps(Satir));
          _Checked  := (GetValue('checked', GetProps(Satir)) = 'true' );
          _Default  := (GetValue('default', GetProps(Satir)) = 'true' );
          if (L = 0) then begin
              LV0 := New( GetBaslik(Satir), _Tag, _Image, _ShortCut, _Default, _Checked);
              Items.Add(LV0);
          end else
          if (L = 1) then begin
              LV1 := New( GetBaslik(Satir), _Tag, _Image, _ShortCut, _Default, _Checked);
              Items.Find(LV0.Caption).Add(LV1);
          end else
          if (L = 2) then begin
              LV2 := New( GetBaslik(Satir), _Tag, _Image, _ShortCut, _Default, _Checked);
              Items.Find(LV0.Caption)
                   .Find(LV1.Caption)
                   .Add(LV2);
          end else
          if (L = 3) then begin
              LV3 := New( GetBaslik(Satir), _Tag, _Image, _ShortCut, _Default, _Checked);
              Items.Find(LV0.Caption)
                   .Find(LV1.Caption)
                   .Find(LV2.Caption)
                   .Add(LV3);
          end else
          if (L = 4) then begin
              LV4 := New( GetBaslik(Satir), _Tag, _Image, _ShortCut, _Default, _Checked);
              Items.Find(LV0.Caption)
                   .Find(LV1.Caption)
                   .Find(LV2.Caption)
                   .Find(LV3.Caption)
                   .Add(LV4);
          end else
          if (L = 5) then begin
              LV5 := New( GetBaslik(Satir), _Tag, _Image, _ShortCut, _Default, _Checked);
              Items.Find(LV0.Caption)
                   .Find(LV1.Caption)
                   .Find(LV2.Caption)
                   .Find(LV3.Caption)
                   .Find(LV4.Caption)
                   .Add(LV5);
          end else
          if (L = 6) then begin
              LV6 := New( GetBaslik(Satir), _Tag, _Image, _ShortCut, _Default, _Checked);
              Items.Find(LV0.Caption)
                   .Find(LV1.Caption)
                   .Find(LV2.Caption)
                   .Find(LV3.Caption)
                   .Find(LV4.Caption)
                   .Find(LV5.Caption)
                   .Add(LV6);
          end else
          if (L = 7) then begin
              LV7 := New( GetBaslik(Satir), _Tag, _Image, _ShortCut, _Default, _Checked);
              Items.Find(LV0.Caption)
                   .Find(LV1.Caption)
                   .Find(LV2.Caption)
                   .Find(LV3.Caption)
                   .Find(LV4.Caption)
                   .Find(LV5.Caption)
                   .Find(LV6.Caption)
                   .Add(LV7);
          end else
          if (L = 8) then begin
              LV8 := New( GetBaslik(Satir), _Tag, _Image, _ShortCut, _Default, _Checked);
              Items.Find(LV0.Caption)
                   .Find(LV1.Caption)
                   .Find(LV2.Caption)
                   .Find(LV3.Caption)
                   .Find(LV4.Caption)
                   .Find(LV5.Caption)
                   .Find(LV6.Caption)
                   .Find(LV7.Caption)
                   .Add(LV8);
          end else
          if (L = 9) then begin
              LV9 := New( GetBaslik(Satir), _Tag, _Image, _ShortCut, _Default, _Checked);
              Items.Find(LV0.Caption)
                   .Find(LV1.Caption)
                   .Find(LV2.Caption)
                   .Find(LV3.Caption)
                   .Find(LV4.Caption)
                   .Find(LV5.Caption)
                   .Find(LV6.Caption)
                   .Find(LV7.Caption)
                   .Find(LV8.Caption)
                   .Add(LV9);
          end else
          begin
            raise Exception.Create('Men�lerde en fazla 9 k�r�l�ma kadar izin veriliyor.');
            { Standart else sonu }
          end;
      end;
  end;
end;

constructor TMainMenu.Create(aOwner: TComponent);
begin
  inherited;
  FIcerik   := TStringList.Create;
  FEleman := TStringList.Create;
end;

destructor TMainMenu.Destroy;
begin
  FreeAndNil(FEleman);
  FreeAndNil(FIcerik);
  inherited;
end;

function TMainMenu.GetLevel(aString: String): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Length(aString)-1 do
      if (aString[I] = #32) then Result := Result + 1 else
      if (aString[I] > #32) then exit;
end;

procedure TMainMenu.Sablon(aString: String);
begin
  FIcerik.Text  := StringReplace( aString, #1, #13#10, [rfReplaceAll, rfIgnoreCase]);
end;

procedure TMainMenu.Ayarla(aOnClick: TNotifyEvent; aAyrac, aAyracBasi, aAyracSonu, aElemanAyrac: Char);
begin
  FAyrac      := aAyrac;
  FAyracBasi  := aAyracBasi;
  FAyracSonu  := aAyracSonu;
  FElemanAyrac:= aElemanAyrac;
  FOnClick    := aOnClick;
end;

function TMainMenu.Ayristir(aString: String; aSagdakini: Boolean): String;
var
  X: Integer;
begin
  Result := '';
  X := pos(FElemanAyrac, aString);
  if (X > 0) then begin
      if (aSagdakini = True)
      then Result := Trim(copy(aString, X + 1, Length(aString) - X))
      else Result := Trim(copy(aString, 1, X - 1));
  end;
end;

function TMainMenu.New(aCaption: String; aTag, aImageIndex: Integer; aShortCut: String; aDefault, aChecked: Boolean): TMenuItem;
begin
  Result := TMenuItem.Create(Self);
  Result.Caption := aCaption;
  Result.Tag := aTag;
  Result.ImageIndex := aImageIndex;
  Result.Default := aDefault;
  Result.Checked := aChecked;
  Result.ShortCut := TextToShortCut(aShortCut);
  if aTag > 0 then
  Result.OnClick := FOnClick;
end;

function TMainMenu.GetProps(aString: String): String;
var
  X, Y: Integer;
begin
  Result := '';
  X := pos(FAyracBasi, aString);
  Y := pos(FAyracSonu, aString);
  if (Y > X) and (X > 0) then Result := Trim(Copy(aString, X + 1, Y - X - 1));
end;

function TMainMenu.GetBaslik(aString: string): String;
var
  X, Y: Integer;
begin
  Result := aString;
  X := pos(FAyracBasi, aString);
  Y := pos(FAyracSonu, aString);
  if (Y > X) and (X > 0) then Result := Trim(Copy(aString, 1, X - 1)); // {'nin sol taraf�n� al�r.
end;

function TMainMenu.GetValue(aItem, aString: String): String;
var
  I: Integer;
  S, R: string;
begin
  Result := '';
  if (aString <> '') then begin
      FEleman.Delimiter     := FAyrac;
      FEleman.DelimitedText := StringReplace(aString, #32, '', [rfReplaceAll, rfIgnoreCase]);
      for I := 0 to FEleman.Count-1 do begin
          R := Trim(FEleman.Strings[I]);
          S := Ayristir(R);
          if (S = aItem) then begin
              Result := Ayristir(R, True);
              Exit;
          end;
      end;
  end;
end;

end.
