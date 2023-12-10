package com.popcap.flash.games.pvz.renderables
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.render.Renderable;
   import com.popcap.flash.framework.resources.particles.ParticleSystem;
   
   public class ParticleRenderable implements Renderable
   {
       
      
      private var mDepth:Number;
      
      private var mEffect:ParticleSystem;
      
      public function ParticleRenderable(effect:ParticleSystem, depth:Number = 0)
      {
         super();
         this.mEffect = effect;
         this.mDepth = depth;
      }
      
      public function getIsDisposable() : Boolean
      {
         return this.mEffect.mDead;
      }
      
      public function draw(g:Graphics2D) : void
      {
         this.mEffect.draw(g);
      }
      
      public function update() : void
      {
         this.mEffect.update();
      }
      
      public function getIsVisible() : Boolean
      {
         return true;
      }
      
      public function getDepth() : Number
      {
         return this.mDepth;
      }
      
      public function toString() : String
      {
         return "Particle@" + this.mDepth;
      }
   }
}
