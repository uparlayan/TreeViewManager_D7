program TreeViewManager_D7;

uses
  Forms,
  Ana_ in 'Sources\Ana_.pas' {Ana},
  Class_Interposer_TreeView_ in 'Classes\Class_Interposer_TreeView_.pas',
  Class_Interposer_MainMenu_ in 'Classes\Class_Interposer_MainMenu_.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TAna, Ana);
  Application.Run;
end.
