package com.popcap.flash.games.pvz.logic
{
   import com.popcap.flash.framework.resources.reanimator.Reanimation;
   import com.popcap.flash.games.pvz.PVZApp;
   
   public class CutScene
   {
       
      
      public var mCrazyDaveLastTalkIndex:int;
      
      public var mZombiesWonReanim:Reanimation;
      
      public var mPreloaded:Boolean;
      
      public var mCutsceneTime:int;
      
      public var mSodTime:int;
      
      public var mSeedChoosing:Boolean;
      
      public var mUpsellHideBoard:Boolean;
      
      public var mLawnMowerTime:int;
      
      public var mPreUpdatingBoard:Boolean;
      
      public var mCrazyDaveCountDown:int;
      
      public var mGraveStoneTime:int;
      
      public var mCrazyDaveTime:int;
      
      public var mPlacedZombies:Boolean;
      
      public var mBossTime:int;
      
      public var mCrazyDaveDialogStart:int;
      
      public var mReadySetPlantTime:int;
      
      public var mPlacedLawnItems:Boolean;
      
      public var mBoard:Board;
      
      public var mApp:PVZApp;
      
      public var mFogTime:int;
      
      public function CutScene(app:PVZApp, theBoard:Board)
      {
         super();
         this.mApp = app;
         this.mBoard = theBoard;
         this.mCutsceneTime = 0;
         this.mSodTime = 0;
         this.mFogTime = 0;
         this.mBossTime = 0;
         this.mCrazyDaveTime = 0;
         this.mGraveStoneTime = 0;
         this.mReadySetPlantTime = 0;
         this.mLawnMowerTime = 0;
         this.mCrazyDaveDialogStart = -1;
         this.mSeedChoosing = false;
         this.mZombiesWonReanim = null;
         this.mPreloaded = false;
         this.mPlacedZombies = false;
         this.mPlacedLawnItems = false;
         this.mCrazyDaveCountDown = 0;
         this.mCrazyDaveLastTalkIndex = -1;
         this.mUpsellHideBoard = false;
         this.mPreUpdatingBoard = false;
      }
   }
}
