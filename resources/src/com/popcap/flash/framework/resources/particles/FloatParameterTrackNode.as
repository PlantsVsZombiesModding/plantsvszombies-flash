package com.popcap.flash.framework.resources.particles
{
   public class FloatParameterTrackNode
   {
       
      
      public var mDistribution:CurveType;
      
      public var mTime:Number;
      
      public var mHighValue:Number;
      
      public var mLowValue:Number;
      
      public var mCurveType:CurveType;
      
      public function FloatParameterTrackNode()
      {
         super();
         this.mDistribution = CurveType.CONSTANT;
      }
      
      public function toString() : String
      {
         return "range=[" + this.mLowValue + " " + this.mHighValue + "] time=" + this.mTime + " curve=" + this.mCurveType + " dist=" + this.mDistribution;
      }
   }
}
