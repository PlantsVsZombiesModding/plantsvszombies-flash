package com.popcap.flash.games.pvz.states.playing
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.states.IState;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.PVZMusic;
   import com.popcap.flash.games.pvz.logic.Board;
   import com.popcap.flash.games.pvz.logic.TodCommon;
   
   public class SurvivalRepickState implements IState
   {
      
      public static var TimePanRightStart:int = 1000;
      
      public static var TimePanRightEnd:int = TimePanRightStart + 1500;
       
      
      private var app:PVZApp;
      
      private var mPaused:Boolean;
      
      public function SurvivalRepickState(app:PVZApp)
      {
         super();
         this.app = app;
      }
      
      public function draw(g:Graphics2D) : void
      {
         this.app.widgetManager.drawScreen(g);
      }
      
      public function GameContinue() : void
      {
         if(this.app.adAPI.enabled)
         {
            this.app.musicManager.resumeMusic();
            this.app.soundManager.resumeAll();
         }
         this.mPaused = false;
      }
      
      public function onPush() : void
      {
      }
      
      public function update() : void
      {
         var posStart:int = 0;
         var posEnd:int = 0;
         var x:int = 0;
         this.app.widgetManager.updateFrame();
         if(this.mPaused)
         {
            return;
         }
         this.app.mCutsceneTime += 10;
         var aTimePanRightStart:int = TimePanRightStart;
         var aTimePanRightEnd:int = TimePanRightEnd;
         var aBoardLeftPosition:int = 0;
         if(this.app.mCutsceneTime <= aTimePanRightStart)
         {
            this.app.mBoard.move(aBoardLeftPosition,0);
         }
         if(this.app.mCutsceneTime > aTimePanRightStart && this.app.mCutsceneTime <= aTimePanRightEnd)
         {
            posStart = -aBoardLeftPosition;
            posEnd = -PVZApp.BOARD_OFFSET + PVZApp.BACKGROUND_IMAGE_WIDTH - this.app.width;
            x = TodCommon.TodAnimateCurve(aTimePanRightStart,aTimePanRightEnd,this.app.mCutsceneTime,posStart,posEnd,TodCommon.CURVE_EASE_IN_OUT);
            this.app.mBoard.move(-x,0);
         }
         if(this.app.mBoard.x <= -257)
         {
            if(this.app.mBoard.ChooseSeedsOnCurrentLevel())
            {
               this.app.stateManager.changeState(PVZApp.STATE_SEEDCHOOSER);
            }
            else
            {
               this.app.stateManager.changeState(PVZApp.STATE_PAN_LEFT);
            }
         }
      }
      
      public function onPop() : void
      {
      }
      
      public function onEnter() : void
      {
         var aString:String = null;
         this.mPaused = true;
         this.app.musicManager.playMusic(PVZMusic.CHOOSE_YOUR_SEEDS,true,50);
         if(this.app.adAPI.enabled)
         {
            this.app.musicManager.pauseMusic();
            this.app.soundManager.pauseAll();
         }
         this.app.adAPI.GameBreak(this.app.mBoard.mChallenge.mSurvivalStage,this.GameContinue);
         this.app.mBoard.mGameScene = PVZApp.SCENE_LEVEL_INTRO;
         this.app.mBoard.mShowShovel = false;
         if(this.app.mSeedChooserScreen == null)
         {
            this.app.mBoard.mSeedBank.mVisible = false;
            this.app.mBoard.mShowShovel = false;
            this.app.mPlacedZombies = false;
            aString = "[SURVIVAL_POOL_ENDLESS]";
            this.app.mBoard.mAdvice.SetLabel(aString,Board.MESSAGE_STYLE_HOUSE_NAME);
         }
      }
      
      public function onExit() : void
      {
      }
   }
}
