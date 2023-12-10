package com.popcap.flash.framework.resources.images
{
   import flash.display.BitmapData;
   
   public class ImageData
   {
       
      
      public var cels:Array;
      
      public var cols:Number;
      
      public var rows:Number;
      
      public var celWidth:Number;
      
      public var celHeight:Number;
      
      public function ImageData(param1:BitmapData = null, param2:Number = 1, param3:Number = 1)
      {
         super();
         this.cels = new Array(param1);
         this.rows = param2;
         this.cols = param3;
      }
      
      public function toString() : String
      {
         return "Data [" + this.rows + "x" + this.cols + ", " + this.cels + "]";
      }
   }
}
