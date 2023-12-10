package com.popcap.flash.framework.resources.particles
{
   import com.popcap.flash.framework.utils.CEnum;
   
   public class ParticleEmitterType extends CEnum
   {
      
      public static const BOX:ParticleEmitterType = new ParticleEmitterType();
      
      public static const CIRCLE_EVEN_SPACING:ParticleEmitterType = new ParticleEmitterType();
      
      public static const CIRCLE:ParticleEmitterType = new ParticleEmitterType();
      
      public static const CIRCLE_PATH:ParticleEmitterType = new ParticleEmitterType();
      
      public static const BOX_PATH:ParticleEmitterType = new ParticleEmitterType();
      
      {
         CEnum.InitEnumConstants(ParticleEmitterType);
      }
      
      public function ParticleEmitterType()
      {
         super();
      }
      
      public static function fromUInt(param1:uint) : ParticleEmitterType
      {
         switch(param1)
         {
            case 0:
               return CIRCLE;
            case 1:
               return BOX;
            case 2:
               return BOX_PATH;
            case 3:
               return CIRCLE_PATH;
            case 4:
               return CIRCLE_EVEN_SPACING;
            default:
               return null;
         }
      }
      
      public static function toUInt(param1:ParticleEmitterType) : uint
      {
         if(param1 == CIRCLE)
         {
            return 0;
         }
         if(param1 == BOX)
         {
            return 1;
         }
         if(param1 == BOX_PATH)
         {
            return 2;
         }
         if(param1 == CIRCLE_PATH)
         {
            return 3;
         }
         if(param1 == CIRCLE_EVEN_SPACING)
         {
            return 4;
         }
         throw new Error("How did I get here?");
      }
      
      public static function fromString(param1:String) : ParticleEmitterType
      {
         switch(param1)
         {
            case "Circle":
               return CIRCLE;
            case "Box":
               return BOX;
            case "BoxPath":
               return BOX_PATH;
            case "CirclePath":
               return CIRCLE_PATH;
            case "CircleEvenSpacing":
               return CIRCLE_EVEN_SPACING;
            default:
               throw new ArgumentError("Unknown ParticleEmitterType \'" + param1 + "\'");
         }
      }
   }
}
