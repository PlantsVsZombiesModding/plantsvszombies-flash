package com.popcap.flash.games.pvz.logic
{
   import com.popcap.flash.framework.graphics.Color;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.resources.fonts.FontInst;
   import com.popcap.flash.framework.resources.images.ImageData;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.widgets.CWidget;
   import com.popcap.flash.framework.widgets.ui.CButtonWidget;
   import com.popcap.flash.framework.widgets.ui.IButtonListener;
   import com.popcap.flash.framework.widgets.ui.ImageButtonWidget;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.renderables.StringRenderable;
   import com.popcap.flash.games.pvz.resources.PVZFonts;
   import com.popcap.flash.games.pvz.resources.PVZImages;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class ChallengeScreen extends CWidget implements IButtonListener
   {
       
      
      public var mStartButton:ImageButtonWidget;
      
      private var mButtonText:String;
      
      private var StartGame:int = 100;
      
      private var mUpsellText:StringRenderable;
      
      private var mTitleString:String;
      
      public var mBackToMenuButton:CButtonWidget;
      
      public var app:PVZApp;
      
      private var mBackgroundImage:ImageInst;
      
      private var mBackToMenuImage:ImageInst;
      
      private var BackToMenu:int = 101;
      
      public var mBoard:Board;
      
      public function ChallengeScreen(app:PVZApp, theBoard:Board)
      {
         super();
         this.app = app;
         this.mBoard = theBoard;
         this.mStartButton = new ImageButtonWidget(this.StartGame,this);
         if(app.IsScaryPotterLevel())
         {
            this.mButtonText = app.stringManager.translateString("[SCARY_POTTER_ENDLESS]");
            this.mStartButton.resize(20,62,80,81);
         }
         else if(app.IsSurvivalMode())
         {
            this.mButtonText = app.stringManager.translateString("[SURVIVAL_POOL_ENDLESS]");
            this.mStartButton.resize(20,100,80,81);
         }
         this.mStartButton.mUpImage = this.MakeUpButtonImage();
         this.mStartButton.mDownImage = this.MakeDownButtonImage();
         this.mStartButton.mOverImage = this.MakeDownButtonImage();
         this.mStartButton.mDownOffset = new Point(1,1);
         this.mStartButton.mDisabledImage = this.MakeUpButtonImage();
         this.mBackToMenuButton = new CButtonWidget(this.BackToMenu,this);
         this.mBackToMenuButton.setDisabled(false);
         this.mBackToMenuButton.visible = true;
         this.mBackToMenuButton.label = app.stringManager.translateString("[BACK_TO_MENU]");
         this.mBackToMenuButton.setColor(CButtonWidget.COLOR_LABEL,Color.RGB(218 / 255,184 / 255,33 / 255));
         var font:FontInst = app.fontManager.getFontInst(PVZFonts.FONT_BRIANNETOD16);
         font.scale = 0.6;
         this.mBackToMenuButton.font = font;
         this.mBackToMenuButton.resize(20,360,75,18);
         this.mBackToMenuImage = app.imageManager.getImageInst(PVZImages.IMAGE_SEEDCHOOSER_BUTTON2);
         this.mBackgroundImage = app.imageManager.getImageInst(PVZImages.IMAGE_CHALLENGE_BACKGROUND);
         font = app.fontManager.getFontInst(PVZFonts.FONT_DWARVENTODCRAFT36GREENINSET);
         font.scale = 0.8;
         font.setColor(1,90 / 255,40 / 255,30 / 255);
         this.mUpsellText = new StringRenderable(0);
         this.mUpsellText.font = font;
         if(app.IsScaryPotterLevel())
         {
            this.mUpsellText.setBounds(20,150,500,200);
            this.mUpsellText.text = app.stringManager.translateString("[PUZZLE_UPSELL_MESSAGE]");
            this.mTitleString = app.stringManager.translateString("[SCARY_POTTER]");
         }
         else if(app.IsSurvivalMode())
         {
            this.mUpsellText.setBounds(70,150,420,200);
            this.mUpsellText.text = app.stringManager.translateString("[SURVIVAL_UPSELL_MESSAGE]");
            this.mTitleString = app.stringManager.translateString("[PICK_AREA]");
         }
      }
      
      public function buttonMouseMove(id:Number, x:Number, y:Number) : void
      {
      }
      
      public function buttonMouseEnter(id:Number) : void
      {
      }
      
      override public function update() : void
      {
      }
      
      public function buttonDownTick(id:Number) : void
      {
      }
      
      public function MakeDownButtonImage() : ImageInst
      {
         var w:Number = 80;
         var h:Number = 81;
         var aBufferedImage:ImageInst = new ImageInst(new ImageData(new BitmapData(w,h,true,0)));
         var bufferG:Graphics2D = aBufferedImage.graphics;
         var anImage:ImageInst = this.app.imageManager.getImageInst(PVZImages.IMAGE_CHALLENGE_WINDOW_HIGHLIGHT);
         bufferG.drawImage(anImage,0,0);
         anImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_SURVIVAL_THUMBNAILS);
         var aStringRenderable:StringRenderable = new StringRenderable(0);
         var aFont:FontInst = this.app.fontManager.getFontInst(PVZFonts.FONT_BRIANNETOD16);
         aFont.setColor(1,250 / 255,40 / 255,40 / 255);
         aFont.scale = 0.6;
         aStringRenderable.text = this.mButtonText;
         aStringRenderable.font = aFont;
         aStringRenderable.setBounds(7,50,65,23);
         aStringRenderable.draw(bufferG);
         return aBufferedImage;
      }
      
      public function MakeUpButtonImage() : ImageInst
      {
         var w:Number = 80;
         var h:Number = 81;
         var aBufferedImage:ImageInst = new ImageInst(new ImageData(new BitmapData(w,h,true,0)));
         var bufferG:Graphics2D = aBufferedImage.graphics;
         var anImage:ImageInst = this.app.imageManager.getImageInst(PVZImages.IMAGE_CHALLENGE_WINDOW);
         bufferG.drawImage(anImage,0,0);
         anImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_SURVIVAL_THUMBNAILS);
         var aStringRenderable:StringRenderable = new StringRenderable(0);
         var aFont:FontInst = this.app.fontManager.getFontInst(PVZFonts.FONT_BRIANNETOD16);
         aFont.setColor(1,42 / 255,42 / 255,90 / 255);
         aFont.scale = 0.6;
         aStringRenderable.text = this.mButtonText;
         aStringRenderable.font = aFont;
         aStringRenderable.setBounds(7,50,65,23);
         aStringRenderable.draw(bufferG);
         return aBufferedImage;
      }
      
      public function buttonMouseLeave(id:Number) : void
      {
      }
      
      override public function draw(g:Graphics2D) : void
      {
         var aPosX:int = 0;
         var aPosY:int = 0;
         var aRow:int = 0;
         var aCol:int = 0;
         g.drawImage(this.mBackgroundImage,0,0);
         var aFont:FontInst = this.app.fontManager.getFontInst(PVZFonts.FONT_HOUSEOFTERROR28);
         aFont.scale = 0.7;
         aFont.setColor(1,220 / 255,220 / 255,220 / 255);
         g.setFont(aFont);
         g.drawString(this.mTitleString,230,12);
         var i:int = 1;
         var aBlank:ImageInst = this.app.imageManager.getImageInst(PVZImages.IMAGE_CHALLENGE_BLANK);
         if(this.app.IsScaryPotterLevel())
         {
            for(i = 1; i < 20; i++)
            {
               aRow = i / 5;
               aCol = i % 5;
               aPosX = 23 + aCol * 105;
               aPosY = 62 + aRow * 81;
               g.drawImage(aBlank,aPosX,aPosY);
            }
         }
         else if(this.app.IsSurvivalMode())
         {
            for(i = 1; i < 10; i++)
            {
               aRow = i / 5;
               aCol = i % 5;
               aPosX = 23 + aCol * 105;
               aPosY = 100 + aRow * 100;
               g.drawImage(aBlank,aPosX,aPosY);
            }
            aPosX = 23 + 2 * 105;
            aPosY = 100 + 2 * 100;
            g.drawImage(aBlank,aPosX,aPosY);
         }
         this.mUpsellText.draw(g);
         g.drawImage(this.mBackToMenuImage,20,361);
      }
      
      public function buttonPress(id:Number) : void
      {
      }
      
      public function buttonRelease(id:Number) : void
      {
         switch(id)
         {
            case this.StartGame:
               this.app.stateManager.popState();
               this.app.stateManager.changeState(PVZApp.STATE_LEVEL_INTRO);
               break;
            case this.BackToMenu:
               this.app.stateManager.changeState(PVZApp.STATE_MAIN_MENU);
         }
      }
   }
}
