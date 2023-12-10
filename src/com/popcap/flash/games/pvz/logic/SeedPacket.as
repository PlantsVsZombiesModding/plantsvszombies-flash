package com.popcap.flash.games.pvz.logic
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.resources.fonts.FontInst;
   import com.popcap.flash.framework.resources.images.ImageData;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.resources.particles.ParticleSystem;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.PVZFoleyType;
   import com.popcap.flash.games.pvz.renderables.ParticleRenderable;
   import com.popcap.flash.games.pvz.resources.PVZFonts;
   import com.popcap.flash.games.pvz.resources.PVZImages;
   import com.popcap.flash.games.pvz.resources.PVZParticles;
   import flash.display.BitmapData;
   
   public class SeedPacket extends GameObject
   {
      
      private static const CURSOR_TYPE_PLANT_FROM_BANK:int = 1;
      
      public static const TUTORIAL_MORESUN_COMPLETED:int = 12;
      
      private static const SLOT_MACHINE_TIME:int = 400;
      
      public static const TUTORIAL_LEVEL_2_PLANT_SUNFLOWER:int = 6;
      
      private static const OBJECT_TYPE_PLANT:int = 1;
      
      private static const CURSOR_TYPE_HAMMER:int = 4;
      
      private static const OBJECT_TYPE_PROJECTILE:int = 2;
      
      public static const SEED_REPEATER:int = 7;
      
      public static const TUTORIAL_MORESUN_PICK_UP_SUNFLOWER:int = 9;
      
      private static const CURSOR_TYPE_PLANT_FROM_USABLE_COIN:int = 2;
      
      private static const OBJECT_TYPE_NONE:int = 0;
      
      public static const TUTORIAL_LEVEL_1_COMPLETED:int = 4;
      
      public static const SEED_WALLNUT:int = 3;
      
      public static const SEED_PUFFSHROOM:int = 8;
      
      public static const TUTORIAL_MORESUN_PLANT_SUNFLOWER:int = 10;
      
      private static const SECONDS_PER_UPDATE:Number = 0.01;
      
      private static const CURSOR_TYPE_NORMAL:int = 0;
      
      private static const VARIATION_NORMAL:String = "normal";
      
      public static const SEED_EXPLODE_O_NUT:int = 50;
      
      public static const SEED_SUNFLOWER:int = 1;
      
      public static const SEED_PEASHOOTER:int = 0;
      
      public static const SEED_FUMESHROOM:int = 10;
      
      public static const TUTORIAL_LEVEL_1_PLANT_PEASHOOTER:int = 2;
      
      public static const TUTORIAL_LEVEL_2_REFRESH_SUNFLOWER:int = 7;
      
      public static const TUTORIAL_SHOVEL_DIG:int = 14;
      
      private static const OBJECT_TYPE_SHOVEL:int = 5;
      
      public static const SEED_SNOWPEA:int = 5;
      
      public static const SEED_CHOMPER:int = 6;
      
      public static const SEED_NONE:int = -1;
      
      public static const TUTORIAL_LEVEL_1_REFRESH_PEASHOOTER:int = 3;
      
      public static const TUTORIAL_LEVEL_1_PICK_UP_PEASHOOTER:int = 1;
      
      public static const TUTORIAL_SHOVEL_COMPLETED:int = 16;
      
      public static const SEED_CHERRYBOMB:int = 2;
      
      public static const TUTORIAL_MORESUN_REFRESH_SUNFLOWER:int = 11;
      
      private static const OBJECT_TYPE_SEEDPACKET:int = 4;
      
      private static const CURSOR_TYPE_SHOVEL:int = 3;
      
      public static const TUTORIAL_LEVEL_2_COMPLETED:int = 8;
      
      public static const SEED_SQUASH:int = 4;
      
      public static const SEED_LEFTPEATER:int = 49;
      
      public static const TUTORIAL_OFF:int = 0;
      
      public static const SEED_SUNSHROOM:int = 9;
      
      private static const OBJECT_TYPE_COIN:int = 3;
      
      public static const TUTORIAL_SHOVEL_PICKUP:int = 13;
      
      public static const TUTORIAL_LEVEL_2_PICK_UP_SUNFLOWER:int = 5;
      
      public static const TUTORIAL_SHOVEL_KEEP_DIGGING:int = 15;
      
      public static const SEED_GRAVEBUSTER:int = 11;
       
      
      private var mSlotMachiningPosition:Number;
      
      public var mUpdateImage:Boolean;
      
      private var mBufferedImage:ImageInst;
      
      public var mActive:Boolean;
      
      private var mSeedPacketFont:FontInst;
      
      private var mImitaterType:int;
      
      public var mRefreshTime:int;
      
      private var mSlotMachiningNextSeed:int;
      
      public var mIndex:int;
      
      public var mRefreshCounter:int;
      
      public var mPacketType:int;
      
      public var mRefreshing:Boolean;
      
      private var mSlotMachineCountDown:int;
      
      public var mTimesUsed:int;
      
      public var mOffsetX:int;
      
      public function SeedPacket(app:PVZApp, theBoard:Board)
      {
         super();
         this.mSeedPacketFont = app.fontManager.getFontInst(PVZFonts.FONT_PICO129);
         mBoard = theBoard;
         this.app = app;
         this.mPacketType = SEED_PEASHOOTER;
         this.mImitaterType = SEED_NONE;
         this.mIndex = -1;
         mWidth = 46;
         mHeight = 65;
         this.mRefreshCounter = 0;
         this.mRefreshTime = 0;
         this.mRefreshing = false;
         this.mActive = true;
         this.mOffsetX = 0;
         this.mSlotMachineCountDown = 0;
         this.mSlotMachiningNextSeed = SEED_NONE;
         this.mSlotMachiningPosition = 0;
         this.mTimesUsed = 0;
         mVisible = true;
         this.mUpdateImage = true;
      }
      
      public function MouseHitTest(theX:int, theY:int, theHitResult:HitResult) : Boolean
      {
         if(theX >= mX + this.mOffsetX && theX < mX + mWidth + this.mOffsetX && theY >= mY && theY < mY + mHeight && this.mPacketType != SEED_NONE)
         {
            theHitResult.mObject = this;
            theHitResult.mObjectType = OBJECT_TYPE_SEEDPACKET;
            return true;
         }
         theHitResult.mObject = null;
         theHitResult.mObjectType = OBJECT_TYPE_NONE;
         return false;
      }
      
      public function WasPlanted() : void
      {
         if(mBoard.HasConveyorBeltSeedBank())
         {
            mBoard.mSeedBank.RemoveSeed(this.mIndex);
         }
         else
         {
            ++this.mTimesUsed;
            this.mRefreshing = true;
            this.mRefreshTime = this.GetRefreshTime(this.mPacketType);
         }
      }
      
      public function FlashIfReady() : void
      {
         var anEffect:ParticleSystem = null;
         if(!this.CanPickUp())
         {
            return;
         }
         if(mBoard.mEasyPlantingCheat)
         {
            return;
         }
         if(!mBoard.HasConveyorBeltSeedBank())
         {
            anEffect = app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_SEEDPACKETFLASH);
            anEffect.setPosition(mX + 6,mY + 9);
            mBoard.mRenderManager.add(new ParticleRenderable(anEffect,Board.RENDER_LAYER_UI_BOTTOM + 2));
         }
         if(mBoard.mTutorialState == TUTORIAL_LEVEL_1_REFRESH_PEASHOOTER)
         {
            mBoard.SetTutorialState(TUTORIAL_LEVEL_1_PICK_UP_PEASHOOTER);
         }
         else if(mBoard.mTutorialState == TUTORIAL_LEVEL_2_REFRESH_SUNFLOWER && this.mPacketType == SEED_SUNFLOWER)
         {
            mBoard.SetTutorialState(TUTORIAL_LEVEL_2_PICK_UP_SUNFLOWER);
         }
         else if(mBoard.mTutorialState == TUTORIAL_MORESUN_REFRESH_SUNFLOWER && this.mPacketType == SEED_SUNFLOWER)
         {
            mBoard.SetTutorialState(TUTORIAL_MORESUN_PICK_UP_SUNFLOWER);
         }
      }
      
      public function PickNextSlotMachineSeed() : void
      {
      }
      
      public function update() : void
      {
         if(mBoard.mGameScene != PVZApp.SCENE_PLAYING)
         {
            return;
         }
         if(this.mPacketType == SEED_NONE)
         {
            return;
         }
         if(mBoard.mMainCounter == 0)
         {
            this.FlashIfReady();
         }
         if(!this.mActive && this.mRefreshing)
         {
            ++this.mRefreshCounter;
            if(this.mRefreshCounter > this.mRefreshTime)
            {
               this.mRefreshCounter = 0;
               this.mRefreshing = false;
               this.Activate();
               this.FlashIfReady();
            }
         }
      }
      
      public function MouseDown(x:Number, y:Number) : void
      {
         var aCost:int = 0;
         if(mBoard.mPaused || mBoard.mGameScene != Board.SCENE_PLAYING)
         {
            return;
         }
         if(this.mPacketType == SEED_NONE)
         {
            return;
         }
         var aPlantingSeedType:int = this.mPacketType;
         if(!mBoard.mEasyPlantingCheat)
         {
            if(!this.mActive)
            {
               app.foleyManager.playFoley(PVZFoleyType.BUZZER);
               if(mBoard.mLevel == 1 && Boolean(mBoard.mHelpDisplayed[Board.ADVICE_CLICK_ON_SUN]))
               {
                  mBoard.DisplayAdvice("[ADVICE_SEED_REFRESH]",Board.MESSAGE_STYLE_TUTORIAL_LEVEL1,Board.ADVICE_SEED_REFRESH);
               }
               return;
            }
            aCost = mBoard.GetCurrentPlantCost(this.mPacketType);
            if(!mBoard.CanTakeSunMoney(aCost) && !mBoard.HasConveyorBeltSeedBank())
            {
               app.foleyManager.playFoley(PVZFoleyType.BUZZER);
               mBoard.mOutOfMoneyCounter = 70;
               if(mBoard.mLevel == 1 && Boolean(mBoard.mHelpDisplayed[Board.ADVICE_CLICK_ON_SUN]))
               {
                  mBoard.DisplayAdvice("[ADVICE_CANT_AFFORD_PLANT]",Board.MESSAGE_STYLE_TUTORIAL_LEVEL1,Board.ADVICE_CANT_AFFORD_PLANT);
               }
               return;
            }
         }
         mBoard.mCursorObject.mType = this.mPacketType;
         mBoard.mCursorObject.mCursorType = CURSOR_TYPE_PLANT_FROM_BANK;
         mBoard.mCursorObject.mSeedBankIndex = this.mIndex;
         app.foleyManager.playFoley(PVZFoleyType.SEEDLIFT);
         if(mBoard.mTutorialState == TUTORIAL_LEVEL_1_PICK_UP_PEASHOOTER)
         {
            mBoard.SetTutorialState(TUTORIAL_LEVEL_1_PLANT_PEASHOOTER);
         }
         else if(mBoard.mTutorialState == TUTORIAL_LEVEL_2_PICK_UP_SUNFLOWER)
         {
            if(this.mPacketType == SEED_SUNFLOWER)
            {
               mBoard.SetTutorialState(TUTORIAL_LEVEL_2_PLANT_SUNFLOWER);
            }
            else
            {
               mBoard.SetTutorialState(TUTORIAL_LEVEL_2_REFRESH_SUNFLOWER);
            }
         }
         else if(mBoard.mTutorialState == TUTORIAL_MORESUN_PICK_UP_SUNFLOWER)
         {
            if(this.mPacketType == SEED_SUNFLOWER)
            {
               mBoard.SetTutorialState(TUTORIAL_MORESUN_PLANT_SUNFLOWER);
            }
            else
            {
               mBoard.SetTutorialState(TUTORIAL_MORESUN_REFRESH_SUNFLOWER);
            }
         }
         this.Deactivate();
      }
      
      public function Deactivate() : void
      {
         this.mActive = false;
         this.mRefreshCounter = 0;
         this.mRefreshTime = 0;
         this.mRefreshing = false;
      }
      
      private function drawBufferedImage(g:Graphics2D) : void
      {
         var aSeedBackImg:ImageInst = null;
         var aPlantImg:ImageInst = null;
         var aCost:int = 0;
         var width:int = 0;
         var height:int = 0;
         var aTextOffsetX:int = 0;
         var aTextOffsetY:int = 0;
         aSeedBackImg = app.imageManager.getImageInst(PVZImages.IMAGE_SEEDBACK);
         var w:Number = aSeedBackImg.width;
         var h:Number = aSeedBackImg.height;
         this.mBufferedImage = new ImageInst(new ImageData(new BitmapData(w,h,true,0)));
         var bufferG:Graphics2D = this.mBufferedImage.graphics;
         bufferG.drawImage(aSeedBackImg,0,0);
         var aOffsetX:Number = 5;
         var aOffsetY:Number = 10;
         var aScale:Number = 0.75;
         switch(this.mPacketType)
         {
            case SEED_EXPLODE_O_NUT:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_WALLNUT);
               aPlantImg.useColor = true;
               aPlantImg.setColor(1,1,64 / 255,64 / 255);
               aOffsetX += 3;
               break;
            case SEED_PEASHOOTER:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_PEASHOOTERSINGLE);
               aOffsetY += 4;
               break;
            case SEED_SUNFLOWER:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_SUNFLOWER);
               aOffsetY += 1;
               aOffsetX += 2;
               break;
            case SEED_CHERRYBOMB:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_CHERRYBOMB);
               aOffsetY += 3;
               aOffsetX += -1;
               break;
            case SEED_SQUASH:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_SQUASH);
               aOffsetX += 0;
               aOffsetY += -2;
               break;
            case SEED_CHOMPER:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_CHOMPER);
               aOffsetX += -2;
               aOffsetY += -3;
               aScale = 0.6;
               break;
            case SEED_SNOWPEA:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_SNOWPEA);
               aOffsetY += 3;
               break;
            case SEED_REPEATER:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_PEASHOOTER);
               aOffsetY += 5;
               break;
            case SEED_PUFFSHROOM:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_PUFFSHROOM);
               aOffsetY += 10;
               aOffsetX += 7;
               break;
            case SEED_SUNSHROOM:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_SUNSHROOM);
               aOffsetY += 10;
               aOffsetX += 7;
               break;
            case SEED_GRAVEBUSTER:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_GRAVEDIGGER);
               aOffsetY += 0;
               aOffsetX += -3;
               aScale = 0.6;
               break;
            case SEED_FUMESHROOM:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_FUMESHROOM);
               aOffsetY += 1;
               aScale = 0.65;
               break;
            case SEED_WALLNUT:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_WALLNUT);
               aOffsetX += 3;
               break;
            case SEED_LEFTPEATER:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_LEFTFACINGPEASHOOTER);
               aOffsetX += 4;
         }
         bufferG.pushState();
         bufferG.scale(aScale,aScale);
         bufferG.drawImage(aPlantImg,aOffsetX,aOffsetY);
         bufferG.popState();
         if(!mBoard.HasConveyorBeltSeedBank())
         {
            aCost = mBoard.GetCurrentPlantCost(this.mPacketType);
            width = this.mSeedPacketFont.stringWidth(String(aCost));
            height = this.mSeedPacketFont.getAscent();
            aTextOffsetX = 30 - width;
            aTextOffsetY = 40 + height;
            this.mSeedPacketFont.setColor(1,0,0,0);
            bufferG.setFont(this.mSeedPacketFont);
            bufferG.drawString(String(aCost),aTextOffsetX,aTextOffsetY);
         }
      }
      
      public function SlotMachineStart() : void
      {
      }
      
      public function Activate() : void
      {
         this.mActive = true;
      }
      
      public function Draw(g:Graphics2D) : void
      {
         if(!mVisible)
         {
            return;
         }
         if(this.mUpdateImage)
         {
            this.mUpdateImage = false;
            this.drawBufferedImage(g);
         }
         var aPercentDark:Number = 0;
         if(!this.mActive)
         {
            if(this.mRefreshTime == 0)
            {
               aPercentDark = 1;
            }
            else
            {
               aPercentDark = Number(this.mRefreshTime - this.mRefreshCounter) / Number(this.mRefreshTime);
            }
         }
         var aUseSeedType:int = this.mPacketType;
         var aDrawCost:Boolean = true;
         g.pushState();
         if(mBoard.HasConveyorBeltSeedBank())
         {
            g.setClipRect(2,0,380,405);
            aDrawCost = false;
         }
         var aCost:int = mBoard.GetCurrentPlantCost(this.mPacketType);
         var aGrayness:Number = 1;
         if(mBoard.mGameScene != PVZApp.SCENE_PLAYING)
         {
            aGrayness = 0.5;
            aPercentDark = 0;
         }
         else if(mBoard.mTutorialState == TUTORIAL_LEVEL_1_PICK_UP_PEASHOOTER && mBoard.mTutorialTimer == -1 && this.mPacketType == SEED_PEASHOOTER)
         {
            aGrayness = TodCommon.GetFlashingColor(mBoard.mMainCounter,75).red;
         }
         else if(mBoard.mTutorialState == TUTORIAL_LEVEL_2_PICK_UP_SUNFLOWER && this.mPacketType == SEED_SUNFLOWER)
         {
            aGrayness = TodCommon.GetFlashingColor(mBoard.mMainCounter,75).red;
         }
         else if(mBoard.mTutorialState == TUTORIAL_MORESUN_PICK_UP_SUNFLOWER && this.mPacketType == SEED_SUNFLOWER)
         {
            aGrayness = TodCommon.GetFlashingColor(mBoard.mMainCounter,75).red;
         }
         else if(mBoard.mEasyPlantingCheat)
         {
            aGrayness = 1;
            aPercentDark = 0;
         }
         else if(!mBoard.CanTakeSunMoney(aCost) && aDrawCost)
         {
            aGrayness = 0.5;
         }
         else if(aPercentDark > 0)
         {
            aGrayness = 0.5;
         }
         this.mBufferedImage.useColor = true;
         this.mBufferedImage.setColor(1,aGrayness,aGrayness,aGrayness);
         g.drawImage(this.mBufferedImage,mX + this.mOffsetX,mY);
         g.setClipRect(mX + this.mOffsetX,mY,this.mBufferedImage.width,this.mBufferedImage.height * aPercentDark,false);
         this.mBufferedImage.useColor = true;
         this.mBufferedImage.setColor(1,0.25,0.25,0.25);
         g.drawImage(this.mBufferedImage,mX + this.mOffsetX,mY);
         g.popState();
      }
      
      public function SetPacketType(theSeedType:int) : void
      {
      }
      
      public function GetRefreshTime(thePacketType:int) : int
      {
         var aRefreshTime:int = 0;
         switch(thePacketType)
         {
            case SEED_PEASHOOTER:
            case SEED_SUNFLOWER:
            case SEED_REPEATER:
            case SEED_SNOWPEA:
            case SEED_CHOMPER:
            case SEED_PUFFSHROOM:
            case SEED_GRAVEBUSTER:
            case SEED_FUMESHROOM:
            case SEED_SUNSHROOM:
               aRefreshTime = 750;
               break;
            case SEED_CHERRYBOMB:
               aRefreshTime = 5000;
               break;
            case SEED_WALLNUT:
            case SEED_SQUASH:
               aRefreshTime = 3000;
               break;
            default:
               aRefreshTime = 750;
         }
         return aRefreshTime;
      }
      
      public function CanPickUp() : Boolean
      {
         if(mBoard.mPaused || mBoard.mGameScene != Board.SCENE_PLAYING)
         {
            return false;
         }
         if(this.mPacketType == SEED_NONE)
         {
            return false;
         }
         if(mBoard.mEasyPlantingCheat)
         {
            return true;
         }
         var aUseSeedType:int = this.mPacketType;
         if(!this.mActive)
         {
            return false;
         }
         var aCost:int = mBoard.GetCurrentPlantCost(this.mPacketType);
         if(!mBoard.CanTakeSunMoney(aCost) && !mBoard.HasConveyorBeltSeedBank())
         {
            return false;
         }
         return true;
      }
   }
}
