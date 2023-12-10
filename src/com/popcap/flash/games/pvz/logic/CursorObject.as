package com.popcap.flash.games.pvz.logic
{
   import com.popcap.flash.framework.graphics.Color;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.resources.images.ImageData;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.resources.reanimator.Reanimation;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.resources.PVZImages;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class CursorObject extends GameObject
   {
      
      public static const SEED_EXPLODE_O_NUT:int = 50;
      
      private static const CURSOR_TYPE_PLANT_FROM_BANK:int = 1;
      
      public static const SEED_PUFFSHROOM:int = 8;
      
      private static const CURSOR_TYPE_NORMAL:int = 0;
      
      private static const SEED_NONE:int = -1;
      
      private static const SEED_CHERRYBOMB:int = 2;
      
      private static const SEED_SQUASH:int = 4;
      
      private static const SEED_PEASHOOTER:int = 0;
      
      private static const CURSOR_TYPE_HAMMER:int = 4;
      
      private static const SEED_CHOMPER:int = 6;
      
      public static const SEED_SUNSHROOM:int = 9;
      
      private static const SEED_REPEATER:int = 7;
      
      private static const STATE_HOLDING_SEED:String = "holding seed";
      
      private static const CURSOR_TYPE_SHOVEL:int = 3;
      
      private static const SEED_WALLNUT:int = 3;
      
      public static const SEED_FUMESHROOM:int = 10;
      
      private static const CURSOR_TYPE_PLANT_FROM_USABLE_COIN:int = 2;
      
      private static const STATE_EMPTY:String = "empty";
      
      public static const SEED_LEFTPEATER:int = 49;
      
      private static const VARIATION_NORMAL:String = "normal";
      
      public static const SEED_GRAVEBUSTER:int = 11;
      
      private static const SEED_SUNFLOWER:int = 1;
      
      private static const SEED_SNOWPEA:int = 5;
       
      
      public var mCursorType:int;
      
      public var mType:int;
      
      private var mShovelImage:ImageInst;
      
      private var mSeedImages:Array;
      
      public var mSeedBankIndex:int;
      
      public var cursorState:String;
      
      public var mCoin:Coin;
      
      public function CursorObject(app:PVZApp, theBoard:Board)
      {
         this.mSeedImages = new Array();
         super();
         this.mCoin = null;
         this.mCursorType = CURSOR_TYPE_NORMAL;
         this.cursorState = STATE_EMPTY;
         mBoard = theBoard;
         this.app = app;
         this.mShovelImage = app.imageManager.getImageInst(PVZImages.IMAGE_SHOVEL_SMALL);
      }
      
      public function draw(g:Graphics2D) : void
      {
         var anImg:ImageInst = null;
         var aOffsetX:Number = NaN;
         var aOffsetY:Number = NaN;
         if(this.mCursorType == CURSOR_TYPE_SHOVEL)
         {
            g.blitImage(this.mShovelImage,mX,mY - 41);
         }
         else if(this.mCursorType == CURSOR_TYPE_PLANT_FROM_BANK || this.mCursorType == CURSOR_TYPE_PLANT_FROM_USABLE_COIN)
         {
            anImg = this.mSeedImages[this.mType];
            if(anImg == null)
            {
               anImg = this.GetPlantImage(this.mType);
            }
            aOffsetX = -anImg.width / 2;
            aOffsetY = -anImg.height / 2;
            g.drawImage(anImg,mX + aOffsetX,mY + aOffsetY);
         }
      }
      
      public function update() : void
      {
         mVisible = true;
         mX = app.widgetManager.lastMouseX;
         mY = app.widgetManager.lastMouseY;
      }
      
      private function GetPlantImage(theType:int) : ImageInst
      {
         var aPlantImg:ImageInst = null;
         switch(theType)
         {
            case SEED_PEASHOOTER:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_PEASHOOTERSINGLE);
               break;
            case SEED_SUNFLOWER:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_SUNFLOWER);
               break;
            case SEED_CHERRYBOMB:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_CHERRYBOMB);
               break;
            case SEED_SQUASH:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_SQUASH);
               break;
            case SEED_CHOMPER:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_CHOMPER);
               break;
            case SEED_SNOWPEA:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_SNOWPEA);
               break;
            case SEED_REPEATER:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_PEASHOOTER);
               break;
            case SEED_WALLNUT:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_WALLNUT);
               break;
            case SEED_EXPLODE_O_NUT:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_WALLNUT);
               aPlantImg.useColor = true;
               aPlantImg.setColor(1,1,64 / 255,64 / 255);
               break;
            case SEED_PUFFSHROOM:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_PUFFSHROOM);
               break;
            case SEED_SUNSHROOM:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_SUNSHROOM);
               break;
            case SEED_FUMESHROOM:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_FUMESHROOM);
               break;
            case SEED_GRAVEBUSTER:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_GRAVEDIGGER);
               break;
            case SEED_LEFTPEATER:
               aPlantImg = app.imageManager.getImageInst(PVZImages.IMAGE_LEFTFACINGPEASHOOTER);
         }
         this.mSeedImages[theType] = aPlantImg;
         return aPlantImg;
      }
      
      private function drawBufferedSeed(seedType:Number) : ImageInst
      {
         var aPlantReanimType:String = mBoard.GetPlantDefinition(seedType);
         trace(aPlantReanimType);
         var aPlantReanim:Reanimation = app.reanimator.createReanimation(aPlantReanimType);
         switch(seedType)
         {
            case SEED_PEASHOOTER:
            case SEED_REPEATER:
            case SEED_SNOWPEA:
               aPlantReanim.currentTrack = "anim_full_idle";
               break;
            case SEED_WALLNUT:
               aPlantReanim.currentTrack = "anim_idle1";
               break;
            case SEED_EXPLODE_O_NUT:
               aPlantReanim.currentTrack = "anim_idle1";
               aPlantReanim.useColor = true;
               aPlantReanim.overrideColor = Color.RGB(1,64 / 255,64 / 255);
               break;
            case SEED_PUFFSHROOM:
               break;
            default:
               aPlantReanim.currentTrack = "anim_idle";
         }
         aPlantReanim.update();
         var aBounds:Rectangle = aPlantReanim.getBoundsForFrame();
         var aImage:ImageInst = new ImageInst(new ImageData(new BitmapData(aBounds.width,aBounds.height,true,0)));
         var bufferG:Graphics2D = new Graphics2D(aImage.pixels);
         aPlantReanim.drawLerp(bufferG,new Matrix());
         this.mSeedImages[seedType] = aImage;
         return aImage;
      }
   }
}
