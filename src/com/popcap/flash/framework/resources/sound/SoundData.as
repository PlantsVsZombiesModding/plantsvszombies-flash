package com.popcap.flash.framework.resources.sound
{
   import flash.media.Sound;
   
   public class SoundData
   {
       
      
      public var mSource:Sound;
      
      public var mRefCount:Number = 0;
      
      public function SoundData(param1:Sound = null)
      {
         super();
         this.mSource = param1;
      }
   }
}
