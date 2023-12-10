package com.popcap.flash.games.pvz.states.playing
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.states.IState;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.logic.Board;
   import com.popcap.flash.games.pvz.logic.UI.DialogBox;
   
   public class DialogState implements IState
   {
       
      
      private var app:PVZApp;
      
      public function DialogState(app:PVZApp)
      {
         super();
         this.app = app;
      }
      
      public function onEnter() : void
      {
         var aMessage:String = null;
         var aFlags:int = 0;
         var aFlagStr:String = null;
         var aCompletedStr:String = null;
         this.app.mDialogBox = new DialogBox(this.app,this.app.mBoard);
         this.app.widgetManager.addWidget(this.app.mDialogBox);
         this.app.widgetManager.addWidget(this.app.mDialogBox.mOkButton);
         this.app.widgetManager.setFocus(this.app.mDialogBox);
         if(this.app.mBoard.mGameScene == Board.SCENE_ZOMBIES_WON)
         {
            if(this.app.IsAdventureMode())
            {
               this.app.mDialogBox.resize(255 - 63 * 1,130 - 36 * 1,153 + 63 * 1,184 + 36 * 1);
               this.app.mDialogBox.mDialogType = DialogBox.DIALOG_GAMEOVER;
               this.app.mDialogBox.InitializeDialogBox(this.app.stringManager.translateString("[GAME_OVER]"),"",this.app.stringManager.translateString("[TRY_AGAIN]"),"",1,1);
            }
            else if(this.app.IsScaryPotterLevel())
            {
               this.app.mDialogBox.resize(255 - 63 * 3,130 - 36 * 1,153 + 63 * 4,184 + 36 * 1);
               this.app.mDialogBox.mDialogType = DialogBox.DIALOG_RETRY;
               aMessage = this.app.stringManager.translateString("[ENDLESS_PUZZLE_DEATH_MESSAGE]");
               aMessage = aMessage.replace("{STREAK}",this.app.mBoard.mChallenge.mSurvivalStage);
               this.app.mDialogBox.InitializeDialogBox(this.app.stringManager.translateString("[SCARY_POTTER_ENDLESS]"),aMessage,this.app.stringManager.translateString("[TRY_AGAIN]"),"",4,1);
            }
            else if(this.app.IsSurvivalMode())
            {
               this.app.mDialogBox.resize(255 - 63 * 3,130 - 36 * 2,153 + 63 * 4,184 + 36 * 2);
               this.app.mDialogBox.mDialogType = DialogBox.DIALOG_RETRY;
               aFlags = this.app.mBoard.GetSurvivalFlagsCompleted();
               aFlagStr = this.app.mBoard.Pluralize(aFlags,"[ONE_FLAG]","[COUNT_FLAGS]");
               aCompletedStr = this.app.stringManager.translateString("[SURVIVAL_DEATH_MESSAGE]").replace("{FLAGS}",aFlagStr);
               this.app.mDialogBox.InitializeDialogBox(this.app.stringManager.translateString("[SURVIVAL_POOL_ENDLESS]"),aCompletedStr,this.app.stringManager.translateString("[TRY_AGAIN]"),"",4,2);
            }
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
         this.app.widgetManager.removeAllWidgets();
         this.app.mBoard = null;
         this.app.mDialogBox = null;
      }
      
      public function update() : void
      {
         this.app.widgetManager.updateFrame();
      }
      
      public function onPop() : void
      {
      }
      
      public function GameContinue(obj:Object) : void
      {
         this.app.soundManager.resumeAll();
         this.app.musicManager.resumeMusic();
         this.app.mAwardScreen.mStartButton.setDisabled(false);
      }
   }
}
