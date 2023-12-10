package com.popcap.flash.framework.utils
{
   public class Flags
   {
       
      
      private var mFlags:uint = 0;
      
      public function Flags()
      {
         super();
      }
      
      public function clearFlags(flags:uint) : void
      {
         this.mFlags &= ~flags;
      }
      
      public function setFlags(flags:uint) : void
      {
         this.mFlags |= flags;
      }
      
      public function hasFlags(testFlags:uint) : Boolean
      {
         return (this.mFlags & testFlags) != 0;
      }
   }
}
