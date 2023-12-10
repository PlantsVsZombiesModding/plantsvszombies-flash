package mx.core
{
   import flash.display.BitmapData;
   
   use namespace mx_internal;
   
   public class BitmapAsset extends FlexBitmap implements IFlexAsset, IFlexDisplayObject
   {
      
      mx_internal static const VERSION:String = "3.3.0.4852";
       
      
      public function BitmapAsset(bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false)
      {
         super(bitmapData,pixelSnapping,smoothing);
      }
      
      public function get measuredWidth() : Number
      {
         if(bitmapData)
         {
            return bitmapData.width;
         }
         return 0;
      }
      
      public function get measuredHeight() : Number
      {
         if(bitmapData)
         {
            return bitmapData.height;
         }
         return 0;
      }
      
      public function setActualSize(newWidth:Number, newHeight:Number) : void
      {
         width = newWidth;
         height = newHeight;
      }
      
      public function move(x:Number, y:Number) : void
      {
         this.x = x;
         this.y = y;
      }
   }
}
