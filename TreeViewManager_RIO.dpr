program TreeViewManager_RIO;

uses
  Vcl.Forms,
  Ana_ in 'Sources\Ana_.pas' {Ana},
  Class_Interposer_MainMenu_ in 'Classes\Class_Interposer_MainMenu_.pas',
  Class_Interposer_TreeView_ in 'Classes\Class_Interposer_TreeView_.pas',
  TemelForm_ in 'Forms\TemelForm_.pas' {TemelForm},
  TemelDBForm_ in 'Forms\TemelDBForm_.pas' {TemelDBForm};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TAna, Ana);
  Application.CreateForm(TTemelDBForm, TemelDBForm);
  Application.Run;
end.
