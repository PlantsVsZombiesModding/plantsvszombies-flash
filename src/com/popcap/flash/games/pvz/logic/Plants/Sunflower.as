package com.popcap.flash.games.pvz.logic.Plants
{
   import com.popcap.flash.framework.resources.reanimator.Reanimation;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.PVZFoleyType;
   import com.popcap.flash.games.pvz.logic.Board;
   import com.popcap.flash.games.pvz.logic.TodCommon;
   import com.popcap.flash.games.pvz.resources.PVZReanims;
   
   public class Sunflower extends CPlant
   {
      
      private static const COIN_NONE:String = "none";
      
      private static const COIN_MOTION_FROM_SKY:String = "from sky";
      
      private static const COIN_MOTION_FROM_PLANT:String = "from plant";
      
      private static const COIN_MOTION_FROM_SKY_SLOW:String = "from sky slow";
      
      private static const COIN_SUN:String = "sun";
       
      
      public function Sunflower(theGridX:int, theGridY:int, theSeedType:int, app:PVZApp, theBoard:Board)
      {
         super();
         this.app = app;
         mBoard = theBoard;
         mPlantCol = theGridX;
         mRow = theGridY;
         if(mBoard)
         {
            mX = mBoard.GridToPixelX(theGridX,theGridY);
            mY = mBoard.GridToPixelY(theGridX,theGridY);
         }
         mAnimCounter = 0;
         mAnimPing = true;
         mFrame = 0;
         mShootingCounter = 0;
         mFrameLength = 18;
         mNumFrames = 5;
         mDead = false;
         mSquished = false;
         mSeedType = theSeedType;
         mPlantHealth = 300;
         mDoSpecialCountdown = 0;
         mDisappearCountdown = 200;
         mTargetX = -1;
         mTargetY = -1;
         mStateCountdown = 0;
         mStartRow = mRow;
         mBlinkCountdown = 0;
         mRecentlyEatenCountdown = 0;
         mEatenFlashCountdown = 0;
         mHighlighted = false;
         mWidth = 54;
         mHeight = 54;
         mLaunchRate = 2500;
         mReanimationType = REANIM_SUNFLOWER;
         var aBodyReanim:Reanimation = app.reanimator.createReanimation(PVZReanims.REANIM_SUNFLOWER);
         aBodyReanim.loopType = Reanimation.LOOP_TYPE_ALWAYS;
         aBodyReanim.animRate = TodCommon.RandRangeFloat(10,15);
         aBodyReanim.currentTrack = "anim_idle";
         mBodyReanimation = aBodyReanim;
         mLaunchCounter = TodCommon.RandRangeInt(300,mLaunchRate / 2);
      }
      
      override public function Animate() : void
      {
         var maxTime:int = 0;
         if(mRecentlyEatenCountdown > 0)
         {
            --mRecentlyEatenCountdown;
         }
         if(mEatenFlashCountdown > 0)
         {
            --mEatenFlashCountdown;
         }
         if(mSquished)
         {
            mFrame = 0;
            return;
         }
         UpdateBlink();
         if(mAnimPing)
         {
            maxTime = mFrameLength * mNumFrames - 1;
            if(mAnimCounter < maxTime)
            {
               ++mAnimCounter;
            }
            else
            {
               mAnimPing = false;
               mAnimCounter -= mFrameLength;
            }
         }
         else if(mAnimCounter > 0)
         {
            --mAnimCounter;
         }
         else
         {
            mAnimPing = true;
            mAnimCounter += mFrameLength;
         }
         mFrame = mAnimCounter / mFrameLength;
      }
      
      override public function Update() : void
      {
         if(mBoard.mGameScene == Board.SCENE_ZOMBIES_WON || mBoard.mGameScene == Board.SCENE_AWARD || mBoard.mGameScene == Board.SCENE_LEVEL_INTRO)
         {
            return;
         }
         this.UpdateAbilities();
         this.Animate();
         UpdateReanimColor();
         UpdateReanim();
      }
      
      public function UpdateProductionPlant() : void
      {
         var aLightUpAmount:int = 0;
         if(mBoard.HasLevelAwardDropped())
         {
            return;
         }
         --mLaunchCounter;
         if(mLaunchCounter <= 100)
         {
            aLightUpAmount = TodCommon.TodAnimateCurve(100,0,mLaunchCounter,0,100,TodCommon.CURVE_LINEAR);
            mEatenFlashCountdown = Math.max(mEatenFlashCountdown,aLightUpAmount);
         }
         if(mLaunchCounter <= 0)
         {
            mLaunchCounter = TodCommon.RandRangeInt(mLaunchRate - 150,mLaunchRate);
            app.foleyManager.playFoley(PVZFoleyType.SPAWN_SUN);
            mBoard.AddCoin(mX,mY,COIN_SUN,COIN_MOTION_FROM_PLANT);
         }
      }
      
      public function UpdateAbilities() : void
      {
         if(!IsInPlay())
         {
            return;
         }
         if(mStateCountdown > 0)
         {
            --mStateCountdown;
         }
         this.UpdateProductionPlant();
         if(mDoSpecialCountdown > 0)
         {
            --mDoSpecialCountdown;
            if(mDoSpecialCountdown == 0)
            {
            }
         }
      }
   }
}
