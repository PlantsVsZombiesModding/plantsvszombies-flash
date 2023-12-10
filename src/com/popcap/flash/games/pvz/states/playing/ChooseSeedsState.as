package com.popcap.flash.games.pvz.states.playing
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.states.IState;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.logic.SeedChooserScreen;
   import com.popcap.flash.games.pvz.logic.TodCommon;
   
   public class ChooseSeedsState implements IState
   {
      
      public static const SEED_CHOOSER_OFFSETSCREEN_OFFSET:int = 348;
      
      public static const TimeSeedChoserSlideOnStart:int = 500;
      
      public static const SEED_CHOOSER_STARTBUTTON_OFFSET:int = 713;
      
      public static const TimeSeedChoserSlideOnEnd:int = TimeSeedChoserSlideOnStart + 250;
      
      public static const TimeSeedChoserSlideOffStart:int = TimeSeedChoserSlideOnEnd + 250;
      
      public static const TimeSeedChoserSlideOffEnd:int = TimeSeedChoserSlideOffStart + 250;
       
      
      private var app:PVZApp;
      
      public function ChooseSeedsState(app:PVZApp)
      {
         super();
         this.app = app;
      }
      
      public function onEnter() : void
      {
         if(this.app.mSeedChooserScreen == null)
         {
            this.app.mSeedChooserScreen = new SeedChooserScreen(this.app,this.app.mBoard);
            this.app.widgetManager.addWidget(this.app.mSeedChooserScreen);
            this.app.widgetManager.addWidget(this.app.mSeedChooserScreen.mStartButton);
            this.app.widgetManager.addWidget(this.app.mSeedChooserScreen.mLawnViewButton);
            this.app.widgetManager.addWidget(this.app.mSeedChooserScreen.mDialogBox);
            this.app.widgetManager.addWidget(this.app.mSeedChooserScreen.mDialogBox.mOkButton);
            this.app.widgetManager.addWidget(this.app.mSeedChooserScreen.mDialogBox.mCancelButton);
         }
         this.app.mBoard.mMenuButton.setVisible(false);
         this.app.mBoard.mSeedBank.mVisible = true;
         this.app.mBoard.mToolTip.mVisible = false;
         this.app.mSeedChooserScreen.mToolTip.mVisible = false;
         this.app.mCutsceneTime = 0;
         this.app.widgetManager.setFocus(this.app.mSeedChooserScreen);
         this.app.mSeedChooserScreen.visible = true;
         if(this.app.IsAdventureMode() || this.app.mBoard.mChallenge.mSurvivalStage == 0)
         {
            this.app.mSeedChooserScreen.mLawnViewButton.visible = false;
         }
         else
         {
            this.app.mSeedChooserScreen.mLawnViewButton.visible = true;
         }
         this.app.mSeedChooserScreen.mStartButton.visible = true;
         this.app.mSeedChooserScreen.mStartButton.move(115,SEED_CHOOSER_STARTBUTTON_OFFSET);
         this.app.mSeedChooserScreen.mLawnViewButton.move(20,SEED_CHOOSER_STARTBUTTON_OFFSET + 5);
         this.app.mSeedChooserScreen.move(0,SEED_CHOOSER_OFFSETSCREEN_OFFSET);
         this.app.mSeedChooserScreen.mChooseState = SeedChooserScreen.CHOOSE_ENTER;
      }
      
      public function draw(g:Graphics2D) : void
      {
         this.app.widgetManager.drawScreen(g);
      }
      
      public function onPush() : void
      {
      }
      
      public function onExit() : void
      {
         this.app.mBoard.mToolTip.mVisible = false;
      }
      
      public function update() : void
      {
         var y:int = 0;
         var posStart:int = 0;
         var posEnd:int = 0;
         var aButtonY:int = 0;
         this.app.widgetManager.updateFrame();
         if(this.app.mSeedChooserScreen.mChooseState == SeedChooserScreen.CHOOSE_ENTER || this.app.mSeedChooserScreen.mChooseState == SeedChooserScreen.CHOOSE_LEAVE || this.app.mSeedChooserScreen.mChooseState == SeedChooserScreen.CHOOSE_VIEW_LAWN)
         {
            this.app.mCutsceneTime += 10;
         }
         var aTimeSeedChoserSlideOnStart:int = TimeSeedChoserSlideOnStart;
         var aTimeSeedChoserSlideOnEnd:int = TimeSeedChoserSlideOnEnd;
         if(this.app.mSeedChooserScreen.mChooseState == SeedChooserScreen.CHOOSE_ENTER)
         {
            if(this.app.mCutsceneTime > aTimeSeedChoserSlideOnEnd)
            {
               this.app.mSeedChooserScreen.mToolTip.mVisible = true;
               this.app.mSeedChooserScreen.mChooseState = SeedChooserScreen.CHOOSE_NORMAL;
            }
            if(this.app.mCutsceneTime > aTimeSeedChoserSlideOnStart && this.app.mCutsceneTime <= aTimeSeedChoserSlideOnEnd)
            {
               posStart = SEED_CHOOSER_OFFSETSCREEN_OFFSET;
               posEnd = 0;
               y = TodCommon.TodAnimateCurve(aTimeSeedChoserSlideOnStart,aTimeSeedChoserSlideOnEnd,this.app.mCutsceneTime,posStart,posEnd,TodCommon.CURVE_EASE_IN_OUT);
               this.app.mSeedChooserScreen.move(0,y);
               posStart = SEED_CHOOSER_STARTBUTTON_OFFSET;
               posEnd = 370;
               aButtonY = TodCommon.TodAnimateCurve(aTimeSeedChoserSlideOnStart,aTimeSeedChoserSlideOnEnd,this.app.mCutsceneTime,posStart,posEnd,TodCommon.CURVE_EASE_IN_OUT);
               this.app.mSeedChooserScreen.mStartButton.move(115,aButtonY);
               this.app.mSeedChooserScreen.mLawnViewButton.move(20,aButtonY + 5);
               if(y <= 0)
               {
               }
            }
         }
         var aTimeSeedChoserSlideOffStart:int = TimeSeedChoserSlideOffStart;
         var aTimeSeedChoserSlideOffEnd:int = TimeSeedChoserSlideOffEnd;
         if(this.app.mSeedChooserScreen.mChooseState == SeedChooserScreen.CHOOSE_LEAVE || this.app.mSeedChooserScreen.mChooseState == SeedChooserScreen.CHOOSE_VIEW_LAWN)
         {
            if(this.app.mCutsceneTime > aTimeSeedChoserSlideOffEnd)
            {
               if(this.app.mSeedChooserScreen.mChooseState == SeedChooserScreen.CHOOSE_VIEW_LAWN)
               {
                  this.app.stateManager.changeState(PVZApp.STATE_LAWN_VIEW);
               }
               else
               {
                  this.app.stateManager.changeState(PVZApp.STATE_PAN_LEFT);
               }
            }
            if(this.app.mCutsceneTime > aTimeSeedChoserSlideOffStart && this.app.mCutsceneTime <= aTimeSeedChoserSlideOffEnd)
            {
               posStart = 0;
               posEnd = SEED_CHOOSER_OFFSETSCREEN_OFFSET;
               y = TodCommon.TodAnimateCurve(aTimeSeedChoserSlideOffStart,aTimeSeedChoserSlideOffEnd,this.app.mCutsceneTime,posStart,posEnd,TodCommon.CURVE_EASE_IN_OUT);
               this.app.mSeedChooserScreen.move(0,y);
               this.app.mSeedChooserScreen.mStartButton.setVisible(false);
               this.app.mSeedChooserScreen.mLawnViewButton.setVisible(false);
               if(y >= SEED_CHOOSER_OFFSETSCREEN_OFFSET)
               {
                  this.app.mSeedChooserScreen.visible = false;
                  if(this.app.mSeedChooserScreen.mChooseState == SeedChooserScreen.CHOOSE_VIEW_LAWN)
                  {
                     this.app.stateManager.changeState(PVZApp.STATE_LAWN_VIEW);
                  }
                  else
                  {
                     this.app.stateManager.changeState(PVZApp.STATE_PAN_LEFT);
                  }
               }
            }
         }
      }
      
      public function onPop() : void
      {
      }
   }
}
