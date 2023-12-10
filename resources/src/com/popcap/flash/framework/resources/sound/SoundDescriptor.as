package com.popcap.flash.framework.resources.sound
{
   import flash.media.Sound;
   
   public class SoundDescriptor
   {
       
      
      private var mSoundClass:Class;
      
      public function SoundDescriptor(param1:Class)
      {
         super();
         this.mSoundClass = param1;
      }
      
      public function createData() : SoundData
      {
         return new SoundData(new this.mSoundClass() as Sound);
      }
   }
}
