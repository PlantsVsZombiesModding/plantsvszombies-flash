package com.popcap.flash.games.pvz.logic.Plants
{
   import com.popcap.flash.framework.resources.particles.ParticleSystem;
   import com.popcap.flash.framework.resources.reanimator.Reanimation;
   import com.popcap.flash.framework.resources.reanimator.looptypes.ReanimLoopOnceAndIdle;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.PVZFoleyType;
   import com.popcap.flash.games.pvz.logic.Board;
   import com.popcap.flash.games.pvz.logic.Projectile;
   import com.popcap.flash.games.pvz.logic.TodCommon;
   import com.popcap.flash.games.pvz.logic.Zombies.Zombie;
   import com.popcap.flash.games.pvz.renderables.ParticleRenderable;
   import com.popcap.flash.games.pvz.resources.PVZParticles;
   import com.popcap.flash.games.pvz.resources.PVZReanims;
   
   public class PuffShroom extends CPlant
   {
       
      
      public function PuffShroom(theGridX:int, theGridY:int, theSeedType:int, app:PVZApp, theBoard:Board)
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
         mLaunchRate = 150;
         if(IsNocturnal(mSeedType) && mBoard && !mBoard.StageIsNight())
         {
            SetSleeping(true);
         }
         mLaunchCounter = TodCommon.RandRangeInt(0,mLaunchRate);
         mBodyReanimation = app.reanimator.createReanimation(PVZReanims.REANIM_PUFFSHROOM);
         mBodyReanimation.animRate = TodCommon.RandRangeFloat(15,20);
         mBodyReanimation.loopType = Reanimation.LOOP_TYPE_ALWAYS;
         mBodyReanimation.currentTrack = "anim_idle";
         if(IsInPlay())
         {
            mX += Math.random() * 6 - 3;
            mY += Math.random() * 4 - 2;
         }
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
         mShootingCounter = 29;
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
         var aProjectileType:int = 0;
         switch(mSeedType)
         {
            case SEED_PEASHOOTER:
               aProjectileType = PROJECTILE_PEA;
               break;
            case SEED_REPEATER:
               aProjectileType = PROJECTILE_PEA;
               break;
            case SEED_SNOWPEA:
               aProjectileType = PROJECTILE_SNOWPEA;
               break;
            case SEED_PUFFSHROOM:
               aProjectileType = PROJECTILE_PUFF;
         }
         app.foleyManager.playFoley(PVZFoleyType.PUFF);
         var aOriginX:int = mX + 30;
         var aOriginY:int = mY + 30;
         var anEffect:ParticleSystem = app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_PUFFSHROOMMUZZLE);
         anEffect.setPosition(aOriginX + 6,aOriginY + 10);
         mBoard.mRenderManager.add(new ParticleRenderable(anEffect));
         var aProjectile:Projectile = mBoard.AddProjectile(aOriginX,aOriginY,mRenderOrder,theRow,aProjectileType);
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
      
      public function UpdateShooting() : void
      {
         if(mShootingCounter == 0)
         {
            return;
         }
         --mShootingCounter;
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
