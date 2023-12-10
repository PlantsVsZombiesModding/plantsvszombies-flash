package com.popcap.flash.framework.resources.particles
{
   public class ParticleField
   {
       
      
      public var mFieldType:ParticleFieldType;
      
      public var mX:FloatParameterTrack;
      
      public var mY:FloatParameterTrack;
      
      public function ParticleField()
      {
         super();
         this.mX = new FloatParameterTrack();
         this.mY = new FloatParameterTrack();
      }
   }
}
