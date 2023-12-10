package com.popcap.flash.framework.resources.fonts
{
   import flash.utils.Dictionary;
   
   public class FontData
   {
       
      
      public var mPointSize:Number;
      
      public var layerMap:Dictionary;
      
      public var layerList:Array;
      
      private var mAscent:Number = 19;
      
      private var mAscentPadding:Number = 0;
      
      private var mHeight:Number;
      
      private var mLineSpacingOffset:Number = 0;
      
      public function FontData()
      {
         super();
         this.layerList = new Array();
         this.layerMap = new Dictionary();
      }
      
      public function charWidthKern(param1:Number, param2:Number) : Number
      {
         var _loc6_:CharData = null;
         if(this.layerList.length == 0)
         {
            return 0;
         }
         var _loc3_:Number = 0;
         var _loc4_:int = int(this.layerList.length);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = this.layerList[_loc5_].getCharData(param1);
            _loc3_ = _loc3_ < _loc6_.mWidth ? _loc6_.mWidth : _loc3_;
            _loc5_++;
         }
         return _loc3_;
      }
      
      public function getAscent() : Number
      {
         var _loc2_:FontLayer = null;
         var _loc1_:Number = 0;
         for each(_loc2_ in this.layerList)
         {
            _loc1_ = _loc2_.mAscent > _loc1_ ? _loc2_.mAscent : _loc1_;
         }
         return _loc1_;
      }
      
      public function getDescent() : Number
      {
         return 0;
      }
      
      public function charWidth(param1:Number) : Number
      {
         return this.charWidthKern(param1,0);
      }
      
      public function stringImageWidth(param1:String) : Number
      {
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:FontLayer = null;
         var _loc12_:CharData = null;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc2_:FontLayer = this.layerList[0];
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:int = param1.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc7_ = param1.charCodeAt(_loc6_);
            _loc8_ = _loc4_;
            _loc9_ = int(this.layerList.length);
            _loc10_ = 0;
            while(_loc10_ < _loc9_)
            {
               _loc12_ = (_loc11_ = this.layerList[_loc10_]).getCharData(_loc7_);
               _loc13_ = _loc4_;
               _loc14_ = 0;
               _loc15_ = _loc12_.mWidth;
               _loc16_ = _loc13_ + _loc2_.mOffset.x + _loc12_.mOffset.x;
               _loc17_ = -(_loc11_.mAscent - _loc11_.mOffset.y - _loc12_.mOffset.y);
               if(_loc12_.mImage != null)
               {
                  _loc3_ = _loc16_ + _loc12_.mImage.width;
               }
               if((_loc13_ += _loc15_ + _loc14_) > _loc8_)
               {
                  _loc8_ = _loc13_;
               }
               _loc10_++;
            }
            _loc4_ = _loc8_;
            _loc6_++;
         }
         return _loc3_;
      }
      
      public function getHeight() : Number
      {
         var _loc2_:FontLayer = null;
         var _loc1_:Number = 0;
         for each(_loc2_ in this.layerList)
         {
            _loc1_ = _loc2_.height > _loc1_ ? _loc2_.height : _loc1_;
         }
         return _loc1_;
      }
      
      private function getMappedChar(param1:Number) : Number
      {
         return 0;
      }
      
      public function getAscentPadding() : Number
      {
         return this.mAscentPadding;
      }
      
      public function getLineSpacingOffset() : Number
      {
         return 0;
      }
      
      public function stringWidth(param1:String) : Number
      {
         var _loc6_:Number = NaN;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:int = param1.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = param1.charCodeAt(_loc5_);
            _loc2_ += this.charWidthKern(_loc6_,_loc3_);
            _loc3_ = _loc6_;
            _loc5_++;
         }
         return _loc2_;
      }
      
      public function getLineSpacing() : Number
      {
         var _loc2_:FontLayer = null;
         var _loc1_:Number = 0;
         for each(_loc2_ in this.layerList)
         {
            _loc1_ = _loc2_.mSpacing > _loc1_ ? _loc2_.mSpacing : _loc1_;
         }
         return _loc1_;
      }
   }
}
