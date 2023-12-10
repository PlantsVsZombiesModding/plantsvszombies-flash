package com.popcap.flash.framework.resources.reanimator.looptypes
{
   import com.popcap.flash.framework.resources.reanimator.ReanimLoopType;
   import com.popcap.flash.framework.resources.reanimator.Reanimation;
   
   public class ReanimLoopAlways extends ReanimLoopType
   {
       
      
      public function ReanimLoopAlways()
      {
         super();
      }
      
      override public function updatePositive(reanim:Reanimation) : void
      {
         var aFinalTime:Number = reanim.animTime;
         while(aFinalTime >= 1)
         {
            aFinalTime--;
         }
         reanim.animTime = aFinalTime;
      }
      
      override public function updateNegative(reanim:Reanimation) : void
      {
         var aFinalTime:Number = reanim.animTime;
         while(aFinalTime < 0)
         {
            aFinalTime += 1;
         }
         reanim.animTime = aFinalTime;
      }
   }
}
