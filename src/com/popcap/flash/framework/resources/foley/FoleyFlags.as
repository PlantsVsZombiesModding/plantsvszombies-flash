package com.popcap.flash.framework.resources.foley
{
   import com.popcap.flash.framework.utils.Flags;
   
   public class FoleyFlags extends Flags
   {
      
      public static const LOOP:uint = 1;
      
      public static const USES_MUSIC_VOLUME:uint = 8;
      
      public static const DONT_REPEAT:uint = 16;
      
      public static const MUTE_ON_PAUSE:uint = 4;
      
      public static const ONE_AT_A_TIME:uint = 2;
      
      public static const NONE:FoleyFlags = new FoleyFlags();
       
      
      public function FoleyFlags(flags:uint = 0)
      {
         super();
         setFlags(flags);
      }
   }
}
