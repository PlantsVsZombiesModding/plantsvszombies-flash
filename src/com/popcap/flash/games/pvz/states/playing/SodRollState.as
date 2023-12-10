package com.popcap.flash.games.pvz.states.playing
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.resources.particles.ParticleSystem;
   import com.popcap.flash.framework.resources.reanimator.Reanimation;
   import com.popcap.flash.framework.states.IState;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.PVZFoleyType;
   import com.popcap.flash.games.pvz.logic.Board;
   import com.popcap.flash.games.pvz.logic.TodCommon;
   import com.popcap.flash.games.pvz.renderables.ParticleRenderable;
   import com.popcap.flash.games.pvz.renderables.ReanimationRenderable;
   import com.popcap.flash.games.pvz.resources.PVZParticles;
   import com.popcap.flash.games.pvz.resources.PVZReanims;
   
   public class SodRollState implements IState
   {
      
      public static var TimeRollSodStart:int = 500;
      
      public static var TimeRollSodEnd:int = TimeRollSodStart + 2010;
       
      
      private var app:PVZApp;
      
      public function SodRollState(app:PVZApp)
      {
         super();
         this.app = app;
      }
      
      public function onEnter() : void
      {
         this.app.mCutsceneTime = 0;
      }
      
      public function draw(g:Graphics2D) : void
      {
         this.app.widgetManager.drawScreen(g);
      }
      
      public function onPush() : void
      {
      }
      
      public function onExit() : void
      {
      }
      
      public function update() : void
      {
         var aTimeRollSodStart:int = 0;
         var aTimeRollSodEnd:int = 0;
         var x:int = 0;
         var aReanimation:Reanimation = null;
         var anEffect:ParticleSystem = null;
         var anEffect2:ParticleSystem = null;
         this.app.widgetManager.updateFrame();
         this.app.mCutsceneTime += 10;
         if(this.app.mSodTime > 0)
         {
            aTimeRollSodStart = TimeRollSodStart;
            aTimeRollSodEnd = TimeRollSodEnd;
            x = TodCommon.TodAnimateCurve(aTimeRollSodStart,aTimeRollSodEnd,this.app.mCutsceneTime,0,1000,TodCommon.CURVE_LINEAR);
            this.app.mBoard.mSodPosition = x;
            if(this.app.mCutsceneTime == aTimeRollSodStart)
            {
               this.app.foleyManager.playFoley(PVZFoleyType.DIGGER);
               anEffect = this.app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_SODROLL);
               anEffect2 = this.app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_SODROLL);
               if(this.app.mBoard.mLevel == 1)
               {
                  aReanimation = this.app.reanimator.createReanimation(PVZReanims.REANIM_SODROLL);
                  aReanimation.animRate = 24;
                  aReanimation.currentTrack = "SodRoll";
                  aReanimation.loopType = Reanimation.LOOP_TYPE_ONCE_AND_DIE;
                  aReanimation.x = -5;
                  aReanimation.y = 15;
                  this.app.mBoard.mRenderManager.add(new ReanimationRenderable(aReanimation,0,true));
                  anEffect.setPosition(20,260);
                  this.app.mBoard.mRenderManager.add(new ParticleRenderable(anEffect,Board.RENDER_LAYER_TOP));
               }
               else if(this.app.mBoard.mLevel == 2)
               {
                  aReanimation = this.app.reanimator.createReanimation(PVZReanims.REANIM_SODROLL);
                  aReanimation.animRate = 24;
                  aReanimation.currentTrack = "SodRoll";
                  aReanimation.loopType = Reanimation.LOOP_TYPE_ONCE_AND_DIE;
                  aReanimation.x = -5;
                  aReanimation.y = -54;
                  this.app.mBoard.mRenderManager.add(new ReanimationRenderable(aReanimation,0,true));
                  anEffect.setPosition(20,200);
                  this.app.mBoard.mRenderManager.add(new ParticleRenderable(anEffect,Board.RENDER_LAYER_TOP));
                  aReanimation = this.app.reanimator.createReanimation(PVZReanims.REANIM_SODROLL);
                  aReanimation.animRate = 24;
                  aReanimation.currentTrack = "SodRoll";
                  aReanimation.loopType = Reanimation.LOOP_TYPE_ONCE_AND_DIE;
                  aReanimation.x = -5;
                  aReanimation.y = 90;
                  this.app.mBoard.mRenderManager.add(new ReanimationRenderable(aReanimation,0,true));
                  anEffect2.setPosition(20,350);
                  this.app.mBoard.mRenderManager.add(new ParticleRenderable(anEffect2,Board.RENDER_LAYER_TOP));
               }
               else if(this.app.mBoard.mLevel == 4)
               {
                  aReanimation = this.app.reanimator.createReanimation(PVZReanims.REANIM_SODROLL);
                  aReanimation.animRate = 24;
                  aReanimation.currentTrack = "SodRoll";
                  aReanimation.loopType = Reanimation.LOOP_TYPE_ONCE_AND_DIE;
                  aReanimation.x = -7;
                  aReanimation.y = -118;
                  this.app.mBoard.mRenderManager.add(new ReanimationRenderable(aReanimation,0,true));
                  anEffect.setPosition(20,141);
                  this.app.mBoard.mRenderManager.add(new ParticleRenderable(anEffect,Board.RENDER_LAYER_TOP));
                  aReanimation = this.app.reanimator.createReanimation(PVZReanims.REANIM_SODROLL);
                  aReanimation.animRate = 24;
                  aReanimation.currentTrack = "SodRoll";
                  aReanimation.loopType = Reanimation.LOOP_TYPE_ONCE_AND_DIE;
                  aReanimation.x = -7;
                  aReanimation.y = 152;
                  this.app.mBoard.mRenderManager.add(new ReanimationRenderable(aReanimation,0,true));
                  anEffect2.setPosition(20,412);
                  this.app.mBoard.mRenderManager.add(new ParticleRenderable(anEffect2,Board.RENDER_LAYER_TOP));
               }
            }
            if(this.app.mCutsceneTime == aTimeRollSodEnd)
            {
               this.app.stateManager.changeState(PVZApp.STATE_SLIDE_UI);
            }
         }
         else
         {
            this.app.stateManager.changeState(PVZApp.STATE_SLIDE_UI);
         }
      }
      
      public function onPop() : void
      {
      }
   }
}
