unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls, Process, Unzip51g;

type

  { TForm1 }

  TForm1 = class(TForm)
    Panel1: TPanel;
    Process1: TProcess;
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form1: TForm1; 

implementation

{$R *.lfm}

{ TForm1 }
// Subversion test, by Motaz 11.June, 11:57 am

procedure TForm1.FormCreate(Sender: TObject);
var
  CompressedFileName: string;
  RunApplicationName: string;
begin

  if Paramcount <> 2 then
    Panel1.Caption:= 'Wrong parameters count'
  else
  begin
    Panel1.Caption:= 'Waiting..';
    Sleep(2000);
    CompressedFileName:= ParamStr(1);
    RunApplicationName:= ParamStr(2);
    Panel1.Caption:= 'Decompressing....';
    {$IFDEF MSWINDOWS}
    FileUnzipEx(PChar(CompressedFileName), PChar(GetCurrentDir) , '');
    {$ENDIF}
    Process1:= TProcess.Create(nil);
    {$IFDEF LINUX}
    Process1.CommandLine:= 'unzip -o ' + CompressedFileName;
    Process1.Execute;
    Sleep(8000);


    Process1.CommandLine:= 'chmod +x ' + RunApplicationName;
    Process1.Execute;
    Sleep(5000);
    {$ENDIF}

    Process1.CommandLine:= RunApplicationName;
    Process1.Execute;
    Application.Terminate;
  end;
end;

end.
