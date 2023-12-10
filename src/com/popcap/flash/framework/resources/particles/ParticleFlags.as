package com.popcap.flash.framework.resources.particles
{
   public class ParticleFlags
   {
      
      public static const SOFTWARE_ONLY:uint = 1024;
      
      public static const RANDOM_LAUNCH_SPIN:uint = 1;
      
      public static const ADDITIVE:uint = 256;
      
      public static const DIE_IF_OVERLOADED:uint = 128;
      
      public static const SYSTEM_LOOPS:uint = 8;
      
      public static const HARDWARE_ONLY:uint = 2048;
      
      public static const RANDOM_START_TIME:uint = 64;
      
      public static const PARTICLES_DONT_FOLLOW:uint = 32;
      
      public static const ALIGN_LAUNCH_SPIN:uint = 2;
      
      public static const PARTICLE_LOOPS:uint = 16;
      
      public static const FULLSCREEN:uint = 512;
      
      public static const ALIGN_TO_PIXEL:uint = 4;
       
      
      private var mFlags:uint = 0;
      
      public function ParticleFlags()
      {
         super();
      }
      
      public static function fromString(param1:String) : uint
      {
         switch(param1)
         {
            case "RandomLaunchSpin":
               return RANDOM_LAUNCH_SPIN;
            case "AlignLaunchSpin":
               return ALIGN_LAUNCH_SPIN;
            case "AlignToPixel":
               return ALIGN_TO_PIXEL;
            case "SystemLoops":
               return SYSTEM_LOOPS;
            case "ParticleLoops":
               return PARTICLE_LOOPS;
            case "ParticlesDontFollow":
               return PARTICLES_DONT_FOLLOW;
            case "RandomStartTime":
               return RANDOM_START_TIME;
            case "DieIfOverloaded":
               return DIE_IF_OVERLOADED;
            case "Additive":
               return ADDITIVE;
            case "FullScreen":
               return FULLSCREEN;
            case "SoftwareOnly":
               return SOFTWARE_ONLY;
            case "HardwareOnly":
               return HARDWARE_ONLY;
            default:
               throw new ArgumentError("Unknown ParticleFlags type \'" + param1 + "\'");
         }
      }
      
      public function setFlags(param1:uint) : void
      {
         this.mFlags |= param1;
      }
      
      public function clearFlags(param1:uint) : void
      {
         this.mFlags &= ~param1;
      }
      
      public function fromUInt(param1:uint) : void
      {
         this.mFlags = param1;
      }
      
      public function toUInt() : uint
      {
         return this.mFlags;
      }
      
      public function hasFlags(param1:uint) : Boolean
      {
         return (this.mFlags & param1) != 0;
      }
      
      public function toString() : String
      {
         var _loc1_:* = "[" + this.mFlags;
         if(this.hasFlags(RANDOM_LAUNCH_SPIN))
         {
            _loc1_ += "|RANDOM_LAUNCH_SPIN";
         }
         if(this.hasFlags(ALIGN_LAUNCH_SPIN))
         {
            _loc1_ += "|ALIGN_LAUNCH_SPING";
         }
         if(this.hasFlags(SYSTEM_LOOPS))
         {
            _loc1_ += "|SYSTEM_LOOPS";
         }
         if(this.hasFlags(PARTICLE_LOOPS))
         {
            _loc1_ += "|PARTICLE_LOOPS";
         }
         if(this.hasFlags(PARTICLES_DONT_FOLLOW))
         {
            _loc1_ += "|PARTICLES_DONT_FOLLOW";
         }
         if(this.hasFlags(RANDOM_START_TIME))
         {
            _loc1_ += "|RANDOM_START_TIME";
         }
         if(this.hasFlags(DIE_IF_OVERLOADED))
         {
            _loc1_ += "|DIE_IF_OVERLOADED";
         }
         if(this.hasFlags(ADDITIVE))
         {
            _loc1_ += "|ADDITIVE";
         }
         if(this.hasFlags(FULLSCREEN))
         {
            _loc1_ += "|FULLSCREEN";
         }
         if(this.hasFlags(SOFTWARE_ONLY))
         {
            _loc1_ += "|SOFTWARE_ONLY";
         }
         if(this.hasFlags(HARDWARE_ONLY))
         {
            _loc1_ += "|HARDWARE_ONLY";
         }
         return _loc1_ + "]";
      }
   }
}
