package com.popcap.flash.framework.resources.reanimator
{
   public class ReanimFrameTime
   {
       
      
      public var mFraction:Number = 0;
      
      public var mFrameAfter:Number = 0;
      
      public var mFrameBefore:Number = 0;
      
      public function ReanimFrameTime()
      {
         super();
      }
      
      public function update(animTime:Number, startFrame:Number, frameCount:Number, hold:Boolean = false) : void
      {
         var aFrameCount:Number = frameCount;
         var aAnimPosition:Number = startFrame + aFrameCount * animTime;
         var aAnimFrameBefore:Number = int(aAnimPosition);
         var aLastFrame:Number = startFrame + frameCount - 1;
         this.mFraction = aAnimPosition - aAnimFrameBefore;
         this.mFrameBefore = aAnimFrameBefore;
         this.mFrameAfter = this.mFrameBefore + 1;
         if(hold && animTime == 1)
         {
            this.mFrameBefore = aLastFrame;
            this.mFrameAfter = aLastFrame;
         }
      }
   }
}
