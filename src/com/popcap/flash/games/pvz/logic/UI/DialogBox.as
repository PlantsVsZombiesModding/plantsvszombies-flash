package com.popcap.flash.games.pvz.logic.UI
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.resources.fonts.FontInst;
   import com.popcap.flash.framework.resources.images.ImageData;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.widgets.CWidget;
   import com.popcap.flash.framework.widgets.ui.IButtonListener;
   import com.popcap.flash.framework.widgets.ui.ImageButtonWidget;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.PVZMusic;
   import com.popcap.flash.games.pvz.logic.Board;
   import com.popcap.flash.games.pvz.logic.SeedChooserScreen;
   import com.popcap.flash.games.pvz.renderables.StringRenderable;
   import com.popcap.flash.games.pvz.resources.PVZFonts;
   import com.popcap.flash.games.pvz.resources.PVZImages;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.net.URLRequest;
   
   public class DialogBox extends CWidget implements IButtonListener
   {
      
      public static const DIALOG_LOCKED:int = 6;
      
      public static const DIALOG_UPSELL:int = 5;
      
      public static const DIALOG_REPICK:int = 4;
      
      public static const DIALOG_MAINMENU:int = 1;
      
      public static const DIALOG_RETRY:int = 3;
      
      public static const DIALOG_RESTART:int = 0;
      
      public static const DIALOG_GAMEOVER:int = 2;
       
      
      public var mDialogBoxImage:ImageInst;
      
      private var Menu_Ok:int = 100;
      
      public var mCancelText:String;
      
      public var mCancelButton:ImageButtonWidget;
      
      private var Menu_Cancel:int = 101;
      
      public var app:PVZApp;
      
      public var mHeader:String;
      
      private var mURLRequest:URLRequest;
      
      public var mDialogType:int;
      
      public var mBoard:Board;
      
      public var mOkButton:ImageButtonWidget;
      
      public var mMessage:String;
      
      public var mOkText:String;
      
      public function DialogBox(app:PVZApp, theBoard:Board)
      {
         super();
         this.app = app;
         this.mBoard = theBoard;
         this.mOkButton = new ImageButtonWidget(this.Menu_Ok,this);
         this.mCancelButton = new ImageButtonWidget(this.Menu_Cancel,this);
         this.mURLRequest = new URLRequest(app.mUpsellLink);
      }
      
      public function MakeDownButtonImage(theText:String) : ImageInst
      {
         var size:int = 2;
         if(this.mDialogType == DIALOG_GAMEOVER || this.mDialogType == DIALOG_UPSELL)
         {
            size = 4;
         }
         else if(this.mDialogType == DIALOG_RETRY || this.mDialogType == DIALOG_LOCKED)
         {
            size = 6;
         }
         var w:Number = 48 + 31 * size;
         var h:Number = 31;
         var x:int = 0;
         var y:int = 0;
         var aBufferedImage:ImageInst = new ImageInst(new ImageData(new BitmapData(w,h,true,0)));
         var bufferG:Graphics2D = aBufferedImage.graphics;
         var anImage:ImageInst = this.app.imageManager.getImageInst(PVZImages.IMAGE_BUTTON_LEFT);
         bufferG.drawImage(anImage,x,y);
         for(var i:int = 0; i < size; i++)
         {
            x += anImage.width;
            anImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_BUTTON_MIDDLE);
            bufferG.drawImage(anImage,x,y);
         }
         x += anImage.width;
         anImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_BUTTON_RIGHT);
         bufferG.drawImage(anImage,x,y);
         var font:FontInst = this.app.fontManager.getFontInst(PVZFonts.FONT_DWARVENTODCRAFT36BRIGHTGREENINSET);
         font.scale = 0.4;
         var offsetX:Number = (aBufferedImage.width - font.stringImageWidth(theText)) / 2;
         var offsetY:Number = (aBufferedImage.height - font.getHeight() - 5) / 2;
         bufferG.setFont(font);
         bufferG.drawString(theText,offsetX,offsetY);
         return aBufferedImage;
      }
      
      public function buttonDownTick(id:Number) : void
      {
      }
      
      public function MakeUpButtonImage(theText:String) : ImageInst
      {
         var size:int = 2;
         if(this.mDialogType == DIALOG_GAMEOVER || this.mDialogType == DIALOG_UPSELL)
         {
            size = 4;
         }
         else if(this.mDialogType == DIALOG_RETRY || this.mDialogType == DIALOG_LOCKED)
         {
            size = 6;
         }
         var w:Number = 48 + 31 * size;
         var h:Number = 31;
         var x:int = 0;
         var y:int = 0;
         var aBufferedImage:ImageInst = new ImageInst(new ImageData(new BitmapData(w,h,true,0)));
         var bufferG:Graphics2D = aBufferedImage.graphics;
         var anImage:ImageInst = this.app.imageManager.getImageInst(PVZImages.IMAGE_BUTTON_LEFT);
         bufferG.drawImage(anImage,x,y);
         for(var i:int = 0; i < size; i++)
         {
            x += anImage.width;
            anImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_BUTTON_MIDDLE);
            bufferG.drawImage(anImage,x,y);
         }
         x += anImage.width;
         anImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_BUTTON_RIGHT);
         bufferG.drawImage(anImage,x,y);
         var font:FontInst = this.app.fontManager.getFontInst(PVZFonts.FONT_DWARVENTODCRAFT36GREENINSET);
         font.scale = 0.4;
         var offsetX:Number = (aBufferedImage.width - font.stringImageWidth(theText)) / 2;
         var offsetY:Number = (aBufferedImage.height - font.getHeight() - 5) / 2;
         bufferG.setFont(font);
         bufferG.drawString(theText,offsetX,offsetY);
         return aBufferedImage;
      }
      
      override public function update() : void
      {
      }
      
      public function KillAll() : void
      {
         this.mOkButton.setVisible(false);
         this.mCancelButton.setVisible(false);
         this.setVisible(false);
      }
      
      override public function draw(g:Graphics2D) : void
      {
         if(this.mDialogBoxImage != null)
         {
            g.drawImage(this.mDialogBoxImage,0,0);
         }
      }
      
      public function buttonMouseMove(id:Number, x:Number, y:Number) : void
      {
      }
      
      public function buttonMouseEnter(id:Number) : void
      {
      }
      
      public function GameContinue(obj:Object) : void
      {
         this.app.soundManager.resumeAll();
         this.app.musicManager.resumeMusic();
         this.app.stateManager.changeState(PVZApp.STATE_LEVEL_INTRO);
      }
      
      public function InitializeDialogBox(theHeader:String, theMessage:String, theOkText:String, theCancelText:String, theWidth:int, theHeight:int) : void
      {
         this.mHeader = theHeader;
         this.mMessage = theMessage;
         this.mOkText = theOkText;
         this.mCancelText = theCancelText;
         this.mDialogBoxImage = this.MakeDialogBoxImage(theWidth,theHeight);
         var aPoint:Point = new Point(1,1);
         this.mOkButton.mUpImage = this.MakeUpButtonImage(this.mOkText);
         this.mOkButton.mOverImage = this.MakeDownButtonImage(this.mOkText);
         this.mOkButton.mDownImage = this.MakeDownButtonImage(this.mOkText);
         this.mOkButton.mDownOffset = aPoint;
         this.mOkButton.mDisabledImage = this.MakeUpButtonImage(this.mOkText);
         this.mOkButton.doFinger = true;
         this.mOkButton.visible = true;
         this.mOkButton.setDisabled(false);
         if(this.mDialogType == DIALOG_GAMEOVER || this.mDialogType == DIALOG_UPSELL)
         {
            this.mOkButton.resize(this.x + 20,this.y + 130 + theHeight * 36,172,31);
         }
         else if(this.mDialogType == DIALOG_RETRY || this.mDialogType == DIALOG_LOCKED)
         {
            this.mOkButton.resize(this.x + 80,this.y + 130 + theHeight * 36,234,31);
         }
         else
         {
            this.mOkButton.resize(this.x + 20,this.y + 130 + theHeight * 36,110,31);
         }
         if(this.mDialogType == DIALOG_GAMEOVER || this.mDialogType == DIALOG_RESTART || this.mDialogType == DIALOG_UPSELL || this.mDialogType == DIALOG_MAINMENU)
         {
            this.mCancelButton.mUpImage = this.MakeUpButtonImage(this.mCancelText);
            this.mCancelButton.mOverImage = this.MakeDownButtonImage(this.mCancelText);
            this.mCancelButton.mDownImage = this.MakeDownButtonImage(this.mCancelText);
            this.mCancelButton.mDownOffset = aPoint;
            this.mCancelButton.mDisabledImage = this.MakeUpButtonImage(this.mCancelText);
            this.mCancelButton.doFinger = true;
            this.mCancelButton.visible = true;
            this.mCancelButton.setDisabled(false);
            this.mCancelButton.resize(this.x + 15 + theWidth * 63,this.y + 130 + theHeight * 36,110,31);
            if(this.mDialogType == DIALOG_UPSELL)
            {
               this.mCancelButton.resize(this.x - 50 + theWidth * 63,this.y + 130 + theHeight * 36,172,31);
            }
         }
      }
      
      public function KillButtons() : void
      {
         this.mOkButton.setVisible(false);
         this.mCancelButton.setVisible(false);
      }
      
      public function buttonMouseLeave(id:Number) : void
      {
      }
      
      public function buttonPress(id:Number) : void
      {
      }
      
      public function buttonRelease(id:Number) : void
      {
         switch(id)
         {
            case this.Menu_Ok:
               if(this.mDialogType == DIALOG_MAINMENU)
               {
                  this.app.adAPI.GameEnd();
                  this.app.musicManager.playMusic(PVZMusic.CRAZY_DAVE);
                  this.app.stateManager.changeState(PVZApp.STATE_MAIN_MENU);
               }
               else if(this.mDialogType == DIALOG_GAMEOVER || this.mDialogType == DIALOG_RETRY)
               {
                  if(this.app.adAPI.enabled)
                  {
                     this.app.adAPI.GameEnd();
                     this.app.stateManager.changeState(PVZApp.STATE_MAIN_MENU);
                  }
                  if(this.app.mUpsellOn)
                  {
                     this.app.stateManager.changeState(PVZApp.STATE_UPSELL_SCREEN);
                  }
                  else
                  {
                     this.app.stateManager.changeState(PVZApp.STATE_MAIN_MENU);
                  }
               }
               else if(this.mDialogType == DIALOG_RESTART)
               {
                  if(this.app.adAPI.enabled)
                  {
                     this.app.soundManager.pauseAll();
                     this.app.musicManager.pauseMusic();
                     this.app.mTotalZombiesKilled = 0;
                     this.app.adAPI.setScore(this.app.mTotalZombiesKilled);
                     this.app.stateManager.changeState(PVZApp.STATE_LEVEL_INTRO);
                  }
                  else
                  {
                     this.app.stateManager.changeState(PVZApp.STATE_LEVEL_INTRO);
                  }
               }
               else if(this.mDialogType == DIALOG_REPICK)
               {
                  this.app.mSeedChooserScreen.mChooseState = SeedChooserScreen.CHOOSE_LEAVE;
                  this.app.mSeedChooserScreen.KillDialogBox();
                  this.app.mSeedChooserScreen.CloseSeedChooser();
               }
               else if(this.mDialogType == DIALOG_LOCKED)
               {
                  this.KillAll();
               }
               else if(this.mDialogType == DIALOG_UPSELL)
               {
               }
               break;
            case this.Menu_Cancel:
               if(this.mDialogType == DIALOG_REPICK)
               {
                  this.app.mSeedChooserScreen.KillDialogBox();
               }
               else if(this.mDialogType == DIALOG_RESTART || this.mDialogType == DIALOG_MAINMENU)
               {
                  this.app.mOptionsMenu.KillDialogBox();
               }
               else if(this.mDialogType == DIALOG_UPSELL)
               {
                  this.KillAll();
               }
         }
      }
      
      public function MakeDialogBoxImage(width:int = 1, height:int = 1) : ImageInst
      {
         var anImage:ImageInst = null;
         var j:int = 0;
         if(width <= 0)
         {
            width = 1;
         }
         if(height <= 0)
         {
            height = 1;
         }
         var w:Number = 153 + 63 * width;
         var h:Number = 184 + 36 * height;
         var x:int = 0;
         var y:int = 50;
         var i:int = 0;
         var headerX:int = 0;
         var headerY:int = 50;
         var aBufferedImage:ImageInst = new ImageInst(new ImageData(new BitmapData(w,h,true,0)));
         var bufferG:Graphics2D = aBufferedImage.graphics;
         anImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_DIALOG_TOPLEFT);
         bufferG.drawImage(anImage,x + 1,y);
         for(i = 0; i < width; i++)
         {
            x += anImage.width - 1;
            anImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_DIALOG_TOPMIDDLE);
            bufferG.drawImage(anImage,x,y);
         }
         var headerImage:ImageInst = this.app.imageManager.getImageInst(PVZImages.IMAGE_DIALOG_HEADER);
         headerX = headerImage.width / 2 - (anImage.width / 2 + anImage.x) + 5 + 31 * (width - 1);
         headerY += anImage.y - 30;
         x += anImage.width;
         anImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_DIALOG_TOPRIGHT);
         bufferG.drawImage(anImage,x - 3,y);
         for(i = 0; i < height; i++)
         {
            x = 0;
            y += anImage.height - 1;
            anImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_DIALOG_CENTERLEFT);
            bufferG.drawImage(anImage,x,y);
            for(j = 0; j < width; j++)
            {
               x += anImage.width - 1;
               anImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_DIALOG_CENTERMIDDLE);
               bufferG.drawImage(anImage,x,y);
            }
            x += anImage.width;
            anImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_DIALOG_CENTERRIGHT);
            bufferG.drawImage(anImage,x - 3,y);
         }
         x = 0;
         y += anImage.height - 2;
         anImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_DIALOG_BOTTOMLEFT);
         bufferG.drawImage(anImage,x + 1,y - 1);
         for(i = 0; i < width; i++)
         {
            x += anImage.width - 1;
            anImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_DIALOG_BOTTOMMIDDLE);
            bufferG.drawImage(anImage,x,y - 1);
         }
         x += anImage.width;
         anImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_DIALOG_BOTTOMRIGHT);
         bufferG.drawImage(anImage,x - 3,y - 1);
         bufferG.drawImage(headerImage,headerX,headerY);
         var aStringRenderable:StringRenderable = new StringRenderable(0);
         var aFont:FontInst = this.app.fontManager.getFontInst(PVZFonts.FONT_DWARVENTODCRAFT24);
         aFont.setColor(1,224 / 255,187 / 255,98 / 255);
         if(this.mDialogType == DIALOG_GAMEOVER)
         {
            aFont.scale = 0.85;
            aStringRenderable.text = this.mHeader;
            aStringRenderable.font = aFont;
            aStringRenderable.setBounds(20,70,102 + width * 63,75);
            aStringRenderable.justification = StringRenderable.JUSTIFY_CENTER;
            aStringRenderable.draw(bufferG);
         }
         else if(this.mDialogType == DIALOG_RETRY)
         {
            aFont.scale = 1;
            aStringRenderable.text = this.mHeader;
            aStringRenderable.font = aFont;
            aStringRenderable.setBounds(20,70,102 + width * 63,40);
            aStringRenderable.justification = StringRenderable.JUSTIFY_CENTER;
            aStringRenderable.draw(bufferG);
         }
         else
         {
            aFont.scale = 0.6;
            aStringRenderable.text = this.mHeader;
            aStringRenderable.font = aFont;
            aStringRenderable.setBounds(20,70,102 + width * 63,30);
            aStringRenderable.justification = StringRenderable.JUSTIFY_CENTER;
            aStringRenderable.draw(bufferG);
         }
         aFont = this.app.fontManager.getFontInst(PVZFonts.FONT_DWARVENTODCRAFT15);
         aFont.scale = 0.85;
         aFont.setColor(1,224 / 255,187 / 255,98 / 255);
         if(this.mMessage == "")
         {
            aStringRenderable.dead = true;
         }
         else
         {
            if(this.mDialogType == DIALOG_RETRY)
            {
               aFont.scale = 1;
            }
            aStringRenderable.text = this.mMessage;
            aStringRenderable.font = aFont;
            aStringRenderable.setBounds(22,90,97 + width * 63,29 + height * 36);
            aStringRenderable.draw(bufferG);
         }
         this.mDialogBoxImage = aBufferedImage;
         return aBufferedImage;
      }
   }
}
