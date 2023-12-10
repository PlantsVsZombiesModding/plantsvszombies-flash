package com.popcap.flash.framework.resources.particles
{
   import com.popcap.flash.framework.resources.images.ImageInst;
   
   public class ParticleEmitterDefinition
   {
       
      
      public var mClipBottom:FloatParameterTrack;
      
      public var mEmitterPath:FloatParameterTrack;
      
      public var mImageID:String = "";
      
      public var mSpawnMinActive:FloatParameterTrack;
      
      public var mParticleAlpha:FloatParameterTrack;
      
      public var mImageRow:Number;
      
      public var mParticleBlue:FloatParameterTrack;
      
      public var mParticleScale:FloatParameterTrack;
      
      public var mEmitterType:ParticleEmitterType;
      
      public var mSpawnRate:FloatParameterTrack;
      
      public var mName:String;
      
      public var mEmitterOffsetX:FloatParameterTrack;
      
      public var mEmitterOffsetY:FloatParameterTrack;
      
      public var mClipLeft:FloatParameterTrack;
      
      public var mLaunchSpeed:FloatParameterTrack;
      
      public var mSpawnMaxLaunched:FloatParameterTrack;
      
      public var mCrossFadeDuration:FloatParameterTrack;
      
      public var mParticleFields:Array;
      
      public var mCollisionSpin:FloatParameterTrack;
      
      public var mAnimationRate:FloatParameterTrack;
      
      public var mAnimated:Boolean;
      
      public var mImageCol:Number;
      
      public var mEmitterRadius:FloatParameterTrack;
      
      public var mImageFrames:Number;
      
      public var mLaunchAngle:FloatParameterTrack;
      
      public var mParticleFlags:ParticleFlags;
      
      public var mSpawnMaxActive:FloatParameterTrack;
      
      public var mSystemDuration:FloatParameterTrack;
      
      public var mSystemAlpha:FloatParameterTrack;
      
      public var mParticleBrightness:FloatParameterTrack;
      
      public var mEffectDef:ParticleDefinition;
      
      public var mEmitterSkewX:FloatParameterTrack;
      
      public var mParticleDuration:FloatParameterTrack;
      
      public var mEmitterBoxY:FloatParameterTrack;
      
      public var mParticleGreen:FloatParameterTrack;
      
      public var mEmitterBoxX:FloatParameterTrack;
      
      public var mParticleSpinSpeed:FloatParameterTrack;
      
      public var mEmitterSkewY:FloatParameterTrack;
      
      public var mParticleSpinAngle:FloatParameterTrack;
      
      public var mClipRight:FloatParameterTrack;
      
      public var mCollisionReflect:FloatParameterTrack;
      
      public var mImage:ImageInst;
      
      public var mClipTop:FloatParameterTrack;
      
      public var mParticleStretch:FloatParameterTrack;
      
      public var mSystemBrightness:FloatParameterTrack;
      
      public var mSystemRed:FloatParameterTrack;
      
      public var mSystemGreen:FloatParameterTrack;
      
      public var mSystemFields:Array;
      
      public var mSystemBlue:FloatParameterTrack;
      
      public var mParticleRed:FloatParameterTrack;
      
      public function ParticleEmitterDefinition()
      {
         this.mSystemDuration = new FloatParameterTrack();
         this.mCrossFadeDuration = new FloatParameterTrack();
         this.mSpawnRate = new FloatParameterTrack();
         this.mSpawnMinActive = new FloatParameterTrack();
         this.mSpawnMaxActive = new FloatParameterTrack();
         this.mSpawnMaxLaunched = new FloatParameterTrack();
         this.mEmitterRadius = new FloatParameterTrack();
         this.mEmitterOffsetX = new FloatParameterTrack();
         this.mEmitterOffsetY = new FloatParameterTrack();
         this.mEmitterBoxX = new FloatParameterTrack();
         this.mEmitterBoxY = new FloatParameterTrack();
         this.mEmitterSkewX = new FloatParameterTrack();
         this.mEmitterSkewY = new FloatParameterTrack();
         this.mEmitterPath = new FloatParameterTrack();
         this.mParticleDuration = new FloatParameterTrack();
         this.mLaunchSpeed = new FloatParameterTrack();
         this.mLaunchAngle = new FloatParameterTrack();
         this.mSystemRed = new FloatParameterTrack();
         this.mSystemGreen = new FloatParameterTrack();
         this.mSystemBlue = new FloatParameterTrack();
         this.mSystemAlpha = new FloatParameterTrack();
         this.mSystemBrightness = new FloatParameterTrack();
         this.mParticleRed = new FloatParameterTrack();
         this.mParticleGreen = new FloatParameterTrack();
         this.mParticleBlue = new FloatParameterTrack();
         this.mParticleAlpha = new FloatParameterTrack();
         this.mParticleBrightness = new FloatParameterTrack();
         this.mParticleSpinAngle = new FloatParameterTrack();
         this.mParticleSpinSpeed = new FloatParameterTrack();
         this.mParticleScale = new FloatParameterTrack();
         this.mParticleStretch = new FloatParameterTrack();
         this.mCollisionReflect = new FloatParameterTrack();
         this.mCollisionSpin = new FloatParameterTrack();
         this.mClipTop = new FloatParameterTrack();
         this.mClipBottom = new FloatParameterTrack();
         this.mClipLeft = new FloatParameterTrack();
         this.mClipRight = new FloatParameterTrack();
         this.mAnimationRate = new FloatParameterTrack();
         super();
         this.mImageRow = 0;
         this.mImageCol = 0;
         this.mImageFrames = 1;
         this.mAnimated = false;
         this.mEmitterType = ParticleEmitterType.BOX;
         this.mImage = null;
         this.mName = "";
         this.mParticleFlags = new ParticleFlags();
         this.mParticleFields = new Array();
         this.mSystemFields = new Array();
      }
      
      public function toString() : String
      {
         return "[ParticleEmitterDef \'" + this.mName + "\' file=\'" + this.mEffectDef.mFilename + "\']";
      }
   }
}
