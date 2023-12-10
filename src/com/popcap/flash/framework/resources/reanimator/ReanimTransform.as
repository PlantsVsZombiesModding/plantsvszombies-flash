package com.popcap.flash.framework.resources.reanimator
{
   import com.popcap.flash.framework.resources.images.ImageInst;
   import flash.geom.Matrix;
   
   public class ReanimTransform
   {
       
      
      public var matrix:Matrix;
      
      public var sX:Number;
      
      public var sY:Number;
      
      public var cache:ImageInst;
      
      public var kX:Number;
      
      public var kY:Number;
      
      public var image:ImageInst;
      
      public var alpha:Number;
      
      public var tX:Number;
      
      public var tY:Number;
      
      public var frame:Number;
      
      public var imageID:String;
      
      public function ReanimTransform()
      {
         super();
         this.tX = NaN;
         this.tY = NaN;
         this.kX = NaN;
         this.kY = NaN;
         this.sX = NaN;
         this.sY = NaN;
         this.frame = NaN;
         this.alpha = NaN;
         this.image = null;
      }
      
      public function fillInFrom(param1:ReanimTransform) : void
      {
         if(param1 == null)
         {
            param1 = new ReanimTransform();
            param1.tX = 0;
            param1.tY = 0;
            param1.kX = 0;
            param1.kY = 0;
            param1.sX = 1;
            param1.sY = 1;
            param1.frame = -1;
            param1.alpha = 1;
         }
         if(isNaN(this.tX))
         {
            this.tX = param1.tX;
         }
         if(isNaN(this.tY))
         {
            this.tY = param1.tY;
         }
         if(isNaN(this.kX))
         {
            this.kX = param1.kX;
         }
         if(isNaN(this.kY))
         {
            this.kY = param1.kY;
         }
         if(isNaN(this.sX))
         {
            this.sX = param1.sX;
         }
         if(isNaN(this.sY))
         {
            this.sY = param1.sY;
         }
         if(isNaN(this.frame))
         {
            this.frame = param1.frame;
         }
         if(isNaN(this.alpha))
         {
            this.alpha = param1.alpha;
         }
         if(this.image == null)
         {
            this.image = param1.image;
         }
         this.calcMatrix();
      }
      
      public function calcMatrix() : void
      {
         this.matrix = new Matrix(Math.cos(this.kX) * this.sX,-Math.sin(this.kX) * this.sX,Math.sin(this.kY) * this.sY,Math.cos(this.kY) * this.sY,this.tX,this.tY);
      }
      
      public function toString() : String
      {
         return "[" + this.frame + "] x:" + this.tX + " y:" + this.tY + " image:" + this.image;
      }
   }
}
