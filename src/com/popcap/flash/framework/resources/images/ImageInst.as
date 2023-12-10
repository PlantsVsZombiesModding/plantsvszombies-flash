package com.popcap.flash.framework.resources.images
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ImageInst
   {
       
      
      private var mFrame:Number;
      
      public var destPt:Point;
      
      private var mColorTransform:ColorTransform;
      
      private var mGraphics:Graphics2D;
      
      public var doAdditiveBlend:Boolean = false;
      
      public var useColor:Boolean = false;
      
      public var doSmoothing:Boolean = true;
      
      private var mData:ImageData;
      
      private var mPixels:BitmapData;
      
      private var mSrcRect:Rectangle;
      
      public function ImageInst(param1:ImageData)
      {
         super();
         this.destPt = new Point();
         this.mData = param1;
         this.mFrame = 0;
         this.mColorTransform = new ColorTransform();
      }
      
      public function set x(param1:Number) : void
      {
         this.destPt.x = param1;
      }
      
      public function get green() : Number
      {
         return this.mColorTransform.greenMultiplier;
      }
      
      public function get graphics() : Graphics2D
      {
         if(this.mGraphics == null)
         {
            this.mGraphics = new Graphics2D(this.pixels);
         }
         return this.mGraphics;
      }
      
      public function get width() : Number
      {
         return this.pixels.width;
      }
      
      public function setColor(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         this.mColorTransform.alphaMultiplier = param1;
         this.mColorTransform.redMultiplier = param2;
         this.mColorTransform.greenMultiplier = param3;
         this.mColorTransform.blueMultiplier = param4;
      }
      
      public function get red() : Number
      {
         return this.mColorTransform.redMultiplier;
      }
      
      public function get alpha() : Number
      {
         return this.mColorTransform.alphaMultiplier;
      }
      
      public function get blue() : Number
      {
         return this.mColorTransform.blueMultiplier;
      }
      
      public function get height() : Number
      {
         return this.pixels.height;
      }
      
      public function get srcRect() : Rectangle
      {
         var _loc1_:BitmapData = null;
         if(this.mSrcRect == null)
         {
            _loc1_ = this.pixels;
            this.mSrcRect = new Rectangle(0,0,_loc1_.width,_loc1_.height);
         }
         return this.mSrcRect;
      }
      
      public function setFrame(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:int = param1 + param2 + param3 * this.mData.cols;
         var _loc5_:int = int(this.mData.cels.length);
         _loc4_ = (_loc4_ = _loc4_ < 0 ? 0 : _loc4_) >= _loc5_ ? _loc5_ - 1 : _loc4_;
         this.mFrame = _loc4_;
         this.mPixels = this.mData.cels[_loc4_];
         this.mSrcRect = null;
      }
      
      public function get pixels() : BitmapData
      {
         if(this.mPixels == null)
         {
            this.mPixels = this.mData.cels[0];
         }
         return this.mPixels;
      }
      
      public function set y(param1:Number) : void
      {
         this.destPt.y = param1;
      }
      
      public function get y() : Number
      {
         return this.destPt.y;
      }
      
      public function set frame(param1:Number) : void
      {
         if(param1 < 0 || param1 >= this.mData.cels.length)
         {
            throw new Error("Frame \'" + param1 + "\' is out of range [0, " + (this.mData.cels.length - 1) + "]");
         }
         if(this.mFrame == param1)
         {
            return;
         }
         this.mFrame = param1;
         this.mPixels = this.mData.cels[param1];
         this.mSrcRect = null;
      }
      
      public function get x() : Number
      {
         return this.destPt.x;
      }
   }
}
