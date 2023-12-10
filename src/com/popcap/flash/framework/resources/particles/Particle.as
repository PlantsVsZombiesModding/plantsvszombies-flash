package com.popcap.flash.framework.resources.particles
{
   import flash.geom.Point;
   
   public class Particle
   {
      
      public static const TRACK_PARTICLE_STRETCH:int = 8;
      
      public static const TRACK_PARTICLE_SCALE:int = 7;
      
      public static const NUM_PARTICLE_TRACKS:int = 16;
      
      public static const TRACK_PARTICLE_COLLISION_REFLECT:int = 9;
      
      public static const TRACK_PARTICLE_RED:int = 0;
      
      public static const TRACK_PARTICLE_CLIP_TOP:int = 11;
      
      public static const TRACK_PARTICLE_COLLISION_SPIN:int = 10;
      
      public static const TRACK_PARTICLE_CLIP_BOTTOM:int = 12;
      
      public static const TRACK_PARTICLE_ALPHA:int = 3;
      
      public static const TRACK_PARTICLE_BLUE:int = 2;
      
      public static const TRACK_PARTICLE_ANIMATION_RATE:int = 15;
      
      public static const TRACK_PARTICLE_CLIP_RIGHT:int = 14;
      
      public static const TRACK_PARTICLE_BRIGHTNESS:int = 4;
      
      public static const TRACK_PARTICLE_SPIN_SPEED:int = 5;
      
      public static const TRACK_PARTICLE_CLIP_LEFT:int = 13;
      
      public static const TRACK_PARTICLE_SPIN_ANGLE:int = 6;
      
      public static const TRACK_PARTICLE_GREEN:int = 1;
       
      
      public var mParticleDuration:Number;
      
      public var mParticleLastTimeValue:Number;
      
      public var mSpinVelocity:Number;
      
      public var mAnimationTimeValue:Number;
      
      public var mParticleTimeValue:Number;
      
      public var mCrossFadeParticle:Particle;
      
      public var mParticleInterp:Array;
      
      public var mParticleEmitter:ParticleEmitter;
      
      public var mSpinPosition:Number;
      
      public var mOffset:Point;
      
      public var mParticleFieldInterp:Array;
      
      public var mCrossFadeDuration:Number;
      
      public var mImageFrame:Number;
      
      public var mVelocity:Point;
      
      public var mParticleAge:Number;
      
      public var mPosition:Point;
      
      public function Particle()
      {
         super();
         this.mPosition = new Point();
         this.mOffset = new Point();
         this.mVelocity = new Point();
         this.mParticleInterp = new Array();
         this.mParticleFieldInterp = new Array();
      }
   }
}
