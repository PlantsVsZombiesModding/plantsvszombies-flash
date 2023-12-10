package com.popcap.flash.framework.resources.particles
{
   import com.popcap.flash.framework.graphics.Color;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   public class ParticleEmitter
   {
      
      public static const ONE_OVER_32K:Number = 0.0000305185094;
      
      private static const TRACK_SYSTEM_ALPHA:Number = 8;
      
      private static const TRACK_SYSTEM_BRIGHTNESS:Number = 9;
      
      private static const TRACK_EMITTER_PATH:Number = 4;
      
      private static const TRACK_SYSTEM_BLUE:Number = 7;
      
      private static const TRACK_SPAWN_RATE:Number = 0;
      
      private static const TRACK_SPAWN_MAX_ACTIVE:Number = 2;
      
      public static const CIRCLE_FULL:Number = 6.283185307179586;
      
      private static const TRACK_SPAWN_MAX_LAUNCHED:Number = 3;
      
      private static const TRACK_SYSTEM_GREEN:Number = 6;
      
      private static const TRACK_SPAWN_MIN_ACTIVE:Number = 1;
      
      private static const TRACK_SYSTEM_RED:Number = 5;
      
      public static const SECONDS_PER_UPDATE:Number = 0.01;
      
      private static const NUM_SYSTEM_TRACKS:Number = 10;
       
      
      public var mEmitterDef:ParticleEmitterDefinition;
      
      public var mSystemTimeValue:Number;
      
      public var mSystemLastTimeValue:Number;
      
      public var mTrackInterp:Array;
      
      public var mSystemFieldInterp:Array;
      
      public var mParticleSystem:ParticleSystem;
      
      public var mSystemDuration:Number;
      
      public var mParticleList:Array;
      
      public var mImageOverride:Boolean;
      
      public var mSystemAge:Number;
      
      public var mColorOverride:Color;
      
      public var mSpawnAccum:Number;
      
      public var mDead:Boolean;
      
      public var mEmitterCrossFadeCountDown:Number;
      
      public var mSystemCenter:Point;
      
      public var mParticlesSpawned:Number;
      
      public var mCrossFadeEmitter:ParticleEmitter;
      
      public function ParticleEmitter()
      {
         this.mColorOverride = Color.ARGB(1,1,1,1);
         super();
      }
      
      private function crossFadeParticle(particle:Particle, emitter:ParticleEmitter) : Boolean
      {
         throw new Error("Not implemented yet!");
      }
      
      private function updateSystemField(field:ParticleField, time:Number, index:int) : void
      {
         var aLastX:Number = NaN;
         var aLastY:Number = NaN;
         var aInterpX:Number = Number(this.mSystemFieldInterp[index][0]);
         var aInterpY:Number = Number(this.mSystemFieldInterp[index][1]);
         var x:Number = field.mX.evaluate(time,aInterpX);
         var y:Number = field.mY.evaluate(time,aInterpY);
         if(field.mFieldType == ParticleFieldType.SYSTEM_POSITION)
         {
            aLastX = field.mX.evaluate(this.mSystemLastTimeValue,aInterpX);
            aLastY = field.mY.evaluate(this.mSystemLastTimeValue,aInterpY);
            this.mSystemCenter.x += x - aLastX;
            this.mSystemCenter.y += y - aLastY;
         }
         else if(field.mFieldType != ParticleFieldType.INVALID)
         {
            throw new Error("Bad system field type: " + field.mFieldType);
         }
      }
      
      private function deleteNonCrossFading() : void
      {
         var aParticle:Particle = null;
         var aNumParticles:int = int(this.mParticleList.length);
         for(var i:int = 0; i < aNumParticles; i++)
         {
            aParticle = this.mParticleList[i];
            if(aParticle.mCrossFadeDuration <= 0)
            {
               this.deleteParticle(aParticle);
               i--;
               aNumParticles--;
            }
         }
      }
      
      private function evalSystemTrack(track:FloatParameterTrack, index:Number) : Number
      {
         return track.evaluate(this.mSystemTimeValue,this.mTrackInterp[index]);
      }
      
      private function spawnParticle(index:int, spawnCount:int) : Particle
      {
         var aLaunchAngle:Number = NaN;
         var aEmitterRadiusInterp:Number = NaN;
         var aRadius:Number = NaN;
         var aEmitterBoxXInterp:Number = NaN;
         var aEmitterBoxYInterp:Number = NaN;
         var aType:ParticleEmitterType = this.mEmitterDef.mEmitterType;
         var aParticle:Particle = new Particle();
         var aParticleFieldCount:int = int(this.mEmitterDef.mParticleFields.length);
         for(var i:int = 0; i < aParticleFieldCount; i++)
         {
            aParticle.mParticleFieldInterp[i] = new Array();
            aParticle.mParticleFieldInterp[i][0] = Math.random();
            aParticle.mParticleFieldInterp[i][1] = Math.random();
         }
         for(i = 0; i < Particle.NUM_PARTICLE_TRACKS; i++)
         {
            aParticle.mParticleInterp[i] = Math.random();
         }
         var aParticleDurationInterp:Number = Math.random();
         var aLaunchSpeedInterp:Number = Math.random();
         var aEmitterOffsetXInterp:Number = Math.random();
         var aEmitterOffsetYInterp:Number = Math.random();
         aParticle.mParticleDuration = int(this.mEmitterDef.mParticleDuration.evaluate(this.mSystemTimeValue,aParticleDurationInterp));
         aParticle.mParticleDuration = 1 > aParticle.mParticleDuration ? 1 : aParticle.mParticleDuration;
         aParticle.mParticleAge = 0;
         aParticle.mParticleEmitter = this;
         aParticle.mParticleTimeValue = -1;
         aParticle.mParticleLastTimeValue = -1;
         if(this.mEmitterDef.mParticleFlags.hasFlags(ParticleFlags.RANDOM_START_TIME))
         {
            aParticle.mParticleAge = Math.random() * aParticle.mParticleDuration;
         }
         else
         {
            aParticle.mParticleAge = 0;
         }
         var aLaunchSpeed:Number = this.mEmitterDef.mLaunchSpeed.evaluate(this.mSystemTimeValue,aLaunchSpeedInterp) * SECONDS_PER_UPDATE;
         var aLaunchAngleInterp:Number = Math.random();
         if(aType == ParticleEmitterType.CIRCLE_PATH)
         {
            aLaunchAngle = this.mEmitterDef.mEmitterPath.evaluate(this.mSystemTimeValue,this.mTrackInterp[TRACK_EMITTER_PATH]) * CIRCLE_FULL;
            aLaunchAngle += this.mEmitterDef.mLaunchAngle.evaluate(this.mSystemTimeValue,aLaunchAngleInterp);
         }
         else if(aType == ParticleEmitterType.CIRCLE_EVEN_SPACING)
         {
            aLaunchAngle = CIRCLE_FULL * index / spawnCount;
            aLaunchAngle += this.mEmitterDef.mLaunchAngle.evaluate(this.mSystemTimeValue,aLaunchAngleInterp);
         }
         else if(this.mEmitterDef.mLaunchAngle.isConstantZero())
         {
            aLaunchAngle = Math.random() * CIRCLE_FULL;
         }
         else
         {
            aLaunchAngle = this.mEmitterDef.mLaunchAngle.evaluate(this.mSystemTimeValue,aLaunchAngleInterp);
         }
         var aPosX:Number = 0;
         var aPosY:Number = 0;
         if(aType == ParticleEmitterType.CIRCLE || aType == ParticleEmitterType.CIRCLE_PATH || aType == ParticleEmitterType.CIRCLE_EVEN_SPACING)
         {
            aEmitterRadiusInterp = Math.random();
            aRadius = this.mEmitterDef.mEmitterRadius.evaluate(this.mSystemTimeValue,aEmitterRadiusInterp);
            aPosX = Math.sin(aLaunchAngle) * aRadius;
            aPosY = Math.cos(aLaunchAngle) * aRadius;
         }
         else
         {
            if(aType != ParticleEmitterType.BOX)
            {
               if(aType == ParticleEmitterType.BOX_PATH)
               {
                  throw new Error("Not implemented yet!");
               }
               throw new Error("Unsupported emitter type \'" + aType + "\'");
            }
            aEmitterBoxXInterp = Math.random();
            aEmitterBoxYInterp = Math.random();
            aPosX = this.mEmitterDef.mEmitterBoxX.evaluate(this.mSystemTimeValue,aEmitterBoxXInterp);
            aPosY = this.mEmitterDef.mEmitterBoxY.evaluate(this.mSystemTimeValue,aEmitterBoxYInterp);
         }
         var aEmitterSkewXInterp:Number = Math.random();
         var aEmitterSkewYInterp:Number = Math.random();
         var aSkewX:Number = this.mEmitterDef.mEmitterSkewX.evaluate(this.mSystemTimeValue,aEmitterSkewXInterp);
         var aSkewY:Number = this.mEmitterDef.mEmitterSkewY.evaluate(this.mSystemTimeValue,aEmitterSkewYInterp);
         aParticle.mPosition.x = this.mSystemCenter.x + aPosX + aPosY * aSkewX;
         aParticle.mPosition.y = this.mSystemCenter.y + aPosY + aPosX * aSkewY;
         aParticle.mVelocity.x = Math.sin(aLaunchAngle) * aLaunchSpeed;
         aParticle.mVelocity.y = Math.cos(aLaunchAngle) * aLaunchSpeed;
         var aEmitterOffsetX:Number = this.mEmitterDef.mEmitterOffsetX.evaluate(this.mSystemTimeValue,aEmitterOffsetXInterp);
         var aEmitterOffsetY:Number = this.mEmitterDef.mEmitterOffsetY.evaluate(this.mSystemTimeValue,aEmitterOffsetYInterp);
         aParticle.mPosition.x += aEmitterOffsetX;
         aParticle.mPosition.y += aEmitterOffsetY;
         aParticle.mAnimationTimeValue = 0;
         if(this.mEmitterDef.mAnimated || this.mEmitterDef.mAnimationRate.isSet())
         {
            aParticle.mImageFrame = 0;
         }
         else
         {
            aParticle.mImageFrame = int(Math.random() * this.mEmitterDef.mImageFrames);
         }
         if(this.mEmitterDef.mParticleFlags.hasFlags(ParticleFlags.RANDOM_LAUNCH_SPIN))
         {
            aParticle.mSpinPosition = Math.random() * CIRCLE_FULL;
         }
         else if(this.mEmitterDef.mParticleFlags.hasFlags(ParticleFlags.ALIGN_LAUNCH_SPIN))
         {
            aParticle.mSpinPosition = aLaunchAngle;
         }
         else
         {
            aParticle.mSpinPosition = 0;
         }
         aParticle.mSpinVelocity = 0;
         aParticle.mCrossFadeDuration = 0;
         this.mParticleList.unshift(aParticle);
         ++this.mParticlesSpawned;
         this.updateParticle(aParticle);
         return aParticle;
      }
      
      public function setPosition(x:Number, y:Number) : void
      {
         var aNumParticles:int = 0;
         var i:int = 0;
         var aParticle:Particle = null;
         var deltaX:Number = x - this.mSystemCenter.x;
         var deltaY:Number = y - this.mSystemCenter.y;
         if(deltaX == 0 && deltaY == 0)
         {
            return;
         }
         this.mSystemCenter.x = x;
         this.mSystemCenter.y = y;
         if(!this.mEmitterDef.mParticleFlags.hasFlags(ParticleFlags.PARTICLES_DONT_FOLLOW))
         {
            aNumParticles = int(this.mParticleList.length);
            for(i = 0; i < aNumParticles; i += 1)
            {
               aParticle = this.mParticleList[i];
               aParticle.mPosition.x += deltaX;
               aParticle.mPosition.y += deltaY;
            }
         }
      }
      
      private function getRenderParams(particle:Particle, params:ParticleRenderParams) : Boolean
      {
         var aFraction:Number = NaN;
         var aEmitter:ParticleEmitter = particle.mParticleEmitter;
         var aDef:ParticleEmitterDefinition = aEmitter.mEmitterDef;
         params.mRedIsSet = false;
         params.mRedIsSet = aDef.mSystemRed.isSet() || params.mRedIsSet;
         params.mRedIsSet = aDef.mParticleRed.isSet() || params.mRedIsSet;
         params.mRedIsSet = aEmitter.mColorOverride.red != 1 || params.mRedIsSet;
         params.mGreenIsSet = false;
         params.mGreenIsSet = aDef.mSystemGreen.isSet() || params.mGreenIsSet;
         params.mGreenIsSet = aDef.mParticleGreen.isSet() || params.mGreenIsSet;
         params.mGreenIsSet = aEmitter.mColorOverride.green != 1 || params.mGreenIsSet;
         params.mBlueIsSet = false;
         params.mBlueIsSet = aDef.mSystemBlue.isSet() || params.mBlueIsSet;
         params.mBlueIsSet = aDef.mParticleBlue.isSet() || params.mBlueIsSet;
         params.mBlueIsSet = aEmitter.mColorOverride.blue != 1 || params.mBlueIsSet;
         params.mAlphaIsSet = false;
         params.mAlphaIsSet = aDef.mSystemAlpha.isSet() || params.mAlphaIsSet;
         params.mAlphaIsSet = aDef.mParticleAlpha.isSet() || params.mAlphaIsSet;
         params.mAlphaIsSet = aEmitter.mColorOverride.alpha != 1 || params.mAlphaIsSet;
         params.mParticleScaleIsSet = false;
         params.mParticleScaleIsSet = params.mParticleScaleIsSet || aDef.mParticleScale.isSet();
         params.mParticleStretchIsSet = aDef.mParticleStretch.isSet();
         params.mSpinPositionIsSet = false;
         params.mSpinPositionIsSet = params.mSpinPositionIsSet || aDef.mParticleSpinSpeed.isSet();
         params.mSpinPositionIsSet = params.mSpinPositionIsSet || aDef.mParticleSpinAngle.isSet();
         params.mSpinPositionIsSet = params.mSpinPositionIsSet || aDef.mParticleFlags.hasFlags(ParticleFlags.RANDOM_LAUNCH_SPIN);
         params.mSpinPositionIsSet = params.mSpinPositionIsSet || aDef.mParticleFlags.hasFlags(ParticleFlags.ALIGN_LAUNCH_SPIN);
         params.mPositionIsSet = false;
         params.mPositionIsSet = params.mPositionIsSet || aDef.mParticleFields.length > 0;
         params.mPositionIsSet = params.mPositionIsSet || aDef.mEmitterRadius.isSet();
         params.mPositionIsSet = params.mPositionIsSet || aDef.mEmitterOffsetX.isSet();
         params.mPositionIsSet = params.mPositionIsSet || aDef.mEmitterOffsetY.isSet();
         params.mPositionIsSet = params.mPositionIsSet || aDef.mEmitterBoxX.isSet();
         params.mPositionIsSet = params.mPositionIsSet || aDef.mEmitterBoxY.isSet();
         var aSystemRed:Number = this.evalSystemTrack(aDef.mSystemRed,TRACK_SYSTEM_RED);
         var aSystemGreen:Number = this.evalSystemTrack(aDef.mSystemGreen,TRACK_SYSTEM_GREEN);
         var aSystemBlue:Number = this.evalSystemTrack(aDef.mSystemBlue,TRACK_SYSTEM_BLUE);
         var aSystemAlpha:Number = this.evalSystemTrack(aDef.mSystemAlpha,TRACK_SYSTEM_ALPHA);
         var aSystemBrightness:Number = this.evalSystemTrack(aDef.mSystemBrightness,TRACK_SYSTEM_BRIGHTNESS);
         var aParticleRed:Number = this.evalParticleTrack(aDef.mParticleRed,particle,Particle.TRACK_PARTICLE_RED);
         var aParticleGreen:Number = this.evalParticleTrack(aDef.mParticleGreen,particle,Particle.TRACK_PARTICLE_GREEN);
         var aParticleBlue:Number = this.evalParticleTrack(aDef.mParticleBlue,particle,Particle.TRACK_PARTICLE_BLUE);
         var aParticleAlpha:Number = this.evalParticleTrack(aDef.mParticleAlpha,particle,Particle.TRACK_PARTICLE_ALPHA);
         var aParticleBrightness:Number = this.evalParticleTrack(aDef.mParticleBrightness,particle,Particle.TRACK_PARTICLE_BRIGHTNESS);
         var aBrightness:Number = aParticleBrightness * aSystemBrightness;
         params.mRed = aParticleRed * aSystemRed * aEmitter.mColorOverride.red * aBrightness;
         params.mGreen = aParticleGreen * aSystemGreen * aEmitter.mColorOverride.green * aBrightness;
         params.mBlue = aParticleBlue * aSystemBlue * aEmitter.mColorOverride.blue * aBrightness;
         params.mAlpha = aParticleAlpha * aSystemAlpha * aEmitter.mColorOverride.alpha * aBrightness;
         params.mPosX = particle.mPosition.x;
         params.mPosY = particle.mPosition.y;
         params.mParticleScale = this.evalParticleTrack(aDef.mParticleScale,particle,Particle.TRACK_PARTICLE_SCALE);
         params.mParticleStretch = this.evalParticleTrack(aDef.mParticleStretch,particle,Particle.TRACK_PARTICLE_STRETCH);
         params.mSpinPosition = particle.mSpinPosition;
         var aCrossParticle:Particle = particle.mCrossFadeParticle;
         if(aCrossParticle == null)
         {
            return true;
         }
         var aCrossFadeParams:ParticleRenderParams = new ParticleRenderParams();
         if(this.getRenderParams(aCrossParticle,aCrossFadeParams))
         {
            aFraction = particle.mParticleAge / (aCrossParticle.mCrossFadeDuration - 1);
            params.mAlpha = this.crossFadeLerp(aCrossFadeParams.mAlpha,params.mAlpha,aCrossFadeParams.mAlphaIsSet,params.mAlphaIsSet,aFraction);
            params.mRed = this.crossFadeLerp(aCrossFadeParams.mRed,params.mRed,aCrossFadeParams.mRedIsSet,params.mRedIsSet,aFraction);
            params.mGreen = this.crossFadeLerp(aCrossFadeParams.mGreen,params.mGreen,aCrossFadeParams.mGreenIsSet,params.mGreenIsSet,aFraction);
            params.mBlue = this.crossFadeLerp(aCrossFadeParams.mBlue,params.mBlue,aCrossFadeParams.mBlueIsSet,params.mBlueIsSet,aFraction);
            params.mParticleScale = this.crossFadeLerp(aCrossFadeParams.mParticleScale,params.mParticleScale,aCrossFadeParams.mParticleScaleIsSet,params.mParticleScaleIsSet,aFraction);
            params.mParticleStretch = this.crossFadeLerp(aCrossFadeParams.mParticleStretch,params.mParticleStretch,aCrossFadeParams.mParticleStretchIsSet,params.mParticleStretchIsSet,aFraction);
            params.mSpinPosition = this.crossFadeLerp(aCrossFadeParams.mSpinPosition,params.mSpinPosition,aCrossFadeParams.mSpinPositionIsSet,params.mSpinPositionIsSet,aFraction);
            params.mPosX = this.crossFadeLerp(aCrossFadeParams.mPosX,params.mPosX,aCrossFadeParams.mPositionIsSet,params.mPositionIsSet,aFraction);
            params.mPosY = this.crossFadeLerp(aCrossFadeParams.mPosY,params.mPosY,aCrossFadeParams.mPositionIsSet,params.mPositionIsSet,aFraction);
            params.mAlphaIsSet = params.mAlphaIsSet || aCrossFadeParams.mAlphaIsSet;
            params.mRedIsSet = params.mRedIsSet || aCrossFadeParams.mRedIsSet;
            params.mGreenIsSet = params.mGreenIsSet || aCrossFadeParams.mGreenIsSet;
            params.mBlueIsSet = params.mBlueIsSet || aCrossFadeParams.mBlueIsSet;
            params.mParticleScaleIsSet = params.mParticleScaleIsSet || aCrossFadeParams.mParticleScaleIsSet;
            params.mParticleStretchIsSet = params.mParticleStretchIsSet || aCrossFadeParams.mParticleStretchIsSet;
            params.mSpinPositionIsSet = params.mSpinPositionIsSet || aCrossFadeParams.mSpinPositionIsSet;
            params.mPositionIsSet = params.mPositionIsSet || aCrossFadeParams.mPositionIsSet;
         }
         return true;
      }
      
      private function evalParticleTrack(track:FloatParameterTrack, particle:Particle, index:Number) : Number
      {
         return track.evaluate(particle.mParticleTimeValue,particle.mParticleInterp[index]);
      }
      
      private function clamp(value:Number, min:Number, max:Number) : Number
      {
         var tmp:Number = value < max ? value : max;
         return tmp > min ? tmp : min;
      }
      
      private function renderParticle(g:Graphics2D, particle:Particle, params:ParticleRenderParams) : void
      {
         var anEmitter:ParticleEmitter = particle.mParticleEmitter;
         var aDef:ParticleEmitterDefinition = anEmitter.mEmitterDef;
         var aImage:ImageInst = aDef.mImage;
         if(aImage == null)
         {
            return;
         }
         var aFrame:Number = 0;
         var aNumFrames:Number = this.mEmitterDef.mImageFrames;
         if(this.mEmitterDef.mAnimationRate.isSet())
         {
            aFrame = int(particle.mAnimationTimeValue * aNumFrames);
            aFrame = this.clamp(aFrame,0,aNumFrames - 1);
         }
         else if(this.mEmitterDef.mAnimated)
         {
            aFrame = int(particle.mParticleTimeValue * aNumFrames);
            aFrame = this.clamp(aFrame,0,aNumFrames - 1);
         }
         else
         {
            aFrame = particle.mImageFrame;
         }
         aImage.setFrame(aFrame,aDef.mImageCol,aDef.mImageRow);
         var aTransform:Matrix = new Matrix();
         aTransform.translate(-aImage.width / 2,-aImage.height / 2);
         if(params.mSpinPositionIsSet)
         {
            aTransform.rotate(params.mSpinPosition);
         }
         if(params.mParticleScaleIsSet)
         {
            aTransform.scale(params.mParticleScale,params.mParticleScale);
         }
         if(params.mParticleStretchIsSet)
         {
            aTransform.scale(1,params.mParticleStretch);
         }
         aImage.useColor = params.mAlphaIsSet || params.mRedIsSet || params.mGreenIsSet || params.mBlueIsSet;
         aImage.setColor(params.mAlphaIsSet ? params.mAlpha : 1,params.mRedIsSet ? params.mRed : 1,params.mGreenIsSet ? params.mGreen : 1,params.mBlueIsSet ? params.mBlue : 1);
         aTransform.translate(params.mPosX,params.mPosY);
         g.pushState();
         g.setTransform(aTransform);
         g.drawImage(aImage,0,0);
         g.popState();
      }
      
      public function update() : void
      {
         var aEmitterCrossFade:ParticleEmitter = null;
         var aParticleField:ParticleField = null;
         var aParticle:Particle = null;
         if(this.mDead)
         {
            return;
         }
         ++this.mSystemAge;
         var aDie:Boolean = false;
         if(this.mSystemAge >= this.mSystemDuration)
         {
            if(this.mEmitterDef.mParticleFlags.hasFlags(ParticleFlags.SYSTEM_LOOPS))
            {
               this.mSystemAge = 0;
            }
            else
            {
               this.mSystemAge = this.mSystemDuration - 1;
               aDie = true;
            }
         }
         if(this.mEmitterCrossFadeCountDown > 0)
         {
            --this.mEmitterCrossFadeCountDown;
            if(this.mEmitterCrossFadeCountDown == 0)
            {
               aDie = true;
            }
         }
         if(this.mCrossFadeEmitter != null)
         {
            aEmitterCrossFade = this.mCrossFadeEmitter;
            if(aEmitterCrossFade == null || aEmitterCrossFade.mDead)
            {
               aDie = true;
            }
         }
         this.mSystemTimeValue = this.mSystemAge / (this.mSystemDuration - 1);
         var aSystemFieldCount:int = int(this.mEmitterDef.mSystemFields.length);
         for(var i:int = 0; i < aSystemFieldCount; i++)
         {
            aParticleField = this.mEmitterDef.mSystemFields[i];
            this.updateSystemField(aParticleField,this.mSystemTimeValue,i);
         }
         var aNumParticles:int = int(this.mParticleList.length);
         for(var k:int = 0; k < aNumParticles; k++)
         {
            aParticle = this.mParticleList[k];
            if(!this.updateParticle(aParticle))
            {
               this.deleteParticle(aParticle);
               k--;
               aNumParticles--;
            }
         }
         this.updateSpawning();
         if(aDie)
         {
            this.deleteNonCrossFading();
            if(this.mParticleList.length == 0)
            {
               this.mDead = true;
               return;
            }
         }
         this.mSystemLastTimeValue = this.mSystemTimeValue;
      }
      
      private function updateParticleField(particle:Particle, field:ParticleField, time:Number, index:int) : void
      {
         var aInterpX:Number = NaN;
         var aInterpY:Number = NaN;
         var x:Number = NaN;
         var y:Number = NaN;
         var aDiffX:Number = NaN;
         var aDiffY:Number = NaN;
         var aLastX:Number = NaN;
         var aLastY:Number = NaN;
         var aCollisionReflect:Number = NaN;
         var aCollisionSpin:Number = NaN;
         aInterpX = Number(particle.mParticleFieldInterp[index][0]);
         aInterpY = Number(particle.mParticleFieldInterp[index][1]);
         x = field.mX.evaluate(time,aInterpX);
         y = field.mY.evaluate(time,aInterpY);
         switch(field.mFieldType)
         {
            case ParticleFieldType.ACCELERATION:
               particle.mVelocity.x += x * SECONDS_PER_UPDATE;
               particle.mVelocity.y += y * SECONDS_PER_UPDATE;
               break;
            case ParticleFieldType.FRICTION:
               particle.mVelocity.x *= 1 - x;
               particle.mVelocity.y *= 1 - y;
               break;
            case ParticleFieldType.ATTRACTOR:
               aDiffX = x - (particle.mPosition.x - this.mSystemCenter.x);
               aDiffY = y - (particle.mPosition.y - this.mSystemCenter.y);
               particle.mVelocity.x += aDiffX * SECONDS_PER_UPDATE;
               particle.mVelocity.y += aDiffY * SECONDS_PER_UPDATE;
               break;
            case ParticleFieldType.MAX_VELOCITY:
               particle.mVelocity.x = this.clamp(particle.mVelocity.x,-x,x);
               particle.mVelocity.y = this.clamp(particle.mVelocity.y,-y,y);
               break;
            case ParticleFieldType.VELOCITY:
               particle.mPosition.x += x * SECONDS_PER_UPDATE;
               particle.mPosition.y += y * SECONDS_PER_UPDATE;
               break;
            case ParticleFieldType.POSITION:
               aLastX = field.mX.evaluate(particle.mParticleLastTimeValue,aInterpX);
               aLastY = field.mY.evaluate(particle.mParticleLastTimeValue,aInterpY);
               particle.mPosition.x += x - aLastX;
               particle.mPosition.y += y - aLastY;
               break;
            case ParticleFieldType.GROUND_CONSTRAINT:
               if(particle.mPosition.y > this.mSystemCenter.y + y)
               {
                  particle.mPosition.y = this.mSystemCenter.y + y;
                  aCollisionReflect = this.mEmitterDef.mCollisionReflect.evaluate(time,particle.mParticleInterp[Particle.TRACK_PARTICLE_COLLISION_REFLECT]);
                  aCollisionSpin = this.mEmitterDef.mCollisionSpin.evaluate(time,particle.mParticleInterp[Particle.TRACK_PARTICLE_COLLISION_SPIN]) / 1000;
                  particle.mSpinVelocity = particle.mVelocity.y * aCollisionSpin;
                  particle.mVelocity.x *= aCollisionReflect;
                  particle.mVelocity.y = -particle.mVelocity.y * aCollisionReflect;
               }
               break;
            case ParticleFieldType.SHAKE:
               particle.mPosition.x -= particle.mOffset.x;
               particle.mPosition.y -= particle.mOffset.y;
               particle.mOffset.x = x * (Math.random() * ONE_OVER_32K * 2 - 1);
               particle.mOffset.y = y * (Math.random() * ONE_OVER_32K * 2 - 1);
               particle.mPosition.x += particle.mOffset.x;
               particle.mPosition.y += particle.mOffset.y;
               break;
            default:
               throw new Error("Unsupported field type \'" + field.mFieldType + "\'");
         }
      }
      
      public function draw(g:Graphics2D) : void
      {
         var aParticle:Particle = null;
         if(this.mEmitterDef.mParticleFlags.hasFlags(ParticleFlags.HARDWARE_ONLY))
         {
            return;
         }
         var aNumParticles:int = int(this.mParticleList.length);
         for(var i:int = 0; i < aNumParticles; i++)
         {
            aParticle = this.mParticleList[i];
            this.drawParticle(g,aParticle);
         }
      }
      
      private function deleteParticle(particle:Particle) : void
      {
         var aCrossParticle:Particle = particle.mCrossFadeParticle;
         if(aCrossParticle != null)
         {
            aCrossParticle.mParticleEmitter.deleteParticle(aCrossParticle);
            particle.mCrossFadeParticle = null;
         }
         var index:Number = this.mParticleList.indexOf(particle);
         if(index > -1)
         {
            this.mParticleList.splice(index,1);
         }
      }
      
      private function drawParticle(g:Graphics2D, particle:Particle) : void
      {
         var aCrossFadeParticle:Particle = null;
         if(particle.mCrossFadeDuration > 0)
         {
            return;
         }
         var aParams:ParticleRenderParams = new ParticleRenderParams();
         if(!this.getRenderParams(particle,aParams))
         {
            return;
         }
         if(aParams.mAlpha == 0)
         {
            return;
         }
         aParams.mPosX += g.getTransform().tx;
         aParams.mPosY += g.getTransform().ty;
         var aImageParticle:Particle = particle;
         if(this.mImageOverride || this.mEmitterDef.mImage != null)
         {
            aImageParticle = particle;
         }
         else
         {
            aCrossFadeParticle = null;
            if(aCrossFadeParticle == null)
            {
               return;
            }
            aImageParticle = aCrossFadeParticle;
         }
         this.renderParticle(g,aImageParticle,aParams);
      }
      
      public function initFromDef(emitterDef:ParticleEmitterDefinition, system:ParticleSystem) : void
      {
         var aSystemDurationInterp:Number = NaN;
         this.mEmitterDef = emitterDef;
         this.mParticleSystem = system;
         this.mSpawnAccum = 0;
         this.mParticlesSpawned = 0;
         this.mSystemAge = -1;
         this.mDead = false;
         this.mSystemTimeValue = -1;
         this.mSystemLastTimeValue = -1;
         this.mSystemDuration = 0;
         this.mSystemCenter = new Point();
         this.mParticleList = new Array();
         if(this.mEmitterDef.mSystemDuration.isSet())
         {
            aSystemDurationInterp = Math.random();
            this.mSystemDuration = this.mEmitterDef.mSystemDuration.evaluate(0,aSystemDurationInterp);
         }
         else
         {
            this.mSystemDuration = this.mEmitterDef.mParticleDuration.evaluate(0,1);
         }
         this.mSystemDuration = this.mSystemDuration > 1 ? this.mSystemDuration : 1;
         var aSystemFieldCount:int = int(this.mEmitterDef.mSystemFields.length);
         this.mSystemFieldInterp = new Array();
         for(var i:int = 0; i < aSystemFieldCount; i++)
         {
            this.mSystemFieldInterp[i] = new Array();
            this.mSystemFieldInterp[i][0] = Math.random();
            this.mSystemFieldInterp[i][1] = Math.random();
         }
         this.mTrackInterp = new Array(NUM_SYSTEM_TRACKS);
         var aNumInterps:int = int(this.mTrackInterp.length);
         for(var k:int = 0; k < aNumInterps; k++)
         {
            this.mTrackInterp[k] = Math.random();
         }
         this.update();
      }
      
      private function updateParticle(particle:Particle) : Boolean
      {
         var aField:ParticleField = null;
         if(particle.mParticleAge >= particle.mParticleDuration)
         {
            if(this.mEmitterDef.mParticleFlags.hasFlags(ParticleFlags.PARTICLE_LOOPS))
            {
               particle.mParticleAge = 0;
            }
            else
            {
               if(particle.mCrossFadeDuration <= 0)
               {
                  return false;
               }
               particle.mParticleAge = particle.mParticleDuration - 1;
            }
         }
         particle.mParticleTimeValue = particle.mParticleAge / (particle.mParticleDuration - 1);
         var aFieldCount:int = int(this.mEmitterDef.mParticleFields.length);
         for(var i:int = 0; i < aFieldCount; i++)
         {
            aField = this.mEmitterDef.mParticleFields[i];
            this.updateParticleField(particle,aField,particle.mParticleTimeValue,i);
         }
         particle.mPosition.x += particle.mVelocity.x;
         particle.mPosition.y += particle.mVelocity.y;
         var aSpinSpeed:Number = this.mEmitterDef.mParticleSpinSpeed.evaluate(particle.mParticleTimeValue,particle.mParticleInterp[Particle.TRACK_PARTICLE_SPIN_SPEED]) * SECONDS_PER_UPDATE;
         var aSpinAngle:Number = this.mEmitterDef.mParticleSpinAngle.evaluate(particle.mParticleTimeValue,particle.mParticleInterp[Particle.TRACK_PARTICLE_SPIN_ANGLE]);
         var aLastSpinAngle:Number = this.mEmitterDef.mParticleSpinAngle.evaluateLast(particle.mParticleLastTimeValue,particle.mParticleInterp[Particle.TRACK_PARTICLE_SPIN_ANGLE]);
         particle.mSpinPosition += aSpinSpeed + aSpinAngle - aLastSpinAngle;
         particle.mSpinPosition += particle.mSpinVelocity;
         if(this.mEmitterDef.mAnimationRate.isSet())
         {
            throw new Error("Not implemented!");
         }
         particle.mParticleLastTimeValue = particle.mParticleTimeValue;
         ++particle.mParticleAge;
         return true;
      }
      
      private function updateSpawning() : void
      {
         var aSpawnMinimum:Number = NaN;
         var aMaxCanSpawn:Number = NaN;
         var aSpawnMaxLaunched:int = 0;
         var aMaxCanSpawn2:Number = NaN;
         var aParticle:Particle = null;
         var aSpawnEmitter:ParticleEmitter = this;
         var aCrossFadeEmitter:ParticleEmitter = this.mCrossFadeEmitter;
         if(aCrossFadeEmitter != null)
         {
            aSpawnEmitter = aCrossFadeEmitter;
         }
         var aDef:ParticleEmitterDefinition = aSpawnEmitter.mEmitterDef;
         var aTrack:FloatParameterTrack = null;
         var aTime:Number = 0;
         var anInterp:Number = 0;
         aTrack = aDef.mSpawnRate;
         aTime = aSpawnEmitter.mSystemTimeValue;
         anInterp = Number(aSpawnEmitter.mTrackInterp[TRACK_SPAWN_RATE]);
         this.mSpawnAccum += aTrack.evaluate(aTime,anInterp) * SECONDS_PER_UPDATE;
         var aSpawnCount:int = int(this.mSpawnAccum);
         this.mSpawnAccum -= aSpawnCount;
         aTrack = aDef.mSpawnMinActive;
         aTime = aSpawnEmitter.mSystemTimeValue;
         anInterp = Number(aSpawnEmitter.mTrackInterp[TRACK_SPAWN_MIN_ACTIVE]);
         var aSpawnMinActive:int = int(aTrack.evaluate(aTime,anInterp));
         if(aSpawnMinActive >= 0)
         {
            aSpawnMinimum = aSpawnMinActive - this.mParticleList.length;
            if(aSpawnCount < aSpawnMinimum)
            {
               aSpawnCount = aSpawnMinimum;
            }
         }
         aTrack = aDef.mSpawnMaxActive;
         aTime = aSpawnEmitter.mSystemTimeValue;
         anInterp = Number(aSpawnEmitter.mTrackInterp[TRACK_SPAWN_MAX_ACTIVE]);
         var aSpawnMaxActive:int = int(aTrack.evaluate(aTime,anInterp));
         if(aSpawnMaxActive >= 0)
         {
            aMaxCanSpawn = aSpawnMaxActive - this.mParticleList.length;
            if(aSpawnCount > aMaxCanSpawn)
            {
               aSpawnCount = aMaxCanSpawn;
            }
         }
         if(aDef.mSpawnMaxLaunched.isSet())
         {
            aTrack = aDef.mSpawnMaxLaunched;
            aTime = aSpawnEmitter.mSystemTimeValue;
            anInterp = Number(aSpawnEmitter.mTrackInterp[TRACK_SPAWN_MAX_LAUNCHED]);
            aSpawnMaxLaunched = int(aTrack.evaluate(aTime,anInterp));
            aMaxCanSpawn2 = aSpawnMaxLaunched - this.mParticlesSpawned;
            if(aSpawnCount > aMaxCanSpawn2)
            {
               aSpawnCount = aMaxCanSpawn2;
            }
         }
         for(var i:int = 0; i < aSpawnCount; i++)
         {
            aParticle = this.spawnParticle(i,aSpawnCount);
            if(aCrossFadeEmitter)
            {
               this.crossFadeParticle(aParticle,aCrossFadeEmitter);
            }
         }
      }
      
      private function crossFadeLerp(from:Number, to:Number, fromIsSet:Boolean, toIsSet:Boolean, fraction:Number) : Number
      {
         if(!fromIsSet)
         {
            return to;
         }
         if(!toIsSet)
         {
            return from;
         }
         return from + (to - from) * fraction;
      }
      
      public function deleteAll() : void
      {
         this.mParticleList = new Array();
      }
   }
}
