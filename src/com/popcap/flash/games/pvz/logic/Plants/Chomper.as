package com.popcap.flash.games.pvz.logic.Plants
{
   import com.popcap.flash.framework.resources.reanimator.Reanimation;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.PVZFoleyType;
   import com.popcap.flash.games.pvz.logic.Board;
   import com.popcap.flash.games.pvz.logic.TodCommon;
   import com.popcap.flash.games.pvz.logic.Zombies.Zombie;
   import com.popcap.flash.games.pvz.resources.PVZReanims;
   
   public class Chomper extends CPlant
   {
       
      
      public function Chomper(theGridX:int, theGridY:int, theSeedType:int, app:PVZApp, theBoard:Board)
      {
         super();
         this.app = app;
         mBoard = theBoard;
         mPlantCol = theGridX;
         mRow = theGridY;
         if(mBoard)
         {
            mX = mBoard.GridToPixelX(theGridX,theGridY) + 5;
            mY = mBoard.GridToPixelY(theGridX,theGridY);
         }
         mAnimCounter = 0;
         mAnimPing = true;
         mFrame = 0;
         mShootingCounter = 0;
         mFrameLength = 18;
         mNumFrames = 5;
         mState = STATE_READY;
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
         mWidth = 54;
         mHeight = 54;
         mLaunchRate = 2500;
         mReanimationType = REANIM_SUNFLOWER;
         var aBodyReanim:Reanimation = app.reanimator.createReanimation(PVZReanims.REANIM_CHOMPER);
         aBodyReanim.loopType = Reanimation.LOOP_TYPE_ALWAYS;
         aBodyReanim.animRate = TodCommon.RandRangeFloat(13,17);
         aBodyReanim.currentTrack = "anim_idle";
         mBodyReanimation = aBodyReanim;
         mLaunchCounter = TodCommon.RandRangeInt(300,mLaunchRate / 2);
      }
      
      public function UpdateChomper() : void
      {
         var aZombie:Zombie = null;
         if(mState == STATE_READY)
         {
            aZombie = FindTargetZombie(mRow,WEAPON_PRIMARY);
            if(aZombie)
            {
               mBodyReanimation.loopType = Reanimation.LOOP_TYPE_ONCE_AND_HOLD;
               mBodyReanimation.animRate = 24;
               mBodyReanimation.currentTrack = "anim_bite";
               mState = STATE_CHOMPER_BITING;
               mStateCountdown = 70;
            }
         }
         else if(mState == STATE_CHOMPER_BITING)
         {
            if(mStateCountdown == 0)
            {
               app.foleyManager.playFoley(PVZFoleyType.BIGCHOMP);
               aZombie = FindTargetZombie(mRow,WEAPON_PRIMARY);
               if(aZombie && aZombie.mZombiePhase != PHASE_POLEVAULTER_IN_VAULT && aZombie.mZombiePhase != PHASE_POLEVAULTER_PRE_VAULT)
               {
                  app.foleyManager.playFoley(PVZFoleyType.GULP);
                  aZombie.DieWithLoot();
                  mState = STATE_CHOMPER_BITING_GOT_ONE;
               }
               else
               {
                  mState = STATE_CHOMPER_BITING_MISSED;
               }
               mStateCountdown = 40;
            }
         }
         else if(mState == STATE_CHOMPER_BITING_GOT_ONE)
         {
            if(mStateCountdown == 0)
            {
               mBodyReanimation.loopType = Reanimation.LOOP_TYPE_ALWAYS;
               mBodyReanimation.animRate = 15;
               mBodyReanimation.currentTrack = "anim_chew";
               mState = STATE_CHOMPER_DIGESTING;
               mStateCountdown = 4000;
            }
         }
         else if(mState == STATE_CHOMPER_DIGESTING)
         {
            if(mStateCountdown == 0)
            {
               mBodyReanimation.loopType = Reanimation.LOOP_TYPE_ONCE_AND_HOLD;
               mBodyReanimation.animRate = 12;
               mBodyReanimation.currentTrack = "anim_swallow";
               mState = STATE_CHOMPER_SWALLOWING;
               mStateCountdown = 230;
            }
         }
         else if(mState == STATE_CHOMPER_SWALLOWING || mState == STATE_CHOMPER_BITING_MISSED)
         {
            if(mStateCountdown == 0)
            {
               mBodyReanimation.loopType = Reanimation.LOOP_TYPE_ALWAYS;
               mBodyReanimation.animRate = TodCommon.RandRangeFloat(13,17);
               mBodyReanimation.currentTrack = "anim_idle";
               mState = STATE_READY;
            }
         }
      }
      
      override public function Update() : void
      {
         if(mBoard.mGameScene == Board.SCENE_ZOMBIES_WON || mBoard.mGameScene == Board.SCENE_AWARD || mBoard.mGameScene == Board.SCENE_LEVEL_INTRO)
         {
            return;
         }
         if(mStateCountdown > 0)
         {
            --mStateCountdown;
         }
         this.UpdateChomper();
         Animate();
         if(mPlantHealth < 0)
         {
            Die();
         }
         UpdateReanimColor();
         UpdateReanim();
      }
   }
}
