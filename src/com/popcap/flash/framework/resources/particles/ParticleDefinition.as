package com.popcap.flash.framework.resources.particles
{
   public class ParticleDefinition
   {
       
      
      public var mFilename:String;
      
      public var mEmitterDefs:Array;
      
      public function ParticleDefinition()
      {
         super();
         this.mEmitterDefs = new Array();
      }
   }
}
