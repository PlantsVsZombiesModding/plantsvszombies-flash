package com.popcap.flash.games.pvz.logic
{
   import com.popcap.flash.framework.graphics.Color;
   
   public class TodCommon
   {
      
      public static const CURVE_WEAK_FAST_IN_OUT:int = 8;
      
      public static const CURVE_SIN_WAVE:int = 12;
      
      public static const CURVE_BOUNCE_FAST_MIDDLE:int = 10;
      
      public static const CURVE_CONSTANT:int = 0;
      
      public static const CURVE_LINEAR:int = 1;
      
      public static const CURVE_EASE_IN_OUT:int = 4;
      
      public static const CURVE_EASE_IN:int = 2;
      
      public static const SECONDS_PER_UPDATE:Number = 0.01;
      
      public static const EPSILON:Number = 0.000001;
      
      public static const CURVE_EASE_OUT:int = 3;
      
      public static const CURVE_FAST_IN_OUT_WEAK:int = 7;
      
      public static const CURVE_BOUNCE_SLOW_MIDDLE:int = 11;
      
      public static const CURVE_EASE_SIN_WAVE:int = 13;
      
      public static const CURVE_EASE_IN_OUT_WEAK:int = 5;
      
      public static const CURVE_FAST_IN_OUT:int = 6;
      
      private static var gFlashingColor:Color = new Color();
      
      public static const CURVE_BOUNCE:int = 9;
      
      public static const PI:Number = 3.141592653;
      
      public static const CIRCLE_HALF:Number = PI;
      
      public static const CIRCLE_FULL:Number = PI * 2;
      
      public static const CIRCLE_QUARTER:Number = PI * 0.5;
      
      public static const CIRCLE_SIXTH:Number = PI * 0.333333333;
      
      public static const CIRCLE_EIGHTH:Number = PI * 0.25;
      
      public static const TICKS_PER_SECOND:Number = 100;
       
      
      public function TodCommon()
      {
         super();
      }
      
      public static function ClampFloat(num:Number, minNum:Number, maxNum:Number) : Number
      {
         if(num <= minNum)
         {
            return minNum;
         }
         if(num >= maxNum)
         {
            return maxNum;
         }
         return num;
      }
      
      public static function TodPickFromArray(theArray:Array, theCount:int) : int
      {
         var aPick:int = Math.random() * theCount;
         return theArray[aPick];
      }
      
      public static function TodCurveEvaluate(theTime:Number, thePositionStart:Number, thePositionEnd:Number, theCurve:int) : Number
      {
         var aWarpedTime:Number = NaN;
         switch(theCurve)
         {
            case CURVE_CONSTANT:
               aWarpedTime = 0;
               break;
            case CURVE_LINEAR:
               aWarpedTime = theTime;
               break;
            case CURVE_EASE_IN:
               aWarpedTime = TodCurveQuad(theTime);
               break;
            case CURVE_EASE_OUT:
               aWarpedTime = TodCurveInvQuad(theTime);
               break;
            case CURVE_EASE_IN_OUT:
               aWarpedTime = TodCurveS(TodCurveS(theTime));
               break;
            case CURVE_EASE_IN_OUT_WEAK:
               aWarpedTime = TodCurveS(theTime);
               break;
            case CURVE_FAST_IN_OUT:
               aWarpedTime = TodCurveInvQuadS(TodCurveInvQuadS(theTime));
               break;
            case CURVE_FAST_IN_OUT_WEAK:
               aWarpedTime = TodCurveInvQuadS(theTime);
               break;
            case CURVE_BOUNCE:
               aWarpedTime = TodCurveBounce(theTime);
               break;
            case CURVE_BOUNCE_FAST_MIDDLE:
               aWarpedTime = TodCurveQuad(TodCurveBounce(theTime));
               break;
            case CURVE_BOUNCE_SLOW_MIDDLE:
               aWarpedTime = TodCurveInvQuad(TodCurveBounce(theTime));
               break;
            case CURVE_SIN_WAVE:
               aWarpedTime = Math.sin(theTime * CIRCLE_FULL);
               break;
            case CURVE_EASE_SIN_WAVE:
               aWarpedTime = Math.sin(TodCurveS(theTime) * CIRCLE_FULL);
               break;
            default:
               aWarpedTime = 0;
         }
         return FloatLerp(thePositionStart,thePositionEnd,aWarpedTime);
      }
      
      public static function TodCalcSmoothWeight(aWeight:Number, aLastPicked:Number, aSecondLastPicked:Number) : Number
      {
         if(aWeight < EPSILON)
         {
            return 0;
         }
         var aSmoothFactor:Number = 2;
         var aExpectedLength1:Number = 1 / aWeight;
         var aExpectedLength2:Number = aExpectedLength1 * 2;
         var aDelta1:Number = aLastPicked + 1 - aExpectedLength1;
         var aDelta2:Number = aSecondLastPicked + 1 - aExpectedLength2;
         var aFactor1:Number = 1 + aDelta1 / aExpectedLength1 * aSmoothFactor;
         var aFactor2:Number = 1 + aDelta2 / aExpectedLength2 * aSmoothFactor;
         var aFactorFinal:Number = TodCommon.ClampFloat(aFactor1 * 0.75 + aFactor2 * 0.25,0.01,100);
         return aWeight * aFactorFinal;
      }
      
      public static function TodPickFromWeightedGridArray(theArray:Array, theCount:int) : WeightedGridArray
      {
         var aTotalWeight:int = 0;
         for(var i:int = 0; i < theCount; i++)
         {
            aTotalWeight += theArray[i].mWeight;
         }
         var aPick:int = Math.random() * aTotalWeight;
         var aAcculumatedWeight:int = 0;
         for(i = 0; i < theCount; i++)
         {
            aAcculumatedWeight += theArray[i].mWeight;
            if(aPick < aAcculumatedWeight)
            {
               return theArray[i];
            }
         }
         return theArray[0];
      }
      
      public static function TodCurveQuad(theTime:Number) : Number
      {
         return theTime * theTime;
      }
      
      public static function TodPickFromWeightedArray(theArray:Array, theCount:int) : int
      {
         var aArrayItem:WeightedArray = TodPickArrayItemFromWeightedArray(theArray,theCount);
         return aArrayItem.mItem;
      }
      
      public static function TodCurveInvQuad(theTime:Number) : Number
      {
         return 2 * theTime - theTime * theTime;
      }
      
      public static function TodCurveEvaluateClamped(theTime:Number, thePositionStart:Number, thePositionEnd:Number, theCurve:int) : Number
      {
         if(theTime <= 0)
         {
            return thePositionStart;
         }
         if(theTime >= 1)
         {
            if(theCurve == CURVE_BOUNCE || theCurve == CURVE_BOUNCE_SLOW_MIDDLE || theCurve == CURVE_BOUNCE_FAST_MIDDLE || theCurve == CURVE_SIN_WAVE || theCurve == CURVE_EASE_SIN_WAVE)
            {
               return thePositionStart;
            }
            return thePositionEnd;
         }
         return TodCurveEvaluate(theTime,thePositionStart,thePositionEnd,theCurve);
      }
      
      public static function TodAnimateCurveFloat(theTimeStart:int, theTimeEnd:int, theTimeAge:int, thePositionStart:Number, thePositionEnd:Number, theCurve:int) : Number
      {
         var aElapse:int = theTimeAge - theTimeStart;
         var aMoveTime:int = theTimeEnd - theTimeStart;
         var aTime:Number = Number(aElapse) / Number(aMoveTime);
         return TodCurveEvaluateClamped(aTime,thePositionStart,thePositionEnd,theCurve);
      }
      
      public static function TodCurveQuadS(theTime:Number) : Number
      {
         if(theTime <= 0.5)
         {
            return TodCurveQuad(theTime * 2) * 0.5;
         }
         return TodCurveInvQuad((theTime - 0 * 2) * 0.5 + 0.5);
      }
      
      public static function RandRangeFloat(theMin:Number, theMax:Number) : Number
      {
         return theMin + Math.random() * (theMax - theMin);
      }
      
      public static function RandRangeInt(theMin:int, theMax:int) : int
      {
         return theMin + Math.random() * (theMax - theMin + 1);
      }
      
      public static function TodUpdateSmoothArrayPick(theArray:Array, theCount:int, thePickIndex:int) : void
      {
         for(var i:int = 0; i < theCount; i++)
         {
            if(theArray[i].mWeight > 0)
            {
               ++theArray[i].mLastPicked;
               ++theArray[i].mSecondLastPicked;
            }
         }
         theArray[thePickIndex].mSecondLastPicked = theArray[thePickIndex].mLastPicked;
         theArray[thePickIndex].mLastPicked = 0;
      }
      
      public static function ClampInt(num:int, minNum:int, maxNum:int) : int
      {
         if(num <= minNum)
         {
            return minNum;
         }
         if(num >= maxNum)
         {
            return maxNum;
         }
         return num;
      }
      
      public static function TodCurveS(theTime:Number) : Number
      {
         return 3 * theTime * theTime - 2 * theTime * theTime * theTime;
      }
      
      public static function TodPickArrayItemFromWeightedArray(theArray:Array, theCount:int) : WeightedArray
      {
         var aTotalWeight:int = 0;
         for(var i:int = 0; i < theCount; i++)
         {
            aTotalWeight += theArray[i].mWeight;
         }
         var aPick:int = Math.random() * aTotalWeight;
         var aAcculumatedWeight:int = 0;
         for(i = 0; i < theCount; i++)
         {
            aAcculumatedWeight += theArray[i].mWeight;
            if(aPick < aAcculumatedWeight)
            {
               return theArray[i];
            }
         }
         return theArray[0];
      }
      
      public static function TodAnimateCurve(theTimeStart:int, theTimeEnd:int, theTimeAge:int, thePositionStart:int, thePositionEnd:int, theCurve:int) : int
      {
         return Math.round(TodAnimateCurveFloat(theTimeStart,theTimeEnd,theTimeAge,Number(thePositionStart),Number(thePositionEnd),theCurve));
      }
      
      public static function TodCurveInvQuadS(theTime:Number) : Number
      {
         if(theTime <= 0.5)
         {
            return TodCurveInvQuad(theTime * 2) * 0.5;
         }
         return TodCurveQuad((theTime - 0.5) * 2) * 0.5 + 0.5;
      }
      
      public static function FloatLerp(theZeroValue:Number, theOneValue:Number, theTime:Number) : Number
      {
         var value:Number = NaN;
         return theZeroValue + (theOneValue - theZeroValue) * theTime;
      }
      
      public static function TodCurveBounce(theTime:Number) : Number
      {
         return 1 - Math.abs(1 - theTime * 2);
      }
      
      public static function TodPickFromSmoothArray(theArray:Array, theCount:int) : int
      {
         var aPickIndex:int = 0;
         var aItem:SmoothArray = null;
         var aTotalWeight:Number = 0;
         for(var i:int = 0; i < theCount; i++)
         {
            aTotalWeight += theArray[i].mWeight;
         }
         var aNormalizeFactor:Number = 1 / aTotalWeight;
         var aTotalAdjustedWeight:Number = 0;
         for(i = 0; i < theCount; i++)
         {
            aTotalAdjustedWeight += TodCalcSmoothWeight(theArray[i].mWeight * aNormalizeFactor,theArray[i].mLastPicked,theArray[i].mSecondLastPicked);
         }
         var aRandWeight:Number = Math.random() * aTotalAdjustedWeight;
         var aAcculumatedWeight:Number = 0;
         for(aPickIndex = 0; aPickIndex < theCount - 1; aPickIndex++)
         {
            aItem = theArray[aPickIndex];
            aAcculumatedWeight += TodCalcSmoothWeight(aItem.mWeight * aNormalizeFactor,aItem.mLastPicked,aItem.mSecondLastPicked);
            if(aRandWeight <= aAcculumatedWeight)
            {
               break;
            }
         }
         for(i = 0; i < theCount; i++)
         {
            if(theArray[i].mWeight > 0)
            {
               ++theArray[i].mLastPicked;
               ++theArray[i].mSecondLastPicked;
            }
         }
         theArray[aPickIndex].mSecondLastPicked = theArray[aPickIndex].mLastPicked;
         theArray[aPickIndex].mLastPicked = 0;
         TodUpdateSmoothArrayPick(theArray,theCount,aPickIndex);
         return theArray[aPickIndex].mItem;
      }
      
      public static function GetFlashingColor(theCounter:int, theFlashTime:int) : Color
      {
         var aFlash:int = int(theCounter % theFlashTime);
         var aHalfFlashTime:* = theFlashTime >> 1;
         var aGrayColor:int = ClampInt(55 + Math.abs(aHalfFlashTime - aFlash) * 200 / aHalfFlashTime,0,255);
         gFlashingColor.alpha = 1;
         gFlashingColor.red = aGrayColor / 255;
         gFlashingColor.green = aGrayColor / 255;
         gFlashingColor.blue = aGrayColor / 255;
         return gFlashingColor;
      }
   }
}
