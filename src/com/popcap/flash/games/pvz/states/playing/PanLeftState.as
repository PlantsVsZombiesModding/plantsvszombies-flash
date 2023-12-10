package com.popcap.flash.games.pvz.states.playing
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.states.IState;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.logic.TodCommon;
   
   public class PanLeftState implements IState
   {
      
      public static var TimePanLeftStart:int = 500;
      
      public static var TimePanLeftEnd:int = TimePanLeftStart + 1500;
       
      
      private var app:PVZApp;
      
      public function PanLeftState(app:PVZApp)
      {
         super();
         this.app = app;
      }
      
      public function onEnter() : void
      {
         this.app.mBoard.mMenuButton.disabled = true;
         this.app.mCutsceneTime = 0;
         if(this.app.mBoard.ChooseSeedsOnCurrentLevel())
         {
         }
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
         var posStart:int = 0;
         var posEnd:int = 0;
         var x:int = 0;
         this.app.widgetManager.updateFrame();
         this.app.mCutsceneTime += 10;
         var aTimePanLeftStart:int = TimePanLeftStart;
         var aTimePanLeftEnd:int = TimePanLeftEnd;
         if(this.app.mCutsceneTime > aTimePanLeftStart)
         {
            posStart = PVZApp.BACKGROUND_IMAGE_WIDTH - this.app.width - PVZApp.BOARD_OFFSET;
            posEnd = 0;
            x = TodCommon.TodAnimateCurve(aTimePanLeftStart,aTimePanLeftEnd,this.app.mCutsceneTime,posStart,posEnd,TodCommon.CURVE_EASE_IN_OUT);
            this.app.mBoard.move(-x,0);
         }
         if(this.app.mBoard.x == 0)
         {
            this.app.stateManager.changeState(PVZApp.STATE_SODROLL);
         }
      }
      
      public function onPop() : void
      {
      }
   }
}
