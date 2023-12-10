package com.popcap.flash.games.pvz.states.playing
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.states.IState;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.logic.Board;
   import com.popcap.flash.games.pvz.logic.TodCommon;
   
   public class PanRightState implements IState
   {
      
      public static var TimePanRightStart:int = 1500;
      
      public static var TimePanRightEnd:int = TimePanRightStart + 2000;
       
      
      private var app:PVZApp;
      
      public function PanRightState(app:PVZApp)
      {
         super();
         this.app = app;
      }
      
      public function onEnter() : void
      {
         var aString:String = null;
         this.app.mCutsceneTime = 0;
         this.app.mBoard.move(PVZApp.BOARD_OFFSET,0);
         if(this.app.IsAdventureMode())
         {
            aString = "[PLAYERS_HOUSE]";
         }
         else if(this.app.IsSurvivalMode())
         {
            aString = "[SURVIVAL_POOL_ENDLESS]";
         }
         if(!(this.app.IsAdventureMode() && this.app.mLevel == 11))
         {
            this.app.mBoard.mAdvice.SetLabel(aString,Board.MESSAGE_STYLE_HOUSE_NAME);
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
         var aTimePanRightStart:int = TimePanRightStart;
         var aTimePanRightEnd:int = TimePanRightEnd;
         var aBoardLeftPosition:int = PVZApp.BOARD_OFFSET;
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
   }
}
