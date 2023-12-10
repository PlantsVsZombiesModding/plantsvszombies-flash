package com.popcap.flash.games.pvz.logic
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.resources.fonts.FontInst;
   import com.popcap.flash.framework.resources.images.ImageData;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.widgets.CWidget;
   import com.popcap.flash.framework.widgets.ui.IButtonListener;
   import com.popcap.flash.framework.widgets.ui.ImageButtonWidget;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.PVZFoleyType;
   import com.popcap.flash.games.pvz.logic.UI.DialogBox;
   import com.popcap.flash.games.pvz.logic.UI.ToolTipWidget;
   import com.popcap.flash.games.pvz.renderables.StringRenderable;
   import com.popcap.flash.games.pvz.resources.PVZFonts;
   import com.popcap.flash.games.pvz.resources.PVZImages;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class SeedChooserScreen extends CWidget implements IButtonListener
   {
      
      public static const SEED_EXPLODE_O_NUT:int = 50;
      
      public static const SEED_PUFFSHROOM:int = 8;
      
      private static const SEED_NONE:int = -1;
      
      public static const SEED_IN_BANK:int = 1;
      
      private static const SEED_CHERRYBOMB:int = 2;
      
      private static const SEED_SQUASH:int = 4;
      
      private static const SEED_PEASHOOTER:int = 0;
      
      public static const SEED_IN_CHOOSER:int = 3;
      
      public static const SEED_FLYING_TO_CHOOSER:int = 2;
      
      private static const SEED_CHOMPER:int = 6;
      
      public static const SEED_SUNSHROOM:int = 9;
      
      private static const SEED_REPEATER:int = 7;
      
      public static const NUM_SEEDS_IN_CHOOSER:int = 14;
      
      public static const CHOOSE_ENTER:int = 1;
      
      private static const SEED_WALLNUT:int = 3;
      
      public static const SEED_FUMESHROOM:int = 10;
      
      public static const CHOOSE_NORMAL:int = 0;
      
      public static const SEED_FLYING_TO_BANK:int = 0;
      
      public static const CHOOSE_LEAVE:int = 2;
      
      public static const SEED_LEFTPEATER:int = 49;
      
      public static const SEED_PACKET_HIDDEN:int = 4;
      
      public static const SEED_GRAVEBUSTER:int = 11;
      
      private static const SEED_SUNFLOWER:int = 1;
      
      private static const SEED_SNOWPEA:int = 5;
      
      public static const CHOOSE_VIEW_LAWN:int = 3;
       
      
      public var mStartButton:ImageButtonWidget;
      
      public var mChooseState:int;
      
      private var mButtonImage:ImageInst;
      
      public var mSeedsInBank:int;
      
      private var mUpsellText:StringRenderable;
      
      public var Options_Menu:int = 100;
      
      public var app:PVZApp;
      
      public var mChosenSeeds:Array;
      
      private var mSeedPacket:Array;
      
      public var mLawnViewButton:ImageButtonWidget;
      
      public var mToolTip:ToolTipWidget;
      
      public var mMenuButton:ImageButtonWidget;
      
      public var mToolTipSeed:int;
      
      public var mSeedsInFlight:int;
      
      public var mViewLawnTime:int;
      
      private var mPacketSilhouette:ImageInst;
      
      public var mLastMouseX:int;
      
      public var mLastMouseY:int;
      
      public var mNumSeedsToChoose:int;
      
      public var mSeedChooserAge:int;
      
      public var Start_Game:int = 102;
      
      public var Lawn_View:int = 101;
      
      public var mBoard:Board;
      
      private var mBackground:ImageInst;
      
      public var mDialogBox:DialogBox;
      
      public function SeedChooserScreen(app:PVZApp, theBoard:Board)
      {
         var i:int = 0;
         var aChosenSeed:ChosenSeed = null;
         var aPoint:Point = null;
         var aSeedPacket:SeedPacket = null;
         var aSeedType:int = 0;
         this.mChosenSeeds = new Array();
         this.mSeedPacket = new Array();
         super();
         x = 0;
         y = 0;
         width = 460;
         height = 405;
         this.app = app;
         this.mBoard = theBoard;
         this.mSeedsInFlight = 0;
         this.mSeedsInBank = 0;
         this.mLastMouseX = -1;
         this.mLastMouseY = -1;
         this.mViewLawnTime = 0;
         this.mToolTip = new ToolTipWidget(app,theBoard);
         var font:FontInst = app.fontManager.getFontInst(PVZFonts.FONT_DWARVENTODCRAFT18YELLOW);
         font.scale = 0.7;
         var anImage:ImageInst = app.imageManager.getImageInst(PVZImages.IMAGE_SEEDCHOOSER_BUTTON);
         var aString:String = app.stringManager.translateString("[LETS_ROCK_BUTTON]");
         this.mStartButton = new ImageButtonWidget(this.Start_Game,this);
         this.mStartButton.mUpImage = this.MakeButton(anImage,font,aString);
         font.setColor(1,1.5,1.5,1.5);
         var aGlowImage:ImageInst = app.imageManager.getImageInst(PVZImages.IMAGE_SEEDCHOOSER_BUTTON_GLOW);
         this.mStartButton.mDownImage = this.MakeGlowButton(anImage,aGlowImage,font,aString);
         this.mStartButton.mDownOffset = new Point(1,1);
         this.mStartButton.mOverImage = this.MakeGlowButton(anImage,aGlowImage,font,aString);
         anImage = app.imageManager.getImageInst(PVZImages.IMAGE_SEEDCHOOSER_BUTTON_DISABLED);
         font.setColor(1,64 / 255,64 / 255,64 / 255);
         this.mStartButton.mDisabledImage = this.MakeButton(anImage,font,aString);
         this.mStartButton.visible = true;
         this.mStartButton.resize(115,715,105,28);
         this.EnableStartButton(false);
         this.mLawnViewButton = new ImageButtonWidget(this.Lawn_View,this);
         anImage = app.imageManager.getImageInst(PVZImages.IMAGE_SEEDCHOOSER_BUTTON2);
         aString = app.stringManager.translateString("[VIEW_LAWN]");
         font = app.fontManager.getFontInst(PVZFonts.FONT_BRIANNETOD16);
         font.scale = 0.6;
         font.setColor(1,42 / 255,42 / 255,90 / 255);
         this.mLawnViewButton.mUpImage = this.MakeButton(anImage,font,aString);
         aGlowImage = app.imageManager.getImageInst(PVZImages.IMAGE_SEEDCHOOSER_BUTTON2_GLOW);
         this.mLawnViewButton.mDownImage = this.MakeGlowButton(anImage,aGlowImage,font,aString);
         this.mLawnViewButton.mDownOffset = new Point(1,1);
         this.mLawnViewButton.mOverImage = this.MakeGlowButton(anImage,aGlowImage,font,aString);
         this.mLawnViewButton.mDisabledImage = this.MakeButton(anImage,font,aString);
         this.mLawnViewButton.visible = true;
         this.mLawnViewButton.resize(20,720,75,18);
         if(app.IsAdventureMode() || this.mBoard.mChallenge.mSurvivalStage == 0)
         {
            this.mLawnViewButton.visible = false;
            this.mLawnViewButton.setDisabled(true);
         }
         for(i = 0; i < 12; i++)
         {
            aChosenSeed = new ChosenSeed();
            aPoint = new Point();
            this.GetSeedPositionInChooser(i,aPoint);
            aChosenSeed.mX = aPoint.x;
            aChosenSeed.mY = aPoint.y;
            aChosenSeed.mSeedType = i;
            aChosenSeed.mTimeStartMotion = 0;
            aChosenSeed.mTimeEndMotion = 0;
            aChosenSeed.mStartX = aChosenSeed.mX;
            aChosenSeed.mStartY = aChosenSeed.mY;
            aChosenSeed.mEndX = aChosenSeed.mX;
            aChosenSeed.mEndY = aChosenSeed.mY;
            aChosenSeed.mSeedState = SEED_IN_CHOOSER;
            aChosenSeed.mSeedIndexInBank = 0;
            aChosenSeed.mRefreshCounter = 0;
            aChosenSeed.mRefreshing = false;
            aChosenSeed.mCrazyDavePicked = false;
            this.mChosenSeeds[i] = aChosenSeed;
         }
         if(app.IsSurvivalMode() && this.mBoard.mChallenge.mSurvivalStage > 0 && this.mBoard.mGameScene == Board.SCENE_LEVEL_INTRO)
         {
            for(i = 0; i < this.mBoard.mSeedBank.mNumPackets; i++)
            {
               aSeedPacket = this.mBoard.mSeedBank.mSeedPackets[i];
               aSeedType = aSeedPacket.mPacketType;
               aChosenSeed = this.mChosenSeeds[aSeedType];
               aChosenSeed.mRefreshing = aSeedPacket.mRefreshing;
               aChosenSeed.mRefreshCounter = aSeedPacket.mRefreshCounter;
            }
            for(i = 0; i < 6; i++)
            {
               aSeedPacket = this.mBoard.mSeedBank.mSeedPackets[i];
               aSeedPacket.mX = this.mBoard.GetSeedPacketPositionX(i);
               aSeedPacket.mPacketType = SEED_NONE;
            }
            this.mBoard.mSeedBank.mNumPackets = 4;
         }
         this.mBackground = app.imageManager.getImageInst(PVZImages.IMAGE_SEEDCHOOSER_BACKGROUND);
         this.mButtonImage = app.imageManager.getImageInst(PVZImages.IMAGE_SEEDCHOOSER_BUTTON);
         this.mPacketSilhouette = app.imageManager.getImageInst(PVZImages.IMAGE_SEEDPACKETSILHOUETTE);
         this.mUpsellText = new StringRenderable(0);
         this.mUpsellText.setBounds(27,240,270,130);
         var upsellString:String = app.stringManager.translateString("[SEEDCHOOSER_UPSELL_MESSAGE]");
         font = app.fontManager.getFontInst(PVZFonts.FONT_DWARVENTODCRAFT18YELLOW);
         font.setColor(1,1,1,1);
         font.scale = 1.2;
         this.mUpsellText.font = font;
         this.mUpsellText.text = upsellString;
         this.mDialogBox = new DialogBox(app,this.mBoard);
         this.mDialogBox.setVisible(false);
      }
      
      public function buttonMouseEnter(id:Number) : void
      {
      }
      
      public function ShowToolTip() : void
      {
         if(this.mChooseState != CHOOSE_NORMAL)
         {
            this.RemoveToolTip();
            return;
         }
         if(this.mSeedsInFlight > 0)
         {
            return;
         }
         var aSeedType:int = this.SeedHitTest(this.mLastMouseX,this.mLastMouseY);
         if(aSeedType == SEED_NONE)
         {
            this.RemoveToolTip();
            return;
         }
         if(aSeedType == this.mToolTipSeed)
         {
            return;
         }
         this.RemoveToolTip();
         var aChosenSeed:ChosenSeed = this.mChosenSeeds[aSeedType];
         this.mToolTip.SetWarningText("");
         this.mToolTip.SetTitle(this.mBoard.GetSeedName(aSeedType));
         this.mToolTip.SetLabel(this.mBoard.GetSeedToolTip(aSeedType));
         var aPoint:Point = new Point();
         if(aChosenSeed.mSeedState == SEED_IN_BANK)
         {
            this.GetSeedPositionInBank(aChosenSeed.mSeedIndexInBank,aPoint);
         }
         else
         {
            this.GetSeedPositionInChooser(aSeedType,aPoint);
         }
         var aPosX:int = aPoint.x + (50 - this.mToolTip.mWidth) / 2;
         aPosX = TodCommon.ClampInt(aPosX,0,Board.BOARD_WIDTH - this.mToolTip.mWidth);
         this.mToolTip.mX = aPosX;
         this.mToolTip.mY = aPoint.y + 70;
         this.mToolTip.mVisible = true;
         this.mToolTipSeed = aSeedType;
      }
      
      public function buttonMouseMove(id:Number, x:Number, y:Number) : void
      {
      }
      
      public function EnableStartButton(theEnabled:Boolean) : void
      {
         this.mStartButton.setDisabled(!theEnabled);
      }
      
      public function LandFlyingSeed(theChosenSeed:ChosenSeed) : void
      {
         if(theChosenSeed.mSeedState == SEED_FLYING_TO_BANK)
         {
            theChosenSeed.mTimeStartMotion = 0;
            theChosenSeed.mTimeEndMotion = 0;
            theChosenSeed.mSeedState = SEED_IN_BANK;
            theChosenSeed.mX = theChosenSeed.mEndX;
            theChosenSeed.mY = theChosenSeed.mEndY;
            --this.mSeedsInFlight;
         }
         else if(theChosenSeed.mSeedState == SEED_FLYING_TO_CHOOSER)
         {
            theChosenSeed.mTimeStartMotion = 0;
            theChosenSeed.mTimeEndMotion = 0;
            theChosenSeed.mSeedState = SEED_IN_CHOOSER;
            theChosenSeed.mX = theChosenSeed.mEndX;
            theChosenSeed.mY = theChosenSeed.mEndY;
            --this.mSeedsInFlight;
         }
      }
      
      public function CloseSeedChooser() : void
      {
         var aSeedType:int = 0;
         var aChosenSeed:ChosenSeed = null;
         var aSeedPacket:SeedPacket = null;
         this.mBoard.mSeedBank.mVisible = true;
         for(var i:int = 0; i < this.mBoard.mSeedBank.mNumPackets; i++)
         {
            aSeedType = this.FindSeedInBank(i);
            aChosenSeed = this.mChosenSeeds[aSeedType];
            aSeedPacket = this.mBoard.mSeedBank.mSeedPackets[i];
            aSeedPacket.mPacketType = aSeedType;
            aSeedPacket.mUpdateImage = true;
            aSeedPacket.mVisible = true;
            if(aChosenSeed != null)
            {
               if(aChosenSeed.mRefreshing)
               {
                  aSeedPacket.mRefreshCounter = this.mChosenSeeds[aSeedType].mRefreshCounter;
                  aSeedPacket.mRefreshTime = aSeedPacket.GetRefreshTime(aSeedPacket.mPacketType);
                  aSeedPacket.mRefreshing = true;
                  aSeedPacket.mActive = false;
                  aSeedPacket.mUpdateImage = true;
                  aSeedPacket.mVisible = true;
               }
               else
               {
                  aSeedPacket.mRefreshCounter = 0;
                  aSeedPacket.mRefreshTime = 0;
                  aSeedPacket.mRefreshing = false;
                  aSeedPacket.mActive = true;
               }
            }
            if(aSeedPacket.GetRefreshTime(aSeedPacket.mPacketType) == 3000)
            {
               aSeedPacket.mRefreshCounter = this.mChosenSeeds[aSeedType].mRefreshCounter;
               aSeedPacket.mRefreshing = true;
               aSeedPacket.mRefreshTime = 2000;
               aSeedPacket.mActive = false;
            }
            else if(aSeedPacket.GetRefreshTime(aSeedPacket.mPacketType) == 5000)
            {
               aSeedPacket.mRefreshCounter = this.mChosenSeeds[aSeedType].mRefreshCounter;
               aSeedPacket.mRefreshing = true;
               aSeedPacket.mRefreshTime = 5000;
               aSeedPacket.mActive = false;
            }
         }
      }
      
      public function ClickedSeedInChooser(theChosenSeed:ChosenSeed) : void
      {
         if(this.mSeedsInBank == this.mBoard.mSeedBank.mNumPackets)
         {
            return;
         }
         theChosenSeed.mTimeStartMotion = this.mSeedChooserAge;
         theChosenSeed.mTimeEndMotion = this.mSeedChooserAge + 25;
         theChosenSeed.mStartX = theChosenSeed.mX;
         theChosenSeed.mStartY = theChosenSeed.mY;
         var aPoint:Point = new Point();
         aPoint.x = theChosenSeed.mEndX;
         aPoint.y = theChosenSeed.mEndY;
         this.GetSeedPositionInBank(this.mSeedsInBank,aPoint);
         theChosenSeed.mEndX = aPoint.x;
         theChosenSeed.mEndY = aPoint.y;
         theChosenSeed.mSeedState = SEED_FLYING_TO_BANK;
         theChosenSeed.mSeedIndexInBank = this.mSeedsInBank;
         ++this.mSeedsInFlight;
         ++this.mSeedsInBank;
         this.RemoveToolTip();
         this.app.foleyManager.playFoley(PVZFoleyType.DROP);
         if(this.mSeedsInBank == this.mBoard.mSeedBank.mNumPackets)
         {
            this.EnableStartButton(true);
         }
      }
      
      public function SeedNotAllowedToPick(theSeedType:int) : Boolean
      {
         return false;
      }
      
      public function PickedPlantType(theSeedType:int) : Boolean
      {
         var chosenSeed:ChosenSeed = null;
         for(var i:int = 0; i < NUM_SEEDS_IN_CHOOSER; i++)
         {
            chosenSeed = this.mChosenSeeds[i];
            if(chosenSeed != null)
            {
               if(chosenSeed.mSeedState == SEED_IN_BANK)
               {
                  if(chosenSeed.mSeedType == theSeedType)
                  {
                     return true;
                  }
               }
            }
         }
         return false;
      }
      
      public function GetSeedPositionInChooser(theIndex:int, thePoint:Point) : void
      {
         var aRow:int = theIndex / 6;
         var aCol:int = theIndex % 6;
         thePoint.x = 12 + aCol * 50;
         thePoint.y = 110 + aRow * 65;
      }
      
      public function buttonPress(id:Number) : void
      {
      }
      
      public function KillDialogBox() : void
      {
         this.mDialogBox.setVisible(false);
         this.mDialogBox.KillButtons();
         this.mLawnViewButton.setDisabled(false);
         this.mStartButton.setDisabled(false);
      }
      
      public function OnStartButton() : void
      {
         if(this.app.IsAdventureMode && this.mBoard.mLevel == 11 && !this.PickedPlantType(SEED_PUFFSHROOM))
         {
            this.DisplayRepickWarningDialog("[SEED_CHOOSER_PUFFSHROOM_WARNING]");
         }
         else if(!this.PickedPlantType(SEED_SUNFLOWER) && !this.PickedPlantType(SEED_SUNSHROOM) && this.app.IsAdventureMode())
         {
            if(this.mBoard.mLevel == 11)
            {
               this.DisplayRepickWarningDialog("[SEED_CHOOSER_NIGHT_SUN_WARNING]");
            }
            else
            {
               this.DisplayRepickWarningDialog("[SEED_CHOOSER_SUN_WARNING]");
            }
         }
         else
         {
            this.mChooseState = CHOOSE_LEAVE;
            this.CloseSeedChooser();
         }
      }
      
      public function RemoveToolTip() : void
      {
         this.mToolTip.mVisible = false;
         this.mToolTipSeed = SEED_NONE;
      }
      
      public function ClickedSeedInBank(theChosenSeed:ChosenSeed) : void
      {
         var aSeedIndex:int = 0;
         var aMoveSeed:ChosenSeed = null;
         var aPoint:Point = new Point();
         for(var i:int = theChosenSeed.mSeedIndexInBank + 1; i < this.mBoard.mSeedBank.mNumPackets; i++)
         {
            if(this.mBoard.mSeedBank.mSeedPackets[i].mPacketType != SEED_NONE)
            {
               this.mBoard.mSeedBank.mSeedPackets[i].mVisible = false;
            }
            aSeedIndex = this.FindSeedInBank(i);
            if(aSeedIndex != SEED_NONE)
            {
               aMoveSeed = this.mChosenSeeds[aSeedIndex];
               aMoveSeed.mTimeStartMotion = this.mSeedChooserAge;
               aMoveSeed.mTimeEndMotion = this.mSeedChooserAge + 15;
               aMoveSeed.mStartX = aMoveSeed.mX;
               aMoveSeed.mStartY = aMoveSeed.mY;
               aPoint.x = aMoveSeed.mEndX;
               aPoint.y = aMoveSeed.mEndY;
               this.GetSeedPositionInBank(i - 1,aPoint);
               aMoveSeed.mEndX = aPoint.x;
               aMoveSeed.mEndY = aPoint.y;
               aMoveSeed.mSeedState = SEED_FLYING_TO_BANK;
               aMoveSeed.mSeedIndexInBank = i - 1;
               ++this.mSeedsInFlight;
            }
         }
         i = theChosenSeed.mSeedIndexInBank;
         if(this.mBoard.mSeedBank.mSeedPackets[i].mPacketType != SEED_NONE)
         {
            this.mBoard.mSeedBank.mSeedPackets[i].mVisible = false;
         }
         theChosenSeed.mTimeStartMotion = this.mSeedChooserAge;
         theChosenSeed.mTimeEndMotion = this.mSeedChooserAge + 25;
         theChosenSeed.mStartX = theChosenSeed.mX;
         theChosenSeed.mStartY = theChosenSeed.mY;
         aPoint.x = theChosenSeed.mEndX;
         aPoint.y = theChosenSeed.mEndY;
         this.GetSeedPositionInChooser(theChosenSeed.mSeedType,aPoint);
         theChosenSeed.mEndX = aPoint.x;
         theChosenSeed.mEndY = aPoint.y;
         theChosenSeed.mSeedState = SEED_FLYING_TO_CHOOSER;
         theChosenSeed.mSeedIndexInBank = 0;
         ++this.mSeedsInFlight;
         --this.mSeedsInBank;
         this.EnableStartButton(false);
         this.app.foleyManager.playFoley(PVZFoleyType.DROP);
      }
      
      public function UpdateCursor() : void
      {
         var aShowFinger:Boolean = false;
         var aChosenSeed:ChosenSeed = null;
         var aHitSeedType:int = this.SeedHitTest(this.mLastMouseX,this.mLastMouseY);
         if(aHitSeedType != SEED_NONE)
         {
            aChosenSeed = this.mChosenSeeds[aHitSeedType];
            if(aChosenSeed.mSeedState == SEED_IN_BANK && aChosenSeed.mCrazyDavePicked)
            {
               aHitSeedType = SEED_NONE;
            }
         }
         if(this.mChooseState == CHOOSE_VIEW_LAWN)
         {
            aShowFinger = false;
         }
         else if(aHitSeedType != SEED_NONE)
         {
            if(this.SeedNotAllowedToPick(aHitSeedType))
            {
               aShowFinger = false;
            }
            else
            {
               aShowFinger = true;
            }
         }
         else
         {
            aShowFinger = false;
         }
         showFinger(aShowFinger);
      }
      
      override public function onMouseDown(x:Number, y:Number) : void
      {
         var i:int = 0;
         var aChosenSeed:ChosenSeed = null;
         if(this.mSeedsInFlight > 0)
         {
            for(i = 0; i < NUM_SEEDS_IN_CHOOSER; i++)
            {
               aChosenSeed = this.mChosenSeeds[i];
               if(aChosenSeed != null)
               {
                  this.LandFlyingSeed(aChosenSeed);
               }
            }
         }
         var aSeedType:int = this.SeedHitTest(x,y);
         if(aSeedType == SEED_NONE)
         {
            return;
         }
         aChosenSeed = this.mChosenSeeds[aSeedType];
         if(aChosenSeed.mSeedState == SEED_IN_BANK && aChosenSeed.mCrazyDavePicked)
         {
            return;
         }
         if(aChosenSeed.mSeedState == SEED_IN_BANK)
         {
            this.ClickedSeedInBank(aChosenSeed);
         }
         else if(aChosenSeed.mSeedState == SEED_IN_CHOOSER)
         {
            this.ClickedSeedInChooser(aChosenSeed);
         }
      }
      
      override public function update() : void
      {
         var aChosenSeed:ChosenSeed = null;
         this.mLastMouseX = this.app.widgetManager.lastMouseX;
         this.mLastMouseY = this.app.widgetManager.lastMouseY;
         ++this.mSeedChooserAge;
         this.mToolTip.Update();
         for(var i:int = 0; i < NUM_SEEDS_IN_CHOOSER; i++)
         {
            if(this.HasSeedType(i))
            {
               aChosenSeed = this.mChosenSeeds[i];
               if(aChosenSeed.mSeedState == SEED_FLYING_TO_BANK || aChosenSeed.mSeedState == SEED_FLYING_TO_CHOOSER)
               {
                  aChosenSeed.mX = TodCommon.TodAnimateCurve(aChosenSeed.mTimeStartMotion,aChosenSeed.mTimeEndMotion,this.mSeedChooserAge,aChosenSeed.mStartX,aChosenSeed.mEndX,TodCommon.CURVE_EASE_IN_OUT);
                  aChosenSeed.mY = TodCommon.TodAnimateCurve(aChosenSeed.mTimeStartMotion,aChosenSeed.mTimeEndMotion,this.mSeedChooserAge,aChosenSeed.mStartY,aChosenSeed.mEndY,TodCommon.CURVE_EASE_IN_OUT);
               }
               if(aChosenSeed.mSeedState == SEED_FLYING_TO_BANK && this.mSeedChooserAge >= aChosenSeed.mTimeEndMotion)
               {
                  this.LandFlyingSeed(aChosenSeed);
               }
               if(aChosenSeed.mSeedState == SEED_FLYING_TO_CHOOSER && this.mSeedChooserAge >= aChosenSeed.mTimeEndMotion)
               {
                  this.LandFlyingSeed(aChosenSeed);
               }
            }
         }
         this.ShowToolTip();
         this.UpdateCursor();
         markDirty();
      }
      
      public function FindSeedInBank(theIndexInBank:int) : int
      {
         var aChosenSeed:ChosenSeed = null;
         for(var i:int = 0; i < NUM_SEEDS_IN_CHOOSER; i++)
         {
            if(this.HasSeedType(i))
            {
               aChosenSeed = this.mChosenSeeds[i];
               if(aChosenSeed.mSeedState == SEED_IN_BANK && aChosenSeed.mSeedIndexInBank == theIndexInBank)
               {
                  return i;
               }
            }
         }
         return SEED_NONE;
      }
      
      public function buttonDownTick(id:Number) : void
      {
      }
      
      public function MakeGlowButton(theImage:ImageInst, theGlowImage:ImageInst, theFont:FontInst, theText:String) : ImageInst
      {
         var w:Number = theImage.width;
         var h:Number = theImage.height;
         var aBufferedImage:ImageInst = new ImageInst(new ImageData(new BitmapData(w,h,true,0)));
         var bufferG:Graphics2D = aBufferedImage.graphics;
         bufferG.drawImage(theImage,0,0);
         bufferG.drawImage(theGlowImage,0,0);
         while(theFont.stringImageWidth(theText) > theImage.width)
         {
            theFont.scale -= 0.1;
         }
         bufferG.setFont(theFont);
         var offsetX:Number = (theImage.width - theFont.stringImageWidth(theText)) / 2;
         var offsetY:Number = (theImage.height - theFont.getHeight()) / 2;
         bufferG.drawString(theText,offsetX,offsetY);
         return aBufferedImage;
      }
      
      override public function draw(g:Graphics2D) : void
      {
         var aPoint:Point = null;
         var x:int = 0;
         var y:int = 0;
         var aSeedType:int = 0;
         var aChosenSeed:ChosenSeed = null;
         var upsellImage:ImageInst = null;
         if(!this.mBoard.ChooseSeedsOnCurrentLevel())
         {
            return;
         }
         g.drawImage(this.mBackground,0,78);
         var font:FontInst = this.app.fontManager.getFontInst(PVZFonts.FONT_DWARVENTODCRAFT18YELLOW);
         font.setColor(1,1,1,1);
         font.scale = 0.8;
         g.pushState();
         g.setFont(font);
         g.drawString(this.app.stringManager.translateString("[CHOOSE_YOUR_PLANTS]"),55,82);
         g.popState();
         var aSeedPlaces:int = 24;
         for(var i:int = 0; i < aSeedPlaces; i++)
         {
            aPoint = new Point();
            this.GetSeedPositionInChooser(i,aPoint);
            x = aPoint.x;
            y = aPoint.y;
            aSeedType = i;
            if(this.HasSeedType(aSeedType))
            {
               aChosenSeed = this.mChosenSeeds[i];
               if(aChosenSeed.mSeedState != SEED_IN_CHOOSER)
               {
                  if(this.mSeedPacket[i] == null)
                  {
                     this.DrawSeedPacket(g,i);
                  }
                  this.mSeedPacket[i].useColor = true;
                  this.mSeedPacket[i].setColor(1,0.25,0.25,0.25);
                  g.drawImage(this.mSeedPacket[i],x,y);
               }
            }
            else
            {
               g.drawImage(this.mPacketSilhouette,x,y);
            }
         }
         var aNumPlacesInBank:int = this.mBoard.mSeedBank.mNumPackets;
         for(i = 0; i < aNumPlacesInBank; i++)
         {
            if(this.FindSeedInBank(i) == SEED_NONE)
            {
               this.GetSeedPositionInBank(i,aPoint);
               g.drawImage(this.mPacketSilhouette,aPoint.x,aPoint.y);
            }
         }
         for(i = 0; i < NUM_SEEDS_IN_CHOOSER; i++)
         {
            if(this.HasSeedType(i))
            {
               aChosenSeed = this.mChosenSeeds[i];
               if(!(aChosenSeed.mSeedState == SEED_FLYING_TO_CHOOSER || aChosenSeed.mSeedState == SEED_FLYING_TO_BANK || aChosenSeed.mSeedState == SEED_PACKET_HIDDEN))
               {
                  x = aChosenSeed.mX;
                  y = aChosenSeed.mY;
                  if(aChosenSeed.mSeedState == SEED_IN_BANK)
                  {
                     x -= this.x;
                     y -= this.y;
                  }
                  if(this.mSeedPacket[i] == null)
                  {
                     this.DrawSeedPacket(g,i);
                  }
                  this.mSeedPacket[i].useColor = true;
                  this.mSeedPacket[i].setColor(1,1,1,1);
                  g.drawImage(this.mSeedPacket[i],x,y);
               }
            }
         }
         for(i = 0; i < NUM_SEEDS_IN_CHOOSER; i++)
         {
            if(this.HasSeedType(i))
            {
               aChosenSeed = this.mChosenSeeds[i];
               if(!(aChosenSeed.mSeedState != SEED_FLYING_TO_CHOOSER && aChosenSeed.mSeedState != SEED_FLYING_TO_BANK))
               {
                  this.mSeedPacket[i].useColor = true;
                  this.mSeedPacket[i].setColor(1,1,1,1);
                  g.drawImage(this.mSeedPacket[i],aChosenSeed.mX,aChosenSeed.mY);
               }
            }
         }
         if(this.mBoard.mLevel > 12 || this.app.IsSurvivalMode())
         {
            upsellImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_SEEDCHOOSER_UPSELL);
            g.drawImage(upsellImage,15,242);
            this.mUpsellText.draw(g);
         }
         this.mToolTip.Draw(g);
      }
      
      private function DrawSeedPacket(g:Graphics2D, theType:int) : void
      {
         var aSeedBackImg:ImageInst = null;
         var aPlantImg:ImageInst = null;
         aSeedBackImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_SEEDBACK);
         var w:Number = aSeedBackImg.width;
         var h:Number = aSeedBackImg.height;
         this.mSeedPacket[theType] = new ImageInst(new ImageData(new BitmapData(w,h,true,0)));
         var bufferG:Graphics2D = this.mSeedPacket[theType].graphics;
         bufferG.drawImage(aSeedBackImg,0,0);
         var aOffsetX:Number = 5;
         var aOffsetY:Number = 10;
         var aScale:Number = 0.75;
         switch(theType)
         {
            case SEED_PEASHOOTER:
               aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_PEASHOOTERSINGLE);
               aOffsetY += 4;
               break;
            case SEED_SUNFLOWER:
               aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_SUNFLOWER);
               aOffsetY += 1;
               aOffsetX += 2;
               break;
            case SEED_CHERRYBOMB:
               aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_CHERRYBOMB);
               aOffsetY += 3;
               aOffsetX += -1;
               break;
            case SEED_SQUASH:
               aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_SQUASH);
               aOffsetX += 0;
               aOffsetY += -2;
               break;
            case SEED_CHOMPER:
               aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_CHOMPER);
               aOffsetX += -2;
               aOffsetY += -3;
               aScale = 0.6;
               break;
            case SEED_SNOWPEA:
               aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_SNOWPEA);
               aOffsetY += 3;
               break;
            case SEED_REPEATER:
               aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_PEASHOOTER);
               aOffsetY += 5;
               break;
            case SEED_PUFFSHROOM:
               aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_PUFFSHROOM);
               aOffsetY += 10;
               aOffsetX += 7;
               break;
            case SEED_SUNSHROOM:
               aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_SUNSHROOM);
               aOffsetY += 10;
               aOffsetX += 7;
               break;
            case SEED_GRAVEBUSTER:
               aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_GRAVEDIGGER);
               aOffsetY += 0;
               aOffsetX += -3;
               aScale = 0.6;
               break;
            case SEED_FUMESHROOM:
               aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_FUMESHROOM);
               aOffsetY += 1;
               aScale = 0.65;
               break;
            case SEED_WALLNUT:
               aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_WALLNUT);
               aOffsetX += 3;
         }
         bufferG.pushState();
         bufferG.scale(aScale,aScale);
         bufferG.drawImage(aPlantImg,aOffsetX,aOffsetY);
         bufferG.popState();
         var aCost:int = this.mBoard.GetCurrentPlantCost(theType);
         var aSeedPacketFont:FontInst = this.app.fontManager.getFontInst(PVZFonts.FONT_PICO129);
         aSeedPacketFont.setColor(1,0,0,0);
         var width:int = aSeedPacketFont.stringWidth(String(aCost));
         var height:int = aSeedPacketFont.getAscent();
         var aTextOffsetX:int = 30 - width;
         var aTextOffsetY:int = 40 + height;
         bufferG.setFont(aSeedPacketFont);
         bufferG.drawString(String(aCost),aTextOffsetX,aTextOffsetY);
      }
      
      public function buttonMouseLeave(id:Number) : void
      {
      }
      
      public function HasSeedType(theType:int) : Boolean
      {
         var aArea:int = (this.app.mLevel - 1) / 10 + 1;
         var aSubArea:int = (this.app.mLevel - 1) % 10 + 1;
         var aSeeds:int = (aArea - 1) * 8 + aSubArea;
         if(aSubArea >= 10)
         {
            aSeeds -= 2;
         }
         else if(aSubArea >= 5)
         {
            aSeeds--;
         }
         if(aSeeds > 40)
         {
            aSeeds = 40;
         }
         if(!this.app.IsAdventureMode())
         {
            aSeeds = 12;
         }
         var theSeedType:int = Math.min(12,aSeeds);
         if(theType >= theSeedType)
         {
            return false;
         }
         return true;
      }
      
      public function MakeButton(theImage:ImageInst, theFont:FontInst, theText:String) : ImageInst
      {
         var w:Number = theImage.width;
         var h:Number = theImage.height;
         var aBufferedImage:ImageInst = new ImageInst(new ImageData(new BitmapData(w,h,true,0)));
         var bufferG:Graphics2D = aBufferedImage.graphics;
         bufferG.drawImage(theImage,0,0);
         while(theFont.stringImageWidth(theText) > theImage.width)
         {
            theFont.scale -= 0.1;
         }
         bufferG.setFont(theFont);
         var offsetX:Number = (theImage.width - theFont.stringImageWidth(theText)) / 2;
         var offsetY:Number = (theImage.height - theFont.getHeight()) / 2;
         bufferG.drawString(theText,offsetX,offsetY);
         return aBufferedImage;
      }
      
      public function DisplayRepickWarningDialog(theMessage:String) : void
      {
         var aDialogHeader:String = this.app.stringManager.translateString("[DIALOG_WARNING]");
         var aDialogMessage:String = this.app.stringManager.translateString(theMessage);
         var aDialogOk:String = this.app.stringManager.translateString("[DIALOG_BUTTON_YES]");
         var aDialogCancel:String = this.app.stringManager.translateString("[REPICK_BUTTON]");
         this.mDialogBox.resize(255 - 63 * 2,130 - 36 * 2,153 + 63 * 2,184 + 36 * 2);
         this.mDialogBox.InitializeDialogBox(aDialogHeader,aDialogMessage,aDialogOk,aDialogCancel,2,2);
         this.mDialogBox.mDialogType = DialogBox.DIALOG_REPICK;
         this.mDialogBox.setVisible(true);
         this.mDialogBox.mOkButton.setVisible(true);
         this.mDialogBox.mCancelButton.setVisible(true);
         this.mLawnViewButton.setDisabled(true);
         this.mStartButton.setDisabled(true);
      }
      
      public function SeedHitTest(x:int, y:int) : int
      {
         var aChosenSeed:ChosenSeed = null;
         for(var i:int = 0; i < NUM_SEEDS_IN_CHOOSER; i++)
         {
            if(this.HasSeedType(i))
            {
               aChosenSeed = this.mChosenSeeds[i];
               if(aChosenSeed.mSeedState != SEED_PACKET_HIDDEN)
               {
                  if(x >= aChosenSeed.mX && y >= aChosenSeed.mY && x < aChosenSeed.mX + 46 && y < aChosenSeed.mY + 65)
                  {
                     return i;
                  }
               }
            }
         }
         return SEED_NONE;
      }
      
      public function buttonRelease(id:Number) : void
      {
         switch(id)
         {
            case this.Start_Game:
               this.OnStartButton();
               break;
            case this.Lawn_View:
               this.CloseSeedChooser();
               this.mChooseState = CHOOSE_VIEW_LAWN;
         }
      }
      
      public function GetSeedPositionInBank(theIndex:int, thePoint:Point) : void
      {
         thePoint.x = this.mBoard.mSeedBank.mX + this.mBoard.GetSeedPacketPositionX(theIndex) - this.x;
         thePoint.y = this.mBoard.mSeedBank.mY + 6 - this.y;
      }
   }
}
