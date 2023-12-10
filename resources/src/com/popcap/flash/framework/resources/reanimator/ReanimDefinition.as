package com.popcap.flash.framework.resources.reanimator
{
   import flash.utils.Dictionary;
   
   public class ReanimDefinition
   {
       
      
      public var trackNameMap:Dictionary;
      
      public var tracks:Array;
      
      public var fps:Number;
      
      public var numTracks:Number;
      
      public function ReanimDefinition()
      {
         super();
         this.fps = 0;
         this.tracks = new Array();
         this.trackNameMap = new Dictionary();
         this.numTracks = 0;
      }
   }
}
