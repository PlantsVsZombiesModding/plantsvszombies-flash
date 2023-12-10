package com.popcap.flash.games.pvz.renderables
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.render.Renderable;
   import com.popcap.flash.framework.resources.images.ImageInst;
   
   public class ImageRenderable implements Renderable
   {
       
      
      private var mImage:ImageInst;
      
      private var mDead:Boolean;
      
      private var mDepth:Number;
      
      public function ImageRenderable(image:ImageInst, depth:Number = 0)
      {
         super();
         this.mImage = image;
         this.mDepth = depth;
         this.mDead = false;
      }
      
      public function getIsDisposable() : Boolean
      {
         return this.mDead;
      }
      
      public function draw(g:Graphics2D) : void
      {
         g.blitImage(this.mImage);
      }
      
      public function set dead(value:Boolean) : void
      {
         this.mDead = value;
      }
      
      public function getDepth() : Number
      {
         return this.mDepth;
      }
      
      public function update() : void
      {
      }
      
      public function getIsVisible() : Boolean
      {
         return true;
      }
      
      public function toString() : String
      {
         return "Image@" + this.mDepth;
      }
   }
}
