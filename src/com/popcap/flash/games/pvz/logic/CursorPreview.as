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
   
   public class CursorPreview extends GameObject
   {
      
      private static const SEED_SUNFLOWER:int = 1;
      
      public static const SEED_LEFTPEATER:int = 49;
      
      public static const SEED_PUFFSHROOM:int = 8;
      
      private static const PLANTING_OK:String = "ok";
      
      private static const SEED_NONE:int = -1;
      
      private static const SEED_CHERRYBOMB:int = 2;
      
      private static const LAWN_YMIN:int = 40;
      
      private static const SEED_SQUASH:int = 4;
      
      private static const SEED_PEASHOOTER:int = 0;
      
      private static const SEED_WALLNUT:int = 3;
      
      private static const SEED_REPEATER:int = 7;
      
      private static const SEED_CHOMPER:int = 6;
      
      public static const SEED_SUNSHROOM:int = 9;
      
      private static const LAWN_YMAX:int = 365;
      
      public static const SEED_FUMESHROOM:int = 10;
      
      private static const PLANTING_NOT_HERE:String = "not here";
      
      private static const LAWN_XMIN:int = 27;
      
      private static const GRIDSIZEX:int = 9;
      
      private static const VARIATION_NORMAL:String = "normal";
      
      public static const SEED_EXPLODE_O_NUT:int = 50;
      
      public static const SEED_GRAVEBUSTER:int = 11;
      
      private static const GRIDSIZEY:int = 5;
      
      private static const SEED_SNOWPEA:int = 5;
      
      private static const LAWN_XMAX:int = 513;
       
      
      public var mGridX:int;
      
      private var mSeedImages:Array;
      
      public var mGridY:int;
      
      public function CursorPreview(app:PVZApp, theBoard:Board)
      {
         this.mSeedImages = new Array();
         super();
         this.app = app;
         mBoard = theBoard;
         mX = 0;
         mY = 0;
         mWidth = 54;
         mHeight = 54;
         this.mGridX = 0;
         this.mGridY = 0;
         mVisible = false;
      }
      
      public function draw(g:Graphics2D) : void
      {
         if(!mVisible)
         {
            return;
         }
         var aPlantingSeedType:int = mBoard.GetSeedTypeInCursor();
         if(aPlantingSeedType == SEED_NONE)
         {
            return;
         }
         var anImg:ImageInst = this.mSeedImages[aPlantingSeedType];
         if(anImg == null)
         {
            anImg = this.GetPlantImage(aPlantingSeedType);
         }
         var aCenterX:Number = 28;
         var aCenterY:Number = 28;
         var aOffsetX:Number = aCenterX - anImg.width / 2;
         var aOffsetY:Number = aCenterY - anImg.height / 2;
         g.drawImage(anImg,mX + aOffsetX,mY + aOffsetY);
      }
      
      public function update() : void
      {
         var aPlantingSeedType:int = mBoard.GetSeedTypeInCursor();
         var aMouseX:int = app.widgetManager.lastMouseX;
         var aMouseY:int = app.widgetManager.lastMouseY;
         this.mGridX = mBoard.PlantingPixelToGridX(aMouseX,aMouseY,aPlantingSeedType);
         this.mGridY = mBoard.PlantingPixelToGridY(aMouseX,aMouseY,aPlantingSeedType);
         if(this.mGridX < 0 || this.mGridX >= GRIDSIZEX || this.mGridY < 0 || this.mGridY >= GRIDSIZEY)
         {
            mVisible = false;
         }
         else if(mBoard.IsPlantInCursor() && mBoard.CanPlantAt(this.mGridX,this.mGridY,aPlantingSeedType) == PLANTING_OK)
         {
            mX = mBoard.GridToPixelX(this.mGridX,this.mGridY);
            mY = mBoard.GridToPixelY(this.mGridX,this.mGridY);
            mVisible = true;
         }
         else
         {
            mVisible = false;
         }
      }
      
      private function drawBufferedSeed(seedType:Number) : ImageInst
      {
         var aPlantReanimType:String = mBoard.GetPlantDefinition(seedType);
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
            default:
               aPlantReanim.currentTrack = "anim_idle";
         }
         aPlantReanim.update();
         var aBounds:Rectangle = aPlantReanim.getBoundsForFrame();
         var aImage:ImageInst = new ImageInst(new ImageData(new BitmapData(aBounds.width,aBounds.height,true,0)));
         var bufferG:Graphics2D = new Graphics2D(aImage.pixels);
         aPlantReanim.drawLerp(bufferG,new Matrix(),0.5);
         this.mSeedImages[seedType] = aImage;
         return aImage;
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
               aPlantImg.setColor(0.5,1,64 / 255,64 / 255);
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
         aPlantImg.useColor = true;
         if(theType != SEED_EXPLODE_O_NUT)
         {
            aPlantImg.setColor(0.5,1,1,1);
         }
         this.mSeedImages[theType] = aPlantImg;
         return aPlantImg;
      }
   }
}
