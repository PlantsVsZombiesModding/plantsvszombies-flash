package com.popcap.flash.framework.resources.fonts
{
   import com.popcap.flash.framework.resources.images.ImageInst;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class CharData
   {
       
      
      public var mKerningOffsets:Dictionary;
      
      public var mOrder:Number;
      
      public var mImage:ImageInst;
      
      public var mOffset:Point;
      
      public var mCharCode:Number;
      
      public var mWidth:Number;
      
      public var mImageRect:Rectangle;
      
      public function CharData()
      {
         super();
         this.mCharCode = -1;
         this.mImageRect = new Rectangle();
         this.mOffset = new Point();
         this.mKerningOffsets = new Dictionary();
         this.mWidth = 0;
         this.mOrder = 0;
         this.mImage = null;
      }
   }
}
