package com.popcap.flash.games.pvz.logic.Plants
{
   import com.popcap.flash.framework.resources.particles.ParticleSystem;
   import com.popcap.flash.framework.resources.reanimator.Reanimation;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.PVZFoleyType;
   import com.popcap.flash.games.pvz.logic.Board;
   import com.popcap.flash.games.pvz.logic.TodCommon;
   import com.popcap.flash.games.pvz.renderables.ParticleRenderable;
   import com.popcap.flash.games.pvz.resources.PVZParticles;
   import com.popcap.flash.games.pvz.resources.PVZReanims;
   
   public class CherryBomb extends CPlant
   {
       
      
      public function CherryBomb(theGridX:int, theGridY:int, theSeedType:int, app:PVZApp, theBoard:Board)
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
         mReanimationType = REANIM_CHERRYBOMB;
         mBodyReanimation = app.reanimator.createReanimation(PVZReanims.REANIM_CHERRYBOMB);
         if(IsInPlay())
         {
            mDoSpecialCountdown = 100;
            mBodyReanimation.loopType = Reanimation.LOOP_TYPE_ONCE_AND_HOLD;
            mBodyReanimation.currentTrack = "anim_explode";
            mBodyReanimation.animRate = TodCommon.RandRangeFloat(10,15);
            app.foleyManager.playFoley(PVZFoleyType.REVERSE_EXPLOSION);
         }
      }
      
      override public function Update() : void
      {
         if(mBoard.mGameScene == Board.SCENE_ZOMBIES_WON || mBoard.mGameScene == Board.SCENE_AWARD || mBoard.mGameScene == Board.SCENE_LEVEL_INTRO)
         {
            return;
         }
         Animate();
         if(mPlantHealth < 0)
         {
            Die();
         }
         UpdateReanimColor();
         UpdateReanim();
         if(mDoSpecialCountdown > 0)
         {
            --mDoSpecialCountdown;
            if(mDoSpecialCountdown == 0)
            {
               this.DoSpecial();
            }
         }
      }
      
      override public function DoSpecial() : void
      {
         var aPosX:int = mX + mWidth / 2;
         var aPosY:int = mY + mHeight / 2;
         app.foleyManager.playFoley(PVZFoleyType.CHERRYBOMB);
         app.foleyManager.playFoley(PVZFoleyType.JUICY);
         mBoard.KillAllZombiesInRadius(mRow,aPosX,aPosY,115,1,true);
         var anEffect:ParticleSystem = app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_POWIE);
         anEffect.setPosition(aPosX,aPosY);
         mBoard.mRenderManager.add(new ParticleRenderable(anEffect));
         mBoard.ShakeBoard(10,-15);
         Die();
      }
   }
}
