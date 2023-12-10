package com.popcap.flash.games.pvz.logic
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.render.RenderManager;
   import com.popcap.flash.framework.resources.fonts.FontInst;
   import com.popcap.flash.framework.resources.images.ImageData;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.widgets.CWidget;
   import com.popcap.flash.framework.widgets.ui.IButtonListener;
   import com.popcap.flash.framework.widgets.ui.ImageButtonWidget;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.renderables.StringRenderable;
   import com.popcap.flash.games.pvz.resources.PVZFonts;
   import com.popcap.flash.games.pvz.resources.PVZImages;
   import com.popcap.flash.games.pvz.resources.PVZReanims;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class AwardScreen extends CWidget implements IButtonListener
   {
      
      public static const SEED_PUFFSHROOM:int = 8;
      
      private static const SEED_NONE:int = -1;
      
      private static const SEED_CHERRYBOMB:int = 2;
      
      private static const SEED_SQUASH:int = 4;
      
      private static const SEED_PEASHOOTER:int = 0;
      
      private static const SEED_CHOMPER:int = 6;
      
      public static const SEED_SUNSHROOM:int = 9;
      
      private static const SEED_REPEATER:int = 7;
      
      private static const SEED_WALLNUT:int = 3;
      
      public static const SEED_FUMESHROOM:int = 10;
      
      public static const SEED_GRAVEBUSTER:int = 11;
      
      private static const SEED_SUNFLOWER:int = 1;
      
      private static const SEED_SNOWPEA:int = 5;
       
      
      public var mFadedIn:Boolean;
      
      private var mZombieNote:ImageInst;
      
      public var mStartButton:ImageButtonWidget;
      
      private var mFadeInCounter:int;
      
      private var mButtonImage:ImageInst;
      
      private var app:PVZApp;
      
      private var mDescriptionTextRenderable:StringRenderable;
      
      private var mNameTextRenderable:StringRenderable;
      
      private var mTitleTextRenderable:StringRenderable;
      
      public var mRenderManager:RenderManager;
      
      private var mShovelImage:ImageInst;
      
      private var mZombieNote1:ImageInst;
      
      private var mBufferedImage:ImageInst;
      
      private var mBackground:ImageInst;
      
      public function AwardScreen(app:PVZApp)
      {
         this.mRenderManager = new RenderManager();
         super();
         this.app = app;
         this.mFadeInCounter = 180;
         this.mStartButton = new ImageButtonWidget(0,this);
         this.mStartButton.visible = true;
         var aString:String = app.stringManager.translateString("[NEXT_LEVEL_BUTTON]");
         var font:FontInst = app.fontManager.getFontInst(PVZFonts.FONT_DWARVENTODCRAFT18YELLOW);
         font.scale = 0.7;
         var anImage:ImageInst = app.imageManager.getImageInst(PVZImages.IMAGE_SEEDCHOOSER_BUTTON);
         var aGlowImage:ImageInst = app.imageManager.getImageInst(PVZImages.IMAGE_SEEDCHOOSER_BUTTON_GLOW);
         this.mStartButton.mUpImage = this.MakeButton(anImage,font,aString);
         this.mStartButton.mDisabledImage = this.MakeButton(anImage,font,aString);
         font.setColor(1,1.5,1.5,1.5);
         this.mStartButton.mDownImage = this.MakeGlowButton(anImage,aGlowImage,font,aString);
         this.mStartButton.mDownOffset = new Point(1,1);
         this.mStartButton.mOverImage = this.MakeGlowButton(anImage,aGlowImage,font,aString);
         anImage = app.imageManager.getImageInst(PVZImages.IMAGE_SEEDCHOOSER_BUTTON_DISABLED);
         this.mStartButton.resize(215,337,105,28);
         if(app.mLevel == 9)
         {
            this.mBackground = app.imageManager.getImageInst(PVZImages.IMAGE_BACKGROUND1);
            this.mZombieNote = app.imageManager.getImageInst(PVZImages.IMAGE_ZOMBIENOTE);
         }
         else
         {
            this.mBackground = app.imageManager.getImageInst(PVZImages.IMAGE_AWARDSCREEN_BACK);
         }
         this.mButtonImage = app.imageManager.getImageInst(PVZImages.IMAGE_SEEDCHOOSER_BUTTON);
         this.mShovelImage = app.imageManager.getImageInst(PVZImages.IMAGE_SHOVEL_SMALL);
         var aLevel:int = app.mLevel;
         var awardSeed:int = this.GetAwardSeedForLevel(aLevel);
         var seedName:String = this.GetSeedName(awardSeed);
         var seedToolTip:String = this.GetSeedToolTip(awardSeed);
         var title:String = app.stringManager.translateString("[NEW_PLANT]");
         if(aLevel == 4)
         {
            title = app.stringManager.translateString("[GOT_SHOVEL]");
            seedName = app.stringManager.translateString("[SHOVEL]");
            seedToolTip = app.stringManager.translateString("[SHOVEL_DESCRIPTION]");
         }
         else if(aLevel == 9)
         {
            title = app.stringManager.translateString("[FOUND_NOTE]");
            seedName = "";
            seedToolTip = "";
         }
         font = app.fontManager.getFontInst(PVZFonts.FONT_DWARVENTODCRAFT24);
         font.scale = 0.9;
         font.setColor(1,213 / 255,159 / 255,43 / 255);
         this.mTitleTextRenderable = new StringRenderable(Board.RENDER_LAYER_ABOVE_UI);
         this.mTitleTextRenderable.setBounds(95,20,350,27);
         this.mTitleTextRenderable.font = font;
         this.mTitleTextRenderable.text = title;
         font = app.fontManager.getFontInst(PVZFonts.FONT_DWARVENTODCRAFT18YELLOW);
         font.setColor(1,1,1,1);
         font.scale = 1;
         this.mNameTextRenderable = new StringRenderable(Board.RENDER_LAYER_ABOVE_UI);
         this.mNameTextRenderable.setBounds(157,197,225,40);
         this.mNameTextRenderable.font = font;
         this.mNameTextRenderable.text = seedName;
         font = app.fontManager.getFontInst(PVZFonts.FONT_BRIANNETOD16);
         font.setColor(1,40 / 255,50 / 255,90 / 255);
         font.scale = 1;
         this.mDescriptionTextRenderable = new StringRenderable(Board.RENDER_LAYER_ABOVE_UI);
         this.mDescriptionTextRenderable.setBounds(175,235,185,80);
         this.mDescriptionTextRenderable.font = font;
         this.mDescriptionTextRenderable.text = seedToolTip;
         this.mRenderManager.add(this.mDescriptionTextRenderable);
         this.mRenderManager.add(this.mTitleTextRenderable);
         this.mRenderManager.add(this.mNameTextRenderable);
      }
      
      public function buttonMouseMove(id:Number, x:Number, y:Number) : void
      {
      }
      
      public function GetPlantDefinition(theSeedType:int) : String
      {
         var aReanimType:String = null;
         switch(theSeedType)
         {
            case SEED_PEASHOOTER:
               aReanimType = PVZReanims.REANIM_PEASHOOTERSINGLE;
               break;
            case SEED_SUNFLOWER:
               aReanimType = PVZReanims.REANIM_SUNFLOWER;
               break;
            case SEED_CHERRYBOMB:
               aReanimType = PVZReanims.REANIM_CHERRYBOMB;
               break;
            case SEED_CHOMPER:
               aReanimType = PVZReanims.REANIM_CHOMPER;
               break;
            case SEED_SNOWPEA:
               aReanimType = PVZReanims.REANIM_SNOWPEA;
               break;
            case SEED_SQUASH:
               aReanimType = PVZReanims.REANIM_SQUASH;
               break;
            case SEED_REPEATER:
               aReanimType = PVZReanims.REANIM_PEASHOOTER;
               break;
            case SEED_WALLNUT:
               aReanimType = PVZReanims.REANIM_WALLNUT;
               break;
            case SEED_PUFFSHROOM:
               aReanimType = PVZReanims.REANIM_PUFFSHROOM;
               break;
            case SEED_SUNSHROOM:
               aReanimType = PVZReanims.REANIM_SUNSHROOM;
               break;
            case SEED_FUMESHROOM:
               aReanimType = PVZReanims.REANIM_FUMESHROOM;
               break;
            case SEED_GRAVEBUSTER:
               aReanimType = PVZReanims.REANIM_GRAVEBUSTER;
         }
         return aReanimType;
      }
      
      public function buttonMouseEnter(id:Number) : void
      {
      }
      
      public function GetSeedToolTip(theType:int) : String
      {
         var aName:String = null;
         switch(theType)
         {
            case 0:
               aName = this.app.stringManager.translateString("[PEASHOOTER_TOOLTIP]");
               break;
            case 1:
               aName = this.app.stringManager.translateString("[SUNFLOWER_TOOLTIP]");
               break;
            case 2:
               aName = this.app.stringManager.translateString("[CHERRY_BOMB_TOOLTIP]");
               break;
            case 3:
               aName = this.app.stringManager.translateString("[WALL_NUT_TOOLTIP]");
               break;
            case 4:
               aName = this.app.stringManager.translateString("[SQUASH_TOOLTIP]");
               break;
            case 5:
               aName = this.app.stringManager.translateString("[SNOW_PEA_TOOLTIP]");
               break;
            case 6:
               aName = this.app.stringManager.translateString("[CHOMPER_TOOLTIP]");
               break;
            case 7:
               aName = this.app.stringManager.translateString("[REPEATER_TOOLTIP]");
               break;
            case 8:
               aName = this.app.stringManager.translateString("[PUFF_SHROOM_TOOLTIP]");
               break;
            case 9:
               aName = this.app.stringManager.translateString("[SUN_SHROOM_TOOLTIP]");
               break;
            case 10:
               aName = this.app.stringManager.translateString("[FUME_SHROOM_TOOLTIP]");
               break;
            case 11:
               aName = this.app.stringManager.translateString("[GRAVE_BUSTER_TOOLTIP]");
         }
         return aName;
      }
      
      public function DrawBottom(g:Graphics2D) : void
      {
         g.drawImage(this.mBackground,0,0);
      }
      
      public function GetCurrentPlantCost(theSeedType:int) : int
      {
         var aCost:int = 0;
         switch(theSeedType)
         {
            case SEED_PEASHOOTER:
               aCost = 100;
               break;
            case SEED_SUNFLOWER:
               aCost = 50;
               break;
            case SEED_CHERRYBOMB:
               aCost = 150;
               break;
            case SEED_WALLNUT:
               aCost = 50;
               break;
            case SEED_CHOMPER:
               aCost = 150;
               break;
            case SEED_SQUASH:
               aCost = 50;
               break;
            case SEED_SNOWPEA:
               aCost = 175;
               break;
            case SEED_REPEATER:
               aCost = 200;
               break;
            case SEED_PUFFSHROOM:
               aCost = 0;
               break;
            case SEED_SUNSHROOM:
               aCost = 25;
               break;
            case SEED_FUMESHROOM:
               aCost = 75;
               break;
            case SEED_GRAVEBUSTER:
               aCost = 75;
               break;
            default:
               aCost = 100;
         }
         return aCost;
      }
      
      public function buttonDownTick(id:Number) : void
      {
      }
      
      public function GetAwardSeedForLevel(aLevel:int) : int
      {
         var aArea:int = (aLevel - 1) / 10 + 1;
         var aSubArea:int = (aLevel - 1) % 10 + 1;
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
         return aSeeds;
      }
      
      public function buttonPress(id:Number) : void
      {
      }
      
      override public function draw(g:Graphics2D) : void
      {
         var aLevel:int = this.app.mLevel;
         if(aLevel == 4)
         {
            this.DrawBottom(g);
            g.drawImage(this.mShovelImage,250,115);
         }
         else if(aLevel == 9)
         {
            g.pushState();
            g.scale(2,2);
            g.drawImage(this.mBackground,-472,-202);
            g.popState();
            g.drawImage(this.mZombieNote,60,55);
         }
         else
         {
            this.DrawAwardSeed(g);
         }
         var aAlpha:int = TodCommon.TodAnimateCurve(180,0,this.mFadeInCounter,255,0,TodCommon.CURVE_LINEAR);
         var aColor:uint = uint(aAlpha << 24);
         if(this.IsPaperNote())
         {
            aColor |= 0;
         }
         else
         {
            aColor |= 16777215;
         }
         this.mRenderManager.draw(g);
         g.fillRect(0,0,540,405,aColor);
         if(aAlpha <= 0)
         {
            this.mFadedIn = true;
         }
      }
      
      override public function update() : void
      {
         this.mRenderManager.update();
         markDirty();
         if(this.mFadeInCounter > 0)
         {
            --this.mFadeInCounter;
         }
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
      
      public function SaveUserData() : void
      {
         ++this.app.mSaveObject.level;
         ++this.app.mLevel;
         if(this.app.mSaveObject.level > 14)
         {
            this.app.mSaveObject.level == 1;
            this.app.mLevel = 1;
            if(this.app.mSaveObject.puzzleLocked)
            {
               this.app.mSaveObject.puzzleLocked = false;
               this.app.mPuzzleLocked = false;
            }
            if(this.app.mSaveObject.survivalLocked)
            {
               this.app.mSaveObject.survivalLocked = false;
               this.app.mSurvivalLocked = false;
            }
         }
         this.app.setSaveData(this.app.mSaveObject);
      }
      
      private function GameContinue() : void
      {
         if(this.app.adAPI.enabled)
         {
            this.app.musicManager.resumeMusic();
            this.app.soundManager.resumeAll();
         }
         ++this.app.mLevel;
         ++this.app.mSaveObject.level;
         this.app.setSaveData(this.app.mSaveObject);
         this.app.stateManager.changeState(PVZApp.STATE_LEVEL_INTRO);
      }
      
      public function DrawSeedPacket(g:Graphics2D, theType:int) : void
      {
         var aSeedBackImg:ImageInst = null;
         var aPlantImg:ImageInst = null;
         aSeedBackImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_SEEDPACKET_LARGER);
         var w:Number = aSeedBackImg.width;
         var h:Number = aSeedBackImg.height;
         this.mBufferedImage = new ImageInst(new ImageData(new BitmapData(w,h,true,0)));
         var bufferG:Graphics2D = this.mBufferedImage.graphics;
         bufferG.drawImage(aSeedBackImg,0,0);
         var aOffsetX:Number = 10;
         var aOffsetY:Number = 15;
         var aScale:Number = 1;
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
               aOffsetY += 1;
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
               aScale = 0.85;
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
               aOffsetY += 12;
               aOffsetX += 9;
               break;
            case SEED_SUNSHROOM:
               aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_SUNSHROOM);
               aOffsetY += 13;
               aOffsetX += 10;
               break;
            case SEED_GRAVEBUSTER:
               aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_GRAVEDIGGER);
               aOffsetY += 1;
               aOffsetX += -5;
               aScale = 0.85;
               break;
            case SEED_FUMESHROOM:
               aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_FUMESHROOM);
               aOffsetX -= 2;
               aOffsetY += 1;
               aScale = 0.95;
               break;
            case SEED_WALLNUT:
               aPlantImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_WALLNUT);
               aOffsetX += 3;
         }
         bufferG.pushState();
         bufferG.scale(aScale,aScale);
         bufferG.drawImage(aPlantImg,aOffsetX,aOffsetY);
         bufferG.popState();
         var theFont:FontInst = this.app.fontManager.getFontInst(PVZFonts.FONT_PICO129);
         theFont.scale = 1.6;
         theFont.setColor(1,0,0,0);
         var aCost:int = this.GetCurrentPlantCost(theType);
         var width:int = theFont.stringWidth(String(aCost));
         var height:int = theFont.getAscent();
         var aTextOffsetX:int = 45 - width;
         var aTextOffsetY:int = 72;
         bufferG.setFont(theFont);
         bufferG.drawString(String(aCost),aTextOffsetX,aTextOffsetY);
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
      
      public function buttonMouseLeave(id:Number) : void
      {
      }
      
      public function DrawAwardSeed(g:Graphics2D) : void
      {
         var aLevel:int = this.app.mLevel;
         var awardSeed:int = this.GetAwardSeedForLevel(aLevel);
         this.DrawBottom(g);
         if(this.mBufferedImage == null)
         {
            this.DrawSeedPacket(g,awardSeed);
         }
         g.drawImage(this.mBufferedImage,236,87);
      }
      
      public function GetSeedName(theType:int) : String
      {
         var aName:String = null;
         switch(theType)
         {
            case 0:
               aName = this.app.stringManager.translateString("[PEASHOOTER]");
               break;
            case 1:
               aName = this.app.stringManager.translateString("[SUNFLOWER]");
               break;
            case 2:
               aName = this.app.stringManager.translateString("[CHERRY_BOMB]");
               break;
            case 3:
               aName = this.app.stringManager.translateString("[WALL_NUT]");
               break;
            case 4:
               aName = this.app.stringManager.translateString("[SQUASH]");
               break;
            case 5:
               aName = this.app.stringManager.translateString("[SNOW_PEA]");
               break;
            case 6:
               aName = this.app.stringManager.translateString("[CHOMPER]");
               break;
            case 7:
               aName = this.app.stringManager.translateString("[REPEATER]");
               break;
            case 8:
               aName = this.app.stringManager.translateString("[PUFF_SHROOM]");
               break;
            case 9:
               aName = this.app.stringManager.translateString("[SUN_SHROOM]");
               break;
            case 10:
               aName = this.app.stringManager.translateString("[FUME_SHROOM]");
               break;
            case 11:
               aName = this.app.stringManager.translateString("[GRAVE_BUSTER]");
         }
         return aName;
      }
      
      public function IsPaperNote() : Boolean
      {
         var aLevel:int = 0;
         if(this.app.IsAdventureMode())
         {
            aLevel = this.app.mLevel;
            if(aLevel == 9)
            {
               return true;
            }
         }
         return false;
      }
      
      public function buttonRelease(id:Number) : void
      {
         if(this.app.adAPI.enabled)
         {
            this.app.musicManager.pauseMusic();
            this.app.soundManager.pauseAll();
         }
         this.mStartButton.setDisabled(true);
         this.app.adAPI.GameBreak(this.app.mLevel,this.GameContinue);
      }
   }
}
