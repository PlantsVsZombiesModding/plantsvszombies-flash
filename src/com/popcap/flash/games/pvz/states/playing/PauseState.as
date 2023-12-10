package com.popcap.flash.games.pvz.states.playing
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.states.IState;
   import com.popcap.flash.framework.widgets.ui.CButtonWidget;
   import com.popcap.flash.games.pvz.PVZApp;
   
   public class PauseState implements IState
   {
       
      
      private var mApp:PVZApp;
      
      private var mButton:CButtonWidget;
      
      public function PauseState(app:PVZApp)
      {
         super();
         this.mApp = app;
         this.mButton = new CButtonWidget(0,null);
         this.mButton.resize(0,0,this.mApp.screenWidth,this.mApp.screenHeight);
         this.mButton.setDisabled(true);
      }
      
      public function draw(g:Graphics2D) : void
      {
         g.fillRect(0,0,540,405,2566914048);
      }
      
      public function update() : void
      {
      }
      
      public function onPush() : void
      {
      }
      
      public function onPop() : void
      {
      }
      
      public function onEnter() : void
      {
         this.mApp.widgetManager.addWidget(this.mButton);
      }
      
      public function onExit() : void
      {
         this.mApp.widgetManager.removeWidget(this.mButton);
      }
   }
}
