package com.popcap.flash.framework.resources.reanimator.looptypes
{
   import com.popcap.flash.framework.resources.reanimator.ReanimLoopType;
   import com.popcap.flash.framework.resources.reanimator.Reanimation;
   
   public class ReanimLoopOnceAndIdle extends ReanimLoopType
   {
       
      
      private var mIdleRate:Number = 0;
      
      private var mIdleTrack:String;
      
      public function ReanimLoopOnceAndIdle(idleTrack:String, idleRate:Number)
      {
         super();
         this.mIdleTrack = idleTrack;
         this.mIdleRate = idleRate;
      }
      
      override public function updatePositive(reanim:Reanimation) : void
      {
         if(reanim.animTime > 1)
         {
            reanim.animTime = 0;
            reanim.currentTrack = this.mIdleTrack;
            reanim.loopType = Reanimation.LOOP_TYPE_ALWAYS;
            reanim.animRate = this.mIdleRate;
         }
      }
      
      override public function doHold() : Boolean
      {
         return true;
      }
      
      override public function updateNegative(reanim:Reanimation) : void
      {
         if(reanim.animTime < 0)
         {
            reanim.animTime = 1;
            reanim.currentTrack = this.mIdleTrack;
            reanim.loopType = Reanimation.LOOP_TYPE_ALWAYS;
            reanim.animRate = this.mIdleRate;
         }
      }
   }
}
