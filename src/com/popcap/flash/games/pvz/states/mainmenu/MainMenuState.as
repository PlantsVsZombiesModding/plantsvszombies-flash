package com.popcap.flash.games.pvz.states.mainmenu
{
   import com.popcap.flash.framework.AppUtils;
   import com.popcap.flash.framework.graphics.Color;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.resources.fonts.FontInst;
   import com.popcap.flash.framework.resources.images.ImageData;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.resources.reanimator.Reanimation;
   import com.popcap.flash.framework.states.IState;
   import com.popcap.flash.framework.utils.Utils;
   import com.popcap.flash.framework.widgets.ui.CButtonWidget;
   import com.popcap.flash.framework.widgets.ui.CheckboxWidget;
   import com.popcap.flash.framework.widgets.ui.IButtonListener;
   import com.popcap.flash.framework.widgets.ui.ICheckboxListener;
   import com.popcap.flash.framework.widgets.ui.ImageButtonWidget;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.PVZFoleyType;
   import com.popcap.flash.games.pvz.PVZMusic;
   import com.popcap.flash.games.pvz.logic.Board;
   import com.popcap.flash.games.pvz.logic.TodCommon;
   import com.popcap.flash.games.pvz.logic.UI.DialogBox;
   import com.popcap.flash.games.pvz.resources.PVZFonts;
   import com.popcap.flash.games.pvz.resources.PVZImages;
   import com.popcap.flash.games.pvz.resources.PVZReanims;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class MainMenuState implements IState, IButtonListener, ICheckboxListener
   {
      
      private static const mScratchMatrix:Matrix = new Matrix();
       
      
      public var mShowingDialog:Boolean;
      
      private var menuReanim:Reanimation;
      
      private var mUpsellButton:CButtonWidget;
      
      private var Menu_MusicCheckBox:int = 105;
      
      private var mPuzzleButton:ImageButtonWidget;
      
      private var app:PVZApp;
      
      private var mAdventureButtonImage:ImageInst;
      
      private var mMinigameButton:ImageButtonWidget;
      
      public var mAdventureLevel:Boolean;
      
      private var mAdventureButton:ImageButtonWidget;
      
      private var GameSelector_Sound:int = 104;
      
      private var GameSelector_Adventure:int = 100;
      
      private var mStageImage:ImageInst;
      
      private var GameSelector_Puzzle:int = 102;
      
      private var GameSelector_Minigame:int = 101;
      
      private var mStartingGame:Boolean;
      
      private var mUpsellCounter:int;
      
      public var mSoundCheckBox:CheckboxWidget;
      
      private var mURLRequest:URLRequest;
      
      private var mSoundButton:ImageButtonWidget;
      
      public var mDialogBox:DialogBox;
      
      private var GameSelector_Upsell:int = 105;
      
      public var mMusicCheckBox:CheckboxWidget;
      
      private var mLevelImage:ImageInst;
      
      private var mStartingGameCounter:int;
      
      private var mStartingLevel:Number = 1;
      
      private var GameSelector_Survival:int = 103;
      
      private var zombieHandReanim:Reanimation;
      
      private var mSurvivalButton:ImageButtonWidget;
      
      private var Menu_SoundCheckBox:int = 104;
      
      private var boardImg:ImageInst;
      
      private var mAdventureButtonHighlight:ImageInst;
      
      public function MainMenuState(app:PVZApp)
      {
         super();
         this.app = app;
      }
      
      public function onPop() : void
      {
      }
      
      public function buttonMouseMove(id:Number, x:Number, y:Number) : void
      {
      }
      
      public function buttonMouseEnter(id:Number) : void
      {
         if(id != this.GameSelector_Minigame)
         {
            this.app.foleyManager.playFoley(PVZFoleyType.BLEEP);
         }
      }
      
      public function ButtonsOn() : void
      {
         this.mMusicCheckBox.disabled = false;
         this.mSoundCheckBox.disabled = false;
         this.mPuzzleButton.setDisabled(false);
         this.mMinigameButton.setDisabled(false);
         this.mSurvivalButton.setDisabled(false);
         this.mAdventureButton.setDisabled(false);
         this.mUpsellButton.setDisabled(false);
         this.mAdventureButton.setVisible(true);
         this.mPuzzleButton.setVisible(true);
         this.mMinigameButton.setVisible(true);
         this.mSurvivalButton.setVisible(true);
         this.mUpsellButton.setVisible(true);
         this.menuReanim.setTrackVisible("SelectorScreen_Survival_button",false);
         this.menuReanim.setTrackVisible("SelectorScreen_Challenges_button",false);
         this.menuReanim.setTrackVisible("SelectorScreen_ZenGarden_button",false);
         if(this.app.mLevel == 1)
         {
            this.menuReanim.setTrackVisible("SelectorScreen_StartAdventure_button",false);
         }
         else
         {
            this.menuReanim.setTrackVisible("SelectorScreen_Adventure_button",false);
         }
      }
      
      public function buttonPress(id:Number) : void
      {
      }
      
      public function onEnter() : void
      {
         this.app.mTotalZombiesKilled = 0;
         this.app.adAPI.setScore(this.app.mTotalZombiesKilled);
         this.app.registerCheat("unlockAllModes",this.unlockAllModes);
         this.mURLRequest = new URLRequest(this.app.mUpsellLink);
         this.app.mUpsellOn = AppUtils.asBoolean(this.app.getProperties().upsell.enabled,false);
         this.app.mUpsellLink = this.app.getProperties().upsell.url;
         if(this.app.musicManager.getPlayingId() != PVZMusic.CRAZY_DAVE)
         {
            this.app.musicManager.playMusic(PVZMusic.CRAZY_DAVE);
         }
         this.mShowingDialog = false;
         if(this.app.mBoard != null)
         {
            this.app.widgetManager.removeAllWidgets();
            this.app.mBoard = null;
         }
         this.initDialog();
         this.initMenuReanim();
      }
      
      public function draw(g:Graphics2D) : void
      {
         var yPos:Number = NaN;
         if(this.menuReanim != null)
         {
            this.menuReanim.drawLerp(g,mScratchMatrix,1);
         }
         if(this.zombieHandReanim != null)
         {
            this.zombieHandReanim.drawLerp(g,mScratchMatrix,1);
         }
         if(this.mUpsellButton.visible)
         {
            yPos = TodCommon.TodAnimateCurveFloat(0,50,this.mUpsellCounter,-50,110,TodCommon.CURVE_EASE_OUT);
            g.drawImage(this.app.imageManager.getImageInst(PVZImages.IMAGE_SELECTORSCREEN_WOODSIGN),17,yPos);
            this.mUpsellButton.move(17,yPos);
         }
         g.reset();
         this.app.widgetManager.drawScreen(g);
      }
      
      private function initMenuReanim() : void
      {
         var aPoint:Point = new Point(1,1);
         var buttonsOn:Boolean = true;
         if(this.menuReanim == null)
         {
            this.menuReanim = this.app.reanimator.createReanimation(PVZReanims.REANIM_SELECTORSCREEN);
            this.menuReanim.x = 0;
            this.menuReanim.y = 0;
            this.menuReanim.animRate = 20;
            this.menuReanim.loopType = Reanimation.LOOP_TYPE_ONCE_AND_HOLD;
            this.menuReanim.currentTrack = "anim_play";
            this.app.foleyManager.playFoley(PVZFoleyType.ROLL_IN);
            buttonsOn = false;
         }
         else
         {
            this.menuReanim.animTime = 1;
         }
         this.menuReanim.setTrackVisible("woodsign2",false);
         this.menuReanim.setTrackVisible("woodsign3",false);
         this.menuReanim.overrideImage("SelectorScreen_ZenGarden_button",this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_VASEBREAKER_BUTTON_LOCKED));
         if(this.app.mPuzzleLocked)
         {
            this.menuReanim.overrideImage("SelectorScreen_Challenges_button",this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_CHALLENGES_BUTTON_LOCKED));
         }
         if(this.app.mSurvivalLocked)
         {
            this.menuReanim.overrideImage("SelectorScreen_Survival_button",this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_SURVIVAL_BUTTON_LOCKED));
         }
         if(this.app.mLevel == 1)
         {
            this.menuReanim.setTrackVisible("SelectorScreen_Adventure_button",false);
            this.menuReanim.setTrackVisible("SelectorScreen_Adventure_shadow",false);
            this.mAdventureButton = new ImageButtonWidget(this.GameSelector_Adventure,this);
            this.mAdventureButton.mUpImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_STARTADVENTURE_BUTTON1);
            this.mAdventureButton.mOverImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_STARTADVENTURE_HIGHLIGHT);
            this.mAdventureButton.mDownImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_STARTADVENTURE_HIGHLIGHT);
            this.mAdventureButton.mDownOffset = aPoint;
            this.mAdventureButton.mDisabledImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_STARTADVENTURE_BUTTON1);
            this.mAdventureButton.resize(273.4,43.9,this.mAdventureButton.mUpImage.width,80);
         }
         else
         {
            this.GetLevelNumbers();
            this.menuReanim.setTrackVisible("SelectorScreen_StartAdventure_button",false);
            this.menuReanim.setTrackVisible("SelectorScreen_StartAdventure_shadow",false);
            this.mAdventureButton = new ImageButtonWidget(this.GameSelector_Adventure,this);
            this.mAdventureButtonImage = this.MakeStartAdventureButton(this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_ADVENTURE_BUTTON));
            this.mAdventureButtonHighlight = this.MakeStartAdventureButton(this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_ADVENTURE_HIGHLIGHT));
            this.mAdventureButton.mUpImage = this.mAdventureButtonImage;
            this.mAdventureButton.mOverImage = this.mAdventureButtonHighlight;
            this.mAdventureButton.mDownImage = this.mAdventureButtonHighlight;
            this.mAdventureButton.mDownOffset = aPoint;
            this.mAdventureButton.mDisabledImage = this.mAdventureButtonImage;
            this.mAdventureButton.resize(273.4,53,this.mAdventureButton.mUpImage.width,80);
            this.menuReanim.overrideImage("SelectorScreen_Adventure_button",this.mAdventureButtonImage);
         }
         this.mStartingGameCounter = 0;
         this.mStartingGame = false;
         this.mAdventureButton.doFinger = true;
         this.mAdventureButton.visible = false;
         this.mAdventureButton.setDisabled(false);
         this.app.widgetManager.addWidget(this.mAdventureButton);
         this.mSurvivalButton = new ImageButtonWidget(this.GameSelector_Minigame,this);
         this.mSurvivalButton.mUpImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_VASEBREAKER_BUTTON_LOCKED);
         this.mSurvivalButton.mOverImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_VASEBREAKER_BUTTON_LOCKED);
         this.mSurvivalButton.mDownImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_VASEBREAKER_BUTTON_LOCKED);
         this.mSurvivalButton.mDownOffset = aPoint;
         this.mSurvivalButton.mDisabledImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_VASEBREAKER_BUTTON_LOCKED);
         this.mSurvivalButton.resize(278.8,221.4,this.mSurvivalButton.mUpImage.width,50);
         this.mSurvivalButton.doFinger = true;
         this.mSurvivalButton.visible = false;
         this.mSurvivalButton.setDisabled(false);
         this.app.widgetManager.addWidget(this.mSurvivalButton);
         this.mPuzzleButton = new ImageButtonWidget(this.GameSelector_Puzzle,this);
         if(this.app.mPuzzleLocked)
         {
            this.mPuzzleButton.mUpImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_CHALLENGES_BUTTON_LOCKED);
            this.mPuzzleButton.mDownImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_CHALLENGES_BUTTON_LOCKED);
            this.mPuzzleButton.mOverImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_CHALLENGES_BUTTON_LOCKED);
            this.mPuzzleButton.mDownOffset = aPoint;
            this.mPuzzleButton.mDisabledImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_CHALLENGES_BUTTON_LOCKED);
         }
         else
         {
            this.mPuzzleButton.mUpImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_CHALLENGES_BUTTON);
            this.mPuzzleButton.mDownImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_CHALLENGES_HIGHLIGHT);
            this.mPuzzleButton.mOverImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_CHALLENGES_HIGHLIGHT);
            this.mPuzzleButton.mDownOffset = aPoint;
            this.mPuzzleButton.mDisabledImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_CHALLENGES_BUTTON);
         }
         this.mPuzzleButton.resize(276.8,171.9,this.mPuzzleButton.mUpImage.width,50);
         this.mPuzzleButton.doFinger = true;
         this.mPuzzleButton.visible = false;
         this.mPuzzleButton.setDisabled(false);
         this.app.widgetManager.addWidget(this.mPuzzleButton);
         this.mMinigameButton = new ImageButtonWidget(this.GameSelector_Survival,this);
         if(this.app.mSurvivalLocked)
         {
            this.mMinigameButton.mUpImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_SURVIVAL_BUTTON_LOCKED);
            this.mMinigameButton.mDownImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_SURVIVAL_BUTTON_LOCKED);
            this.mMinigameButton.mDownOffset = aPoint;
            this.mMinigameButton.mOverImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_SURVIVAL_BUTTON_LOCKED);
            this.mMinigameButton.mDisabledImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_SURVIVAL_BUTTON_LOCKED);
         }
         else
         {
            this.mMinigameButton.mUpImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_SURVIVAL_BUTTON);
            this.mMinigameButton.mDownImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_SURVIVAL_HIGHLIGHT);
            this.mMinigameButton.mDownOffset = aPoint;
            this.mMinigameButton.mOverImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_SURVIVAL_HIGHLIGHT);
            this.mMinigameButton.mDisabledImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_SURVIVAL_BUTTON);
         }
         this.mMinigameButton.resize(274.1,114.8,this.mMinigameButton.mUpImage.width,50);
         this.mMinigameButton.doFinger = true;
         this.mMinigameButton.visible = false;
         this.mMinigameButton.setDisabled(false);
         this.app.widgetManager.addWidget(this.mMinigameButton);
         this.mUpsellButton = new CButtonWidget(this.GameSelector_Upsell,this);
         this.mUpsellButton.setDisabled(false);
         this.mUpsellButton.visible = false;
         this.mUpsellButton.label = this.app.stringManager.translateString("[UPSELL_BUY_BUTTON]");
         this.mUpsellButton.setColor(CButtonWidget.COLOR_LABEL,Color.RGB(1,1,1));
         this.mUpsellButton.setColor(CButtonWidget.COLOR_LABEL_HILITE,Color.RGB(179 / 255,158 / 255,110 / 255));
         var font5:FontInst = this.app.fontManager.getFontInst(PVZFonts.FONT_BRIANNETOD16);
         font5.scale = 0.9;
         this.mUpsellButton.font = font5;
         this.mUpsellButton.resize(17,110,190,30);
         this.app.widgetManager.addWidget(this.mUpsellButton);
         this.initSoundCheckboxes(buttonsOn);
         if(buttonsOn)
         {
            this.ButtonsOn();
         }
      }
      
      public function ButtonsOff() : void
      {
         this.mMusicCheckBox.disabled = true;
         this.mSoundCheckBox.disabled = true;
         this.mAdventureButton.setDisabled(true);
         this.mPuzzleButton.setDisabled(true);
         this.mMinigameButton.setDisabled(true);
         this.mSurvivalButton.setDisabled(true);
         this.mSurvivalButton.setDisabled(true);
         this.mAdventureButton.setVisible(false);
         this.mPuzzleButton.setVisible(false);
         this.mMinigameButton.setVisible(false);
         this.mSurvivalButton.setVisible(false);
         this.mUpsellButton.setVisible(false);
         this.menuReanim.setTrackVisible("SelectorScreen_Survival_button",true);
         this.menuReanim.setTrackVisible("SelectorScreen_Challenges_button",true);
         this.menuReanim.setTrackVisible("SelectorScreen_ZenGarden_button",true);
         if(this.app.mLevel == 1)
         {
            this.menuReanim.setTrackVisible("SelectorScreen_StartAdventure_button",true);
         }
         else
         {
            this.menuReanim.setTrackVisible("SelectorScreen_Adventure_button",true);
         }
      }
      
      public function StartGame() : void
      {
         if(this.app.adAPI.enabled)
         {
            this.app.musicManager.resumeMusic();
            this.app.soundManager.resumeAll();
         }
         this.app.stateManager.changeState(PVZApp.STATE_LEVEL_INTRO);
      }
      
      public function checkboxChecked(id:Number, checked:Boolean) : void
      {
         switch(id)
         {
            case this.Menu_SoundCheckBox:
               if(checked)
               {
                  this.app.soundManager.unmute();
                  this.app.mSaveObject.soundOn = true;
               }
               else
               {
                  this.app.soundManager.mute();
                  this.app.mSaveObject.soundOn = false;
               }
               this.app.setSaveData(this.app.mSaveObject);
               break;
            case this.Menu_MusicCheckBox:
               if(checked)
               {
                  this.app.musicManager.unmute();
                  this.app.mSaveObject.musicOn = true;
               }
               else
               {
                  this.app.musicManager.mute();
                  this.app.mSaveObject.musicOn = false;
               }
               this.app.setSaveData(this.app.mSaveObject);
         }
      }
      
      public function unlockAllModes() : void
      {
         var aPoint:Point = null;
         if(this.app.mPuzzleLocked || this.app.mSurvivalLocked)
         {
            this.app.mPuzzleLocked = false;
            this.app.mSurvivalLocked = false;
            aPoint = new Point(1,1);
            this.mPuzzleButton.mUpImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_CHALLENGES_BUTTON);
            this.mPuzzleButton.mDownImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_CHALLENGES_HIGHLIGHT);
            this.mPuzzleButton.mOverImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_CHALLENGES_HIGHLIGHT);
            this.mPuzzleButton.mDownOffset = aPoint;
            this.mPuzzleButton.mDisabledImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_CHALLENGES_BUTTON);
            this.mMinigameButton.mUpImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_SURVIVAL_BUTTON);
            this.mMinigameButton.mDownImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_SURVIVAL_HIGHLIGHT);
            this.mMinigameButton.mDownOffset = aPoint;
            this.mMinigameButton.mOverImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_SURVIVAL_HIGHLIGHT);
            this.mMinigameButton.mDisabledImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_SURVIVAL_BUTTON);
            this.mPuzzleButton.setDisabled(false);
            this.mSurvivalButton.setDisabled(false);
         }
      }
      
      public function buttonRelease(id:Number) : void
      {
         var aDialogHeader:String = null;
         var aDialogMessage:String = null;
         var aDialogOk:String = null;
         var aDialogCancel:String = null;
         var mode:int = -1;
         var level:int = -1;
         var doStart:Boolean = false;
         var upsellXML:XML = <data>DeluxeDownload</data>;
         switch(id)
         {
            case this.GameSelector_Upsell:
               if(this.app.mUpsellOn)
               {
                  this.ButtonsOff();
                  this.app.stateManager.pushState(PVZApp.STATE_UPSELL_SCREEN);
               }
               else
               {
                  this.app.adAPI.CustomEvent(upsellXML,this.DoUpsell);
                  navigateToURL(this.mURLRequest);
               }
               break;
            case this.GameSelector_Adventure:
               this.app.foleyManager.playFoley(PVZFoleyType.GRAVEBUTTON);
               this.mStartingLevel = this.app.mLevel;
               this.app.mGameMode = PVZApp.GAMEMODE_ADVENTURE;
               this.playAdventureIntro();
               break;
            case this.GameSelector_Puzzle:
               if(this.app.mPuzzleLocked)
               {
                  this.mShowingDialog = true;
                  this.ButtonsOff();
                  this.mDialogBox.mDialogType = DialogBox.DIALOG_LOCKED;
                  aDialogHeader = this.app.stringManager.translateString("[MODE_LOCKED]");
                  aDialogMessage = this.app.stringManager.translateString("[PUZZLE_LOCKED_MESSAGE]");
                  aDialogOk = this.app.stringManager.translateString("[DIALOG_BUTTON_OK]");
                  aDialogCancel = "";
                  this.mDialogBox.visible = true;
                  this.mDialogBox.move(75,50);
                  this.mDialogBox.InitializeDialogBox(aDialogHeader,aDialogMessage,aDialogOk,aDialogCancel,4,2);
               }
               else
               {
                  this.app.foleyManager.playFoley(PVZFoleyType.GRAVEBUTTON);
                  this.app.mGameMode = PVZApp.GAMEMODE_SCARY_POTTER_ENDLESS;
                  this.mStartingLevel = 1;
                  this.gameReady();
               }
               break;
            case this.GameSelector_Survival:
               if(this.app.mSurvivalLocked)
               {
                  this.mShowingDialog = true;
                  this.ButtonsOff();
                  this.mDialogBox.mDialogType = DialogBox.DIALOG_LOCKED;
                  aDialogHeader = this.app.stringManager.translateString("[MODE_LOCKED]");
                  aDialogMessage = this.app.stringManager.translateString("[SURVIVAL_LOCKED_MESSAGE]");
                  aDialogOk = this.app.stringManager.translateString("[DIALOG_BUTTON_OK]");
                  aDialogCancel = "";
                  this.mDialogBox.visible = true;
                  this.mDialogBox.move(75,50);
                  this.mDialogBox.InitializeDialogBox(aDialogHeader,aDialogMessage,aDialogOk,aDialogCancel,4,2);
               }
               else
               {
                  this.app.foleyManager.playFoley(PVZFoleyType.GRAVEBUTTON);
                  this.app.mGameMode = PVZApp.GAMEMODE_SURVIVAL_ENDLESS_STAGE_2;
                  this.mStartingLevel = 1;
                  this.gameReady();
               }
               break;
            case this.GameSelector_Minigame:
               if(this.app.mUpsellOn)
               {
                  this.ButtonsOff();
                  this.app.stateManager.pushState(PVZApp.STATE_UPSELL_SCREEN);
               }
               else
               {
                  this.mShowingDialog = true;
                  this.ButtonsOff();
                  this.mDialogBox.mDialogType = DialogBox.DIALOG_LOCKED;
                  aDialogHeader = this.app.stringManager.translateString("[FULL_VERSION_ONLY]");
                  aDialogMessage = this.app.stringManager.translateString("[FULL_VERSION_MODE]");
                  aDialogOk = this.app.stringManager.translateString("[DIALOG_BUTTON_OK]");
                  this.mDialogBox.visible = true;
                  this.mDialogBox.move(75,50);
                  this.mDialogBox.InitializeDialogBox(aDialogHeader,aDialogMessage,aDialogOk,aDialogCancel,4,2);
               }
         }
         if(doStart)
         {
            this.app.mGameMode = mode;
         }
      }
      
      private function initDialog() : void
      {
         this.mDialogBox = new DialogBox(this.app,null);
         this.app.widgetManager.addWidget(this.mDialogBox);
         this.app.widgetManager.addWidget(this.mDialogBox.mOkButton);
         this.app.widgetManager.addWidget(this.mDialogBox.mCancelButton);
      }
      
      public function GetLevelNumbers() : void
      {
         var img:ImageInst = null;
         var theLevel:int = this.app.mLevel;
         var aArea:int = TodCommon.ClampInt((theLevel - 1) / Board.LEVELS_PER_AREA + 1,1,6);
         var aSubArea:int = theLevel - (aArea - 1) * Board.LEVELS_PER_AREA;
         this.mStageImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_SELECTORSCREEN_LEVELNUMBERS);
         this.mStageImage.frame = aArea;
         var digits:Vector.<int> = Utils.getDigits(aSubArea);
         var images:Array = new Array();
         var srcRects:Array = new Array();
         var destPoints:Array = new Array();
         var numDigits:int = int(digits.length);
         for(var i:int = 0; i < numDigits; i++)
         {
            img = this.app.imageManager.getImageInst(PVZImages.IMAGE_SELECTORSCREEN_LEVELNUMBERS);
            img.frame = digits[i];
            images[i] = img;
            srcRects[i] = new Rectangle(0,0,img.width,img.height);
            destPoints[i] = new Point(i * (-img.width + 2),numDigits - i - 1);
         }
         this.mLevelImage = Utils.createMergedImage(images,srcRects,destPoints);
      }
      
      private function playAdventureIntro() : void
      {
         this.mStartingGame = true;
         this.mAdventureButton.setDisabled(true);
         this.mPuzzleButton.setDisabled(true);
         this.mMinigameButton.setDisabled(true);
         this.mSurvivalButton.setDisabled(true);
         this.mUpsellButton.setDisabled(true);
         this.mSoundCheckBox.disabled = true;
         this.mMusicCheckBox.disabled = true;
         this.zombieHandReanim = this.app.reanimator.createReanimation(PVZReanims.REANIM_ZOMBIE_HAND);
         this.zombieHandReanim.x = -50;
         this.zombieHandReanim.y = 0;
         this.zombieHandReanim.animRate = 30;
         this.zombieHandReanim.currentTrack = "anim_play";
         this.zombieHandReanim.loopType = Reanimation.LOOP_TYPE_ONCE_AND_HOLD;
         this.app.musicManager.playMusic(PVZMusic.LOSEMUSIC);
         this.app.foleyManager.playFoley(PVZFoleyType.DIRT_RISE);
      }
      
      public function onPush() : void
      {
      }
      
      public function onExit() : void
      {
         this.zombieHandReanim = null;
         this.app.widgetManager.removeAllWidgets();
      }
      
      public function buttonDownTick(id:Number) : void
      {
      }
      
      public function update() : void
      {
         this.app.widgetManager.updateFrame();
         if(this.menuReanim != null)
         {
            this.menuReanim.update();
            if(this.menuReanim.shouldTriggerTimedEvent(0.3))
            {
               this.showMenuButtons();
            }
         }
         if(!this.mDialogBox.visible && this.mShowingDialog)
         {
            this.mShowingDialog = false;
            this.ButtonsOn();
         }
         if(this.zombieHandReanim)
         {
            this.zombieHandReanim.update();
         }
         if(this.mStartingGame)
         {
            ++this.mStartingGameCounter;
            if(this.mStartingGameCounter > 450)
            {
               this.zombieHandReanim = null;
               this.app.widgetManager.removeAllWidgets();
               this.gameReady();
            }
            if(this.mStartingGameCounter % 20 < 10)
            {
               if(this.app.mLevel == 1)
               {
                  this.mAdventureButton.mDisabledImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_STARTADVENTURE_HIGHLIGHT);
               }
               else
               {
                  this.mAdventureButton.mDisabledImage = this.mAdventureButtonHighlight;
               }
            }
            else if(this.app.mLevel == 1)
            {
               this.mAdventureButton.mDisabledImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_STARTADVENTURE_BUTTON1);
            }
            else
            {
               this.mAdventureButton.mDisabledImage = this.mAdventureButtonImage;
            }
            if(this.mStartingGameCounter == 125)
            {
               this.app.foleyManager.playFoley(PVZFoleyType.EVILLAUGH);
            }
         }
         if(this.mUpsellButton.visible && this.mUpsellCounter < 200)
         {
            ++this.mUpsellCounter;
         }
      }
      
      public function MakeStartAdventureButton(theImage:ImageInst) : ImageInst
      {
         var w:Number = theImage.width;
         var h:Number = theImage.height;
         var aBufferedImage:ImageInst = new ImageInst(new ImageData(new BitmapData(w,h,true,0)));
         var bufferG:Graphics2D = aBufferedImage.graphics;
         bufferG.drawImage(theImage,0,0);
         bufferG.drawImage(this.mStageImage,102,59);
         bufferG.drawImage(this.mLevelImage,114,61);
         return aBufferedImage;
      }
      
      private function gameReady() : void
      {
         if(this.app.adAPI.enabled)
         {
            this.app.musicManager.pauseMusic();
            this.app.soundManager.pauseAll();
         }
         this.app.adAPI.GameReady(this.app.mGameMode,this.mStartingLevel,this.StartGame);
      }
      
      public function MakeCheckBox(theImage:ImageInst) : ImageInst
      {
         var w:Number = theImage.width;
         var h:Number = theImage.height;
         var aBufferedImage:ImageInst = new ImageInst(new ImageData(new BitmapData(w,h,true,0)));
         var bufferG:Graphics2D = aBufferedImage.graphics;
         bufferG.drawImage(theImage,0,0);
         var check:ImageInst = this.app.imageManager.getImageInst(PVZImages.IMAGE_SELECTORSCREEN_SOUNDX);
         bufferG.drawImage(check,16,3);
         return aBufferedImage;
      }
      
      private function showMenuButtons() : void
      {
         this.menuReanim.overrideImage("SelectorScreen_ZenGarden_button",this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SELECTORSCREEN_VASEBREAKER_BUTTON_LOCKED));
         this.menuReanim.setTrackVisible("SelectorScreen_Survival_button",false);
         this.menuReanim.setTrackVisible("SelectorScreen_Challenges_button",false);
         this.menuReanim.setTrackVisible("SelectorScreen_ZenGarden_button",false);
         this.menuReanim.setTrackVisible("SelectorScreen_StartAdventure_button",false);
         this.menuReanim.setTrackVisible("SelectorScreen_Adventure_button",false);
         if(this.app.mLevel == 1)
         {
            this.menuReanim.setTrackVisible("SelectorScreen_Adventure_shadow",false);
         }
         else
         {
            this.menuReanim.setTrackVisible("SelectorScreen_StartAdventure_shadow",false);
         }
         this.mAdventureButton.visible = true;
         this.mSurvivalButton.visible = true;
         this.mPuzzleButton.visible = true;
         this.mMinigameButton.visible = true;
         this.mSoundCheckBox.visible = true;
         this.mMusicCheckBox.visible = true;
         this.mUpsellButton.visible = true;
      }
      
      private function initSoundCheckboxes(visible:Boolean) : void
      {
         var checkbox:ImageInst = this.app.imageManager.getImageInst(PVZImages.IMAGE_SELECTORSCREEN_SOUND2);
         var emptyCheckbox:ImageInst = this.MakeCheckBox(this.app.imageManager.getImageInst(PVZImages.IMAGE_SELECTORSCREEN_SOUND1));
         this.mSoundCheckBox = new CheckboxWidget(this.Menu_SoundCheckBox,checkbox,emptyCheckbox,this);
         this.mSoundCheckBox.resize(412,352,44,29);
         if(!this.app.soundManager.isMuted())
         {
            this.mSoundCheckBox.setChecked(true,false);
         }
         this.mSoundCheckBox.visible = visible;
         this.app.widgetManager.addWidget(this.mSoundCheckBox);
         checkbox = this.app.imageManager.getImageInst(PVZImages.IMAGE_SELECTORSCREEN_MUSIC2);
         emptyCheckbox = this.MakeCheckBox(this.app.imageManager.getImageInst(PVZImages.IMAGE_SELECTORSCREEN_MUSIC1));
         this.mMusicCheckBox = new CheckboxWidget(this.Menu_MusicCheckBox,checkbox,emptyCheckbox,this);
         this.mMusicCheckBox.resize(480,350,43,31);
         if(!this.app.musicManager.isMuted())
         {
            this.mMusicCheckBox.setChecked(true,false);
         }
         this.mMusicCheckBox.visible = visible;
         this.app.widgetManager.addWidget(this.mMusicCheckBox);
      }
      
      public function buttonMouseLeave(id:Number) : void
      {
      }
      
      public function DoUpsell() : void
      {
      }
   }
}
