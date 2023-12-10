package com.popcap.flash.games.pvz.states.playing
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.states.IState;
   import com.popcap.flash.framework.utils.Utils;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.PVZFoleyType;
   import com.popcap.flash.games.pvz.PVZMusic;
   import com.popcap.flash.games.pvz.logic.TodCommon;
   import com.popcap.flash.games.pvz.resources.PVZImages;
   import flash.geom.Rectangle;
   
   public class ZombiesWonState implements IState
   {
      
      private static var TIME_PAN_RIGHT_START:int = 1500;
      
      private static var TIME_PAN_RIGHT_END:int = TIME_PAN_RIGHT_START + 2000;
      
      private static var TIME_GRAPHIC_START:int = TIME_PAN_RIGHT_START + 2500;
      
      private static var TIME_GRAPHIC_SHAKE:int = TIME_GRAPHIC_START + 1000;
      
      private static var TIME_GRAPHIC_SHAKE_END:int = TIME_GRAPHIC_SHAKE + 1000;
      
      private static var TIME_GRAPHIC_END:int = TIME_GRAPHIC_SHAKE_END + 3000;
      
      private static var TIME_END:int = TIME_GRAPHIC_END;
       
      
      private var mImageBounds:Rectangle;
      
      private var mScreenBounds:Rectangle;
      
      private var mZombiesWon:ImageInst;
      
      private var mImageOffsetX:Number = 0;
      
      private var mImageOffsetY:Number = 0;
      
      private var mApp:PVZApp;
      
      private var mImageScale:Number = 1;
      
      public function ZombiesWonState(app:PVZApp)
      {
         this.mImageBounds = new Rectangle();
         this.mScreenBounds = new Rectangle(0,0,540,405);
         super();
         this.mApp = app;
      }
      
      public function onEnter() : void
      {
         if(this.mZombiesWon == null)
         {
            this.mZombiesWon = this.mApp.imageManager.getImageInst(PVZImages.IMAGE_ZOMBIESWON);
         }
         this.mApp.musicManager.playMusic(PVZMusic.LOSEMUSIC,false);
         this.mApp.mBoard.mMenuButton.setVisible(false);
         if(this.mApp.IsScaryPotterLevel())
         {
            this.mApp.mCutsceneTime = TIME_END - 10;
         }
         else
         {
            this.mApp.mCutsceneTime = 0;
         }
      }
      
      public function draw(g:Graphics2D) : void
      {
         this.mApp.widgetManager.drawScreen(g);
         if(this.mApp.IsScaryPotterLevel())
         {
            return;
         }
         if(this.mApp.mCutsceneTime >= TIME_GRAPHIC_START && this.mApp.mCutsceneTime < TIME_GRAPHIC_END)
         {
            this.mImageBounds.x = 0;
            this.mImageBounds.y = 0;
            this.mImageBounds.width = this.mZombiesWon.width * this.mImageScale;
            this.mImageBounds.height = this.mZombiesWon.height * this.mImageScale;
            Utils.align(this.mImageBounds,this.mScreenBounds,Utils.ALIGN_CENTER,Utils.ALIGN_CENTER);
            g.pushState();
            g.scale(this.mImageScale,this.mImageScale);
            g.drawImage(this.mZombiesWon,this.mImageBounds.x + this.mImageOffsetX,this.mImageBounds.y + this.mImageOffsetY);
            g.popState();
         }
      }
      
      public function update() : void
      {
         var x:int = 0;
         this.mApp.widgetManager.updateFrame();
         this.mApp.mCutsceneTime += 10;
         var time:Number = this.mApp.mCutsceneTime;
         if(time == TIME_END)
         {
            this.mApp.stateManager.changeState(PVZApp.STATE_DIALOG_BOX);
         }
         if(time > TIME_PAN_RIGHT_START && time <= TIME_PAN_RIGHT_END)
         {
            x = TodCommon.TodAnimateCurve(TIME_PAN_RIGHT_START,TIME_PAN_RIGHT_END,time,0,PVZApp.BOARD_OFFSET,TodCommon.CURVE_EASE_IN_OUT);
            this.mApp.mBoard.move(x,0);
         }
         if(time == TIME_GRAPHIC_START - 400 || time == TIME_GRAPHIC_START - 900)
         {
            this.mApp.foleyManager.playFoley(PVZFoleyType.CHOMP);
         }
         if(time > TIME_PAN_RIGHT_START)
         {
            this.mApp.mBoard.mShowZombieWalking = true;
         }
         if(time == TIME_GRAPHIC_START)
         {
            this.mApp.foleyManager.playFoley(PVZFoleyType.SCREAM);
         }
         if(time >= TIME_GRAPHIC_START && time < TIME_GRAPHIC_SHAKE)
         {
            this.mImageScale = (time - TIME_GRAPHIC_START) / (TIME_GRAPHIC_SHAKE - TIME_GRAPHIC_START);
         }
         this.mImageOffsetX = 0;
         this.mImageOffsetY = 0;
         if(time >= TIME_GRAPHIC_SHAKE && time < TIME_GRAPHIC_SHAKE_END)
         {
            this.mImageOffsetX = Math.random() * 4 - 2;
            this.mImageOffsetY = Math.random() * 4 - 2;
         }
      }
      
      public function onPush() : void
      {
      }
      
      public function onExit() : void
      {
      }
      
      public function onPop() : void
      {
      }
   }
}
