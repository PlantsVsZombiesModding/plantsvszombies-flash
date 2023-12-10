package com.popcap.flash.games.pvz.logic.UI
{
   import com.popcap.flash.framework.graphics.Color;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.resources.fonts.FontInst;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.widgets.CWidget;
   import com.popcap.flash.framework.widgets.ui.CButtonWidget;
   import com.popcap.flash.framework.widgets.ui.IButtonListener;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.renderables.StringRenderable;
   import com.popcap.flash.games.pvz.resources.PVZFonts;
   import com.popcap.flash.games.pvz.resources.PVZImages;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class UpsellScreen extends CWidget implements IButtonListener
   {
      
      public static const ADVENTURE:int = 0;
      
      public static const PUZZLE:int = 1;
      
      public static const MINIGAME:int = 3;
      
      public static const SURVIVAL:int = 2;
       
      
      private var mBackToGameButtonText:StringRenderable;
      
      public var mUpsellButton:CButtonWidget;
      
      private var mTitleDescription:StringRenderable;
      
      private var mHeader1:StringRenderable;
      
      private var mHeader2:StringRenderable;
      
      private var mBackgroundImage:ImageInst;
      
      public var app:PVZApp;
      
      private var UpsellLink:int = 100;
      
      public var mBackToGameButton:CButtonWidget;
      
      private var mUpsellImage2:ImageInst;
      
      private var mUpsellImage:ImageInst;
      
      private var mHeader2Description:StringRenderable;
      
      private var mType:int;
      
      private var mUpsellButtonText:StringRenderable;
      
      private var mTitleString:StringRenderable;
      
      private var mHeader1Description:StringRenderable;
      
      private var upsellXML:XML;
      
      private var mURLRequest:URLRequest;
      
      private var BackToGame:int = 101;
      
      public function UpsellScreen(app:PVZApp, theType:int)
      {
         this.upsellXML = <data>DeluxeDownload</data>;
         super();
         this.app = app;
         this.mURLRequest = new URLRequest(app.mUpsellLink);
         this.mBackToGameButton = new CButtonWidget(this.BackToGame,this);
         this.mBackToGameButton.setDisabled(false);
         this.mBackToGameButton.visible = true;
         this.mBackToGameButton.label = app.stringManager.translateString("[UPSELL_RETURN_TO_GAME_BUTTON]");
         this.mBackToGameButton.setColor(CButtonWidget.COLOR_LABEL,Color.RGB(25 / 255,30 / 255,200 / 255));
         this.mBackToGameButton.setColor(CButtonWidget.COLOR_LABEL_HILITE,Color.RGB(100 / 255,150 / 255,240 / 255));
         var font4:FontInst = app.fontManager.getFontInst(PVZFonts.FONT_BRIANNETOD16);
         font4.scale = 0.9;
         this.mBackToGameButton.font = font4;
         this.mBackToGameButton.resize(287,358,152,37);
         this.mUpsellButton = new CButtonWidget(this.UpsellLink,this);
         this.mUpsellButton.setDisabled(false);
         this.mUpsellButton.visible = true;
         this.mUpsellButton.label = app.stringManager.translateString("[UPSELL_BUY_BUTTON]");
         this.mUpsellButton.setColor(CButtonWidget.COLOR_LABEL,Color.RGB(25 / 255,30 / 255,200 / 255));
         this.mUpsellButton.setColor(CButtonWidget.COLOR_LABEL_HILITE,Color.RGB(100 / 255,150 / 255,240 / 255));
         var font5:FontInst = app.fontManager.getFontInst(PVZFonts.FONT_BRIANNETOD16);
         font5.scale = 0.9;
         this.mUpsellButton.font = font5;
         this.mUpsellButton.resize(99,358,153,37);
         switch(theType)
         {
            case ADVENTURE:
               this.Adventure();
               break;
            case PUZZLE:
               this.Puzzle();
               break;
            case SURVIVAL:
               this.Survival();
               break;
            case MINIGAME:
               this.Minigame();
         }
         this.mType = theType;
      }
      
      public function buttonMouseMove(id:Number, x:Number, y:Number) : void
      {
      }
      
      public function buttonMouseEnter(id:Number) : void
      {
      }
      
      public function buttonDownTick(id:Number) : void
      {
      }
      
      public function buttonPress(id:Number) : void
      {
      }
      
      override public function draw(g:Graphics2D) : void
      {
         g.drawImage(this.mBackgroundImage,0,0);
      }
      
      override public function update() : void
      {
      }
      
      public function Survival() : void
      {
         this.mBackgroundImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_UPSELL3);
      }
      
      public function buttonMouseLeave(id:Number) : void
      {
      }
      
      public function Minigame() : void
      {
         this.mBackgroundImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_UPSELL2);
      }
      
      public function CloseUpsell() : void
      {
         if(this.mType == MINIGAME)
         {
            this.app.stateManager.popState();
         }
         else
         {
            this.app.stateManager.changeState(PVZApp.STATE_MAIN_MENU);
         }
      }
      
      public function Adventure() : void
      {
         this.mBackgroundImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_UPSELL1);
      }
      
      public function buttonRelease(id:Number) : void
      {
         switch(id)
         {
            case this.UpsellLink:
               this.app.adAPI.CustomEvent(this.upsellXML,this.CloseUpsell);
               if(!this.app.adAPI.enabled)
               {
                  navigateToURL(this.mURLRequest);
               }
               break;
            case this.BackToGame:
               if(this.mType == MINIGAME)
               {
                  this.app.stateManager.popState();
               }
               else
               {
                  this.app.adAPI.GameEnd();
                  this.app.stateManager.changeState(PVZApp.STATE_MAIN_MENU);
               }
         }
      }
      
      public function Puzzle() : void
      {
         this.mBackgroundImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_UPSELL4);
      }
   }
}
