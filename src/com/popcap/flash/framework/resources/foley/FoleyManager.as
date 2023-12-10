package com.popcap.flash.framework.resources.foley
{
   import com.popcap.flash.framework.AppBase;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class FoleyManager
   {
      
      public static const MAX_FOLEY_INSTANCES:Number = 8;
       
      
      private var mFoleyMap:Dictionary;
      
      private var mApp:AppBase;
      
      public function FoleyManager(app:AppBase)
      {
         super();
         this.mApp = app;
         this.mFoleyMap = new Dictionary();
      }
      
      public function loadFoley(type:FoleyType) : void
      {
         var aData:FoleyTypeData = new FoleyTypeData(type);
         this.mFoleyMap[type] = aData;
      }
      
      public function playFoley(type:FoleyType) : void
      {
         var aData:FoleyTypeData = this.mFoleyMap[type];
         if(aData == null)
         {
            throw new Error("FoleyType \'" + type + "\' not loaded.");
         }
         var aType:FoleyType = aData.mType;
         var aPitch:Number = 0;
         if(aType.pitchRange != 0)
         {
            aPitch = Math.random() * aType.pitchRange;
         }
         this.playFoleyPitch(aData,aPitch);
      }
      
      private function playFoleyPitch(data:FoleyTypeData, pitch:Number) : void
      {
         var aType:FoleyType = data.mType;
         var aTimeNow:int = getTimer();
         if(aTimeNow - data.mLastPlayed < 100)
         {
            return;
         }
         if(aType.flags.hasFlags(FoleyFlags.ONE_AT_A_TIME))
         {
         }
         var aVariations:Array = new Array();
         var aVariationCount:int = int(aType.variations.length);
         for(var i:int = 0; i < aVariationCount; i++)
         {
            if(!(aType.flags.hasFlags(FoleyFlags.DONT_REPEAT) && data.mLastVariationPlayed == i))
            {
               aVariations.push(aType.variations[i]);
            }
         }
         var aNumChoices:int = int(aVariations.length);
         var aChosen:int = Math.floor(Math.random() * aNumChoices);
         data.mLastVariationPlayed = aChosen;
         var aSoundId:String = String(aType.variations[aChosen]);
         var aNumPlaying:Number = this.mApp.soundManager.getNumPlaying(aSoundId);
         if(aNumPlaying >= MAX_FOLEY_INSTANCES)
         {
            return;
         }
         if(aType.flags.hasFlags(FoleyFlags.USES_MUSIC_VOLUME))
         {
         }
         var isLooping:Boolean = aType.flags.hasFlags(FoleyFlags.LOOP);
         data.mLastPlayed = getTimer();
         this.mApp.soundManager.playSound(aSoundId);
      }
   }
}
