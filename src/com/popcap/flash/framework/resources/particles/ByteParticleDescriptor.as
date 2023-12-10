package com.popcap.flash.framework.resources.particles
{
   import com.popcap.flash.framework.AppBase;
   import flash.utils.ByteArray;
   
   public class ByteParticleDescriptor implements ParticleDescriptor
   {
       
      
      private var mBytes:ByteArray;
      
      public function ByteParticleDescriptor(param1:ByteArray)
      {
         super();
         this.mBytes = param1;
      }
      
      public function createData(param1:AppBase) : ParticleDefinition
      {
         var _loc5_:ParticleEmitterDefinition = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:ParticleField = null;
         var _loc10_:ParticleField = null;
         var _loc2_:ParticleDefinition = new ParticleDefinition();
         this.mBytes.position = 0;
         var _loc3_:int = this.mBytes.readInt();
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            (_loc5_ = new ParticleEmitterDefinition()).mName = this.mBytes.readUTF();
            _loc5_.mImageID = this.mBytes.readUTF();
            if(_loc5_.mImageID.length > 0)
            {
               _loc5_.mImage = param1.imageManager.getImageInst(_loc5_.mImageID);
            }
            _loc5_.mImageCol = this.mBytes.readInt();
            _loc5_.mImageRow = this.mBytes.readInt();
            _loc5_.mImageFrames = this.mBytes.readInt();
            _loc5_.mAnimated = this.mBytes.readBoolean();
            _loc5_.mParticleFlags.fromUInt(this.mBytes.readUnsignedInt());
            _loc5_.mEmitterType = ParticleEmitterType.fromUInt(this.mBytes.readUnsignedInt());
            this.readParam(this.mBytes,_loc5_.mSystemDuration);
            this.readParam(this.mBytes,_loc5_.mCrossFadeDuration);
            this.readParam(this.mBytes,_loc5_.mSpawnRate);
            this.readParam(this.mBytes,_loc5_.mSpawnMinActive);
            this.readParam(this.mBytes,_loc5_.mSpawnMaxActive);
            this.readParam(this.mBytes,_loc5_.mSpawnMaxLaunched);
            this.readParam(this.mBytes,_loc5_.mEmitterRadius);
            this.readParam(this.mBytes,_loc5_.mEmitterOffsetX);
            this.readParam(this.mBytes,_loc5_.mEmitterOffsetY);
            this.readParam(this.mBytes,_loc5_.mEmitterBoxX);
            this.readParam(this.mBytes,_loc5_.mEmitterBoxY);
            this.readParam(this.mBytes,_loc5_.mEmitterSkewX);
            this.readParam(this.mBytes,_loc5_.mEmitterSkewY);
            this.readParam(this.mBytes,_loc5_.mEmitterPath);
            this.readParam(this.mBytes,_loc5_.mParticleDuration);
            this.readParam(this.mBytes,_loc5_.mLaunchSpeed);
            this.readParam(this.mBytes,_loc5_.mLaunchAngle);
            this.readParam(this.mBytes,_loc5_.mSystemRed);
            this.readParam(this.mBytes,_loc5_.mSystemGreen);
            this.readParam(this.mBytes,_loc5_.mSystemBlue);
            this.readParam(this.mBytes,_loc5_.mSystemAlpha);
            this.readParam(this.mBytes,_loc5_.mSystemBrightness);
            this.readParam(this.mBytes,_loc5_.mParticleRed);
            this.readParam(this.mBytes,_loc5_.mParticleGreen);
            this.readParam(this.mBytes,_loc5_.mParticleBlue);
            this.readParam(this.mBytes,_loc5_.mParticleAlpha);
            this.readParam(this.mBytes,_loc5_.mParticleBrightness);
            this.readParam(this.mBytes,_loc5_.mParticleSpinAngle);
            this.readParam(this.mBytes,_loc5_.mParticleSpinSpeed);
            this.readParam(this.mBytes,_loc5_.mParticleScale);
            this.readParam(this.mBytes,_loc5_.mParticleStretch);
            this.readParam(this.mBytes,_loc5_.mCollisionReflect);
            this.readParam(this.mBytes,_loc5_.mCollisionSpin);
            this.readParam(this.mBytes,_loc5_.mClipTop);
            this.readParam(this.mBytes,_loc5_.mClipBottom);
            this.readParam(this.mBytes,_loc5_.mClipLeft);
            this.readParam(this.mBytes,_loc5_.mClipRight);
            this.readParam(this.mBytes,_loc5_.mAnimationRate);
            _loc6_ = 0;
            _loc7_ = this.mBytes.readInt();
            _loc6_ = 0;
            while(_loc6_ < _loc7_)
            {
               (_loc9_ = new ParticleField()).mFieldType = ParticleFieldType.fromUInt(this.mBytes.readUnsignedInt());
               this.readParam(this.mBytes,_loc9_.mX);
               this.readParam(this.mBytes,_loc9_.mY);
               _loc5_.mParticleFields[_loc6_] = _loc9_;
               _loc6_++;
            }
            _loc8_ = this.mBytes.readInt();
            _loc6_ = 0;
            while(_loc6_ < _loc8_)
            {
               (_loc10_ = new ParticleField()).mFieldType = ParticleFieldType.fromUInt(this.mBytes.readUnsignedInt());
               this.readParam(this.mBytes,_loc10_.mX);
               this.readParam(this.mBytes,_loc10_.mY);
               _loc5_.mSystemFields[_loc6_] = _loc10_;
               _loc6_++;
            }
            _loc2_.mEmitterDefs[_loc4_] = _loc5_;
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function readParam(param1:ByteArray, param2:FloatParameterTrack) : void
      {
         var _loc5_:FloatParameterTrackNode = null;
         var _loc3_:int = param1.readInt();
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            (_loc5_ = new FloatParameterTrackNode()).mCurveType = CurveType.fromUInt(param1.readUnsignedInt());
            _loc5_.mDistribution = CurveType.fromUInt(param1.readUnsignedInt());
            _loc5_.mHighValue = param1.readDouble();
            _loc5_.mLowValue = param1.readDouble();
            _loc5_.mTime = param1.readFloat();
            param2.mNodes[_loc4_] = _loc5_;
            _loc4_++;
         }
      }
   }
}
