package com.popcap.flash.games.pvz.logic.Plants
{
   import com.popcap.flash.framework.resources.particles.ParticleSystem;
   import com.popcap.flash.framework.resources.reanimator.Reanimation;
   import com.popcap.flash.framework.resources.reanimator.looptypes.ReanimLoopQueue;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.PVZFoleyType;
   import com.popcap.flash.games.pvz.logic.Board;
   import com.popcap.flash.games.pvz.logic.GridItem;
   import com.popcap.flash.games.pvz.logic.TodCommon;
   import com.popcap.flash.games.pvz.renderables.ParticleRenderable;
   import com.popcap.flash.games.pvz.resources.PVZParticles;
   import com.popcap.flash.games.pvz.resources.PVZReanims;
   
   public class GraveBuster extends CPlant
   {
       
      
      public function GraveBuster(theGridX:int, theGridY:int, theSeedType:int, app:PVZApp, theBoard:Board)
      {
         var anArray:Array = null;
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
         var aOffsetX:Number = 3;
         var aOffsetY:Number = -20;
         mX += aOffsetX;
         mY += aOffsetY;
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
         mBodyReanimation = app.reanimator.createReanimation(PVZReanims.REANIM_GRAVEBUSTER);
         if(IsInPlay())
         {
            mBodyReanimation.currentTrack = "anim_land";
            mBodyReanimation.animRate = TodCommon.RandRangeFloat(10,15);
            anArray = new Array("anim_idle");
            mBodyReanimation.loopType = new ReanimLoopQueue(anArray);
            mState = STATE_GRAVEBUSTER_LANDING;
            app.foleyManager.playFoley(PVZFoleyType.GRAVEBUSTERCHOMP);
         }
      }
      
      override public function Update() : void
      {
         var anEffect:ParticleSystem = null;
         var aGraveStone:GridItem = null;
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
         if(mStateCountdown > 0)
         {
            --mStateCountdown;
         }
         mY = mBoard.GridToPixelY(mPlantCol,mRow) - 20;
         var aOffsetY:Number = 0;
         if(mState == STATE_GRAVEBUSTER_EATING)
         {
            aOffsetY = TodCommon.TodAnimateCurveFloat(GRAVE_BUSTER_EAT_TIME,0,mStateCountdown,0,20,TodCommon.CURVE_LINEAR);
         }
         mY += aOffsetY;
         if(mState == STATE_GRAVEBUSTER_LANDING)
         {
            if(mBodyReanimation.currentTrack == "anim_idle")
            {
               mBodyReanimation.loopType = Reanimation.LOOP_TYPE_ALWAYS;
               mBodyReanimation.animRate = 12;
               mStateCountdown = GRAVE_BUSTER_EAT_TIME;
               mState = STATE_GRAVEBUSTER_EATING;
               anEffect = app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_GRAVEBUSTER);
               anEffect.setPosition(mX + 24,mY + 40);
               mBoard.mRenderManager.add(new ParticleRenderable(anEffect,Board.RENDER_LAYER_PARTICLE));
            }
         }
         else if(mState == STATE_GRAVEBUSTER_EATING)
         {
            if(mStateCountdown == 0)
            {
               aGraveStone = mBoard.GetGraveStoneAt(mPlantCol,mRow);
               if(aGraveStone)
               {
                  aGraveStone.GridItemDie();
                  ++mBoard.mGravesCleared;
               }
               anEffect = app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_GRAVEBUSTERDIE);
               anEffect.setPosition(mX + 27,mY + 54);
               mBoard.mRenderManager.add(new ParticleRenderable(anEffect,Board.RENDER_LAYER_PARTICLE));
               Die();
            }
         }
      }
   }
}
