package com.popcap.flash.games.pvz.renderables
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.render.Renderable;
   import com.popcap.flash.framework.resources.reanimator.Reanimation;
   import flash.geom.Matrix;
   
   public class ReanimationRenderable implements Renderable
   {
      
      private static const mScratchMatrix:Matrix = new Matrix();
       
      
      private var mLerped:Boolean;
      
      private var mReanim:Reanimation;
      
      private var mDepth:Number;
      
      public function ReanimationRenderable(reanim:Reanimation, depth:Number, lerped:Boolean = false)
      {
         super();
         this.mReanim = reanim;
         this.mDepth = depth;
         this.mLerped = lerped;
      }
      
      public function getIsDisposable() : Boolean
      {
         return this.mReanim.mIsDead;
      }
      
      public function draw(g:Graphics2D) : void
      {
         if(this.mLerped)
         {
            this.mReanim.drawLerp(g,mScratchMatrix,1);
            return;
         }
         this.mReanim.draw(g);
      }
      
      public function getDepth() : Number
      {
         return this.mDepth;
      }
      
      public function update() : void
      {
         this.mReanim.update();
      }
      
      public function getIsVisible() : Boolean
      {
         return true;
      }
      
      public function toString() : String
      {
         return "Reanim@" + this.mDepth;
      }
   }
}
