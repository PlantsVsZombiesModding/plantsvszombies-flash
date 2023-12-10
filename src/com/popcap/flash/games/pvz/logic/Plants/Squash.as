package com.popcap.flash.games.pvz.logic.Plants
{
   import com.popcap.flash.framework.resources.reanimator.Reanimation;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.PVZFoleyType;
   import com.popcap.flash.games.pvz.logic.Board;
   import com.popcap.flash.games.pvz.logic.TodCommon;
   import com.popcap.flash.games.pvz.logic.Zombies.Zombie;
   import com.popcap.flash.games.pvz.resources.PVZReanims;
   import flash.geom.Rectangle;
   
   public class Squash extends CPlant
   {
      
      private static const SQUASH_RISE_TIME:int = 50;
      
      private static const DAMAGE_FREEZE:int = 0;
      
      private static const DAMAGE_BYPASSES_SHIELD:int = 2;
      
      private static const DAMAGE_DOESNT_CAUSE_FLASH:int = 1;
      
      private static const SQUASH_FALL_HEIGHT:int = 120;
      
      private static const SQUASH_LOOK_TIME:int = 80;
      
      private static const DAMAGE_HITS_SHIELD_AND_BODY:int = 3;
      
      private static const SQUASH_FALL_TIME:int = 10;
      
      private static const SQUASH_DONE_TIME:int = 100;
      
      private static const DAMAGE_DOESNT_LEAVE_BODY:int = 4;
      
      private static const SQUASH_PRE_LAUNCH_TIME:int = 45;
       
      
      public function Squash(theGridX:int, theGridY:int, theSeedType:int, app:PVZApp, theBoard:Board)
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
         var aBodyReanim:Reanimation = app.reanimator.createReanimation(PVZReanims.REANIM_SQUASH);
         aBodyReanim.loopType = Reanimation.LOOP_TYPE_ALWAYS;
         aBodyReanim.animRate = TodCommon.RandRangeFloat(10,15);
         aBodyReanim.currentTrack = "anim_idle";
         mBodyReanimation = aBodyReanim;
         mLaunchCounter = TodCommon.RandRangeInt(300,mLaunchRate / 2);
      }
      
      public function DoSquashDamage() : void
      {
         var aZombie:Zombie = null;
         var aRowDiff:int = 0;
         var aZombieRect:Rectangle = null;
         var aRectOverlap:int = 0;
         var aRange:int = 0;
         var aAttackRect:Rectangle = GetPlantAttackRect(WEAPON_PRIMARY);
         for each(aZombie in mBoard.mZombies)
         {
            aRowDiff = aZombie.mRow - mRow;
            if(aRowDiff == 0)
            {
               aZombieRect = aZombie.GetZombieRect();
               aRectOverlap = mBoard.GetRectOverlap(aAttackRect,aZombieRect);
               aRange = 0;
               if(aRectOverlap > aRange)
               {
                  aZombie.TakeDamage(1800,DAMAGE_DOESNT_LEAVE_BODY);
               }
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
         this.UpdateSquash();
         Animate();
         if(mPlantHealth < 0)
         {
            Die();
         }
         UpdateReanimColor();
         UpdateReanim();
      }
      
      public function FindSquashTarget() : Zombie
      {
         var aZombie:Zombie = null;
         var aRowDiff:int = 0;
         var aZombieRect:Rectangle = null;
         var aRange:int = 0;
         var aDist:int = 0;
         var aCheckLeftDistance:int = 0;
         var aAttackRect:Rectangle = GetPlantAttackRect(WEAPON_PRIMARY);
         var aClosestRange:int = 0;
         var aClosestZombie:Zombie = null;
         for each(aZombie in mBoard.mZombies)
         {
            aRowDiff = aZombie.mRow - mRow;
            if(aRowDiff == 0)
            {
               if(aZombie.mHasHead)
               {
                  aZombieRect = aZombie.GetZombieRect();
                  if(!(aZombie.mZombiePhase == PHASE_POLEVAULTER_PRE_VAULT && aZombieRect.x < mX + 20))
                  {
                     if(aZombie.mZombiePhase == PHASE_POLEVAULTER_PRE_VAULT || aZombie.mZombiePhase == PHASE_POLEVAULTER_IN_VAULT)
                     {
                        continue;
                     }
                  }
                  aRange = 70;
                  if(aZombie.mIsEating)
                  {
                     aRange = 110;
                  }
                  aDist = -mBoard.GetRectOverlap(aAttackRect,aZombieRect);
                  if(aDist <= aRange)
                  {
                     aCheckLeftDistance = aAttackRect.x;
                     if(aZombie.mZombiePhase == PHASE_POLEVAULTER_POST_VAULT || aZombie.mZombiePhase == PHASE_POLEVAULTER_PRE_VAULT)
                     {
                        aCheckLeftDistance = aAttackRect.x - 60;
                     }
                     if(aZombieRect.x + aZombieRect.width >= aCheckLeftDistance)
                     {
                        if(aZombie == mTargetZombie)
                        {
                           return aZombie;
                        }
                        if(!aClosestZombie || aDist < aClosestRange)
                        {
                           aClosestZombie = aZombie;
                           aClosestRange = aDist;
                        }
                     }
                  }
               }
            }
         }
         return aClosestZombie;
      }
      
      public function UpdateSquash() : void
      {
         var aZombie:Zombie = null;
         var aStartX:int = 0;
         var aStartY:int = 0;
         var aOffsetY:Number = NaN;
         if(mState == STATE_NOTREADY)
         {
            aZombie = this.FindSquashTarget();
            if(!aZombie)
            {
               return;
            }
            mTargetZombie = aZombie;
            mTargetX = int(aZombie.ZombieTargetLeadX(0)) - mWidth / 2;
            mState = STATE_SQUASH_LOOK;
            mStateCountdown = SQUASH_LOOK_TIME;
            if(mTargetX < mX)
            {
               mBodyReanimation.currentTrack = "anim_lookleft";
               mBodyReanimation.animRate = 24;
               mBodyReanimation.loopType = Reanimation.LOOP_TYPE_ONCE_AND_HOLD;
            }
            else
            {
               mBodyReanimation.currentTrack = "anim_lookright";
               mBodyReanimation.animRate = 24;
               mBodyReanimation.loopType = Reanimation.LOOP_TYPE_ONCE_AND_HOLD;
            }
            app.foleyManager.playFoley(PVZFoleyType.SQUASH_HMM);
            return;
         }
         if(mState == STATE_SQUASH_LOOK)
         {
            if(mStateCountdown == 0)
            {
               mBodyReanimation.currentTrack = "anim_jumpup";
               mBodyReanimation.animRate = 24;
               mBodyReanimation.loopType = Reanimation.LOOP_TYPE_ONCE_AND_HOLD;
               mState = STATE_SQUASH_PRE_LAUNCH;
               mStateCountdown = SQUASH_PRE_LAUNCH_TIME;
            }
            return;
         }
         if(mState == STATE_SQUASH_PRE_LAUNCH)
         {
            if(mStateCountdown == 0)
            {
               aZombie = this.FindSquashTarget();
               if(aZombie)
               {
                  mTargetX = int(aZombie.ZombieTargetLeadX(30)) - mWidth / 2;
               }
               mState = STATE_SQUASH_RISING;
               mStateCountdown = SQUASH_RISE_TIME;
            }
            return;
         }
         var aTargetCol:int = mBoard.PixelToGridXKeepOnBoard(mTargetX,mY);
         var aDestX:int = mTargetX;
         var aDestY:int = mBoard.GridToPixelY(aTargetCol,mRow) + 8;
         if(mState == STATE_SQUASH_RISING)
         {
            aStartX = mBoard.GridToPixelX(mPlantCol,mStartRow);
            aStartY = mBoard.GridToPixelY(mPlantCol,mStartRow);
            mX = TodCommon.TodAnimateCurve(SQUASH_RISE_TIME,20,mStateCountdown,aStartX,aDestX,TodCommon.CURVE_EASE_IN_OUT);
            mY = TodCommon.TodAnimateCurve(SQUASH_RISE_TIME,20,mStateCountdown,aStartY,aDestY - SQUASH_FALL_HEIGHT,TodCommon.CURVE_EASE_IN_OUT);
            if(mStateCountdown == 0)
            {
               mBodyReanimation.currentTrack = "anim_jumpdown";
               mBodyReanimation.animRate = 24;
               mBodyReanimation.loopType = Reanimation.LOOP_TYPE_ONCE_AND_HOLD;
               mState = STATE_SQUASH_FALLING;
               mStateCountdown = SQUASH_FALL_TIME;
            }
         }
         else if(mState == STATE_SQUASH_FALLING)
         {
            mY = TodCommon.TodAnimateCurve(SQUASH_FALL_TIME,0,mStateCountdown,aDestY - SQUASH_FALL_HEIGHT,aDestY,TodCommon.CURVE_LINEAR);
            if(mStateCountdown == 5)
            {
               this.DoSquashDamage();
               app.foleyManager.playFoley(PVZFoleyType.SPLAT);
            }
            if(mStateCountdown == 0)
            {
               mState = STATE_SQUASH_DONE_FALLING;
               mStateCountdown = SQUASH_DONE_TIME;
               mBoard.ShakeBoard(1,4);
               app.foleyManager.playFoley(PVZFoleyType.THUMP);
               aOffsetY = 80;
            }
         }
         else if(mState == STATE_SQUASH_DONE_FALLING)
         {
            if(mStateCountdown == 0)
            {
               Die();
            }
         }
      }
   }
}
