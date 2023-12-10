package com.popcap.flash.games.pvz.logic
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.resources.particles.ParticleSystem;
   import com.popcap.flash.framework.resources.reanimator.Reanimation;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.PVZFoleyType;
   import com.popcap.flash.games.pvz.logic.Plants.CPlant;
   import com.popcap.flash.games.pvz.renderables.ParticleRenderable;
   import com.popcap.flash.games.pvz.resources.PVZImages;
   import com.popcap.flash.games.pvz.resources.PVZParticles;
   import flash.geom.Rectangle;
   
   public class GridItem
   {
      
      public static const GRIDITEM_GRAVESTONE:int = 1;
      
      public static const GRIDITEM_SCARY_POT:int = 2;
      
      public static const GRIDITEM_STATE_SCARY_POT_LEAF:int = 4;
      
      public static const GRIDITEM_STATE_PORTAL_CLOSED:int = 2;
      
      public static const GRIDITEM_STATE_GRAVESTONE_SPECIAL:int = 1;
      
      public static const GRIDITEM_STATE_SCARY_POT_QUESTION:int = 3;
      
      public static const GRIDITEM_STATE_SCARY_POT_ZOMBIE:int = 5;
      
      public static const GRIDITEM_STATE_NORMAL:int = 0;
      
      public static const GRIDITEM_NONE:int = 0;
       
      
      public var mScaryPotType:int;
      
      private var mGravestoneImage:ImageInst;
      
      public var mPosX:Number;
      
      public var mPosY:Number;
      
      public var mGridItemCounter:int;
      
      public var mTransparentCounter:int;
      
      public var app:PVZApp;
      
      public var mHighlighted:Boolean;
      
      public var mGridItemState:int;
      
      public var mRenderOrder:int;
      
      public var mSunCount:int;
      
      public var mGoalX:Number;
      
      public var mGoalY:Number;
      
      public var mGridItemParticle:ParticleSystem;
      
      public var mZombieType:int;
      
      private var mScaryPotImage:ImageInst;
      
      public var mSeedType:int;
      
      public var mGridItemType:int;
      
      public var mGridX:int;
      
      public var mGridY:int;
      
      public var mGridItemReanim:Reanimation;
      
      private var mGravestoneMoundsImage:ImageInst;
      
      public var mDead:Boolean;
      
      public var mBoard:Board;
      
      public function GridItem(app:PVZApp, theBoard:Board)
      {
         super();
         this.app = app;
         this.mBoard = theBoard;
         this.mGridItemType = GRIDITEM_NONE;
         this.mGridX = 0;
         this.mGridY = 0;
         this.mGridItemCounter = 0;
         this.mRenderOrder = 0;
         this.mDead = false;
         this.mPosX = 0;
         this.mPosY = 0;
         this.mGoalX = 0;
         this.mGoalY = 0;
         this.mGridItemReanim = null;
         this.mGridItemParticle = null;
         this.mZombieType = Board.ZOMBIE_INVALID;
         this.mSeedType = Board.SEED_NONE;
         this.mScaryPotType = Board.SCARYPOT_NONE;
         this.mHighlighted = false;
         this.mTransparentCounter = 0;
         this.mSunCount = 0;
         this.mScaryPotImage = app.imageManager.getImageInst(PVZImages.IMAGE_SCARY_POT);
         this.mGravestoneImage = app.imageManager.getImageInst(PVZImages.IMAGE_TOMBSTONES);
         this.mGravestoneMoundsImage = app.imageManager.getImageInst(PVZImages.IMAGE_TOMBSTONE_MOUNDS);
      }
      
      public function GridItemDie() : void
      {
         this.mDead = true;
         if(this.mGridItemReanim)
         {
            this.mGridItemReanim.mIsDead = true;
            this.mGridItemReanim = null;
         }
         if(this.mGridItemParticle)
         {
            this.mGridItemParticle.die();
            this.mGridItemParticle = null;
         }
      }
      
      public function DrawScaryPot(g:Graphics2D) : void
      {
         var aImageCol:int = this.mGridItemState;
         var aXPos:int = this.mBoard.GridToPixelX(this.mGridX,this.mGridY) - 2;
         var aYPos:int = this.mBoard.GridToPixelY(this.mGridX,this.mGridY) - 17;
         this.mScaryPotImage.frame = aImageCol;
         g.drawImage(this.mScaryPotImage,aXPos,aYPos);
         if(this.mHighlighted)
         {
            if(this.mTransparentCounter == 0)
            {
               this.mScaryPotImage.useColor = true;
               this.mScaryPotImage.setColor(196 / 255,1.5,1.5,1.5);
               g.drawImage(this.mScaryPotImage,aXPos,aYPos);
            }
         }
         else
         {
            this.mScaryPotImage.setColor(1,1,1,1);
         }
      }
      
      public function UpdateScaryPot() : void
      {
         if(this.mTransparentCounter > 0)
         {
            --this.mTransparentCounter;
         }
      }
      
      public function Draw(g:Graphics2D) : void
      {
         switch(this.mGridItemType)
         {
            case GRIDITEM_GRAVESTONE:
               this.DrawGraveStone(g);
               break;
            case GRIDITEM_SCARY_POT:
               this.DrawScaryPot(g);
         }
      }
      
      public function Update() : void
      {
         if(this.mGridItemType == GRIDITEM_SCARY_POT)
         {
            this.UpdateScaryPot();
         }
      }
      
      public function AddGraveStoneParticles() : void
      {
         var aGridCelOffsetX:int = int(this.mBoard.mGridCelOffset[this.mGridX][this.mGridY][0]);
         var aGridCelOffsetY:int = int(this.mBoard.mGridCelOffset[this.mGridX][this.mGridY][1]);
         var aXPos:int = this.mBoard.GridToPixelX(this.mGridX,this.mGridY) + aGridCelOffsetX;
         var aYPos:int = this.mBoard.GridToPixelY(this.mGridX,this.mGridY) + aGridCelOffsetY + 40;
         var anEffect:ParticleSystem = this.app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_GRAVESTONERISE);
         anEffect.setPosition(aXPos,aYPos);
         this.mBoard.mRenderManager.add(new ParticleRenderable(anEffect,Board.RENDER_LAYER_PARTICLE));
         this.app.foleyManager.playFoley(PVZFoleyType.DIRT_RISE);
      }
      
      public function DrawGraveStone(g:Graphics2D) : void
      {
         if(this.mGridItemCounter <= 0)
         {
            return;
         }
         var aHeightPosition:int = TodCommon.TodAnimateCurve(0,100,this.mGridItemCounter,1000,0,TodCommon.CURVE_EASE_IN_OUT);
         var aGridCelLook:int = int(this.mBoard.mGridCelLook[this.mGridX][this.mGridY]);
         var aGridCelOffsetX:int = int(this.mBoard.mGridCelOffset[this.mGridX][this.mGridY][0]);
         var aGridCelOffsetY:int = int(this.mBoard.mGridCelOffset[this.mGridX][this.mGridY][1]);
         var aCelWidth:int = 58;
         var aCelHeight:int = 61;
         var aGraveCol:int = aGridCelLook % 5;
         var aGraveRow:int = 0;
         if(this.mGridY == 0)
         {
            aGraveRow = 1;
         }
         else if(this.mGridItemState == GRIDITEM_STATE_GRAVESTONE_SPECIAL)
         {
            aGraveRow = 0;
         }
         else
         {
            aGraveRow = 2 + aGridCelLook % 2;
         }
         this.mGravestoneImage.frame = aGridCelLook;
         if(aGridCelLook < 14)
         {
            this.mGravestoneMoundsImage.frame = aGridCelLook + 5;
         }
         else
         {
            this.mGravestoneMoundsImage.frame = aGridCelLook;
         }
         var aVisibleHeight:int = TodCommon.TodAnimateCurve(0,1000,aHeightPosition,aCelHeight,0,TodCommon.CURVE_EASE_IN_OUT);
         var aExtraBottomClip:int = TodCommon.TodAnimateCurve(0,50,aHeightPosition,0,14,TodCommon.CURVE_EASE_IN_OUT);
         var aVisibleHeightDirt:int = TodCommon.TodAnimateCurve(500,1000,aHeightPosition,aCelHeight,0,TodCommon.CURVE_EASE_IN_OUT);
         var aTopClip:int = 0;
         var aGraveBusterPlant:CPlant = this.mBoard.GetPlantsOnLawn(this.mGridX,this.mGridY);
         if(Boolean(aGraveBusterPlant) && aGraveBusterPlant.mState == CPlant.STATE_GRAVEBUSTER_EATING)
         {
            aTopClip = TodCommon.TodAnimateCurveFloat(CPlant.GRAVE_BUSTER_EAT_TIME,0,aGraveBusterPlant.mStateCountdown,10,40,TodCommon.CURVE_LINEAR);
         }
         var aSrcRect:Rectangle = new Rectangle(aCelWidth * aGraveCol,aCelHeight * aGraveRow + aTopClip,aCelWidth,aVisibleHeight - aExtraBottomClip - aTopClip);
         var aSrcRectDirt:Rectangle = new Rectangle(aCelWidth * aGraveCol,aCelHeight * aGraveRow,aCelWidth,aVisibleHeightDirt);
         var aXPos:int = this.mBoard.GridToPixelX(this.mGridX,this.mGridY) + 2 + aGridCelOffsetX;
         var aYPos:int = this.mBoard.GridToPixelY(this.mGridX,this.mGridY) - 5 + aGridCelOffsetY;
         g.pushState();
         g.setClipRect(aXPos + this.mBoard.x,aYPos + aTopClip,53,52 - aTopClip);
         g.drawImage(this.mGravestoneImage,aXPos,aYPos + 61 - aVisibleHeight);
         g.popState();
         g.drawImage(this.mGravestoneMoundsImage,aXPos - 5,aYPos + 41);
      }
   }
}
