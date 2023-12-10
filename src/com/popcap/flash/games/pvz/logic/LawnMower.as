package com.popcap.flash.games.pvz.logic
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.resources.reanimator.Reanimation;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.PVZFoleyType;
   import com.popcap.flash.games.pvz.logic.Zombies.Zombie;
   import com.popcap.flash.games.pvz.resources.PVZReanims;
   import flash.geom.Rectangle;
   
   public class LawnMower
   {
      
      private static const PHASE_ZOMBIE_BURNED:int = 2;
      
      public static const MOWER_ROLLING_IN:int = 0;
      
      private static const PHASE_POLEVAULTER_POST_VAULT:int = 6;
      
      private static const PHASE_ZOMBIE_MOWERED:int = 3;
      
      private static const PHASE_POLEVAULTER_IN_VAULT:int = 5;
      
      public static const LAWNMOWER_LAWN:int = 0;
      
      public static const MOWER_TRIGGERED:int = 2;
      
      private static const PHASE_ZOMBIE_DYING:int = 1;
      
      public static const MOWER_SQUISHED:int = 3;
      
      public static const MOWER_READY:int = 1;
      
      private static const BOARD_WIDTH:int = 540;
      
      public static const CHOMP_TIME:int = 50;
      
      private static const PHASE_POLEVAULTER_PRE_VAULT:int = 4;
      
      private static const PHASE_ZOMBIE_NORMAL:int = 0;
       
      
      public var mChompCounter:int;
      
      public var mVisible:Boolean;
      
      public var mSquishedCounter:int;
      
      public var mLastPortalX:int;
      
      public var mPosX:Number;
      
      public var mPosY:Number;
      
      public var mReanim:Reanimation;
      
      public var mMowerHeight:int;
      
      public var mRollingInCounter:int;
      
      public var app:PVZApp;
      
      public var mAnimTicksPerFrame:int;
      
      public var mRenderOrder:int;
      
      public var mRow:int;
      
      public var mMowerType:int;
      
      public var mDead:Boolean;
      
      public var mAltitude:Number;
      
      public var mBoard:Board;
      
      public var mMowerState:int;
      
      public function LawnMower(app:PVZApp, theBoard:Board, theRow:int)
      {
         super();
         this.app = app;
         this.mBoard = theBoard;
         this.mRow = theRow;
         this.mPosX = -108;
         this.mPosY = this.mBoard.GetPosYBasedOnRow(this.mPosX + 28,theRow) + 10;
         this.mDead = false;
         this.mMowerState = MOWER_READY;
         this.mVisible = true;
         this.mChompCounter = 0;
         this.mRollingInCounter = 0;
         this.mSquishedCounter = 0;
         this.mLastPortalX = -1;
         this.mMowerType = LAWNMOWER_LAWN;
         this.mAltitude = 0;
         this.mReanim = app.reanimator.createReanimation(PVZReanims.REANIM_LAWNMOWER);
         this.mReanim.animRate = 0;
         this.mReanim.x = this.mPosX;
         this.mReanim.y = this.mPosY;
         this.mReanim.loopType = Reanimation.LOOP_TYPE_ALWAYS;
         this.mReanim.currentTrack = "anim_normal";
      }
      
      public function Draw(g:Graphics2D) : void
      {
         var aShadowImageIndex:int = 0;
         var aScaleX:Number = NaN;
         var aScaleY:Number = NaN;
         var aShadowX:Number = NaN;
         var aShadowY:Number = NaN;
         if(!this.mVisible)
         {
            return;
         }
         if(this.mMowerState != MOWER_SQUISHED)
         {
            aShadowImageIndex = 0;
            aScaleX = 1;
            aScaleY = 1;
            aShadowX = this.mPosX - 5;
            aShadowY = this.mPosY - this.mAltitude + 30;
         }
         g.pushState();
         this.mReanim.x = this.mPosX + 4;
         this.mReanim.y = this.mPosY - this.mAltitude;
         this.mReanim.draw(g);
         g.popState();
      }
      
      public function Die() : void
      {
         this.mDead = true;
      }
      
      public function StartMower() : void
      {
         if(this.mMowerState == MOWER_TRIGGERED)
         {
            return;
         }
         this.mReanim.animRate = 70;
         this.app.foleyManager.playFoley(PVZFoleyType.LAWNMOWER);
         this.mBoard.mWaveRowGotLawnMowered[this.mRow] = this.mBoard.mCurrentWave;
         ++this.mBoard.mTriggeredLawnMowers;
         this.mMowerState = MOWER_TRIGGERED;
      }
      
      public function GetLawnMowerAttackRect() : Rectangle
      {
         return new Rectangle(this.mPosX,this.mPosY,50,54);
      }
      
      public function Update() : void
      {
         var aZombie:Zombie = null;
         var LAWN_MOWER_ROLL_IN_TIME:int = 0;
         var aRowDiff:int = 0;
         var aZombieRect:Rectangle = null;
         var aOverlap:int = 0;
         var aRange:int = 0;
         if(this.mMowerState == MOWER_SQUISHED)
         {
            --this.mSquishedCounter;
            if(this.mSquishedCounter <= 0)
            {
               this.Die();
            }
            return;
         }
         if(this.mMowerState == MOWER_ROLLING_IN)
         {
            ++this.mRollingInCounter;
            LAWN_MOWER_ROLL_IN_TIME = 100;
            this.mPosX = TodCommon.TodAnimateCurveFloat(0,LAWN_MOWER_ROLL_IN_TIME,this.mRollingInCounter,-160,-21,TodCommon.CURVE_EASE_IN_OUT);
            if(this.mRollingInCounter == LAWN_MOWER_ROLL_IN_TIME)
            {
               this.mMowerState = MOWER_READY;
            }
            return;
         }
         if(this.mBoard.mGameScene != PVZApp.SCENE_PLAYING)
         {
            return;
         }
         var aAttackRect:Rectangle = this.GetLawnMowerAttackRect();
         for each(aZombie in this.mBoard.mZombies)
         {
            aRowDiff = aZombie.mRow - this.mRow;
            if(aRowDiff == 0)
            {
               if(aZombie.mZombiePhase != PHASE_ZOMBIE_MOWERED)
               {
                  aZombieRect = aZombie.GetZombieRect();
                  aOverlap = this.mBoard.GetRectOverlap(aAttackRect,aZombieRect);
                  aRange = 0;
                  if(aOverlap > aRange)
                  {
                     if(this.mMowerState == MOWER_READY)
                     {
                        if(!aZombie.mHasHead)
                        {
                           continue;
                        }
                     }
                     this.MowZombie(aZombie);
                  }
               }
            }
         }
         if(this.mMowerState != MOWER_TRIGGERED && this.mMowerState != MOWER_SQUISHED)
         {
            return;
         }
         var aSpeed:Number = 2.33;
         if(this.mChompCounter > 0)
         {
            --this.mChompCounter;
            aSpeed = TodCommon.TodAnimateCurveFloat(CHOMP_TIME,0,this.mChompCounter,aSpeed,1,TodCommon.CURVE_BOUNCE_SLOW_MIDDLE);
         }
         this.mPosX += aSpeed;
         this.mPosY = this.mBoard.GetPosYBasedOnRow(this.mPosX + 28,this.mRow) + 16;
         if(this.mPosX > BOARD_WIDTH)
         {
            this.Die();
         }
         this.mReanim.update();
      }
      
      public function MowZombie(theZombie:Zombie) : void
      {
         if(this.mMowerState == MOWER_READY)
         {
            this.StartMower();
            this.mChompCounter = CHOMP_TIME / 2;
         }
         else if(this.mMowerState == MOWER_TRIGGERED)
         {
            this.mChompCounter = CHOMP_TIME;
         }
         this.app.foleyManager.playFoley(PVZFoleyType.SPLAT);
         theZombie.MowDown();
      }
   }
}
