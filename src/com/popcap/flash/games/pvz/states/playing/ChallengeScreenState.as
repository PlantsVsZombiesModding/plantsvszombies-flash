package com.popcap.flash.games.pvz.states.playing
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.states.IState;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.logic.ChallengeScreen;
   
   public class ChallengeScreenState implements IState
   {
       
      
      private var app:PVZApp;
      
      public function ChallengeScreenState(app:PVZApp)
      {
         super();
         this.app = app;
      }
      
      public function onEnter() : void
      {
         this.app.mChallengeScreen = new ChallengeScreen(this.app,this.app.mBoard);
         this.app.widgetManager.addWidget(this.app.mChallengeScreen);
         this.app.widgetManager.setFocus(this.app.mChallengeScreen);
         this.app.widgetManager.addWidget(this.app.mChallengeScreen.mStartButton);
         this.app.widgetManager.addWidget(this.app.mChallengeScreen.mBackToMenuButton);
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
         this.app.widgetManager.removeWidget(this.app.mChallengeScreen);
         this.app.widgetManager.removeWidget(this.app.mChallengeScreen.mStartButton);
         this.app.widgetManager.removeWidget(this.app.mChallengeScreen.mBackToMenuButton);
         this.app.mChallengeScreen = null;
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
