package com.popcap.flash.games.pvz.states.loading
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.states.IState;
   import com.popcap.flash.games.pvz.PVZApp;
   
   public class LoadingState implements IState
   {
       
      
      private var app:PVZApp;
      
      public function LoadingState(app:PVZApp)
      {
         super();
         this.app = app;
      }
      
      public function onEnter() : void
      {
      }
      
      public function draw(g:Graphics2D) : void
      {
      }
      
      public function onPush() : void
      {
      }
      
      public function onExit() : void
      {
      }
      
      public function update() : void
      {
         this.app.stateManager.changeState(PVZApp.STATE_TITLE_SCREEN);
      }
      
      public function onPop() : void
      {
      }
   }
}
