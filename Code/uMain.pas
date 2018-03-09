unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Media,
  FMX.Objects, System.Actions, FMX.ActnList, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.MultiView, FMX.StdActns, FMX.MediaLibrary.Actions,
  FMX.Layouts, FMX.ListBox, FMX.InAppPurchase, FMX.Filter.Effects, FMX.Effects,
  FMX.Advertising;

type
  TFormMain = class(TForm)
    ToolBarTop: TToolBar;
    StyleBook1: TStyleBook;
    ActionList1: TActionList;
    ImageMain: TImage;
    CameraComponent1: TCameraComponent;
    BtnPopupMenu: TButton;
    MultiViewLeft: TMultiView;
    BtnShare: TButton;
    ShowShareSheetAction1: TShowShareSheetAction;
    MultiViewRight: TMultiView;
    ListBoxEffects: TListBox;
    BtnCameraKind: TButton;
    BlurEffect: TBlurEffect;
    GlowEffect: TGlowEffect;
    InnerGlowEffect: TInnerGlowEffect;
    BevelEffect: TBevelEffect;
    RippleEffect: TRippleEffect;
    SwirlEffect: TSwirlEffect;
    MagnifyEffect: TMagnifyEffect;
    SmoothMagnifyEffect: TSmoothMagnifyEffect;
    BandsEffect: TBandsEffect;
    WaveEffect: TWaveEffect;
    MonochromeEffect: TMonochromeEffect;
    RasterEffect: TRasterEffect;
    DirectionalBlurEffect: TDirectionalBlurEffect;
    InvertEffect: TInvertEffect;
    PerspectiveTransformEffect: TPerspectiveTransformEffect;
    BtnInfo: TButton;
    HueAdjustEffect: THueAdjustEffect;
    TilerEffect: TTilerEffect;
    procedure ShowShareSheetAction1BeforeExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CameraComponent1SampleBufferReady(Sender: TObject;
      const ATime: TMediaTime);
    procedure ListBoxEffectsChangeCheck(Sender: TObject);
    procedure BtnInfoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

Uses
  uAbout;

{$R *.fmx}
{$R *.NmXhdpiPh.fmx ANDROID}

procedure TFormMain.BtnInfoClick(Sender: TObject);
begin
  if FormAbout = Nil then
    FormAbout := TFormAbout.Create(Application);
  FormAbout.Show;
end;

procedure TFormMain.CameraComponent1SampleBufferReady(Sender: TObject;
  const ATime: TMediaTime);
begin
  TThread.Synchronize(Nil, procedure begin
     CameraComponent1.SampleBufferToBitmap(ImageMain.Bitmap, True);
  end);
end;

procedure TFormMain.FormCreate(Sender: TObject);
var
  I: Integer;
  Effect: TEffect;
begin
  CameraComponent1.Active := True;

  for I := 0 to ImageMain.ChildrenCount - 1 do
    begin
      if ImageMain.Children[I] is TEffect then
      begin
        Effect := ImageMain.Children[I] as TEffect;
        ListBoxEffects.Items.AddObject(Effect.Name, Effect);
        Effect.Enabled := False;
      end;
    end;
end;

procedure TFormMain.ListBoxEffectsChangeCheck(Sender: TObject);
var
  Effect: TEffect;
  Item: TListBoxItem;
begin
  if ListBoxEffects.ItemIndex > -1 then
  begin
    Item := ListBoxEffects.ListItems[ListBoxEffects.ItemIndex];
    Effect := Item.Data as TEffect;
    if Assigned(Effect) then
      Effect.Enabled := Item.IsChecked;
  end;
  MultiViewRight.HideMaster;
end;

procedure TFormMain.ShowShareSheetAction1BeforeExecute(Sender: TObject);
begin
  ShowShareSheetAction1.Bitmap.Assign(ImageMain.MakeScreenshot);
end;

end.
