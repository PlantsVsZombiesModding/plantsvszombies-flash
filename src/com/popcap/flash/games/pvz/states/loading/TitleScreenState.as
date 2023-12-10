package com.popcap.flash.games.pvz.states.loading
{
   import com.popcap.flash.framework.graphics.Color;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.resources.fonts.FontInst;
   import com.popcap.flash.framework.resources.fonts.TXTFontDescriptor;
   import com.popcap.flash.framework.resources.images.ImageDescriptor;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.resources.reanimator.Reanimation;
   import com.popcap.flash.framework.resources.reanimator.XMLReanimDescriptor;
   import com.popcap.flash.framework.states.IState;
   import com.popcap.flash.framework.widgets.ui.CButtonWidget;
   import com.popcap.flash.framework.widgets.ui.IButtonListener;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.resources.PVZImages;
   import com.popcap.flash.games.pvz.resources.PVZReanims;
   import flash.geom.Matrix;
   import flash.utils.ByteArray;
   import com.popcap.flash.games.pvz.resources.PVZResources;
   
   public class TitleScreenState implements IState, IButtonListener
   {
      
      private static const IMAGE_REANIM_SPROUT_PETAL_CLASS:Class = TitleScreenState_IMAGE_REANIM_SPROUT_PETAL_CLASS;
      
      private static const IMAGE_REANIM_SPROUT_BODY_CLASS:Class = TitleScreenState_IMAGE_REANIM_SPROUT_BODY_CLASS;
      
      private static const IMAGE_REANIM_POTATOMINE_ROCK1_CLASS:Class = TitleScreenState_IMAGE_REANIM_POTATOMINE_ROCK1_CLASS;
      
      private static const IMAGE_REANIM_POTATOMINE_ROCK3_CLASS:Class = TitleScreenState_IMAGE_REANIM_POTATOMINE_ROCK3_CLASS;
      
      private static const IMAGE_REANIM_ZOMBIE_HEAD_CLASS:Class = TitleScreenState_IMAGE_REANIM_ZOMBIE_HEAD_CLASS;
      
      private static const MINIMUM_LOAD_TIME:int = 300;
      
      private static const IMAGE_REANIM_ZOMBIE_HAIR_CLASS:Class = TitleScreenState_IMAGE_REANIM_ZOMBIE_HAIR_CLASS;
      
      private static const IMAGE_REANIM_ZOMBIE_JAW_CLASS:Class = TitleScreenState_IMAGE_REANIM_ZOMBIE_JAW_CLASS;
       
      
      private const TITLESCREEN_CLASS:Class = TitleScreenState_TITLESCREEN_CLASS;
      
      private var currentBarWidth:Number = 0;
      
      private var loadingComplete:Boolean = false;
      
      private var app:PVZApp;
      
      private const BRIANNETOD16_IMAGE_CLASS:Class = TitleScreenState_BRIANNETOD16_IMAGE_CLASS;
      
      private const LOADBAR_ZOMBIE_REANIM_CLASS:Class = TitleScreenState_LOADBAR_ZOMBIE_REANIM_CLASS;
      
      private var progress:Number = 0;
      
      private var reanims:Array;
      
      private const LOADBAR_SPROUT_REANIM_CLASS:Class = TitleScreenState_LOADBAR_SPROUT_REANIM_CLASS;
      
      private var startButton:CButtonWidget;
      
      private var loaderDirt:ImageInst;
      
      private var triggerPoints:Array;
      
      private var pvzLogoImg:ImageInst;
      
      private const SODROLLCAP_CLASS:Class = TitleScreenState_SODROLLCAP_CLASS;
      
      private var loadbarGrass:ImageInst;
      
      private var titleImg:ImageInst;
      
      private const PVZ_LOGO_CLASS:Class = TitleScreenState_PVZ_LOGO_CLASS;
      
      private var imgSodrollcap:ImageInst;
      
      private const LOADBAR_DIRT_CLASS:Class = TitleScreenState_LOADBAR_DIRT_CLASS;
      
      private const BRIANNETOD16_FONT_CLASS:Class = TitleScreenState_BRIANNETOD16_FONT_CLASS;
      
      private var progressCapCounter:Number = 0;
      
      private var sproutTransforms:Array;
      
      private var progressCap:Number = 0;
      
      private var totalBarWidth:Number = 314;
      
      private var triggerId:Number = 0;
      
      private var largeStartButton:CButtonWidget;
      
      private const LOADBAR_GRASS_CLASS:Class = TitleScreenState_LOADBAR_GRASS_CLASS;
      
      public function TitleScreenState(app:PVZApp)
      {
         this.sproutTransforms = new Array();
         super();
         this.app = app;
         this.reanims = new Array();
         this.startButton = new CButtonWidget(0,this);
         this.startButton.setDisabled(true);
         this.startButton.visible = false;
         this.largeStartButton = new CButtonWidget(0,this);
         this.largeStartButton.setDisabled(true);
         this.largeStartButton.visible = false;
         this.triggerPoints = new Array(0.11,0.32,0.54,0.72,0.906);
      }
      
      public function buttonMouseEnter(id:Number) : void
      {
      }
      
      public function onPop() : void
      {
      }
      
      public function buttonMouseMove(id:Number, x:Number, y:Number) : void
      {
      }
      
      public function onPush() : void
      {
      }
      
      public function onExit() : void
      {
         this.app.widgetManager.removeAllWidgets(true);
      }
      
      public function buttonPress(id:Number) : void
      {
      }
      
      public function onEnter() : void
      {
         var aByteArray:ByteArray = null;
         this.app.imageManager.addDescriptor(PVZImages.IMAGE_TITLESCREEN,new ImageDescriptor(this.TITLESCREEN_CLASS));
         this.app.imageManager.addDescriptor("IMAGE_PVZ_LOGO",new ImageDescriptor(this.PVZ_LOGO_CLASS));
         this.app.imageManager.addDescriptor("IMAGE_LOADBAR_DIRT",new ImageDescriptor(this.LOADBAR_DIRT_CLASS));
         this.app.imageManager.addDescriptor("IMAGE_LOADBAR_GRASS",new ImageDescriptor(this.LOADBAR_GRASS_CLASS));
         this.app.imageManager.addDescriptor("IMAGE_REANIM_SODROLLCAP",new ImageDescriptor(this.SODROLLCAP_CLASS));
         this.app.imageManager.addDescriptor("IMAGE_REANIM_POTATOMINE_ROCK1",new ImageDescriptor(IMAGE_REANIM_POTATOMINE_ROCK1_CLASS));
         this.app.imageManager.addDescriptor("IMAGE_REANIM_POTATOMINE_ROCK3",new ImageDescriptor(IMAGE_REANIM_POTATOMINE_ROCK3_CLASS));
         this.app.imageManager.addDescriptor("IMAGE_REANIM_SPROUT_BODY",new ImageDescriptor(IMAGE_REANIM_SPROUT_BODY_CLASS));
         this.app.imageManager.addDescriptor("IMAGE_REANIM_SPROUT_PETAL",new ImageDescriptor(IMAGE_REANIM_SPROUT_PETAL_CLASS));
         this.app.imageManager.addDescriptor("IMAGE_REANIM_ZOMBIE_HEAD",new ImageDescriptor(IMAGE_REANIM_ZOMBIE_HEAD_CLASS));
         this.app.imageManager.addDescriptor("IMAGE_REANIM_ZOMBIE_HAIR",new ImageDescriptor(IMAGE_REANIM_ZOMBIE_HAIR_CLASS));
         this.app.imageManager.addDescriptor("IMAGE_REANIM_ZOMBIE_JAW",new ImageDescriptor(IMAGE_REANIM_ZOMBIE_JAW_CLASS));
         this.app.fontManager.addDescriptor("FONT_BRIANNETOD16",new TXTFontDescriptor(this.BRIANNETOD16_FONT_CLASS,[this.BRIANNETOD16_IMAGE_CLASS]));
         aByteArray = new this.LOADBAR_SPROUT_REANIM_CLASS() as ByteArray;
         this.app.reanimator.loadReanim(PVZReanims.REANIM_LOADBAR_SPROUT,new XMLReanimDescriptor(aByteArray));
         aByteArray = new this.LOADBAR_ZOMBIE_REANIM_CLASS() as ByteArray;
         this.app.reanimator.loadReanim(PVZReanims.REANIM_LOADBAR_ZOMBIEHEAD,new XMLReanimDescriptor(aByteArray));
         this.titleImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_TITLESCREEN);
         this.pvzLogoImg = this.app.imageManager.getImageInst(PVZImages.IMAGE_PVZ_LOGO);
         this.loaderDirt = this.app.imageManager.getImageInst(PVZImages.IMAGE_LOADBAR_DIRT);
         this.loadbarGrass = this.app.imageManager.getImageInst(PVZImages.IMAGE_LOADBAR_GRASS);
         this.imgSodrollcap = this.app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_SODROLLCAP);
         this.totalBarWidth = 0.3925 * this.app.appWidth;
         this.startButton.label = this.app.stringManager.translateString("[LOADING]");
         this.startButton.setColor(CButtonWidget.COLOR_LABEL,Color.RGB(218 / 255,184 / 255,33 / 255));
         this.startButton.setColor(CButtonWidget.COLOR_LABEL_HILITE,Color.RGB(1,0,0));
         var font:FontInst = this.app.fontManager.getFontInst("FONT_BRIANNETOD16");
         font.scale = 0.675;
         this.startButton.font = font;
         this.startButton.resize(0.3 * this.app.screenWidth,0.9 * this.app.screenHeight,this.totalBarWidth,0.0833 * this.app.appHeight);
         this.startButton.visible = true;
         this.largeStartButton.resize(0,0,this.app.screenWidth,this.app.screenHeight);
         this.app.widgetManager.addWidget(this.startButton);
         this.app.resourceManager.loadResourceLibrary("resources.swf");
		 //PVZApp.mPVZResources = new PVZResources();
      }
      
      public function update() : void
      {
         var reanim:Reanimation = null;
         var reanimType:String = null;
         var reanimTrack:String = null;
         var x:Number = NaN;
         var y:Number = NaN;
         var newReanim:Reanimation = null;
         var matrix:Matrix = null;
         for each(reanim in this.reanims)
         {
            reanim.update();
         }
         if(this.loadingComplete)
         {
            return;
         }
         ++this.progressCapCounter;
         this.progressCap = this.progressCapCounter / MINIMUM_LOAD_TIME;
         var loadingProgress:Number = this.app.resourceManager.getPercentageLoaded();
         this.app.adAPI.setLoadPercent(int(loadingProgress * 100));
         this.progress = Math.min(this.progressCap,loadingProgress);
         this.currentBarWidth = this.progress * this.totalBarWidth;
         if(!this.loadingComplete && this.progress >= 1)
         {
            this.loadingComplete = true;
            this.startButton.setDisabled(false);
            this.largeStartButton.setDisabled(false);
            this.largeStartButton.setVisible(true);
            this.startButton.label = this.app.stringManager.translateString("[CLICK_TO_START]");
         }
         var remaining:Array = new Array();
         var numPoints:int = int(this.triggerPoints.length);
         for(var i:int = 0; i < numPoints; i++)
         {
            if(this.triggerPoints[i] > this.progress)
            {
               remaining.push(this.triggerPoints[i]);
            }
            else
            {
               reanimType = PVZReanims.REANIM_LOADBAR_SPROUT;
               reanimTrack = "anim_sprout";
               if(i == this.triggerPoints.length - 1)
               {
                  reanimType = PVZReanims.REANIM_LOADBAR_ZOMBIEHEAD;
                  reanimTrack = "anim_zombie";
               }
               x = 225 * 0.675 + this.triggerPoints[i] * this.totalBarWidth;
               y = 511 * 0.675;
               newReanim = this.app.reanimator.createReanimation(reanimType);
               newReanim.x = x;
               newReanim.y = y;
               newReanim.currentTrack = reanimTrack;
               newReanim.loopType = Reanimation.LOOP_TYPE_ONCE_AND_HOLD;
               newReanim.animRate = 18;
               matrix = new Matrix();
               if(this.triggerId == 1 || this.triggerId == 3)
               {
                  matrix.scale(-1,1);
               }
               else if(this.triggerId == 2)
               {
                  matrix.translate(0,-5);
                  matrix.scale(1.1,1.3);
               }
               else if(this.triggerId == 4)
               {
                  matrix.translate(-20,0);
               }
               this.reanims.push(newReanim);
               this.sproutTransforms[this.reanims.length - 1] = matrix;
               ++this.triggerId;
            }
         }
         this.triggerPoints = remaining;
      }
      
      public function draw(g:Graphics2D) : void
      {
         var reanim:Reanimation = null;
         var rollLength:Number = NaN;
         var rotation:Number = NaN;
         var scale:Number = NaN;
         var matrix:Matrix = null;
         g.blitImage(this.titleImg);
         g.blitImage(this.pvzLogoImg,50 * 0.675,30 * 0.675);
         var aBarX:Number = 240;
         var aBarY:Number = 0.9 * 600 - 17;
         g.pushState();
         g.translate((aBarX + 4) * 0.675,(aBarY + 18) * 0.675);
         g.drawImage(this.loaderDirt,0,0);
         g.popState();
         if(this.currentBarWidth >= this.totalBarWidth)
         {
            g.pushState();
            g.translate(aBarX * 0.675,aBarY * 0.675);
            g.drawImage(this.loadbarGrass,0,0);
            g.popState();
         }
         else
         {
            g.pushState();
            g.setClipRect(aBarX * 0.675,aBarY * 0.675,this.currentBarWidth,this.loadbarGrass.height);
            g.translate(aBarX * 0.675,aBarY * 0.675);
            g.drawImage(this.loadbarGrass,0,0);
            g.translate(-aBarX,-aBarY);
            g.popState();
         }
         for(var i:Number = 0; i < this.reanims.length; i++)
         {
            reanim = this.reanims[i];
            reanim.drawLerp(g,this.sproutTransforms[i]);
         }
         if(this.currentBarWidth < this.totalBarWidth)
         {
            rollLength = this.currentBarWidth * 0.94;
            rotation = 2 * rollLength / 180 * Math.PI;
            scale = 1 - this.currentBarWidth / this.totalBarWidth / 2;
            matrix = new Matrix();
            matrix.translate(-this.imgSodrollcap.width / 2,-this.imgSodrollcap.height / 2);
            matrix.rotate(rotation);
            matrix.scale(scale,scale);
            matrix.translate(aBarX * 0.675 + rollLength + 11 * 0.675,(aBarY - 3 - 35 * scale + 35) * 0.675);
            g.pushState();
            g.setTransform(matrix);
            g.drawImage(this.imgSodrollcap,0,0);
            g.popState();
         }
         g.reset();
         this.app.widgetManager.drawScreen(g);
      }
      
      public function buttonMouseLeave(id:Number) : void
      {
      }
      
      public function buttonDownTick(id:Number) : void
      {
      }
      
      public function buttonRelease(id:Number) : void
      {
         this.startButton.setDisabled(true);
         this.largeStartButton.setDisabled(true);
         this.app.adAPI.SessionReady(this.StartSession);
      }
      
      private function StartSession() : void
      {
         this.app.stateManager.changeState(PVZApp.STATE_MAIN_MENU);
      }
   }
}
