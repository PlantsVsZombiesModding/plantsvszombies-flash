package com.popcap.flash.games.pvz.states.playing
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.states.IState;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.PVZMusic;
   import com.popcap.flash.games.pvz.logic.AwardScreen;
   
   public class ShowAwardState implements IState
   {
       
      
      private var app:PVZApp;
      
      public function ShowAwardState(app:PVZApp)
      {
         super();
         this.app = app;
      }
      
      public function onEnter() : void
      {
         this.app.mAwardScreen = new AwardScreen(this.app);
         this.app.widgetManager.addWidget(this.app.mAwardScreen);
         this.app.widgetManager.setFocus(this.app.mAwardScreen);
         this.app.musicManager.playMusic(PVZMusic.ZENGARDEN);
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
         this.app.widgetManager.removeAllWidgets(true);
         this.app.mAwardScreen = null;
      }
      
      public function update() : void
      {
         this.app.widgetManager.updateFrame();
         if(this.app.mAwardScreen.mFadedIn)
         {
            this.app.widgetManager.addWidget(this.app.mAwardScreen.mStartButton);
         }
      }
      
      public function onPop() : void
      {
      }
   }
}
