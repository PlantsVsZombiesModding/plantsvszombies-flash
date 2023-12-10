package com.popcap.flash.games.pvz.logic
{
   import com.popcap.flash.framework.graphics.Color;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.resources.fonts.FontInst;
   import com.popcap.flash.framework.resources.images.ImageData;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.resources.particles.ParticleSystem;
   import com.popcap.flash.framework.resources.reanimator.Reanimation;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.PVZFoleyType;
   import com.popcap.flash.games.pvz.renderables.ParticleRenderable;
   import com.popcap.flash.games.pvz.resources.PVZFonts;
   import com.popcap.flash.games.pvz.resources.PVZImages;
   import com.popcap.flash.games.pvz.resources.PVZParticles;
   import com.popcap.flash.games.pvz.resources.PVZReanims;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   
   public class Coin extends GameObject
   {
      
      public static const CURVE_WEAK_FAST_IN_OUT:int = 8;
      
      public static const COIN_DYNAMITE:String = "dynamite";
      
      private static const OBJECT_TYPE_PLANT:int = 1;
      
      public static const SEED_PUFFSHROOM:int = 8;
      
      private static const OBJECT_TYPE_PROJECTILE:int = 2;
      
      public static const CURVE_SIN_WAVE:int = 12;
      
      public static const CURVE_BOUNCE_FAST_MIDDLE:int = 10;
      
      public static const CURVE_CONSTANT:int = 0;
      
      public static const CURVE_LINEAR:int = 1;
      
      public static const SEED_REPEATER:int = 7;
      
      public static const COIN_MOTION_FROM_SKY_SLOW:String = "from sky slow";
      
      public static const CURVE_EASE_IN_OUT:int = 4;
      
      private static const OBJECT_TYPE_NONE:int = 0;
      
      public static const SEED_WALLNUT:int = 3;
      
      public static const SEED_FUMESHROOM:int = 10;
      
      public static const CURVE_EASE_IN:int = 2;
      
      public static const COIN_MOTION_FROM_SKY:String = "from sky";
      
      public static const COIN_NONE:String = "none";
      
      public static const SEED_PEASHOOTER:int = 0;
      
      public static const COIN_SHOVEL:String = "shovel";
      
      public static const SEED_SUNSHROOM:int = 9;
      
      public static const SEED_EXPLODE_O_NUT:int = 50;
      
      public static const SEED_SUNFLOWER:int = 1;
      
      public static const SEED_SNOWPEA:int = 5;
      
      public static const COIN_USABLE_SEED_PACKET:String = "usableseedpacket";
      
      public static const SEED_GRAVEBUSTER:int = 11;
      
      public static const SEED_NONE:int = -1;
      
      private static const BOARD_HEIGHT:int = 405;
      
      private static const OBJECT_TYPE_SHOVEL:int = 5;
      
      public static const SEED_CHERRYBOMB:int = 2;
      
      public static const CURVE_EASE_OUT:int = 3;
      
      public static const CURVE_FAST_IN_OUT_WEAK:int = 7;
      
      public static const CURVE_BOUNCE_SLOW_MIDDLE:int = 11;
      
      public static const SEED_SQUASH:int = 4;
      
      public static const COIN_SMALLSUN:String = "small sun";
      
      public static const COIN_MOTION_COIN:String = "coin";
      
      private static const OBJECT_TYPE_SEEDPACKET:int = 4;
      
      public static const COIN_NOTE:String = "note";
      
      public static const CURVE_EASE_SIN_WAVE:int = 13;
      
      public static const CURVE_FAST_IN_OUT:int = 6;
      
      public static const CURVE_EASE_IN_OUT_WEAK:int = 5;
      
      public static const SEED_LEFTPEATER:int = 49;
      
      private static const BOARD_WIDTH:int = 540;
      
      public static const SEED_CHOMPER:int = 6;
      
      public static const COIN_MOTION_FROM_PLANT:String = "from plant";
      
      private static const OBJECT_TYPE_COIN:int = 3;
      
      public static const CURVE_BOUNCE:int = 9;
      
      public static const COIN_PRESENT_PLANT:String = "presentplant";
      
      public static const COIN_SUN:String = "sun";
      
      public static const COIN_FINAL_SEED_PACKET:String = "finalseedpacket";
       
      
      public var mCollectionDistance:Number;
      
      public var mCoinAge:int;
      
      public var mReanimation:Reanimation;
      
      public var mGroundY:int;
      
      public var mFadeCount:int;
      
      public var mHitGround:Boolean;
      
      public var mPosX:Number;
      
      public var mPosY:Number;
      
      private var mZombieNote:ImageInst;
      
      public var mBouncyArrow:ParticleSystem;
      
      public var mIsBeingCollected:Boolean;
      
      public var mHasBouncyArrow:Boolean;
      
      public var mTimesDropped:int;
      
      private var mSeedEffect:ParticleSystem;
      
      public var mUsableSeedType:int;
      
      public var mExplode:int;
      
      public var mType:String;
      
      private var mShovelImage:ImageInst;
      
      private var mBufferedImage:ImageInst;
      
      public var mScale:Number;
      
      public var mDisappearCounter:int;
      
      public var mVelX:Number;
      
      public var mVelY:Number;
      
      public var mDead:Boolean;
      
      public var mCoinMotion:String;
      
      public var mCollectX:Number;
      
      public var mCollectY:Number;
      
      public var mNeedsBouncyArrow:Boolean;
      
      private var mScaleMatrix:Matrix;
      
      public function Coin()
      {
         this.mScaleMatrix = new Matrix();
         super();
      }
      
      public function GetDisappearTime() : int
      {
         var aDisappearTime:int = 750;
         if(this.mHasBouncyArrow)
         {
            aDisappearTime = 1500;
         }
         if(app.IsScaryPotterLevel())
         {
            if(this.mType == COIN_USABLE_SEED_PACKET)
            {
               aDisappearTime = 1500;
            }
         }
         return aDisappearTime;
      }
      
      public function UpdateFall() : void
      {
         var aParticleOffsetX:Number = NaN;
         var aParticleOffsetY:Number = NaN;
         var aDisappearTime:int = 0;
         var aFinalScale:Number = NaN;
         if(this.mType == COIN_FINAL_SEED_PACKET)
         {
         }
         if(this.mType == COIN_FINAL_SEED_PACKET)
         {
         }
         if(this.mPosY + this.mVelY < this.mGroundY)
         {
            this.mPosY += this.mVelY;
            if(this.mCoinMotion == COIN_MOTION_FROM_PLANT)
            {
               this.mVelY += 0.09;
            }
            else if(this.mCoinMotion == COIN_MOTION_COIN)
            {
               this.mVelY += 0.15;
            }
            this.mPosX += this.mVelX;
            if(this.mPosX > BOARD_WIDTH - mWidth)
            {
               this.mPosX = BOARD_WIDTH - mWidth;
               this.mVelX = -0.4 - Math.random() * 0.4;
            }
            else if(this.mPosX < 0)
            {
               this.mPosX = 0;
               this.mVelX = 0.4 + Math.random() * 0.4;
            }
         }
         else
         {
            aParticleOffsetX = mWidth / 2 * this.mScale + 17;
            aParticleOffsetY = mHeight / 2 * this.mScale - 15;
            if(this.mType == COIN_SHOVEL || this.mType == COIN_NOTE)
            {
               aParticleOffsetX -= 20;
               aParticleOffsetY -= 30;
            }
            if(this.mNeedsBouncyArrow && !this.mHasBouncyArrow)
            {
               this.mBouncyArrow = app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_SEEDPACKET);
               this.mBouncyArrow.setPosition(this.mPosX + aParticleOffsetX,this.mPosY + aParticleOffsetY);
               mBoard.mRenderManager.add(new ParticleRenderable(this.mBouncyArrow,RENDER_LAYER_PARTICLE));
               this.mHasBouncyArrow = true;
            }
            if(!this.mHitGround)
            {
               this.mHitGround = true;
            }
            this.mPosY = this.mGroundY;
            if(!this.IsLevelAward())
            {
               ++this.mDisappearCounter;
               aDisappearTime = this.GetDisappearTime();
               if(this.mDisappearCounter >= aDisappearTime)
               {
                  this.StartFade();
               }
            }
         }
         if(this.mCoinMotion == COIN_MOTION_FROM_PLANT)
         {
            aFinalScale = 1;
            if(this.mScale < aFinalScale)
            {
               this.mScale += 0.02;
            }
            else
            {
               this.mScale = aFinalScale;
            }
         }
      }
      
      public function MouseHitTest(theX:int, theY:int, theHitResult:HitResult) : Boolean
      {
         var aResult:Boolean = false;
         var aOffsetX:int = 0;
         var aOffsetY:int = 0;
         if(this.mType == COIN_DYNAMITE)
         {
            return false;
         }
         if(this.mType == COIN_FINAL_SEED_PACKET)
         {
            aOffsetX = (mWidth - mWidth * this.mScale) * 0.5;
            aOffsetY = (mHeight - mHeight * this.mScale) * 0.5;
         }
         var aExtraClickSize:int = 0;
         var aExtraClickHeight:int = 0;
         if(this.mType == COIN_SUN)
         {
            aExtraClickSize = 15;
         }
         if(this.mDead)
         {
            aResult = false;
         }
         else if(this.mIsBeingCollected)
         {
            aResult = false;
         }
         else if(this.mType == COIN_USABLE_SEED_PACKET && mBoard && mBoard.mCursorObject.mCursorType != Board.CURSOR_TYPE_NORMAL)
         {
            aResult = false;
         }
         else if(theX >= this.mPosX - aExtraClickSize + aOffsetX && theX < this.mPosX + mWidth * this.mScale + aExtraClickSize + aOffsetX && theY >= this.mPosY + aOffsetY - aExtraClickSize && theY < this.mPosY + mHeight * this.mScale + aOffsetY + aExtraClickSize + aExtraClickHeight)
         {
            aResult = true;
         }
         else
         {
            aResult = false;
         }
         if(aResult)
         {
            theHitResult.mObject = this;
            theHitResult.mObjectType = OBJECT_TYPE_COIN;
            return true;
         }
         theHitResult.mObject = null;
         theHitResult.mObjectType = OBJECT_TYPE_NONE;
         return false;
      }
      
      public function IsPresentWithAdvice() : Boolean
      {
         return false;
      }
      
      public function UpdateFade() : void
      {
         if(this.mType != COIN_NOTE)
         {
            if(this.IsLevelAward())
            {
               return;
            }
         }
         --this.mFadeCount;
         if(this.mFadeCount == 0)
         {
            this.Die();
         }
      }
      
      public function ScoreCoin() : void
      {
         var aSunValue:int = 0;
         if(this.IsSun())
         {
            aSunValue = this.GetSunValue();
            this.mIsBeingCollected = false;
            mBoard.AddSunMoney(aSunValue);
         }
         this.Die();
      }
      
      public function Die() : void
      {
         this.mDead = true;
         if(this.mReanimation != null)
         {
            this.mReanimation.mIsDead = true;
         }
      }
      
      public function CoinInitialize(theX:int, theY:int, theCoinType:String, theCoinMotion:String, app:PVZApp, theBoard:Board) : void
      {
         var aReanim:Reanimation = null;
         this.app = app;
         mBoard = theBoard;
         this.mDead = false;
         this.mType = theCoinType;
         this.mPosX = theX;
         this.mPosY = theY;
         mWidth = 40;
         mHeight = 40;
         this.mDisappearCounter = 0;
         this.mIsBeingCollected = false;
         this.mFadeCount = 0;
         this.mCoinMotion = theCoinMotion;
         this.mCoinAge = 0;
         this.mCollectionDistance = 0;
         this.mScale = 1;
         this.mUsableSeedType = SEED_NONE;
         this.mNeedsBouncyArrow = false;
         this.mHasBouncyArrow = false;
         this.mHitGround = false;
         this.mTimesDropped = 0;
         var aOffsetX:int = mWidth * 0.5;
         var aOffsetY:int = mHeight * 0.5;
         if(this.IsSun())
         {
            aReanim = app.reanimator.createReanimation("REANIM_SUN");
            aReanim.x = this.mPosX + aOffsetX;
            aReanim.y = this.mPosY + aOffsetY;
            aReanim.loopType = Reanimation.LOOP_TYPE_ALWAYS;
            aReanim.animRate = 6;
            aReanim.currentTrack = "Sun1";
            this.mReanimation = aReanim;
         }
         else if(this.mType == COIN_DYNAMITE)
         {
            this.mPosX -= 20;
            this.mPosY -= 20;
            this.mExplode = 100;
            mWidth = 54;
            mHeight = 54;
            this.mScale = 1;
            aReanim = app.reanimator.createReanimation(PVZReanims.REANIM_DYNOMITE);
            aReanim.x = this.mPosX;
            aReanim.y = this.mPosY;
            aReanim.loopType = Reanimation.LOOP_TYPE_ONCE_AND_DIE;
            aReanim.animRate = 15;
            aReanim.currentTrack = "dynomite";
            this.mReanimation = aReanim;
            app.foleyManager.playFoley(PVZFoleyType.REVERSE_EXPLOSION);
         }
         else if(this.mType == COIN_FINAL_SEED_PACKET)
         {
            mWidth = 68;
            mHeight = 95;
            this.mScale = 0.5;
         }
         else if(this.mType == COIN_SHOVEL)
         {
            mWidth = 41;
            mHeight = 41;
            this.mScale = 1;
            this.mShovelImage = app.imageManager.getImageInst(PVZImages.IMAGE_SHOVEL_SMALL);
         }
         else if(this.mType == COIN_NOTE)
         {
            mWidth = 53;
            mHeight = 35;
            this.mScale = 1;
            this.mZombieNote = app.imageManager.getImageInst(PVZImages.IMAGE_ZOMBIENOTESMALL);
         }
         else if(this.mType == COIN_USABLE_SEED_PACKET)
         {
            mWidth = 34;
            mHeight = 48;
            this.mScale = 0.5;
         }
         switch(this.mCoinMotion)
         {
            case COIN_MOTION_FROM_SKY:
               this.mVelY = 0.67;
               this.mVelX = 0;
               this.mGroundY = Math.random() * 169 + 202;
               break;
            case COIN_MOTION_FROM_SKY_SLOW:
               this.mVelY = 0.33;
               this.mVelX = 0;
               this.mGroundY = Math.random() * 169 + 202;
               break;
            case COIN_MOTION_FROM_PLANT:
               this.mVelY = -1.7 - Math.random() * 1.7;
               this.mVelX = -0.4 + Math.random() * 0.8;
               this.mGroundY = this.mPosY + 10 + Math.random() * 13;
               this.mScale = 0.4;
               break;
            case COIN_MOTION_COIN:
               this.mVelY = -2.1 - Math.random() * 1.3;
               this.mVelX = -0.4 + Math.random() * 0.7;
               this.mGroundY = this.mPosY + 30 + Math.random() * 13;
               if(this.mGroundY > BOARD_HEIGHT - 53)
               {
                  this.mGroundY = BOARD_HEIGHT - 53;
               }
               if(this.mGroundY < 54)
               {
                  this.mGroundY = 54;
               }
               if(this.mType == COIN_FINAL_SEED_PACKET || this.mType == COIN_USABLE_SEED_PACKET || this.mType == COIN_SHOVEL || this.mType == COIN_NOTE)
               {
                  this.mGroundY -= 21;
               }
               if(this.mType == COIN_DYNAMITE)
               {
                  this.mVelX = 0;
                  this.mGroundY -= 54;
               }
               if(this.mPosY > this.mGroundY)
               {
                  this.mPosY = this.mGroundY;
               }
         }
         if(this.CoinGetsBouncyArrow())
         {
            this.mNeedsBouncyArrow = true;
         }
         this.PlayLaunchSound();
      }
      
      public function IsSun() : Boolean
      {
         if(this.mType == COIN_SUN || this.mType == COIN_SMALLSUN)
         {
            return true;
         }
         return false;
      }
      
      public function IsLevelAward() : Boolean
      {
         if(this.mType == COIN_FINAL_SEED_PACKET || this.mType == COIN_SHOVEL || this.mType == COIN_NOTE)
         {
            return true;
         }
         return false;
      }
      
      public function Collect() : void
      {
         var anEffect:ParticleSystem = null;
         var aParticleOffsetX:Number = NaN;
         var aParticleOffsetY:Number = NaN;
         var i:int = 0;
         var aSeedPacket:SeedPacket = null;
         var aCost:int = 0;
         var aAmountOver:int = 0;
         if(this.mDead)
         {
            return;
         }
         this.mCollectX = this.mPosX;
         this.mCollectY = this.mPosY;
         this.mIsBeingCollected = true;
         var aIsEndlessAward:Boolean = false;
         if(this.IsLevelAward())
         {
            if(this.mHasBouncyArrow)
            {
               this.mBouncyArrow.mDead = true;
            }
            if(app.IsAdventureMode() && mBoard.mLevel == 4)
            {
               app.foleyManager.playFoley(PVZFoleyType.SHOVEL);
            }
            else
            {
               app.foleyManager.playFoley(PVZFoleyType.SEEDLIFT);
               app.foleyManager.playFoley(PVZFoleyType.DROP);
               anEffect = app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_STARBURST);
               anEffect.setPosition(this.mPosX + mWidth * this.mScale / 2,this.mPosY + mHeight * this.mScale / 2);
               mBoard.mRenderManager.add(new ParticleRenderable(anEffect,RENDER_LAYER_SCREEN_FADE));
            }
            mBoard.FadeOutLevel();
            if(this.mType == COIN_NOTE)
            {
               anEffect = app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_PRESENTPICKUP);
               anEffect.setPosition(this.mPosX + mWidth * this.mScale / 2,this.mPosY + mHeight * this.mScale / 2);
               mBoard.mRenderManager.add(new ParticleRenderable(anEffect));
               this.StartFade();
            }
            else
            {
               aParticleOffsetX = mWidth * this.mScale / 2;
               aParticleOffsetY = mHeight * this.mScale / 2;
               this.mSeedEffect = app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_AWARD);
               this.mSeedEffect.setPosition(this.mPosX + aParticleOffsetX,this.mPosY + aParticleOffsetY);
               mBoard.mRenderManager.add(new ParticleRenderable(this.mSeedEffect,Board.RENDER_LAYER_PARTICLE));
            }
         }
         else
         {
            if(this.mType == COIN_USABLE_SEED_PACKET)
            {
               mBoard.mCursorObject.mType = this.mUsableSeedType;
               mBoard.mCursorObject.mCursorType = Board.CURSOR_TYPE_PLANT_FROM_USABLE_COIN;
               mBoard.mCursorObject.mCoin = this;
               this.mGroundY = this.mPosY;
               this.mFadeCount = 0;
               return;
            }
            if(this.IsSun() && mBoard && !mBoard.HasConveyorBeltSeedBank())
            {
               for(i = 0; i < mBoard.mSeedBank.mNumPackets; i++)
               {
                  aSeedPacket = mBoard.mSeedBank.mSeedPackets[i];
                  aCost = mBoard.GetCurrentPlantCost(aSeedPacket.mPacketType);
                  aAmountOver = mBoard.mSunMoney + mBoard.CountSunBeingCollected() - aCost;
                  if(aAmountOver >= 0 && aAmountOver < this.GetSunValue())
                  {
                     aSeedPacket.FlashIfReady();
                  }
               }
            }
         }
      }
      
      public function TryAutoCollectAfterLevelAward() : void
      {
         var aCollect:Boolean = false;
         if(this.IsSun())
         {
            aCollect = true;
         }
         if(aCollect)
         {
            this.PlayCollectSound();
            this.Collect();
         }
      }
      
      public function PlayLaunchSound() : void
      {
      }
      
      public function CoinGetsBouncyArrow() : Boolean
      {
         if(this.IsLevelAward())
         {
            return true;
         }
         return false;
      }
      
      public function DroppedUsableSeed() : void
      {
         this.mIsBeingCollected = false;
         if(this.mTimesDropped == 0)
         {
            this.mDisappearCounter = Math.min(this.mDisappearCounter,1200);
         }
         ++this.mTimesDropped;
      }
      
      public function GetFinalSeedPacketType() : int
      {
         var aArea:int = (mBoard.mLevel - 1) / 10 + 1;
         var aSubArea:int = (mBoard.mLevel - 1) % 10 + 1;
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
      
      public function MouseDown(x:int, y:int) : void
      {
         if(!mBoard || mBoard.mPaused || mBoard.mGameScene != Board.SCENE_PLAYING)
         {
            return;
         }
         if(this.mDead)
         {
            return;
         }
         if(!this.mIsBeingCollected)
         {
            if(mBoard.mLevel == 1)
            {
               mBoard.DisplayAdvice("[ADVICE_CLICKED_ON_SUN]",Board.MESSAGE_STYLE_TUTORIAL_LEVEL1_STAY,Board.ADVICE_CLICKED_ON_SUN);
            }
            this.PlayCollectSound();
            this.Collect();
         }
      }
      
      public function GetSunValue() : int
      {
         if(this.mType == COIN_SMALLSUN)
         {
            return 15;
         }
         return 25;
      }
      
      public function drawBufferedImage(g:Graphics2D) : void
      {
         var aSeedType:int = 0;
         var aSeedBackImg:ImageInst = null;
         var aPlantImg:ImageInst = null;
         var theFont:FontInst = null;
         var aCost:int = 0;
         var width:int = 0;
         var height:int = 0;
         var aTextOffsetX:int = 0;
         var aTextOffsetY:int = 0;
         if(this.mType == COIN_USABLE_SEED_PACKET)
         {
            aSeedType = this.mUsableSeedType;
         }
         else
         {
            aSeedType = this.GetFinalSeedPacketType();
         }
         aSeedBackImg = app.imageManager.getImageInst(PVZImages.IMAGE_SEEDPACKET_LARGER);
         var w:Number = aSeedBackImg.width;
         var h:Number = aSeedBackImg.height;
         this.mBufferedImage = new ImageInst(new ImageData(new BitmapData(w,h,true,0)));
         var bufferG:Graphics2D = this.mBufferedImage.graphics;
         bufferG.drawImage(aSeedBackImg,0,0);
         var aOffsetX:Number = 10;
         var aOffsetY:Number = 15;
         var aScale:Number = 1;
         switch(aSeedType)
         {
            case SEED_EXPLODE_O_NUT:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_WALLNUT);
               aPlantImg.useColor = true;
               aPlantImg.setColor(1,1,64 / 255,64 / 255);
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
               aOffsetY += 1;
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
               aScale = 0.85;
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
               aOffsetY += 12;
               aOffsetX += 9;
               break;
            case SEED_SUNSHROOM:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_SUNSHROOM);
               aOffsetY += 13;
               aOffsetX += 10;
               break;
            case SEED_GRAVEBUSTER:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_GRAVEDIGGER);
               aOffsetY += 1;
               aOffsetX += -5;
               aScale = 0.85;
               break;
            case SEED_FUMESHROOM:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_FUMESHROOM);
               aOffsetX -= 2;
               aOffsetY += 1;
               aScale = 0.95;
               break;
            case SEED_WALLNUT:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_WALLNUT);
               aOffsetX += 3;
               break;
            case SEED_LEFTPEATER:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_LEFTFACINGPEASHOOTER);
               aOffsetX += 2;
               aOffsetY += 5;
         }
         bufferG.pushState();
         bufferG.scale(aScale,aScale);
         bufferG.drawImage(aPlantImg,aOffsetX,aOffsetY);
         bufferG.popState();
         if(this.mType == COIN_FINAL_SEED_PACKET)
         {
            theFont = app.fontManager.getFontInst(PVZFonts.FONT_PICO129);
            theFont.scale = 1.6;
            theFont.setColor(1,0,0,0);
            aCost = mBoard.GetCurrentPlantCost(aSeedType);
            width = theFont.stringWidth(String(aCost));
            height = theFont.getAscent();
            aTextOffsetX = 45 - width;
            aTextOffsetY = 72;
            bufferG.setFont(theFont);
            bufferG.drawString(String(aCost),aTextOffsetX,aTextOffsetY);
         }
      }
      
      public function Draw(g:Graphics2D) : void
      {
         var aAlpha:Number = NaN;
         var aFade:int = 0;
         var aGray:int = 0;
         var aDisappearTime:int = 0;
         var aFlashingColor:Color = Color.ARGB(1,1,1,1);
         if(this.IsLevelAward() && !this.mIsBeingCollected)
         {
            aFlashingColor = TodCommon.GetFlashingColor(this.mCoinAge,75);
         }
         var aOffsetX:int = mWidth * 0.5;
         var aOffsetY:int = mHeight * 0.5;
         if(this.mReanimation != null)
         {
            this.mReanimation.x = this.mPosX + aOffsetX;
            this.mReanimation.y = this.mPosY + aOffsetY;
            g.pushState();
            if(this.mType == COIN_SMALLSUN)
            {
               this.mScaleMatrix.a = this.mScale * 0.5;
               this.mScaleMatrix.d = this.mScale * 0.5;
            }
            else
            {
               this.mScaleMatrix.a = this.mScale;
               this.mScaleMatrix.d = this.mScale;
            }
            aAlpha = 1;
            if(this.IsSun() && this.mIsBeingCollected)
            {
               aAlpha = TodCommon.ClampFloat(this.mCollectionDistance * 0.035,0.35,1);
            }
            else if(this.mFadeCount > 0)
            {
               aFade = TodCommon.TodAnimateCurve(15,0,this.mFadeCount,255,0,CURVE_LINEAR);
               aAlpha = aFade / 255;
            }
            this.mReanimation.drawLerp(g,this.mScaleMatrix,aAlpha);
            g.popState();
         }
         if(this.mType == COIN_SUN || this.mType == COIN_SMALLSUN || this.mDead || this.mType == COIN_DYNAMITE)
         {
            return;
         }
         if(this.mType == COIN_FINAL_SEED_PACKET)
         {
            aOffsetX = (mWidth - mWidth * this.mScale) * 0.5;
            aOffsetY = (mHeight - mHeight * this.mScale) * 0.5;
            if(this.mBufferedImage == null)
            {
               this.drawBufferedImage(g);
            }
            g.pushState();
            this.mBufferedImage.useColor = true;
            this.mBufferedImage.setColor(aFlashingColor.alpha,aFlashingColor.red,aFlashingColor.green,aFlashingColor.blue);
            g.scale(this.mScale,this.mScale);
            g.drawImage(this.mBufferedImage,this.mPosX + aOffsetX,this.mPosY + aOffsetY);
            g.popState();
            return;
         }
         if(this.mType == COIN_SHOVEL)
         {
            g.pushState();
            g.scale(this.mScale,this.mScale);
            this.mShovelImage.useColor = true;
            this.mShovelImage.setColor(aFlashingColor.alpha,aFlashingColor.red,aFlashingColor.green,aFlashingColor.blue);
            g.drawImage(this.mShovelImage,this.mPosX,this.mPosY);
            g.popState();
         }
         else if(this.mType == COIN_NOTE)
         {
            g.pushState();
            g.scale(this.mScale,this.mScale);
            this.mZombieNote.useColor = true;
            this.mZombieNote.setColor(aFlashingColor.alpha,aFlashingColor.red,aFlashingColor.green,aFlashingColor.blue);
            g.drawImage(this.mZombieNote,this.mPosX,this.mPosY);
            g.popState();
         }
         else if(this.mType == COIN_USABLE_SEED_PACKET)
         {
            aGray = 255;
            if(this.mIsBeingCollected)
            {
               aGray = 128;
            }
            else
            {
               aDisappearTime = this.GetDisappearTime();
               if(this.mDisappearCounter > aDisappearTime - 300 && this.mDisappearCounter % 60 < 30)
               {
                  aGray = 192;
               }
            }
            if(this.mBufferedImage == null)
            {
               this.drawBufferedImage(g);
            }
            g.pushState();
            this.mBufferedImage.useColor = true;
            this.mBufferedImage.setColor(1,aGray / 255,aGray / 255,aGray / 255);
            g.scale(0.5,0.5);
            g.drawImage(this.mBufferedImage,this.mPosX,this.mPosY);
            g.popState();
            return;
         }
      }
      
      public function StartFade() : void
      {
         this.mFadeCount = 15;
      }
      
      public function UpdateCollected() : void
      {
         var aDestX:int = 0;
         var aDestY:int = 0;
         if(this.mType == COIN_FINAL_SEED_PACKET)
         {
         }
         if(this.IsSun())
         {
            aDestX = 16;
            aDestY = 3;
         }
         else
         {
            if(this.mType == COIN_USABLE_SEED_PACKET)
            {
               ++this.mDisappearCounter;
               return;
            }
            if(this.IsLevelAward())
            {
               if(this.mType == COIN_SHOVEL)
               {
                  aDestX = 250;
                  aDestY = 115;
               }
               else
               {
                  aDestX = 236;
                  aDestY = 87;
               }
               ++this.mDisappearCounter;
            }
         }
         if(this.IsLevelAward())
         {
            if(this.mType == COIN_SHOVEL)
            {
               this.mScale = TodCommon.TodAnimateCurveFloat(0,270,this.mDisappearCounter,1,1,TodCommon.CURVE_EASE_IN_OUT);
            }
            else
            {
               this.mScale = TodCommon.TodAnimateCurveFloat(0,270,this.mDisappearCounter,0.51,1,TodCommon.CURVE_EASE_IN_OUT);
            }
            this.mPosX = TodCommon.TodAnimateCurveFloat(0,236,this.mDisappearCounter,this.mCollectX,aDestX,TodCommon.CURVE_EASE_OUT);
            this.mPosY = TodCommon.TodAnimateCurveFloat(0,236,this.mDisappearCounter,this.mCollectY,aDestY,TodCommon.CURVE_EASE_OUT);
            return;
         }
         var aDeltaX:Number = Math.abs(this.mPosX - aDestX);
         var aDeltaY:Number = Math.abs(this.mPosY - aDestY);
         if(this.mPosX > aDestX)
         {
            this.mPosX -= aDeltaX / 21;
         }
         else if(this.mPosX < aDestX)
         {
            this.mPosX += aDeltaX / 21;
         }
         if(this.mPosY > aDestY)
         {
            this.mPosY -= aDeltaY / 21;
         }
         else if(this.mPosY < aDestY)
         {
            this.mPosY += aDeltaY / 21;
         }
         this.mCollectionDistance = Math.sqrt(aDeltaY * aDeltaY + aDeltaX * aDeltaX);
         var aScoringDistance:Number = 8;
         if(this.mCollectionDistance < aScoringDistance)
         {
            this.ScoreCoin();
         }
         this.mScale = TodCommon.ClampFloat(this.mCollectionDistance * 0.05,0.5,1);
         this.mScale *= 1;
      }
      
      public function Update() : void
      {
         var anEffect:ParticleSystem = null;
         if(mBoard.mGameScene == Board.SCENE_ZOMBIES_WON || mBoard.mGameScene == Board.SCENE_AWARD || mBoard.mGameScene == Board.SCENE_LEVEL_INTRO)
         {
            return;
         }
         if(this.mExplode > 0)
         {
            --this.mExplode;
            if(this.mExplode == 0)
            {
               app.foleyManager.playFoley(PVZFoleyType.CHERRYBOMB);
               app.foleyManager.playFoley(PVZFoleyType.JUICY);
               anEffect = app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_POWIE);
               anEffect.setPosition(this.mPosX + 40,this.mPosY + 50);
               mBoard.mRenderManager.add(new ParticleRenderable(anEffect,Board.RENDER_LAYER_PARTICLE));
               mBoard.ShakeBoard(10,-15);
               mBoard.mChallenge.ScaryPotterJackExplode(this.mPosX + 40,this.mPosY + 50);
               mBoard.KillAllPlantsInRadius(this.mPosX + 40,this.mPosY + 50,90);
               this.Die();
            }
         }
         ++this.mCoinAge;
         if(this.mReanimation != null)
         {
            this.mReanimation.update();
         }
         if(mBoard.mGameScene != Board.SCENE_PLAYING && mBoard.mGameScene != Board.SCENE_AWARD)
         {
            return;
         }
         if(this.mFadeCount > 0)
         {
            this.UpdateFade();
         }
         else if(!this.mIsBeingCollected)
         {
            this.UpdateFall();
         }
         else
         {
            this.UpdateCollected();
         }
         var aParticleOffsetX:Number = mWidth / 2;
         var aParticleOffsetY:Number = mHeight / 2;
         if(this.mSeedEffect != null)
         {
            this.mSeedEffect.setPosition(this.mPosX + aParticleOffsetX,this.mPosY + aParticleOffsetY);
         }
      }
      
      public function PlayCollectSound() : void
      {
         if(this.IsSun())
         {
            app.foleyManager.playFoley(PVZFoleyType.SUN);
         }
         else if(this.mType == COIN_USABLE_SEED_PACKET)
         {
            app.foleyManager.playFoley(PVZFoleyType.SEEDLIFT);
         }
      }
   }
}
