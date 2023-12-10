package com.popcap.flash.framework.resources.fonts
{
   import com.popcap.flash.framework.graphics.Color;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class FontInst
   {
       
      
      private var mColorTransform:ColorTransform;
      
      private var mData:FontData;
      
      private var mScale:Number;
      
      public function FontInst(param1:FontData)
      {
         this.mColorTransform = new ColorTransform();
         super();
         this.mData = param1;
         this.mScale = 1;
      }
      
      public function getAscentPadding() : Number
      {
         return this.mData.getAscentPadding() * this.mScale;
      }
      
      public function stringImageWidth(param1:String) : Number
      {
         return this.mData.stringImageWidth(param1) * this.mScale;
      }
      
      public function getDescent() : Number
      {
         return this.mData.getDescent() * this.mScale;
      }
      
      public function setColor(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         this.mColorTransform.alphaMultiplier = param1;
         this.mColorTransform.redMultiplier = param2;
         this.mColorTransform.greenMultiplier = param3;
         this.mColorTransform.blueMultiplier = param4;
      }
      
      public function get scale() : Number
      {
         return this.mScale;
      }
      
      public function draw(param1:Graphics2D, param2:Number, param3:Number, param4:String, param5:Rectangle) : void
      {
         var _loc11_:FontLayer = null;
         var _loc12_:Number = NaN;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:Number = NaN;
         var _loc16_:CharData = null;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Color = null;
         var _loc24_:ImageInst = null;
         var _loc6_:FontLayer = this.mData.layerList[0];
         var _loc7_:Matrix = param1.getTransform();
         var _loc8_:Matrix = new Matrix();
         param1.identity();
         var _loc9_:int = int(this.mData.layerList.length);
         var _loc10_:int = 0;
         while(_loc10_ < _loc9_)
         {
            _loc11_ = this.mData.layerList[_loc10_];
            _loc12_ = 0;
            _loc13_ = param4.length;
            _loc14_ = 0;
            while(_loc14_ < _loc13_)
            {
               _loc15_ = param4.charCodeAt(_loc14_);
               _loc16_ = _loc11_.getCharData(_loc15_);
               _loc17_ = _loc12_;
               _loc18_ = _loc12_;
               _loc19_ = 0;
               _loc20_ = _loc16_.mWidth;
               _loc21_ = _loc18_ + _loc6_.mOffset.x + _loc16_.mOffset.x;
               _loc22_ = -(_loc11_.mAscent - _loc11_.mOffset.y - _loc16_.mOffset.y);
               if(_loc16_.mImage != null)
               {
                  _loc23_ = Color.fromInt(_loc11_.mColorMult);
                  (_loc24_ = _loc16_.mImage).setColor(this.mColorTransform.alphaMultiplier * _loc23_.alpha,this.mColorTransform.redMultiplier * _loc23_.red,this.mColorTransform.greenMultiplier * _loc23_.green,this.mColorTransform.blueMultiplier * _loc23_.blue);
                  _loc24_.useColor = true;
                  _loc8_.identity();
                  _loc8_.translate(_loc21_,0);
                  _loc8_.scale(this.mScale,this.mScale);
                  _loc8_.concat(_loc7_);
                  param1.setTransform(_loc8_);
                  param1.drawImage(_loc16_.mImage,param2,param3);
               }
               if((_loc18_ += _loc20_ + _loc19_) > _loc17_)
               {
                  _loc17_ = _loc18_;
               }
               _loc12_ = _loc17_;
               _loc14_++;
            }
            _loc10_++;
         }
         param1.setTransform(_loc7_);
      }
      
      public function getAscent() : Number
      {
         return this.mData.getAscent() * this.mScale;
      }
      
      public function set scale(param1:Number) : void
      {
         this.mScale = param1;
      }
      
      public function getHeight() : Number
      {
         return this.mData.getHeight() * this.mScale;
      }
      
      public function getLineSpacing() : Number
      {
         return this.mData.getLineSpacing() * this.mScale;
      }
      
      public function getLineSpacingOffset() : Number
      {
         return this.mData.getLineSpacingOffset() * this.mScale;
      }
      
      public function stringWidth(param1:String) : Number
      {
         return this.mData.stringWidth(param1) * this.mScale;
      }
   }
}
