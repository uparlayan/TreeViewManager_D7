unit Class_Interposer_MainMenu_;

interface

uses
    Menus
  , Classes         //  TStringList
  ;

type
  TMainMenu = class(Menus.TMainMenu)
    private
      FAyrac      : Char;
      FAyracBasi  : Char;
      FAyracSonu  : Char;
      FAtomikAyrac: Char;
      FMenu       : TStringList;
      FAtomik     : TStringList;
      FOnClick    : TNotifyEvent;
    protected
      function New(aCaption: String; aTag: Integer; aImageIndex: Integer = -1): TMenuItem;
      function Parse(aString: String; aSagdakini: Boolean = False): String;
      function GetProps(aString: String): String;
      function GetBaslik(aString: string): String;
      function GetValue(aItem, aString: String): String;
      function GetLevel(aString: String): Integer;
      procedure ItemClick(Sender: TObject);
    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;
      procedure Icerik(aString: String);
      procedure Duzenle;
      procedure Kurulum(aOnClick: TNotifyEvent; aAyrac: Char = ','; aAyracBasi: Char = '{'; aAyracSonu: Char = '}'; aAtomikAyrac: Char = ':');
      property Ayrac      : Char read FAyrac        write FAyrac;
      property AyracBasi  : Char read FAyracBasi    write FAyracBasi;
      property AyracSonu  : Char read FAyracSonu    write FAyracSonu;
      property AtomikAyrac: Char read FAtomikAyrac  write FAtomikAyrac;
  end;

implementation

uses
    SysUtils
  , Dialogs
  ;

{ TMainMenu }

procedure TMainMenu.Duzenle;
var
  Satir: String;
  I, L, T, P: Integer;
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
  for I := 0 to FMenu.Count - 1 do begin
      Satir := FMenu.Strings[I];
      if (Trim(Satir) <> '') then begin
          L := GetLevel(Satir);
          T := StrToIntDef(GetValue('tag', GetProps(Satir)), 0);
          P := StrToIntDef(GetValue('image', GetProps(Satir)), -1);
          if (L = 0) then begin
              LV0 := New( GetBaslik(Satir), T, P);
              Items.Add(LV0);
          end else
          if (L = 1) then begin
              LV1 := New( GetBaslik(Satir), T, P);
              Items.Find(LV0.Caption).Add(LV1);
          end else
          if (L = 2) then begin
              LV2 := New( GetBaslik(Satir), T, P);
              Items.Find(LV0.Caption)
                   .Find(LV1.Caption)
                   .Add(LV2);
          end else
          if (L = 3) then begin
              LV3 := New( GetBaslik(Satir), T, P);
              Items.Find(LV0.Caption)
                   .Find(LV1.Caption)
                   .Find(LV2.Caption)
                   .Add(LV3);
          end else
          if (L = 4) then begin
              LV4 := New( GetBaslik(Satir), T, P);
              Items.Find(LV0.Caption)
                   .Find(LV1.Caption)
                   .Find(LV2.Caption)
                   .Find(LV3.Caption)
                   .Add(LV4);
          end else
          if (L = 5) then begin
              LV5 := New( GetBaslik(Satir), T, P);
              Items.Find(LV0.Caption)
                   .Find(LV1.Caption)
                   .Find(LV2.Caption)
                   .Find(LV3.Caption)
                   .Find(LV4.Caption)
                   .Add(LV5);
          end else
          if (L = 6) then begin
              LV6 := New( GetBaslik(Satir), T, P);
              Items.Find(LV0.Caption)
                   .Find(LV1.Caption)
                   .Find(LV2.Caption)
                   .Find(LV3.Caption)
                   .Find(LV4.Caption)
                   .Find(LV5.Caption)
                   .Add(LV6);
          end else
          if (L = 7) then begin
              LV7 := New( GetBaslik(Satir), T, P);
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
              LV8 := New( GetBaslik(Satir), T, P);
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
              LV9 := New( GetBaslik(Satir), T, P);
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
            raise Exception.Create('Menülerde en fazla 9 kýrýlýma kadar izin veriliyor.');
            { Standart else sonu }
          end;
      end;
  end;
end;

constructor TMainMenu.Create(aOwner: TComponent);
begin
  inherited;
  FMenu   := TStringList.Create;
  FAtomik := TStringList.Create;

end;

destructor TMainMenu.Destroy;
begin
  FreeAndNil(FAtomik);
  FreeAndNil(FMenu);
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

procedure TMainMenu.Icerik(aString: String);
begin
  FMenu.Text  := StringReplace( aString, #1, #13#10, [rfReplaceAll, rfIgnoreCase]);
end;

procedure TMainMenu.Kurulum(aOnClick: TNotifyEvent; aAyrac, aAyracBasi, aAyracSonu, aAtomikAyrac: Char);
begin
  FAyrac      := aAyrac;
  FAyracBasi  := aAyracBasi;
  FAyracSonu  := aAyracSonu;
  FAtomikAyrac:= aAtomikAyrac;
  FOnClick    := aOnClick;
end;

function TMainMenu.Parse(aString: String; aSagdakini: Boolean): String;
var
  X: Integer;
begin
  Result := '';
  X := pos(FAtomikAyrac, aString);
  if (X > 0) then begin
      if (aSagdakini = True)
      then Result := Trim(copy(aString, X + 1, Length(aString) - X))
      else Result := Trim(copy(aString, 1, X - 1));
  end;
end;

function TMainMenu.New(aCaption: String; aTag, aImageIndex: Integer): TMenuItem;
begin
  Result := TMenuItem.Create(Self);
  Result.Caption := aCaption;
  Result.Tag := aTag;
  Result.ImageIndex := aImageIndex;
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
  if (Y > X) and (X > 0) then Result := Trim(Copy(aString, 1, X - 1)); // {'nin sol tarafýný alýr.
end;

function TMainMenu.GetValue(aItem, aString: String): String;
var
  I: Integer;
  S, R: string;
begin
  Result := '';
  if (aString <> '') then begin
      FAtomik.Delimiter     := FAyrac;
      FAtomik.DelimitedText := StringReplace(aString, #32, '', [rfReplaceAll, rfIgnoreCase]);
      for I := 0 to FAtomik.Count-1 do begin
          R := Trim(FAtomik.Strings[I]);
          S := Parse(R);
          if (S = aItem) then begin
              Result := Parse(R, True);
              Exit;
          end;
      end;
  end;
end;

procedure TMainMenu.ItemClick(Sender: TObject);
begin
  ShowMessage(TMenuItem(Sender).Caption + ' > ' + IntToStr( TMenuItem(Sender).Tag ));
end;

end.
