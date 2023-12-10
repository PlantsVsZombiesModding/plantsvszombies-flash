package com.popcap.flash.framework.resources.fonts
{
   import com.popcap.flash.framework.AppBase;
   import com.popcap.flash.framework.resources.images.ImageData;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   
   public class ByteFontDescriptor implements FontDescriptor
   {
       
      
      private var mImageIds:Array;
      
      private var mBytes:ByteArray;
      
      public function ByteFontDescriptor(param1:ByteArray, param2:Array)
      {
         super();
         this.mBytes = param1;
         this.mImageIds = param2;
      }
      
      public function createFontData(param1:AppBase) : FontData
      {
         var _loc6_:FontLayer = null;
         var _loc7_:String = null;
         var _loc8_:BitmapData = null;
         var _loc9_:int = 0;
         var _loc10_:Number = NaN;
         var _loc11_:CharData = null;
         var _loc12_:int = 0;
         var _loc13_:Rectangle = null;
         var _loc14_:BitmapData = null;
         var _loc2_:Point = new Point();
         var _loc3_:FontData = new FontData();
         this.mBytes.position = 0;
         _loc3_.mPointSize = this.mBytes.readInt();
         var _loc4_:int = this.mBytes.readInt();
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = new FontLayer();
            _loc7_ = this.mBytes.readUTF();
            _loc6_.mImage = param1.imageManager.getImageInst(_loc7_);
            _loc6_.mLayerName = this.mBytes.readUTF();
            _loc8_ = _loc6_.mImage.pixels;
            _loc6_.mAscent = this.mBytes.readInt();
            _loc6_.mAscentPadding = this.mBytes.readInt();
            _loc6_.mColorAdd = this.mBytes.readInt();
            _loc6_.mColorMult = this.mBytes.readInt();
            _loc6_.mDefaultHeight = this.mBytes.readInt();
            _loc6_.mHeight = this.mBytes.readInt();
            _loc6_.mLineSpacingOffset = this.mBytes.readInt();
            _loc9_ = this.mBytes.readInt();
            _loc10_ = 0;
            while(_loc10_ < _loc9_)
            {
               _loc11_ = new CharData();
               _loc6_.mCharData[_loc10_ = this.mBytes.readInt()] = _loc11_;
               _loc11_.mImageRect.x = this.mBytes.readInt();
               _loc11_.mImageRect.y = this.mBytes.readInt();
               _loc11_.mImageRect.width = this.mBytes.readInt();
               _loc11_.mImageRect.height = this.mBytes.readInt();
               _loc11_.mOffset.x = this.mBytes.readInt();
               _loc11_.mOffset.y = this.mBytes.readInt();
               _loc11_.mWidth = this.mBytes.readInt();
               if(!((_loc13_ = _loc11_.mImageRect).width == 0 || _loc13_.height == 0))
               {
                  (_loc14_ = new BitmapData(_loc13_.width,_loc13_.height,true,0)).copyPixels(_loc8_,_loc13_,_loc2_);
                  _loc11_.mImage = new ImageInst(new ImageData(_loc14_));
               }
               _loc10_++;
            }
            _loc3_.layerList[_loc5_] = _loc6_;
            _loc5_++;
         }
         return _loc3_;
      }
   }
}
