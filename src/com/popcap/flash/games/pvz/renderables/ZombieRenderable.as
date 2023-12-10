package com.popcap.flash.games.pvz.renderables
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.render.Renderable;
   import com.popcap.flash.games.pvz.logic.Zombies.Zombie;
   
   public class ZombieRenderable implements Renderable
   {
       
      
      private var mDepth:Number;
      
      private var mZombie:Zombie;
      
      public function ZombieRenderable(zombie:Zombie, depth:Number = 0)
      {
         super();
         this.mZombie = zombie;
         this.mDepth = depth;
      }
      
      public function getIsDisposable() : Boolean
      {
         return this.mZombie.mDead;
      }
      
      public function draw(g:Graphics2D) : void
      {
         this.mZombie.Draw(g);
      }
      
      public function getDepth() : Number
      {
         return this.mDepth;
      }
      
      public function update() : void
      {
         this.mZombie.Update();
      }
      
      public function getIsVisible() : Boolean
      {
         return true;
      }
      
      public function toString() : String
      {
         return "Zombie@" + this.mDepth;
      }
   }
}
