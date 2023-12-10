package com.popcap.flash.games.pvz.logic.Plants
{
   import com.popcap.flash.framework.resources.particles.ParticleSystem;
   import com.popcap.flash.framework.resources.reanimator.Reanimation;
   import com.popcap.flash.framework.resources.reanimator.looptypes.ReanimLoopOnceAndIdle;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.PVZFoleyType;
   import com.popcap.flash.games.pvz.logic.Board;
   import com.popcap.flash.games.pvz.logic.TodCommon;
   import com.popcap.flash.games.pvz.logic.Zombies.Zombie;
   import com.popcap.flash.games.pvz.renderables.ParticleRenderable;
   import com.popcap.flash.games.pvz.resources.PVZParticles;
   import com.popcap.flash.games.pvz.resources.PVZReanims;
   import flash.geom.Rectangle;
   
   public class FumeShroom extends CPlant
   {
       
      
      public function FumeShroom(theGridX:int, theGridY:int, theSeedType:int, app:PVZApp, theBoard:Board)
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
         if(IsNocturnal(mSeedType) && mBoard && !mBoard.StageIsNight())
         {
            SetSleeping(true);
         }
         mLaunchRate = 150;
         mLaunchCounter = TodCommon.RandRangeInt(0,mLaunchRate);
         mBodyReanimation = app.reanimator.createReanimation(PVZReanims.REANIM_FUMESHROOM);
         mBodyReanimation.animRate = TodCommon.RandRangeFloat(15,20);
         mBodyReanimation.loopType = Reanimation.LOOP_TYPE_ALWAYS;
         mBodyReanimation.currentTrack = "anim_idle";
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
      
      public function FindTargetAndFire(theRow:int, thePlantWeapon:int) : Boolean
      {
         var aZombie:Zombie = FindTargetZombie(theRow,thePlantWeapon);
         if(!aZombie)
         {
            return false;
         }
         var idleRate:Number = TodCommon.RandRangeFloat(15,20);
         mBodyReanimation.animRate = 35;
         mBodyReanimation.currentTrack = "anim_shooting";
         mBodyReanimation.loopType = new ReanimLoopOnceAndIdle("anim_idle",idleRate);
         mShootingCounter = 50;
         return true;
      }
      
      public function UpdateShooter() : void
      {
         --mLaunchCounter;
         if(mLaunchCounter <= 0)
         {
            mLaunchCounter = mLaunchRate - Math.random() * 15;
            this.FindTargetAndFire(mRow,WEAPON_PRIMARY);
         }
         if(mLaunchCounter == 25)
         {
            if(mSeedType == SEED_REPEATER)
            {
               this.FindTargetAndFire(mRow,WEAPON_PRIMARY);
            }
         }
      }
      
      public function Fire(theTargetZombie:Zombie, theRow:int, thePlantWeapon:int) : void
      {
         this.DoRowAreaDamage(20);
         app.foleyManager.playFoley(PVZFoleyType.FUME);
      }
      
      override public function Update() : void
      {
         if(mBoard.mGameScene == Board.SCENE_ZOMBIES_WON || mBoard.mGameScene == Board.SCENE_AWARD || mBoard.mGameScene == Board.SCENE_LEVEL_INTRO)
         {
            return;
         }
         this.UpdateShooting();
         this.UpdateShooter();
         this.Animate();
         if(mPlantHealth < 0)
         {
            Die();
         }
         UpdateReanimColor();
         UpdateReanim();
      }
      
      public function DoRowAreaDamage(theDamage:int) : void
      {
         var aZombie:Zombie = null;
         var aRowDiff:int = 0;
         var aZombieRect:Rectangle = null;
         var aOverlap:int = 0;
         var aFinalDamage:int = 0;
         var aAttackRect:Rectangle = GetPlantAttackRect(WEAPON_PRIMARY);
         for each(aZombie in mBoard.mZombies)
         {
            aRowDiff = aZombie.mRow - mRow;
            if(aRowDiff == 0)
            {
               if(aZombie.EffectedByDamage())
               {
                  aZombieRect = aZombie.GetZombieRect();
                  aOverlap = mBoard.GetRectOverlap(aAttackRect,aZombieRect);
                  if(aOverlap > 0)
                  {
                     aFinalDamage = theDamage;
                     aZombie.TakeDamage(aFinalDamage,DAMAGE_HITS_SHIELD_AND_BODY);
                     app.foleyManager.playFoley(PVZFoleyType.SPLAT);
                  }
               }
            }
         }
      }
      
      public function UpdateShooting() : void
      {
         var anEffect:ParticleSystem = null;
         if(mShootingCounter == 0)
         {
            return;
         }
         --mShootingCounter;
         if(mSeedType == SEED_FUMESHROOM)
         {
            if(mShootingCounter == 15)
            {
               anEffect = app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_FUMECLOUD);
               anEffect.setPosition(mX + 58,mY + 24);
               mBoard.mRenderManager.add(new ParticleRenderable(anEffect,Board.RENDER_LAYER_PARTICLE));
            }
         }
         if(mShootingCounter == 1)
         {
            this.Fire(null,mRow,WEAPON_PRIMARY);
         }
         if(mShootingCounter != 0)
         {
            return;
         }
         mShootingCounter = 1;
      }
   }
}
