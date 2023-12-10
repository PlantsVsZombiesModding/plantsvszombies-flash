package com.popcap.flash.framework.resources.images
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BitmapDataChannel;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ImageDescriptor
   {
      
      private static var srcRect:Rectangle = new Rectangle();
      
      private static var destPt:Point = new Point();
       
      
      private var mRows:Number;
      
      private var mAlphaClass:Class;
      
      private var mRGBClass:Class;
      
      private var mCols:Number;
      
      public function ImageDescriptor(param1:Class = null, param2:Class = null, param3:Number = 1, param4:Number = 1)
      {
         super();
         this.mRGBClass = param1;
         this.mAlphaClass = param2;
         this.mRows = param3;
         this.mCols = param4;
      }
      
      private function sliceCels(param1:BitmapData, param2:Number, param3:Number, param4:ImageData) : void
      {
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:BitmapData = null;
         var _loc15_:Rectangle = null;
         var _loc5_:Number = param1.width / this.mCols;
         var _loc6_:Number = param1.height / this.mRows;
         var _loc7_:Rectangle = new Rectangle(0,0,_loc5_,_loc6_);
         var _loc8_:Point = new Point(0,0);
         param4.rows = param2;
         param4.cols = param3;
         var _loc9_:Array = new Array();
         var _loc10_:int = param2 * param3;
         var _loc11_:int = 0;
         while(_loc11_ < _loc10_)
         {
            _loc12_ = int(_loc11_ / param3);
            _loc13_ = _loc11_ % param3;
            _loc14_ = new BitmapData(_loc5_,_loc6_);
            _loc15_ = new Rectangle(_loc13_ * _loc5_,_loc12_ * _loc6_,_loc5_,_loc6_);
            _loc14_.copyPixels(param1,_loc15_,_loc8_);
            _loc9_[_loc11_] = _loc14_;
            _loc11_ += 1;
         }
         param4.celWidth = _loc5_;
         param4.celHeight = _loc6_;
         param4.cels = _loc9_;
         param1.dispose();
      }
      
      public function createData() : ImageData
      {
         var _loc1_:BitmapData = null;
         var _loc2_:BitmapData = null;
         var _loc3_:BitmapData = null;
         if(this.mRGBClass != null)
         {
            _loc2_ = (new this.mRGBClass() as Bitmap).bitmapData;
         }
         if(this.mAlphaClass != null)
         {
            _loc3_ = (new this.mAlphaClass() as Bitmap).bitmapData;
         }
         if(_loc2_ != null)
         {
            _loc1_ = new BitmapData(_loc2_.width,_loc2_.height,true,0);
         }
         else if(_loc3_ != null)
         {
            _loc1_ = new BitmapData(_loc3_.width,_loc3_.height,true,0);
         }
         if(_loc1_ == null)
         {
            throw new Error("Image is empty.");
         }
         srcRect.width = _loc1_.width;
         srcRect.height = _loc1_.height;
         if(_loc2_ != null)
         {
            _loc1_.copyPixels(_loc2_,srcRect,destPt);
         }
         if(_loc3_ != null)
         {
            if(_loc2_ == null)
            {
               _loc1_.copyPixels(_loc3_,srcRect,destPt);
            }
            _loc1_.copyChannel(_loc3_,srcRect,destPt,BitmapDataChannel.RED,BitmapDataChannel.ALPHA);
         }
         var _loc4_:ImageData = new ImageData(null,this.mRows,this.mCols);
         this.sliceCels(_loc1_,this.mRows,this.mCols,_loc4_);
         return _loc4_;
      }
   }
}
