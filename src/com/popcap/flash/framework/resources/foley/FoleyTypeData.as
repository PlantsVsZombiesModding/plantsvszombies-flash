package com.popcap.flash.framework.resources.foley
{
   public class FoleyTypeData
   {
       
      
      public var mLastVariationPlayed:Number = -1;
      
      public var mLastPlayed:int = 0;
      
      public var mType:FoleyType;
      
      public function FoleyTypeData(type:FoleyType)
      {
         super();
         this.mType = type;
      }
   }
}
