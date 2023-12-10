package com.popcap.flash.framework.resources.reanimator
{
   public class ReanimTrack
   {
       
      
      public var transforms:Array;
      
      public var name:String;
      
      public var numTransforms:Number;
      
      public function ReanimTrack()
      {
         super();
         this.name = "";
         this.transforms = new Array();
         this.numTransforms = 0;
      }
   }
}
