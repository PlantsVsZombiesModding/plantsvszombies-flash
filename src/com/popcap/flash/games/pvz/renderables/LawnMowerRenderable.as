package com.popcap.flash.games.pvz.renderables
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.render.Renderable;
   import com.popcap.flash.games.pvz.logic.LawnMower;
   
   public class LawnMowerRenderable implements Renderable
   {
       
      
      private var mDepth:Number;
      
      private var mLawnMower:LawnMower;
      
      public function LawnMowerRenderable(lawnMower:LawnMower, depth:Number = 0)
      {
         super();
         this.mLawnMower = lawnMower;
         this.mDepth = depth;
      }
      
      public function getIsDisposable() : Boolean
      {
         return this.mLawnMower.mDead;
      }
      
      public function draw(g:Graphics2D) : void
      {
         this.mLawnMower.Draw(g);
      }
      
      public function update() : void
      {
         this.mLawnMower.Update();
      }
      
      public function getIsVisible() : Boolean
      {
         return this.mLawnMower.mVisible;
      }
      
      public function getDepth() : Number
      {
         return this.mDepth;
      }
      
      public function toString() : String
      {
         return "LawnMower@" + this.mDepth;
      }
   }
}
