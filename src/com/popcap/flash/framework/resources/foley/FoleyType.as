package com.popcap.flash.framework.resources.foley
{
   public class FoleyType
   {
       
      
      private var mPitchRange:Number;
      
      private var mFlags:FoleyFlags;
      
      private var mVariations:Array;
      
      public function FoleyType(pitchRange:Number, variations:Array, flags:FoleyFlags)
      {
         super();
         this.mPitchRange = pitchRange;
         this.mVariations = variations;
         this.mFlags = flags;
      }
      
      public function get variations() : Array
      {
         return this.mVariations;
      }
      
      public function get flags() : FoleyFlags
      {
         return this.mFlags;
      }
      
      public function get pitchRange() : Number
      {
         return this.mPitchRange;
      }
   }
}
