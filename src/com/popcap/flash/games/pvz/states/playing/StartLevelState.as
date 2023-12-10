package com.popcap.flash.games.pvz.states.playing
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.states.IState;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.PVZMusic;
   import com.popcap.flash.games.pvz.logic.Board;
   import com.popcap.flash.games.pvz.logic.GridItem;
   import com.popcap.flash.games.pvz.logic.LawnMower;
   
   public class StartLevelState implements IState
   {
       
      
      private var app:PVZApp;
      
      public function StartLevelState(app:PVZApp)
      {
         super();
         this.app = app;
      }
      
      public function onEnter() : void
      {
         var aGridItem:GridItem = null;
         var aLawnMower:LawnMower = null;
         if(this.app.mSeedChooserScreen != null)
         {
            this.app.widgetManager.removeWidget(this.app.mSeedChooserScreen);
            this.app.widgetManager.removeWidget(this.app.mSeedChooserScreen.mStartButton);
            this.app.widgetManager.removeWidget(this.app.mSeedChooserScreen.mLawnViewButton);
            this.app.widgetManager.removeWidget(this.app.mSeedChooserScreen.mDialogBox);
            this.app.widgetManager.removeWidget(this.app.mSeedChooserScreen.mDialogBox.mOkButton);
            this.app.widgetManager.removeWidget(this.app.mSeedChooserScreen.mDialogBox.mCancelButton);
            this.app.mSeedChooserScreen = null;
         }
         if(this.app.IsScaryPotterLevel())
         {
            this.app.musicManager.playMusic(PVZMusic.CEREBRAWL,true,50);
         }
         else if(this.app.mBoard.IsWallnutBowlingLevel())
         {
            this.app.musicManager.playMusic(PVZMusic.LOON_BOON,true,50);
         }
         else if(this.app.mBoard.mLevel > 10 || this.app.IsSurvivalMode())
         {
            this.app.musicManager.playMusic(PVZMusic.MOONGRAINS,true,50);
         }
         else if(this.app.mBoard.mLevel == 10)
         {
            this.app.musicManager.playMusic(PVZMusic.CONVEYOR,true,50);
         }
         else
         {
            this.app.musicManager.playMusic(PVZMusic.GRASS_WALK,true,50);
         }
         if(this.app.mBoard == null)
         {
            this.app.mBoard = new Board(this.app);
         }
         this.app.mBoard.RemoveCutsceneZombies();
         this.app.mBoard.mGameScene = PVZApp.SCENE_PLAYING;
         this.app.widgetManager.setFocus(this.app.mBoard);
         if(!this.app.IsScaryPotterLevel())
         {
            this.app.mBoard.mSeedBank.mVisible = true;
         }
         this.app.mBoard.mToolTip.mVisible = true;
         this.app.mBoard.mMenuButton.setVisible(true);
         this.app.mBoard.mEnableGraveStones = true;
         for each(aGridItem in this.app.mBoard.mGridItems)
         {
            if(aGridItem.mGridItemType == GridItem.GRIDITEM_GRAVESTONE && this.app.mBoard.mChallenge.mSurvivalStage == 0)
            {
               aGridItem.AddGraveStoneParticles();
            }
         }
         if(this.app.mLevel > 4 || this.app.IsSurvivalMode() || this.app.IsScaryPotterLevel())
         {
            this.app.mBoard.mShowShovel = true;
         }
         for each(aLawnMower in this.app.mBoard.mLawnMowers)
         {
            aLawnMower.mVisible = true;
         }
         this.app.mBoard.StartLevel();
         this.app.stateManager.changeState(PVZApp.STATE_PLAY_LEVEL);
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
      
      public function update() : void
      {
         this.app.widgetManager.updateFrame();
      }
      
      public function onPop() : void
      {
      }
   }
}
