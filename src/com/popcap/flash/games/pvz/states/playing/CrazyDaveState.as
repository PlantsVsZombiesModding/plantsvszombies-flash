package com.popcap.flash.games.pvz.states.playing
{
   import com.popcap.flash.framework.graphics.Color;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.resources.fonts.FontInst;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.resources.reanimator.Reanimation;
   import com.popcap.flash.framework.resources.reanimator.looptypes.ReanimLoopQueue;
   import com.popcap.flash.framework.states.IState;
   import com.popcap.flash.framework.widgets.ui.CButtonWidget;
   import com.popcap.flash.framework.widgets.ui.IButtonListener;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.PVZFoleyType;
   import com.popcap.flash.games.pvz.PVZMusic;
   import com.popcap.flash.games.pvz.logic.Board;
   import com.popcap.flash.games.pvz.renderables.ImageRenderable;
   import com.popcap.flash.games.pvz.renderables.ReanimationRenderable;
   import com.popcap.flash.games.pvz.renderables.StringRenderable;
   import com.popcap.flash.games.pvz.resources.PVZFonts;
   import com.popcap.flash.games.pvz.resources.PVZImages;
   
   public class CrazyDaveState implements IState, IButtonListener
   {
      
      public static const CRAZY_DAVE_HANDING_TALKING:int = 5;
      
      public static const CRAZY_DAVE_LEAVING:int = 2;
      
      public static const CRAZY_DAVE_OFF:int = 0;
      
      public static const CRAZY_DAVE_ENTERING:int = 1;
      
      public static const CRAZY_DAVE_TALKING:int = 4;
      
      public static const CRAZY_DAVE_IDLING:int = 3;
      
      public static const CRAZY_DAVE_HANDING_IDLING:int = 6;
       
      
      private var theButton:CButtonWidget;
      
      public var mCrazyDaveMessageText:String;
      
      private var mSpeechTextRenderable:StringRenderable;
      
      private var mCrazyDaveReanim:Reanimation;
      
      private var mSpeechBubble:ImageRenderable;
      
      private var app:PVZApp;
      
      public var mCrazyDaveDialogStart:int;
      
      public var mCrazyDaveDelay:int;
      
      public var mCrazyDaveState:int;
      
      private var mContinueTextRenderable:StringRenderable;
      
      private var mWallnutReanim:Reanimation;
      
      public var mCrazyDaveMessageIndex:int;
      
      public var mIsCrazyDaveShowing:Boolean;
      
      public function CrazyDaveState(app:PVZApp)
      {
         super();
         this.app = app;
      }
      
      public function buttonMouseEnter(id:Number) : void
      {
      }
      
      public function CrazyDaveTalkIndex(theMessageIndex:int) : void
      {
         this.mCrazyDaveMessageIndex = theMessageIndex;
         var aMessageText:String = this.GetCrazyDaveText(theMessageIndex);
         this.CrazyDaveTalkMessage(aMessageText);
      }
      
      public function AdvanceCrazyDaveDialog(theJustSkipping:Boolean) : void
      {
         if(this.mCrazyDaveMessageIndex == -1)
         {
            return;
         }
         if(this.mCrazyDaveMessageIndex == 2406 && !theJustSkipping)
         {
            this.app.mBoard.SetTutorialState(Board.TUTORIAL_SHOVEL_PICKUP);
            this.CrazyDaveLeave();
            return;
         }
         if(!this.AdvanceCrazyDaveText())
         {
            this.CrazyDaveLeave();
            return;
         }
         if(this.mCrazyDaveMessageIndex == 2411)
         {
            this.app.mBoard.mChallenge.mShowBowlingLine = true;
         }
      }
      
      public function CrazyDaveTalkMessage(theMessage:String) : void
      {
         this.app.soundManager.stopAll();
         var anArray:Array = new Array();
         var aDoTalkSound:Boolean = true;
         var aMessageLen:int = 0;
         var aInsideBracket:Boolean = false;
         if(this.mWallnutReanim != null)
         {
            this.mWallnutReanim.mIsDead = true;
         }
         for(var i:int = 0; i < theMessage.length; i++)
         {
            if(theMessage.charAt(i) == "{")
            {
               aInsideBracket = true;
            }
            else if(theMessage.charAt(i) == "}")
            {
               aInsideBracket = false;
            }
            else if(!aInsideBracket)
            {
               aMessageLen++;
            }
         }
         if(!(this.mCrazyDaveState == CRAZY_DAVE_TALKING && !aDoTalkSound))
         {
            if(theMessage.match("{SHAKE}") != null)
            {
               theMessage = theMessage.replace("{SHAKE}","");
               this.mCrazyDaveReanim.currentTrack = "anim_crazy";
               this.mCrazyDaveReanim.animRate = 12;
               anArray[0] = "anim_idle";
               this.mCrazyDaveReanim.loopType = new ReanimLoopQueue(anArray);
               if(aDoTalkSound)
               {
                  this.app.foleyManager.playFoley(PVZFoleyType.CRAZYDAVECRAZY);
               }
               this.mCrazyDaveState = CRAZY_DAVE_TALKING;
            }
            else if(theMessage.match("{SCREAM}") != null)
            {
               theMessage = theMessage.replace("{SCREAM}","");
               this.mCrazyDaveReanim.currentTrack = "anim_smalltalk";
               this.mCrazyDaveReanim.animRate = 12;
               anArray[0] = "anim_idle";
               this.mCrazyDaveReanim.loopType = new ReanimLoopQueue(anArray);
               if(aDoTalkSound)
               {
                  this.app.foleyManager.playFoley(PVZFoleyType.CRAZYDAVESCREAM);
               }
               this.mCrazyDaveState = CRAZY_DAVE_TALKING;
            }
            else if(theMessage.match("{SHOW_WALLNUT}") != null)
            {
               theMessage = theMessage.replace("{SHOW_WALLNUT}","");
               this.mCrazyDaveReanim.currentTrack = "anim_talk_handing";
               this.mCrazyDaveReanim.animRate = 12;
               anArray[0] = "anim_idle_handing";
               this.mCrazyDaveReanim.loopType = new ReanimLoopQueue(anArray);
               this.mWallnutReanim = this.app.reanimator.createReanimation("REANIM_WALLNUT");
               this.mWallnutReanim.currentTrack = "anim_idle1";
               this.mWallnutReanim.animRate = 12;
               this.mWallnutReanim.loopType = Reanimation.LOOP_TYPE_ALWAYS;
               this.mCrazyDaveReanim.attachReanimation(this.mWallnutReanim,"Dave_handinghand",67,275);
               if(aDoTalkSound)
               {
                  this.app.foleyManager.playFoley(PVZFoleyType.CRAZYDAVESCREAM2);
               }
               this.mCrazyDaveState = CRAZY_DAVE_HANDING_TALKING;
            }
            else if(theMessage.match("{SHOW_HAMMER}") == null)
            {
               if(aMessageLen < 23)
               {
                  this.mCrazyDaveReanim.currentTrack = "anim_smalltalk";
                  this.mCrazyDaveReanim.animRate = 12;
                  anArray[0] = "anim_idle";
                  this.mCrazyDaveReanim.loopType = new ReanimLoopQueue(anArray);
                  if(aDoTalkSound)
                  {
                     this.app.foleyManager.playFoley(PVZFoleyType.CRAZYDAVESHORT);
                  }
                  this.mCrazyDaveState = CRAZY_DAVE_TALKING;
               }
               else if(aMessageLen < 52)
               {
                  this.mCrazyDaveReanim.currentTrack = "anim_mediumtalk";
                  this.mCrazyDaveReanim.animRate = 12;
                  anArray[0] = "anim_idle";
                  this.mCrazyDaveReanim.loopType = new ReanimLoopQueue(anArray);
                  if(aDoTalkSound)
                  {
                     this.app.foleyManager.playFoley(PVZFoleyType.CRAZYDAVELONG);
                  }
                  this.mCrazyDaveState = CRAZY_DAVE_TALKING;
               }
               else
               {
                  this.mCrazyDaveReanim.currentTrack = "anim_blahblah";
                  this.mCrazyDaveReanim.animRate = 12;
                  anArray[0] = "anim_idle";
                  this.mCrazyDaveReanim.loopType = new ReanimLoopQueue(anArray);
                  if(aDoTalkSound)
                  {
                     this.app.foleyManager.playFoley(PVZFoleyType.CRAZYDAVEEXTRALONG);
                  }
                  this.mCrazyDaveState = CRAZY_DAVE_TALKING;
               }
            }
         }
         theMessage = theMessage.replace("{MOUTH_SMALL_OH}","");
         theMessage = theMessage.replace("{MOUTH_SMALL_SMILE}","");
         theMessage = theMessage.replace("{MOUTH_BIG_SMILE}","");
         theMessage = theMessage.replace("{SHAKE}","");
         this.mCrazyDaveMessageText = theMessage;
      }
      
      public function buttonMouseMove(id:Number, x:Number, y:Number) : void
      {
      }
      
      public function onPush() : void
      {
      }
      
      public function onExit() : void
      {
         this.app.widgetManager.removeWidget(this.theButton);
      }
      
      public function AdvanceCrazyDaveText() : Boolean
      {
         var aNextMessage:int = this.mCrazyDaveMessageIndex + 1;
         var aMessageName:* = "[CRAZY_DAVE_" + aNextMessage + "]";
         if(aMessageName == "[CRAZY_DAVE_2407]")
         {
            return false;
         }
         if(aMessageName == "[CRAZY_DAVE_2416]" || aMessageName == "[CRAZY_DAVE_3003]" || aMessageName == "[CRAZY_DAVE_208]" || aMessageName == "[CRAZY_DAVE_3303]")
         {
            this.CrazyDaveDie();
         }
         else
         {
            this.CrazyDaveTalkIndex(aNextMessage);
         }
         return true;
      }
      
      public function buttonDownTick(id:Number) : void
      {
      }
      
      public function UpdateCrazyDave() : void
      {
         if(this.mCrazyDaveDelay > 0)
         {
            --this.mCrazyDaveDelay;
            if(this.mCrazyDaveDelay == 0)
            {
               this.mCrazyDaveDelay = 350;
               this.AdvanceCrazyDaveDialog(false);
            }
         }
         if(!this.mCrazyDaveReanim)
         {
            return;
         }
         if(this.mCrazyDaveReanim.mIsDead)
         {
            this.app.mBoard.mGameScene = PVZApp.SCENE_LEVEL_INTRO;
            this.app.widgetManager.removeWidget(this.theButton);
            if(this.app.mBoard.IsWallnutBowlingLevel())
            {
               this.app.widgetManager.setFocus(this.app.mBoard);
               this.app.stateManager.changeState(PVZApp.STATE_SLIDE_UI);
            }
            else if(this.app.IsScaryPotterLevel())
            {
               this.app.widgetManager.setFocus(this.app.mBoard);
               this.app.musicManager.playMusic(PVZMusic.CEREBRAWL,true,50);
               this.app.stateManager.changeState(PVZApp.STATE_SLIDE_UI);
            }
            else if(this.app.IsAdventureMode() && this.app.mLevel == 11)
            {
               this.app.widgetManager.setFocus(this.app.mBoard);
               this.app.musicManager.playMusic(PVZMusic.CHOOSE_YOUR_SEEDS,true,50);
               this.app.stateManager.changeState(PVZApp.STATE_PAN_RIGHT);
            }
            else if(this.app.IsAdventureMode() && this.app.mBoard.mLevel == 14)
            {
               if(this.app.mUpsellOn)
               {
                  this.app.stateManager.changeState(PVZApp.STATE_UPSELL_SCREEN);
               }
               else
               {
                  this.app.stateManager.changeState(PVZApp.STATE_MAIN_MENU);
               }
            }
         }
         switch(this.mCrazyDaveReanim.currentTrack)
         {
            case "anim_idle":
               this.mCrazyDaveState = CRAZY_DAVE_IDLING;
               if(this.mCrazyDaveReanim.animRate != 12)
               {
                  this.mCrazyDaveReanim.animRate = 12;
               }
               break;
            case "anim_enter":
               this.mCrazyDaveState = CRAZY_DAVE_ENTERING;
               break;
            case "anim_leave":
               this.mCrazyDaveState = CRAZY_DAVE_LEAVING;
               break;
            case "anim_blahblah":
            case "anim_smalltalk":
            case "anim_mediumtalk":
            case "anim_crazy":
               this.mCrazyDaveState = CRAZY_DAVE_TALKING;
               break;
            case "anim_enter_handing":
               this.mCrazyDaveState = CRAZY_DAVE_ENTERING;
               break;
            case "anim_idle_handing":
               this.mCrazyDaveState = CRAZY_DAVE_HANDING_IDLING;
               break;
            case "anim_talk_handing":
               this.mCrazyDaveState = CRAZY_DAVE_HANDING_TALKING;
         }
         if(this.app.mBoard.IsWallnutBowlingLevel() && this.app.mBoard.mTutorialState == Board.TUTORIAL_SHOVEL_COMPLETED && !this.mIsCrazyDaveShowing)
         {
            this.mCrazyDaveDialogStart = 2410;
            this.CrazyDaveTalkIndex(this.mCrazyDaveDialogStart);
            this.mCrazyDaveDialogStart = -1;
            this.CrazyDaveEnter();
         }
      }
      
      public function DrawCrazyDave(g:Graphics2D) : void
      {
         this.mSpeechTextRenderable.text = this.mCrazyDaveMessageText;
      }
      
      public function buttonPress(id:Number) : void
      {
      }
      
      public function CrazyDaveDie() : void
      {
         if(!this.mCrazyDaveReanim)
         {
            return;
         }
         if(this.app.mBoard.mLevel == 14)
         {
            this.mCrazyDaveReanim.currentTrack = "anim_leave";
         }
         else
         {
            this.mCrazyDaveReanim.currentTrack = "anim_leave";
         }
         this.mCrazyDaveReanim.loopType = Reanimation.LOOP_TYPE_ONCE_AND_DIE;
         this.mCrazyDaveReanim.animRate = 24;
         this.mCrazyDaveState = CRAZY_DAVE_LEAVING;
         this.mCrazyDaveMessageIndex = -1;
         this.mCrazyDaveMessageText = "";
         this.mSpeechBubble.dead = true;
         this.mContinueTextRenderable.dead = true;
         this.mSpeechTextRenderable.dead = true;
      }
      
      public function onEnter() : void
      {
         this.app.mBoard.mMenuButton.setVisible(false);
         if(this.app.IsAdventureMode() && this.app.mLevel == 14)
         {
            this.mCrazyDaveDelay = 350;
            trace("Delay set");
         }
         else
         {
            this.mCrazyDaveDelay = 0;
         }
         var boardOffset:int = 0;
         if(this.app.IsAdventureMode() && this.app.mLevel == 11)
         {
            boardOffset = -PVZApp.BOARD_OFFSET;
         }
         else if(this.app.IsAdventureMode() && this.app.mLevel == 14)
         {
            boardOffset = -PVZApp.BOARD_OFFSET;
         }
         this.app.mBoard.mGameScene = PVZApp.SCENE_CRAZY_DAVE;
         this.mCrazyDaveReanim = this.app.reanimator.createReanimation("REANIM_CRAZYDAVE");
         this.mCrazyDaveReanim.x = -15 + boardOffset;
         this.app.mBoard.mRenderManager.add(new ReanimationRenderable(this.mCrazyDaveReanim,Board.RENDER_LAYER_ABOVE_UI,true));
         this.theButton = new CButtonWidget(0,this);
         this.theButton.label = "";
         this.theButton.setColor(CButtonWidget.COLOR_LABEL,Color.RGB(1,1,1));
         var font:FontInst = this.app.fontManager.getFontInst(PVZFonts.FONT_BRIANNETOD16);
         this.theButton.font = font;
         this.theButton.setDisabled(false);
         this.theButton.visible = true;
         this.theButton.resize(0,0,540,405);
         this.app.widgetManager.addWidget(this.theButton);
         this.app.widgetManager.setFocus(this.theButton);
         var theBubbleImage:ImageInst = this.app.imageManager.getImageInst(PVZImages.IMAGE_STORE_SPEECHBUBBLE2);
         theBubbleImage.x = 190 + boardOffset;
         theBubbleImage.y = 20;
         this.mSpeechBubble = new ImageRenderable(theBubbleImage,Board.RENDER_LAYER_ABOVE_UI);
         this.app.mBoard.mRenderManager.add(this.mSpeechBubble);
         var aFont:FontInst = this.app.fontManager.getFontInst(PVZFonts.FONT_BRIANNETOD16);
         aFont.setColor(1,0,0,0);
         this.mSpeechTextRenderable = new StringRenderable(Board.RENDER_LAYER_ABOVE_UI + 1);
         this.mSpeechTextRenderable.setBounds(195 + boardOffset,20,180,95);
         this.mSpeechTextRenderable.font = aFont;
         this.mSpeechTextRenderable.text = "Crazy Dave Text";
         this.app.mBoard.mRenderManager.add(this.mSpeechTextRenderable);
         if(this.mCrazyDaveDelay == 0)
         {
            aFont = this.app.fontManager.getFontInst(PVZFonts.FONT_PICO129);
            aFont.setColor(1,0,0,0);
            this.mContinueTextRenderable = new StringRenderable(Board.RENDER_LAYER_ABOVE_UI + 1);
            this.mContinueTextRenderable.setBounds(240 + boardOffset,110,100,20);
            this.mContinueTextRenderable.font = aFont;
            this.mContinueTextRenderable.text = this.app.stringManager.translateString("[CLICK_TO_CONTINUE]");
            this.app.mBoard.mRenderManager.add(this.mContinueTextRenderable);
         }
         else
         {
            this.mContinueTextRenderable.text = "";
            this.mContinueTextRenderable.dead = true;
         }
         if(this.app.mBoard.IsWallnutBowlingLevel() && this.app.IsAdventureMode())
         {
            this.mCrazyDaveDialogStart = 2400;
            this.CrazyDaveTalkIndex(this.mCrazyDaveDialogStart);
            this.mCrazyDaveDialogStart = -1;
            this.app.mBoard.mShowShovel = true;
            this.CrazyDaveEnter();
         }
         else if(this.app.IsScaryPotterLevel())
         {
            this.mCrazyDaveDialogStart = 3000;
            this.CrazyDaveTalkIndex(this.mCrazyDaveDialogStart);
            this.mCrazyDaveDialogStart = -1;
            this.CrazyDaveEnter();
         }
         else if(this.app.IsAdventureMode() && this.app.mLevel == 11)
         {
            this.app.mBoard.move(PVZApp.BOARD_OFFSET,0);
            this.mCrazyDaveDialogStart = 201;
            this.CrazyDaveTalkIndex(this.mCrazyDaveDialogStart);
            this.mCrazyDaveDialogStart = -1;
            this.CrazyDaveEnter();
         }
         else if(this.app.IsAdventureMode() && this.app.mBoard.mLevel == 14)
         {
            this.mCrazyDaveDialogStart = 3300;
            this.CrazyDaveTalkIndex(this.mCrazyDaveDialogStart);
            this.mCrazyDaveDialogStart = -1;
            this.CrazyDaveEnter();
         }
      }
      
      public function draw(g:Graphics2D) : void
      {
         this.app.widgetManager.drawScreen(g);
         this.DrawCrazyDave(g);
      }
      
      public function update() : void
      {
         this.app.widgetManager.updateFrame();
         this.UpdateCrazyDave();
      }
      
      public function LookUpCrazyDaveText(theMessageIndex:String) : String
      {
         var aMessage:String = null;
         switch(theMessageIndex)
         {
            case "[CRAZY_DAVE_2400]":
               aMessage = "Greetings, neighbor!";
               break;
            case "[CRAZY_DAVE_2401]":
               aMessage = "The name\'s Crazy Dave.!";
               break;
            case "[CRAZY_DAVE_2402]":
               aMessage = "But you can just call me Crazy Dave.";
               break;
            case "[CRAZY_DAVE_2403]":
               aMessage = "Listen, I\'ve got a surprise for you.";
               break;
            case "[CRAZY_DAVE_2404]":
               aMessage = "Listen, I\'ve got a surprise for you.";
               break;
            case "[CRAZY_DAVE_2405]":
               aMessage = "Use your shovel and dig up those plants!";
               break;
            case "[CRAZY_DAVE_2406]":
               aMessage = "LET THE DIGGING COMMENCE!{MOUTH_SMALL_OH} {SCREAM}";
               break;
            case "[CRAZY_DAVE_2410]":
               aMessage = "Ok goody, now for the surprise...";
               break;
            case "[CRAZY_DAVE_2411]":
               aMessage = "We\'re going BOWLING!{MOUTH_SMALL_SMILE}";
               break;
            case "[CRAZY_DAVE_2412]":
               aMessage = "{SHOW_WALLNUT}HERE, TAKE THIS WALL-NUT!!";
               break;
            case "[CRAZY_DAVE_2413]":
               aMessage = "Why\'d I put a wall-nut in your hand?{MOUTH_SMALL_OH}";
               break;
            case "[CRAZY_DAVE_2414]":
               aMessage = "{SHAKE}Because I\'m CRAAAZY!!!!!{MOUTH_BIG_SMILE}";
               break;
            case "[CRAZY_DAVE_2415]":
               aMessage = "NOW GO! BOWL ME A WINNER!{MOUTH_BIG_SMILE} {SCREAM}";
               break;
            default:
               aMessage = "";
         }
         return aMessage;
      }
      
      public function handleEffect(effect:String) : void
      {
         switch(effect)
         {
            case "{HANDING}":
            case "SCREAM":
               break;
            default:
               throw new Error("Unhandled text effect: " + effect);
         }
      }
      
      public function CrazyDaveLeave() : void
      {
         this.mIsCrazyDaveShowing = false;
         if(!this.mCrazyDaveReanim)
         {
            return;
         }
         if(this.mCrazyDaveState == CRAZY_DAVE_HANDING_TALKING || this.mCrazyDaveState == CRAZY_DAVE_HANDING_IDLING)
         {
            this.CrazyDaveDoneHanding();
         }
         this.mCrazyDaveReanim.currentTrack = "anim_leave";
         this.mCrazyDaveReanim.loopType = Reanimation.LOOP_TYPE_ONCE_AND_HOLD;
         this.mCrazyDaveReanim.animRate = 24;
         this.mCrazyDaveState = CRAZY_DAVE_LEAVING;
         this.mCrazyDaveMessageIndex = -1;
         this.mCrazyDaveMessageText = "";
         this.mSpeechBubble.dead = true;
         this.mContinueTextRenderable.dead = true;
         this.mSpeechTextRenderable.dead = true;
         this.app.widgetManager.removeWidget(this.theButton);
         this.app.widgetManager.setFocus(this.app.mBoard);
      }
      
      public function CrazyDaveEnter() : void
      {
         this.mSpeechBubble.dead = false;
         if(this.mCrazyDaveDelay == 0)
         {
            this.mContinueTextRenderable.dead = false;
         }
         this.mSpeechTextRenderable.dead = false;
         this.app.mBoard.mRenderManager.add(this.mSpeechBubble);
         this.app.mBoard.mRenderManager.add(this.mContinueTextRenderable);
         this.app.mBoard.mRenderManager.add(this.mSpeechTextRenderable);
         this.mIsCrazyDaveShowing = true;
         if(this.app.IsAdventureMode() && this.app.mBoard.mLevel == 14)
         {
            this.mCrazyDaveReanim.currentTrack = "anim_enter";
            this.mCrazyDaveReanim.x = 10;
         }
         else
         {
            this.mCrazyDaveReanim.currentTrack = "anim_enter";
         }
         this.mCrazyDaveReanim.animRate = 24;
         var anArray:Array = new Array("anim_smalltalk","anim_idle");
         this.mCrazyDaveReanim.loopType = new ReanimLoopQueue(anArray);
         this.mCrazyDaveState = CRAZY_DAVE_ENTERING;
         this.app.widgetManager.addWidget(this.theButton);
         this.app.widgetManager.setFocus(this.theButton);
      }
      
      public function GetCrazyDaveText(theMessageIndex:int) : String
      {
         var aText:* = "[CRAZY_DAVE_" + theMessageIndex + "]";
         return this.app.stringManager.translateString(aText);
      }
      
      public function buttonMouseLeave(id:Number) : void
      {
      }
      
      public function buttonRelease(id:Number) : void
      {
         if(this.mCrazyDaveDelay == 0)
         {
            this.AdvanceCrazyDaveDialog(false);
         }
      }
      
      public function onPop() : void
      {
      }
      
      public function CrazyDaveDoneHanding() : void
      {
      }
   }
}
