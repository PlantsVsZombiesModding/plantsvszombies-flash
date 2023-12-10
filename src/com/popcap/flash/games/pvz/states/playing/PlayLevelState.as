package com.popcap.flash.games.pvz.states.playing
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.states.IState;
   import com.popcap.flash.games.pvz.PVZApp;
   
   public class PlayLevelState implements IState
   {
       
      
      private var app:PVZApp;
      
      public function PlayLevelState(app:PVZApp)
      {
         super();
         this.app = app;
      }
      
      public function onEnter() : void
      {
         this.app.mBoard.mMenuButton.setVisible(true);
         this.app.mBoard.mMenuButton.disabled = false;
         if(this.app.mLevel > 4 || this.app.IsSurvivalMode())
         {
            this.app.mBoard.mShowShovel = true;
         }
         this.app.mBoard.mGameScene = PVZApp.SCENE_PLAYING;
         this.app.widgetManager.setFocus(this.app.mBoard);
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
      }
      
      public function CheckForGameEnd() : void
      {
         if(!this.app.mBoard || !this.app.mBoard.mLevelComplete)
         {
            return;
         }
         if(this.app.IsAdventureMode() && this.app.mBoard.mLevel == 14)
         {
            this.app.stateManager.changeState(PVZApp.STATE_CRAZY_DAVE);
         }
         else if(this.app.IsAdventureMode())
         {
            this.KillBoard();
            this.app.stateManager.changeState(PVZApp.STATE_SHOWAWARD);
         }
         else if(this.app.IsSurvivalMode())
         {
            ++this.app.mBoard.mChallenge.mSurvivalStage;
            this.app.mBoard.InitSurvivalStage();
            this.app.mBoard.PlaceStreetZombies();
            this.app.mCutsceneTime = 0;
            this.app.stateManager.changeState(PVZApp.STATE_SURVIVAL_REPICK);
         }
      }
      
      public function update() : void
      {
         this.app.widgetManager.updateFrame();
         this.CheckForGameEnd();
      }
      
      public function onPop() : void
      {
      }
      
      public function KillBoard() : void
      {
         if(this.app.mBoard != null)
         {
            this.app.widgetManager.removeWidget(this.app.mBoard);
            this.app.mBoard = null;
         }
      }
   }
}
