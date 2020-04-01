unit Class_Interposer_TreeView_;

interface

uses
    ComCtrls        //  Vcl.ComCtrls.TTreeView
  , CommCtrl        //  TVM_SETITEMHEIGHT
  , Classes         //  TStringList
  , StdCtrls        //  TCustomEdit
  , Windows         //  SB_TOP
  , Messages        //  WM_VSCROLL
  , Controls        //  TAlign
  ;

type
  TEdit = class(StdCtrls.TEdit)
    public
      property Align;
  end;
  TTreeView = class(ComCtrls.TTreeView)
    private
      procedure DoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    private
      FAyrac      : Char;
      FAyracBasi  : Char;
      FAyracSonu  : Char;
      FAtomikAyrac: Char;
      FMenu       : TStringList;
      FAtomik     : TStringList;
      FEdit       : TEdit;
      function GetBulucu: String;
      procedure SetBulucu(const Value: String);
    protected
      procedure CreateWnd; override;
      procedure AddLevel(var aNewLevel: TTreeNode; var aOldLevel: TTreeNode; aString: String; OL, NL: Integer);
      function GetLevel(aString: String): Integer;
      function LowerCase(aString: String; aBuyukBasHarf: Boolean = False): String;
    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;
      procedure IlkeGit;
      procedure Icerik(aString: String);
      procedure Kurulum(const aEdit: TEdit; aEditAlign: TAlign = alTop; aAyrac: Char = ','; aAyracBasi: Char = '{'; aAyracSonu: Char = '}'; aAtomikAyrac: Char = ':');
      procedure Filtrele(aString: String);
      procedure Duzenle;
      procedure EditBagla(const aEdit: TEdit; aEditAlign: TAlign = alTop);
      property Bulucu     : String read GetBulucu     write SetBulucu;
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

{ TTreeView }

procedure TTreeView.AddLevel(var aNewLevel, aOldLevel: TTreeNode; aString: String; OL, NL: Integer);
var
  aBaslik, aDizi, Atom, Soldaki, Sagdaki: String;
  aImage, aSelected, aState, I, X, Y, Z: Integer;
  function Oku(aString: String; aSagdakini: Boolean = False): String;
  var
    X: Integer;
  begin
    Result := '';
    X := pos(FAtomikAyrac, aString);
    if (X > 0) then begin
        if aSagdakini
        then Result := Trim(copy(aString, X + 1, Length(aString) - X))
        else Result := Trim(copy(aString, 1, X - 1));
    end;
  end;
begin
  aImage    := -1;
  aSelected := -1;
  aState    := -1;
  X := pos(FAyracBasi, aString);
  Y := pos(FAyracSonu, aString);
  if (Y > X) and (X > 0) then begin
      aBaslik := Trim(Copy(aString, 1, X - 1));
      aDizi   := Trim(Copy(aString, X + 1, Y - X - 1));
      if (aDizi <> '') then begin
          FAtomik.Delimiter := FAyrac;
          FAtomik.DelimitedText := StringReplace(aDizi, #32, '', [rfReplaceAll, rfIgnoreCase]);
          for I := 0 to FAtomik.Count-1 do begin
              Atom := Trim(FAtomik.Strings[I]);
              Soldaki := Oku(Atom);
              Sagdaki := Oku(Atom, True);
              if (Soldaki = 'image')    then aImage    := StrToIntDef(Sagdaki, -1) else
              if (Soldaki = 'selected') then aSelected := StrToIntDef(Sagdaki, -1) else
              if (Soldaki = 'state')    then aState    := StrToIntDef(Sagdaki, -1);
          end;
          FAtomik.Text := '';
          if (aSelected = -1) then aSelected := aImage;
      end;
  end else begin
      Z := pos(Ayrac, aString);
      if (Z > 0) then begin
          aState := StrToIntDef(Copy(aString, Z + 1, Length(aString) - Z), -1);
          aBaslik := Trim(Copy(aString, 1, Z - 1));
      end else begin
          aBaslik := Trim(aString);
      end;
  end;
  if (OL <> NL) then begin
      aNewLevel := Self.Items.AddChild(aOldLevel, aBaslik);
      aNewLevel.Selected := True;
  end else begin
      aNewLevel := Self.Items.Add(Selected, aBaslik);
  end;
  aNewLevel.StateIndex    := aState;
  aNewLevel.SelectedIndex := aSelected;
  aNewLevel.ImageIndex    := aImage;
end;

constructor TTreeView.Create(AOwner: TComponent);
begin
  inherited;
  FMenu   := TStringList.Create;
  FAtomik := TStringList.Create;
  Align := alBottom;
end;

destructor TTreeView.Destroy;
begin
  FreeAndNil(FAtomik);
  FreeAndNil(FMenu);
  inherited;
end;

procedure TTreeView.CreateWnd;
begin
  inherited CreateWnd;
  Perform(TVM_SETITEMHEIGHT, 18, 0);
end;

procedure TTreeView.Filtrele(aString: String);
var
  I, J: Integer;
  N: TTreeNode;
begin
  if (Trim(aString) = '') then exit;
  J := Self.Items.Count - 1;
  for I := 0 to J do begin
      N := Self.Items.Item[J - I];
      if (pos(LowerCase(aString), LowerCase(N.Text)) = 0) then
          if N.Count = 0 then N.Delete;
  end;
end;

procedure TTreeView.EditBagla(const aEdit: TEdit; aEditAlign: TAlign = alTop);
begin
  FEdit := aEdit;
  if (Assigned(aEdit) = True) then begin
      aEdit.OnKeyUp := DoKeyUp;
      aEdit.Align   := aEditAlign;
  end;
end;

function TTreeView.GetLevel(aString: String): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Length(aString)-1 do
      if (aString[I] = #32) then Result := Result + 1 else
      if (aString[I] > #32) then exit;
end;

procedure TTreeView.Icerik(aString: String);
begin
  FMenu.Text  := StringReplace( aString, #1, #13#10, [rfReplaceAll, rfIgnoreCase]);
end;

procedure TTreeView.IlkeGit;
begin
  Selected := Items[0];
  Perform( WM_VSCROLL, SB_TOP,0);
end;

procedure TTreeView.Kurulum(const aEdit: TEdit; aEditAlign: TAlign; aAyrac, aAyracBasi, aAyracSonu, aAtomikAyrac: Char);
begin
  FAyrac      := aAyrac;
  FAyracBasi  := aAyracBasi;
  FAyracSonu  := aAyracSonu;
  FAtomikAyrac:= aAtomikAyrac;
  EditBagla(aEdit, aEditAlign);
end;

function TTreeView.LowerCase(aString: String; aBuyukBasHarf: Boolean): String;
const
  K = 'aeirlýdknmyustboüþzghçðcvpöfjwx';   // Harflerin böyle sýralanmasýnýn sebebi
  B = 'AEÝRLIDKNMYUSTBOÜÞZGHÇÐCVPÖFJWX';   // bunlarýn Türkçedeki kullaným sýklýklarýna göredir.
var
  I: Integer;                              // Sayaç, indis deðiþkeni
  X: Integer;                              // Bulunan harfin alfabedeki indis numarasý
begin
  Result := aString;
  for I := 1 to Length(Result) do begin    // metni harf harf geziyoruz. (Bir rakam ile de karþýlaþabiliriz...)
      X := pos(Result[I], B);              // POS, büyük / küçük harfe duyarlýdýr (Case Sensitive). Yani büyükse küçüðü, küçükse büyüðü vermez.
      if (X > 0) then Result[I] := K[X];   // Bulunan karakter alfabemizde varsa, küçüðüyle yer deðiþtiriyoruz.
  end;
  if (aBuyukBasHarf = True) then
      for I := 1 to Length(Result) do begin // Metni harf harf geziyoruz
          X := pos(Result[I], K);          // Burada harften baþka bir karakter ile de karþýlaþabiliriz
          if (X > 0) then begin            // O nedenle, bulunan karakter bir harf ise X, sýfýrdan büyük olur...
              Result[I] := B[X];
              Exit;                        // Ýlk harfi büyüttükten sonra çýkýyoruz...
          end;
      end;
end;

procedure TTreeView.Duzenle;
var
  S: String;
  I, O, L: Integer;
  LV0, LV1, LV2, LV3, LV4, LV5, LV6, LV7, LV8, LV9: TTreeNode;
begin
  Visible := False;
  Items.Clear;
  L := 0;
  LV0 := Items.GetFirstNode;
  for I := 0 to FMenu.Count - 1 do begin
      S := FMenu.Strings[I];
      if (Trim(S) <> '') then begin
          O := L;
          L := GetLevel(S);
          if (L = 0) then AddLevel(LV1, LV0, S, O, L) else
          if (L = 1) then AddLevel(LV2, LV1, S, O, L) else
          if (L = 2) then AddLevel(LV3, LV2, S, O, L) else
          if (L = 3) then AddLevel(LV4, LV3, S, O, L) else
          if (L = 4) then AddLevel(LV5, LV4, S, O, L) else
          if (L = 5) then AddLevel(LV6, LV5, S, O, L) else
          if (L = 6) then AddLevel(LV7, LV6, S, O, L) else
          if (L = 7) then AddLevel(LV8, LV7, S, O, L) else
          if (L = 8) then AddLevel(LV9, LV8, S, O, L) else
          begin
            raise Exception.Create('Menülerde en fazla 9 kýrýlýma kadar izin veriliyor.');
            { Standart else sonu }
          end;
      end;
  end;
  Visible := True;
end;

procedure TTreeView.DoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = 27) then begin
      Key := 0;
      Bulucu := '';
  end else
  if (Key = VK_DOWN) then begin
      Key := 0;
      SetFocus;
  end;
  if (Shift = []) then begin
      Duzenle;
      Filtrele(Bulucu);
  end;
end;

function TTreeView.GetBulucu: String;
begin
  if Assigned(FEdit) then Result := Trim(FEdit.Text)
  else Result := '';
end;

procedure TTreeView.SetBulucu(const Value: String);
begin
  if Assigned(FEdit) then FEdit.Text := Trim(Value);;
end;

end.
