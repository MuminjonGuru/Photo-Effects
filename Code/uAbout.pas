unit uAbout;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Advertising, FMX.Objects,
  AndroidAPI.JNI.App, AndroidAPI.JNI.Net, AndroidAPI.JNI.GraphicsContentViewText,
  AndroidAPI.Helpers;

type
  TFormAbout = class(TForm)
    ToolBar1: TToolBar;
    BtnBack: TButton;
    BannerAd1: TBannerAd;
    ImageLogo: TImage;
    BtnAppName: TButton;
    BtnAuthoerProgrammerDesigner: TButton;
    Label1: TLabel;
    StyleBook1: TStyleBook;
    procedure BtnBackClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnAppNameClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAbout: TFormAbout;

implementation

{$R *.fmx}

procedure TFormAbout.BtnBackClick(Sender: TObject);
begin
  Close;
end;

procedure TFormAbout.BtnAppNameClick(Sender: TObject);
{$IFDEF Android}
var
  Intent: JIntent;
begin
  Intent := TJIntent.Create;
  Intent.setAction(TJIntent.JavaClass.ACTION_VIEW);
  Intent.setData
    (StrToJURI
    ('https://delphi.uz'));
  TAndroidHelper.Activity.startActivity(Intent);
{$ENDIF}
end;

procedure TFormAbout.FormCreate(Sender: TObject);
begin
  BannerAd1.AdUnitID := 'ca-app-pub-7303908544500004/8781266171';
end;

procedure TFormAbout.FormShow(Sender: TObject);
begin
  BannerAd1.LoadAd;
end;

end.
