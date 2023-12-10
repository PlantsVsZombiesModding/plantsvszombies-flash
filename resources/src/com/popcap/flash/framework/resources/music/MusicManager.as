package com.popcap.flash.framework.resources.music
{
   import com.popcap.flash.framework.AppBase;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundLoaderContext;
   import flash.media.SoundTransform;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   
   public class MusicManager
   {
       
      
      private var mFadeVolume:Number = 0;
      
      private var mPlayingChannel:SoundChannel;
      
      private var mPlayingPosition:Number;
      
      private var mQueuedLoop:Boolean = false;
      
      private var mSongs:Dictionary;
      
      private var mFailed:Boolean = false;
      
      private var mFadeTimer:Number = 0;
      
      private var mIdle:Boolean = true;
      
      private var mSoundTransform:SoundTransform;
      
      private var mIDs:Array;
      
      private var mLoop:Boolean = false;
      
      private var mApp:AppBase;
      
      private var mFadeTime:Number = 0;
      
      private var mQueuedId:MusicId = null;
      
      private var mPlayingId:MusicId;
      
      private var mMuted:Boolean = false;
      
      public function MusicManager(param1:AppBase)
      {
         super();
         this.mApp = param1;
         this.mIDs = new Array();
         this.mSongs = new Dictionary();
         this.mSoundTransform = new SoundTransform();
      }
      
      private function handleError(param1:IOErrorEvent) : void
      {
         throw new Error("Unable to load music.\n" + param1.toString());
      }
      
      private function handleComplete(param1:Event) : void
      {
         if(this.mPlayingId == null)
         {
            return;
         }
         this.mPlayingChannel.removeEventListener(Event.SOUND_COMPLETE,this.handleComplete);
         this.mPlayingChannel = null;
         this.mPlayingPosition = 0;
         this.resumeMusic();
      }
      
      public function resumeMusic() : void
      {
         if(this.mPlayingId == null)
         {
            this.mFailed = false;
            return;
         }
         if(this.mPlayingChannel != null)
         {
            this.mFailed = false;
            return;
         }
         var _loc1_:Sound = this.mSongs[this.mPlayingId];
         var _loc2_:SoundChannel = _loc1_.play(this.mPlayingPosition,0,this.mSoundTransform);
         if(_loc2_ == null)
         {
            this.mFailed = true;
            return;
         }
         this.mPlayingChannel = _loc2_;
         if(this.mLoop)
         {
            this.mPlayingChannel.addEventListener(Event.SOUND_COMPLETE,this.handleComplete);
         }
         this.mPlayingPosition = 0;
         this.mFailed = false;
      }
      
      public function pauseMusic() : void
      {
         if(this.mPlayingChannel == null)
         {
            return;
         }
         this.mPlayingPosition = this.mPlayingChannel.position;
         this.mPlayingChannel.stop();
         this.mPlayingChannel.removeEventListener(Event.SOUND_COMPLETE,this.handleComplete);
         this.mPlayingChannel = null;
      }
      
      public function update() : void
      {
         var _loc1_:SoundTransform = null;
         if(this.mFadeTimer > 0)
         {
            --this.mFadeTimer;
            this.mFadeVolume = this.mFadeTimer / this.mFadeTime;
            if(this.mPlayingChannel != null && !this.mMuted)
            {
               _loc1_ = this.mPlayingChannel.soundTransform;
               _loc1_.volume = this.mFadeVolume;
               this.mPlayingChannel.soundTransform = _loc1_;
            }
            if(this.mFadeTimer == 0)
            {
               this.playMusic(this.mQueuedId,this.mQueuedLoop,0);
            }
         }
         if(!this.mFailed)
         {
            return;
         }
         this.resumeMusic();
      }
      
      public function stopMusic(param1:MusicId) : void
      {
         if(this.mPlayingChannel == null)
         {
            return;
         }
         this.mPlayingPosition = 0;
         this.mPlayingChannel.stop();
         this.mPlayingChannel.removeEventListener(Event.SOUND_COMPLETE,this.handleComplete);
         this.mPlayingChannel = null;
         this.mPlayingId = null;
      }
      
      public function playMusic(param1:MusicId, param2:Boolean = true, param3:Number = 0) : void
      {
         var _loc4_:Sound;
         if((_loc4_ = this.mSongs[param1]) == null)
         {
            throw new Error("Cannot play unregistered music with id \'" + param1 + "\'");
         }
         if(this.mPlayingId != null && param3 > 0)
         {
            this.mFadeTime = param3;
            this.mFadeTimer = this.mFadeTime;
            this.mQueuedLoop = param2;
            this.mQueuedId = param1;
            return;
         }
         if(this.mPlayingId != null)
         {
            this.stopMusic(this.mPlayingId);
         }
         this.mPlayingId = param1;
         this.mPlayingPosition = 0;
         this.mLoop = param2;
         var _loc5_:SoundChannel;
         if((_loc5_ = _loc4_.play(0,0,this.mSoundTransform)) == null)
         {
            this.mFailed = true;
            return;
         }
         this.mPlayingChannel = _loc5_;
         if(this.mLoop)
         {
            this.mPlayingChannel.addEventListener(Event.SOUND_COMPLETE,this.handleComplete);
         }
         this.mFailed = false;
      }
      
      public function registerMusic(param1:MusicId, param2:String) : Boolean
      {
         if(this.mSongs[param1] != null)
         {
            throw new Error("Music is already registered to id \'" + param1 + "\'");
         }
         var _loc3_:Sound = new Sound();
         var _loc4_:URLRequest = new URLRequest(param2);
         var _loc5_:SoundLoaderContext = new SoundLoaderContext(1000,true);
         _loc3_.addEventListener(IOErrorEvent.IO_ERROR,this.handleError);
         _loc3_.load(_loc4_,_loc5_);
         this.mSongs[param1] = _loc3_;
         this.mIDs.push(param1);
         return true;
      }
      
      public function mute() : void
      {
         this.mSoundTransform.volume = 0;
         if(this.mPlayingChannel != null)
         {
            this.mPlayingChannel.soundTransform = this.mSoundTransform;
         }
         this.mMuted = true;
      }
      
      public function stopAllMusic() : void
      {
         var _loc1_:MusicId = null;
         for each(_loc1_ in this.mIDs)
         {
            this.stopMusic(_loc1_);
         }
      }
      
      public function isMuted() : Boolean
      {
         return this.mMuted;
      }
      
      public function unmute() : void
      {
         this.mSoundTransform.volume = 1;
         if(this.mPlayingChannel != null)
         {
            this.mPlayingChannel.soundTransform = this.mSoundTransform;
         }
         this.mMuted = false;
      }
      
      public function getPlayingId() : MusicId
      {
         return this.mPlayingId;
      }
   }
}
