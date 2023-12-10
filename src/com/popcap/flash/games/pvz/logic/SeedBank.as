package com.popcap.flash.games.pvz.logic
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.resources.fonts.FontInst;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.utils.Utils;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.renderables.StringRenderable;
   import com.popcap.flash.games.pvz.resources.PVZFonts;
   import com.popcap.flash.games.pvz.resources.PVZImages;
   import flash.geom.Rectangle;
   
   public class SeedBank extends GameObject
   {
      
      private static const CURSOR_TYPE_PLANT_FROM_BANK:int = 1;
      
      public static const SEED_PUFFSHROOM:int = 8;
      
      private static const OBJECT_TYPE_PLANT:int = 1;
      
      private static const CURSOR_TYPE_HAMMER:int = 4;
      
      public static const SEED_SUNSHROOM:int = 9;
      
      public static const CONVEYOR_PACKET_OFFSET_X:int = 48;
      
      private static const CURSOR_TYPE_PLANT_FROM_USABLE_COIN:int = 2;
      
      private static const OBJECT_TYPE_PROJECTILE:int = 2;
      
      public static const SEED_REPEATER:int = 7;
      
      private static const OBJECT_TYPE_NONE:int = 0;
      
      private static const CURSOR_TYPE_NORMAL:int = 0;
      
      public static const SEED_WALLNUT:int = 3;
      
      public static const SEED_FUMESHROOM:int = 10;
      
      public static const SEED_PEASHOOTER:int = 0;
      
      public static const SEED_EXPLODE_O_NUT:int = 50;
      
      public static const SEEDBANK_MAX:int = 10;
      
      private static const CONVEYOR_SPEED:int = 4;
      
      public static const SEED_SUNFLOWER:int = 1;
      
      public static const SEED_SNOWPEA:int = 5;
      
      private static const OBJECT_TYPE_SHOVEL:int = 5;
      
      public static const SEED_CHERRYBOMB:int = 2;
      
      public static const SEED_CHOMPER:int = 6;
      
      public static const SEED_SQUASH:int = 4;
      
      private static const OBJECT_TYPE_SEEDPACKET:int = 4;
      
      private static const CURSOR_TYPE_SHOVEL:int = 3;
      
      public static const CONVEYOR_PACKET_MIN_OFFSET:int = 40;
      
      public static const SEED_NONE:int = -1;
      
      public static const SEED_LEFTPEATER:int = 49;
      
      private static const OBJECT_TYPE_COIN:int = 3;
      
      public static const SEED_GRAVEBUSTER:int = 11;
       
      
      private var mConveyorBeltCounter:int;
      
      public var mSeedBankFont:FontInst;
      
      public var mSunText:ImageInst;
      
      public var mSeedPackets:Array;
      
      public var mSunRenderable:StringRenderable;
      
      public var mSunBounds:Rectangle;
      
      private var mCutSceneDarken:int;
      
      public var mNumPackets:int;
      
      public function SeedBank(app:PVZApp, theBoard:Board)
      {
         this.mSeedPackets = new Array();
         this.mSunBounds = new Rectangle(11,59,40,15);
         super();
         this.mSeedBankFont = app.fontManager.getFontInst(PVZFonts.FONT_CONTINUUMBOLD14);
         this.mSeedBankFont.scale = 0.8;
         mBoard = theBoard;
         this.app = app;
         if(mBoard.HasConveyorBeltSeedBank())
         {
            mWidth = 387;
         }
         else
         {
            mWidth = 401;
         }
         mHeight = 78;
         this.mNumPackets = 6;
         this.mCutSceneDarken = 255;
         this.mConveyorBeltCounter = 0;
         mVisible = true;
         var bounds:Rectangle = new Rectangle(0,0,40,15);
         this.mSunText = Utils.createStringImage(String(mBoard.mSunMoney),this.mSeedBankFont,bounds,Utils.JUSTIFY_CENTER);
         this.mSunText.useColor = true;
         this.mSunText.setColor(1,0,0,0);
      }
      
      public function MouseHitTest(x:int, y:int, theHitResult:HitResult) : Boolean
      {
         var aSeedPacket:SeedPacket = null;
         for(var i:int = 0; i < this.mNumPackets; i++)
         {
            aSeedPacket = this.mSeedPackets[i];
            if(aSeedPacket.MouseHitTest(x - mX,y - mY,theHitResult))
            {
               return true;
            }
         }
         theHitResult.mObject = null;
         theHitResult.mObjectType = OBJECT_TYPE_NONE;
         return false;
      }
      
      public function AddSeed(theSeedType:int, thePlaceOnLeft:Boolean) : void
      {
         var aSeedPacket:SeedPacket = null;
         var aPrevSeedPacket:SeedPacket = null;
         var aNextIndex:int = this.GetNumSeedsOnConveyorBelt();
         if(aNextIndex == this.mNumPackets)
         {
            return;
         }
         aSeedPacket = this.mSeedPackets[aNextIndex];
         aSeedPacket.mUpdateImage = true;
         aSeedPacket.mPacketType = theSeedType;
         aSeedPacket.mRefreshCounter = 0;
         aSeedPacket.mRefreshTime = 0;
         aSeedPacket.mRefreshing = false;
         aSeedPacket.mActive = true;
         aSeedPacket.mOffsetX = 380 - CONVEYOR_PACKET_OFFSET_X * aNextIndex;
         if(thePlaceOnLeft)
         {
            aSeedPacket.mOffsetX = 0;
         }
         if(aNextIndex > 0)
         {
            aPrevSeedPacket = this.mSeedPackets[aNextIndex - 1];
            if(aSeedPacket.mOffsetX < aPrevSeedPacket.mOffsetX)
            {
               aSeedPacket.mOffsetX = aPrevSeedPacket.mOffsetX + CONVEYOR_PACKET_MIN_OFFSET;
            }
         }
         this.mSeedPackets[aNextIndex];
      }
      
      public function Draw(g:Graphics2D) : void
      {
         var aImage:ImageInst = null;
         var aFrame:int = 0;
         var aSeedPacket:SeedPacket = null;
         var aCenterX:Number = NaN;
         var aCenterY:Number = NaN;
         var aPosX:Number = NaN;
         var aPosY:Number = NaN;
         if(!mVisible)
         {
            return;
         }
         g.pushState();
         g.translate(-mBoard.x,-mBoard.y);
         g.translate(mX,mY);
         aImage = app.imageManager.getImageInst(PVZImages.IMAGE_SEEDBANK);
         if(mBoard.HasConveyorBeltSeedBank())
         {
            aImage = app.imageManager.getImageInst(PVZImages.IMAGE_CONVEYORBELT_BACKDROP);
            g.drawImage(aImage,0,0);
            aFrame = this.mConveyorBeltCounter / CONVEYOR_SPEED % 6;
            aImage = app.imageManager.getImageInst(PVZImages.IMAGE_CONVEYORBELT);
            aImage.frame = aFrame;
            g.drawImage(aImage,5,56);
         }
         else
         {
            aImage = app.imageManager.getImageInst(PVZImages.IMAGE_SEEDBANK);
            g.drawImage(aImage,0,0);
         }
         for(var i:int = 0; i < this.mNumPackets; i++)
         {
            aSeedPacket = this.mSeedPackets[i];
            if(aSeedPacket.mPacketType != SEED_NONE)
            {
               aSeedPacket.Draw(g);
            }
         }
         if(!mBoard.HasConveyorBeltSeedBank() && this.mVisible)
         {
            this.mSunText.setColor(1,0,0,0);
            this.mSunText.useColor = true;
            if(mBoard.mOutOfMoneyCounter > 0)
            {
               if(mBoard.mOutOfMoneyCounter % 20 < 10)
               {
                  this.mSunText.setColor(1,1,0,0);
               }
            }
            aCenterX = this.mSunBounds.x + this.mSunBounds.width / 2;
            aCenterY = this.mSunBounds.y + this.mSunBounds.height / 2;
            aPosX = aCenterX - this.mSunText.width / 2;
            aPosY = aCenterY - this.mSunText.height / 2;
            g.drawImage(this.mSunText,aPosX,aPosY);
         }
         g.popState();
      }
      
      public function GetNumSeedsOnConveyorBelt() : int
      {
         var aSeedPacket:SeedPacket = null;
         for(var i:int = 0; i < this.mNumPackets; i++)
         {
            aSeedPacket = this.mSeedPackets[i];
            if(aSeedPacket.mPacketType == SEED_NONE)
            {
               return i;
            }
         }
         return this.mNumPackets;
      }
      
      public function Move(x:int, y:int) : void
      {
         mX = x;
         mY = y;
      }
      
      public function CountOfTypeOnConveyorBelt(aSeedType:int) : int
      {
         var aSeedPacket:SeedPacket = null;
         var aCount:int = 0;
         for(var i:int = 0; i < this.mNumPackets; i++)
         {
            aSeedPacket = this.mSeedPackets[i];
            if(aSeedPacket.mPacketType == aSeedType)
            {
               aCount++;
            }
         }
         return aCount;
      }
      
      public function RemoveSeed(theIndex:int) : void
      {
         var aSeedPacket:SeedPacket = null;
         var aNextSeedPacket:SeedPacket = null;
         for(var i:int = theIndex; i < this.mNumPackets; i++)
         {
            aSeedPacket = this.mSeedPackets[i];
            if(aSeedPacket.mPacketType == SEED_NONE)
            {
               break;
            }
            if(i == this.mNumPackets - 1)
            {
               aSeedPacket.mPacketType = SEED_NONE;
               aSeedPacket.mOffsetX = 0;
            }
            else
            {
               aNextSeedPacket = this.mSeedPackets[i + 1];
               aSeedPacket.mPacketType = aNextSeedPacket.mPacketType;
               aSeedPacket.mOffsetX = aNextSeedPacket.mOffsetX + CONVEYOR_PACKET_OFFSET_X;
            }
            aSeedPacket.mUpdateImage = true;
            aSeedPacket.mRefreshCounter = 0;
            aSeedPacket.mRefreshTime = 0;
            aSeedPacket.mRefreshing = false;
            aSeedPacket.mActive = true;
         }
      }
      
      public function UpdateConveyorBelt() : void
      {
         var i:int = 0;
         var aSeedPacket:SeedPacket = null;
         ++this.mConveyorBeltCounter;
         if(this.mConveyorBeltCounter % CONVEYOR_SPEED == 0)
         {
            for(i = 0; i < this.mNumPackets; i++)
            {
               aSeedPacket = this.mSeedPackets[i];
               if(aSeedPacket.mOffsetX > 0)
               {
                  aSeedPacket.mOffsetX = Math.max(aSeedPacket.mOffsetX - 1,0);
               }
            }
         }
      }
   }
}
