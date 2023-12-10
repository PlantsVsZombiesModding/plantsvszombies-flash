package com.popcap.flash.framework.resources.reanimator.looptypes
{
   import com.popcap.flash.framework.resources.reanimator.ReanimLoopType;
   import com.popcap.flash.framework.resources.reanimator.Reanimation;
   
   public class ReanimLoopOnceAndDie extends ReanimLoopType
   {
       
      
      public function ReanimLoopOnceAndDie()
      {
         super();
      }
      
      override public function updatePositive(reanim:Reanimation) : void
      {
         if(reanim.animTime >= 1)
         {
            reanim.mIsDead = true;
         }
      }
      
      override public function updateNegative(reanim:Reanimation) : void
      {
         if(reanim.animTime < 0)
         {
            reanim.mIsDead = true;
         }
      }
   }
}
