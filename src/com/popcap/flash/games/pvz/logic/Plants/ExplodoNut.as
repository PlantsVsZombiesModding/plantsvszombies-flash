package com.popcap.flash.games.pvz.logic.Plants
{
   import com.popcap.flash.framework.graphics.Color;
   import com.popcap.flash.framework.resources.reanimator.Reanimation;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.PVZFoleyType;
   import com.popcap.flash.games.pvz.logic.Board;
   import com.popcap.flash.games.pvz.logic.TodCommon;
   import com.popcap.flash.games.pvz.resources.PVZReanims;
   
   public class ExplodoNut extends CPlant
   {
       
      
      public function ExplodoNut(theGridX:int, theGridY:int, theSeedType:int, app:PVZApp, theBoard:Board)
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
         mState = STATE_NOTREADY;
         mDead = false;
         mSquished = false;
         mSeedType = theSeedType;
         mPlantHealth = 4000;
         mDoSpecialCountdown = 0;
         mDisappearCountdown = 200;
         mTargetX = -1;
         mTargetY = -1;
         mStateCountdown = 0;
         mStartRow = mRow;
         mBlinkCountdown = 0;
         mRecentlyEatenCountdown = 0;
         mEatenFlashCountdown = 0;
         mWidth = 54;
         mHeight = 54;
         mLaunchRate = 2500;
         mReanimationType = REANIM_WALLNUT;
         var aBodyReanim:Reanimation = app.reanimator.createReanimation(PVZReanims.REANIM_WALLNUT);
         if(mBoard.IsWallnutBowlingLevel())
         {
            aBodyReanim.loopType = Reanimation.LOOP_TYPE_ALWAYS;
            aBodyReanim.animRate = TodCommon.RandRangeFloat(12,18);
            aBodyReanim.currentTrack = "_ground";
            app.foleyManager.playFoley(PVZFoleyType.BOWLING);
         }
         else
         {
            aBodyReanim.loopType = Reanimation.LOOP_TYPE_ALWAYS;
            aBodyReanim.animRate = TodCommon.RandRangeFloat(10,15);
            aBodyReanim.currentTrack = "anim_idle1";
         }
         aBodyReanim.useColor = true;
         aBodyReanim.overrideColor = Color.RGB(1,64 / 255,64 / 255);
         mBodyReanimation = aBodyReanim;
         mLaunchCounter = TodCommon.RandRangeInt(300,mLaunchRate / 2);
         mPlantMaxHealth = mPlantHealth;
      }
      
      override public function Update() : void
      {
         if(mStateCountdown > 0)
         {
            --mStateCountdown;
         }
         if(mBoard.IsWallnutBowlingLevel())
         {
            UpdateBowling();
         }
         this.AnimateNuts();
         Animate();
         if(mPlantHealth < 0)
         {
            Die();
         }
         UpdateReanim();
      }
      
      public function AnimateNuts() : void
      {
         if(mBoard.mGameScene == Board.SCENE_ZOMBIES_WON || mBoard.mGameScene == Board.SCENE_AWARD || mBoard.mGameScene == Board.SCENE_LEVEL_INTRO)
         {
            return;
         }
         if(mRecentlyEatenCountdown > 0)
         {
            --mRecentlyEatenCountdown;
         }
         if(mEatenFlashCountdown > 0)
         {
            --mEatenFlashCountdown;
         }
         if(mPlantHealth < mPlantMaxHealth / 3)
         {
            mBodyReanimation.currentTrack = "anim_idle3";
         }
         else if(mPlantHealth < mPlantMaxHealth * 2 / 3)
         {
            mBodyReanimation.currentTrack = "anim_idle2";
         }
         if(mRecentlyEatenCountdown > 0)
         {
            mBodyReanimation.animRate = 0.1;
         }
         else
         {
            mBodyReanimation.animRate = TodCommon.RandRangeFloat(10,15);
         }
      }
   }
}
