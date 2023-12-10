package com.popcap.flash.games.pvz
{
   import com.popcap.flash.framework.AppBase;
   import com.popcap.flash.framework.AppUtils;
   import flash.external.ExternalInterface;
   
   public class MSNAdAPI
   {
      
      public static const DEFAULT_LOAD_BROADCAST_RATE:Number = 3000;
      
      private static const MILLIS_PER_UPDATE:Number = 10;
      
      public static const DEFAULT_SCORE_BROADCAST_RATE:Number = 3000;
      
      public static const MIN_BROADCAST_RATE:Number = 1000;
       
      
      private var mPlaying:Boolean = false;
      
      private var mNumBreaks:Number = 0;
      
      private var mLoadBroadcastRate:Number = 3000;
      
      private var mLoading:Boolean = true;
      
      private var mEnabled:Boolean = false;
      
      private var mScoreBroadcastRate:Number = 3000;
      
      private var mSessionReadyCallback:Function;
      
      private var mScore:Number = 0;
      
      public var handleMenu:Function = null;
      
      private var mGameBreakCallback:Function;
      
      private var mGameReadyCallback:Function;
      
      private var mLoadPercent:Number = 0;
      
      private var mAppTime:Number = 0;
      
      private var mGameTime:Number = 0;
      
      private var mCustomEventCallback:Function;
      
      private var mApp:AppBase;
      
      public function MSNAdAPI(app:AppBase)
      {
         super();
         this.mApp = app;
         this.mApp.addUpdateHook(this.update);
      }
      
      private function onCustomReturn(sXML:String = null) : void
      {
         this.mCustomEventCallback();
         this.mCustomEventCallback = null;
      }
      
      private function onGamePause(str:String) : void
      {
         var isPaused:Boolean = this.onOffAsBoolean(str);
         this.togglePause(isPaused);
      }
      
      public function CustomEvent(data:XML, callback:Function) : void
      {
         if(!this.mEnabled || !ExternalInterface.available)
         {
            callback();
            return;
         }
         this.mCustomEventCallback = callback;
         var xml:String = "<data>DeluxeDownload</data>";
         ExternalInterface.call("CustomEvent",xml);
      }
      
      public function init() : void
      {
         var result:Boolean = false;
         this.mEnabled = AppUtils.asBoolean(this.mApp.getProperties().MSN.enabled) && ExternalInterface.available;
         this.mLoadBroadcastRate = AppUtils.asNumber(this.mApp.getProperties().MSN.loadBroadcastRate,DEFAULT_LOAD_BROADCAST_RATE);
         this.mLoadBroadcastRate = Math.max(this.mLoadBroadcastRate,MIN_BROADCAST_RATE);
         this.mScoreBroadcastRate = AppUtils.asNumber(this.mApp.getProperties().MSN.scoreBroadcastRate,DEFAULT_SCORE_BROADCAST_RATE);
         this.mScoreBroadcastRate = Math.max(this.mScoreBroadcastRate,MIN_BROADCAST_RATE);
         if(!this.mEnabled)
         {
            return;
         }
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback("onGameMenu",this.onGameMenu);
            ExternalInterface.addCallback("onGameMute",this.onGameMute);
            ExternalInterface.addCallback("onMuteOn",this.onMuteOn);
            ExternalInterface.addCallback("onMuteOff",this.onMuteOff);
            ExternalInterface.addCallback("onGamePause",this.onGamePause);
            ExternalInterface.addCallback("onPauseOn",this.onPauseOn);
            ExternalInterface.addCallback("onPauseOff",this.onPauseOff);
            ExternalInterface.addCallback("onGameContinue",this.onGameContinue);
            ExternalInterface.addCallback("onGameStart",this.onGameStart);
            ExternalInterface.addCallback("onSessionStart",this.onSessionStart);
            ExternalInterface.addCallback("onCustomReturn",this.onCustomReturn);
            result = ExternalInterface.call("isProxyReady");
            if(result == true)
            {
               ExternalInterface.call("setSWFIsReady");
            }
            else
            {
               this.mEnabled = false;
            }
         }
      }
      
      private function togglePause(isPaused:Boolean) : void
      {
         if(isPaused)
         {
            this.mPlaying = false;
         }
         else
         {
            this.mPlaying = true;
         }
         this.mApp.togglePause(isPaused);
      }
      
      private function toggleMute(isMuted:Boolean) : void
      {
         this.mApp.toggleMute(isMuted/*,true*/);
      }
      
      public function GameError(str:String) : void
      {
         if(!this.mEnabled || !ExternalInterface.available)
         {
            return;
         }
         ExternalInterface.call("GameError",str);
      }
      
      private function onMuteOn() : void
      {
         this.toggleMute(true);
      }
      
      private function onPauseOff() : void
      {
         this.togglePause(false);
      }
      
      private function onPauseOn() : void
      {
         this.togglePause(true);
      }
      
      public function resumeBroadcast() : void
      {
         this.mPlaying = true;
      }
      
      public function ScoreSubmit() : void
      {
         if(!this.mEnabled || !ExternalInterface.available)
         {
            return;
         }
         var xml:* = "<game><score>" + this.mScore + "</score><time>" + int(this.mGameTime / 1000) + "</time></game>";
         ExternalInterface.call("ScoreSubmit",xml);
      }
      
      public function GameBreak(levelCompleted:Number, callback:Function) : void
      {
         this.mPlaying = false;
         this.mNumBreaks += 1;
         if(!this.mEnabled || !ExternalInterface.available)
         {
            this.mPlaying = true;
            callback();
            return;
         }
         this.mGameBreakCallback = callback;
         var xml:* = "<data><breakpoint>" + this.mNumBreaks + "</breakpoint></data>";
         ExternalInterface.call("GameBreak",xml);
      }
      
      public function GameReady(mode:Number, level:Number, callback:Function) : void
      {
         this.mGameTime = 0;
         if(!this.mEnabled || !ExternalInterface.available)
         {
            this.mGameTime = 0;
            this.mPlaying = true;
            callback();
            return;
         }
         this.mGameReadyCallback = callback;
         var xml:* = "<data><mode>" + mode + "</mode><startlevel>" + level + "</startlevel></data>";
         ExternalInterface.call("GameReady",xml);
      }
      
      private function onMuteOff() : void
      {
         this.toggleMute(false);
      }
      
      private function onGameMute(str:String) : void
      {
         this.toggleMute(this.onOffAsBoolean(str));
      }
      
      public function setLoadPercent(loadPercent:Number) : void
      {
         this.mLoadPercent = loadPercent < 0 ? 0 : loadPercent;
         this.mLoadPercent = this.mLoadPercent > 100 ? 100 : this.mLoadPercent;
         this.mLoadPercent = int(this.mLoadPercent);
      }
      
      private function onGameContinue(sXML:String = null) : void
      {
         this.mPlaying = true;
         this.mGameBreakCallback();
         this.mGameBreakCallback = null;
      }
      
      public function get enabled() : Boolean
      {
         return this.mEnabled;
      }
      
      public function SessionReady(callback:Function) : void
      {
         this.mLoading = false;
         var xml:* = "<data><percentcomplete>" + this.mLoadPercent + "</percentcomplete></data>";
         if(!this.mEnabled || !ExternalInterface.available)
         {
            callback();
            return;
         }
         this.mSessionReadyCallback = callback;
         ExternalInterface.call("LoadBroadcast",xml);
         ExternalInterface.call("SessionReady","<data></data>");
      }
      
      public function setScore(score:Number) : void
      {
         this.mScore = score;
      }
      
      private function onOffAsBoolean(str:String) : Boolean
      {
         if(str == "on")
         {
            return true;
         }
         return false;
      }
      
      public function GameEnd() : void
      {
         this.mPlaying = false;
         if(!this.mEnabled || !ExternalInterface.available)
         {
            return;
         }
         ExternalInterface.call("GameEnd","<gamedata></gamedata>");
      }
      
      public function pauseBroadcast() : void
      {
         this.mPlaying = false;
      }
      
      private function onGameStart() : void
      {
         this.mGameTime = 0;
         this.mPlaying = true;
         this.mGameReadyCallback();
         this.mGameReadyCallback = null;
      }
      
      private function onSessionStart() : void
      {
         this.mSessionReadyCallback();
         this.mSessionReadyCallback = null;
      }
      
      public function update() : void
      {
         var xml:* = null;
         var isLoadBroadcastTime:* = false;
         var isTime:* = false;
         if(!this.mEnabled)
         {
            return;
         }
         this.mAppTime += MILLIS_PER_UPDATE;
         if(this.mLoading)
         {
            isLoadBroadcastTime = this.mAppTime % this.mLoadBroadcastRate == 0;
            if(isLoadBroadcastTime)
            {
               xml = "<data><percentcomplete>" + this.mLoadPercent + "</percentcomplete></data>";
               if(ExternalInterface.available)
               {
                  ExternalInterface.call("LoadBroadcast",xml);
               }
            }
         }
         if(this.mPlaying && !this.mApp.isPaused)
         {
            this.mGameTime += MILLIS_PER_UPDATE;
            isTime = this.mGameTime % this.mScoreBroadcastRate == 0;
            if(isTime)
            {
               xml = "<game><score>" + this.mScore + "</score><time>" + int(this.mGameTime / 1000) + "</time></game>";
               if(ExternalInterface.available)
               {
                  ExternalInterface.call("ScoreBroadcast",xml);
               }
            }
         }
      }
      
      private function onGameMenu() : void
      {
         this.mPlaying = false;
         if(this.handleMenu != null)
         {
            this.handleMenu();
         }
      }
   }
}
