package com.popcap.flash.games.pvz.states.playing
{
   import com.popcap.flash.framework.graphics.Color;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.resources.fonts.FontInst;
   import com.popcap.flash.framework.states.IState;
   import com.popcap.flash.framework.widgets.ui.CButtonWidget;
   import com.popcap.flash.framework.widgets.ui.IButtonListener;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.logic.Board;
   import com.popcap.flash.games.pvz.logic.MessageWidget;
   import com.popcap.flash.games.pvz.logic.TodCommon;
   import com.popcap.flash.games.pvz.resources.PVZFonts;
   
   public class LawnViewState implements IState, IButtonListener
   {
      
      public static const PANLEFT:int = 0;
      
      public static var TimePanLeftStart:int = 500;
      
      public static var TimePanLeftEnd:int = TimePanLeftStart + 1500;
      
      public static var TimePanRightStart:int = 100;
      
      public static var TimePanRightEnd:int = TimePanRightStart + 1000;
      
      public static const PANRIGHT:int = 1;
       
      
      private var theButton:CButtonWidget;
      
      private var theState:int;
      
      private var app:PVZApp;
      
      private var drawMessage:Boolean = true;
      
      public function LawnViewState(app:PVZApp)
      {
         super();
         this.app = app;
      }
      
      public function draw(g:Graphics2D) : void
      {
         this.app.widgetManager.drawScreen(g);
      }
      
      public function buttonMouseEnter(id:Number) : void
      {
      }
      
      public function onEnter() : void
      {
         this.theState = PANLEFT;
         this.drawMessage = true;
         this.app.mBoard.mMenuButton.setVisible(false);
         this.app.mCutsceneTime = 0;
         this.theButton = new CButtonWidget(0,this);
         this.theButton.label = "";
         this.theButton.setColor(CButtonWidget.COLOR_LABEL,Color.RGB(1,1,1));
         var font:FontInst = this.app.fontManager.getFontInst(PVZFonts.FONT_BRIANNETOD16);
         this.theButton.font = font;
         this.theButton.setDisabled(true);
         this.theButton.visible = true;
         this.theButton.resize(0,0,540,405);
         this.app.widgetManager.addWidget(this.theButton);
         this.app.widgetManager.setFocus(this.theButton);
      }
      
      public function update() : void
      {
         var posStart:int = 0;
         var posEnd:int = 0;
         var x:int = 0;
         var aBoardLeftPosition:int = 0;
         this.app.widgetManager.updateFrame();
         this.app.mCutsceneTime += 10;
         var aTimePanLeftStart:int = TimePanLeftStart;
         var aTimePanLeftEnd:int = TimePanLeftEnd;
         var aTimePanRightStart:int = TimePanRightStart;
         var aTimePanRightEnd:int = TimePanRightEnd;
         if(this.theState == PANLEFT)
         {
            if(this.app.mCutsceneTime > aTimePanLeftStart)
            {
               posStart = PVZApp.BACKGROUND_IMAGE_WIDTH - this.app.width - PVZApp.BOARD_OFFSET;
               posEnd = 0;
               x = TodCommon.TodAnimateCurve(aTimePanLeftStart,aTimePanLeftEnd,this.app.mCutsceneTime,posStart,posEnd,TodCommon.CURVE_EASE_IN_OUT);
               this.app.mBoard.move(-x,0);
            }
            if(this.app.mBoard.x == 0 && this.drawMessage)
            {
               this.drawMessage = false;
               this.theButton.setDisabled(false);
               this.app.mBoard.DisplayAdvice("[CLICK_TO_CONTINUE]",MessageWidget.MESSAGE_STYLE_HINT_STAY,Board.ADVICE_NONE);
            }
         }
         else if(this.theState == PANRIGHT)
         {
            aBoardLeftPosition = 0;
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
               this.app.stateManager.changeState(PVZApp.STATE_SEEDCHOOSER);
            }
         }
      }
      
      public function buttonDownTick(id:Number) : void
      {
      }
      
      public function onPush() : void
      {
      }
      
      public function buttonMouseMove(id:Number, x:Number, y:Number) : void
      {
      }
      
      public function onExit() : void
      {
         this.app.widgetManager.removeWidget(this.theButton);
         this.app.widgetManager.setFocus(this.app.mSeedChooserScreen);
         this.app.mBoard.ClearAdvice(Board.ADVICE_NONE);
         this.app.mCutsceneTime = 0;
      }
      
      public function buttonMouseLeave(id:Number) : void
      {
      }
      
      public function buttonPress(id:Number) : void
      {
      }
      
      public function onPop() : void
      {
      }
      
      public function buttonRelease(id:Number) : void
      {
         this.theButton.setDisabled(true);
         this.app.mCutsceneTime = 0;
         this.theState = PANRIGHT;
         this.app.mBoard.ClearAdvice(Board.ADVICE_NONE);
      }
   }
}
