package com.popcap.flash.games.pvz.renderables
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.render.Renderable;
   import com.popcap.flash.games.pvz.logic.Projectile;
   
   public class ProjectileRenderable implements Renderable
   {
       
      
      private var mDepth:Number;
      
      private var mProjectile:Projectile;
      
      public function ProjectileRenderable(projectile:Projectile, depth:Number = 0)
      {
         super();
         this.mProjectile = projectile;
         this.mDepth = depth;
      }
      
      public function getIsDisposable() : Boolean
      {
         return this.mProjectile.mDead;
      }
      
      public function draw(g:Graphics2D) : void
      {
         this.mProjectile.Draw(g);
      }
      
      public function getDepth() : Number
      {
         return this.mDepth;
      }
      
      public function toString() : String
      {
         return "Projectile@" + this.mDepth;
      }
      
      public function update() : void
      {
         this.mProjectile.Update();
      }
      
      public function getIsVisible() : Boolean
      {
         return true;
      }
   }
}
