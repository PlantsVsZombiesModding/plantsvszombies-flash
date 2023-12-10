package com.popcap.flash.games.pvz.logic.Zombies
{
   import com.popcap.flash.framework.graphics.Color;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.resources.particles.ParticleSystem;
   import com.popcap.flash.framework.resources.reanimator.ReanimLoopType;
   import com.popcap.flash.framework.resources.reanimator.Reanimation;
   import com.popcap.flash.framework.resources.reanimator.looptypes.ReanimLoopQueue;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.PVZFoleyType;
   import com.popcap.flash.games.pvz.logic.Board;
   import com.popcap.flash.games.pvz.logic.GameObject;
   import com.popcap.flash.games.pvz.logic.MessageWidget;
   import com.popcap.flash.games.pvz.logic.Plants.CPlant;
   import com.popcap.flash.games.pvz.logic.TodCommon;
   import com.popcap.flash.games.pvz.renderables.ParticleRenderable;
   import com.popcap.flash.games.pvz.renderables.ReanimationRenderable;
   import com.popcap.flash.games.pvz.resources.PVZImages;
   import com.popcap.flash.games.pvz.resources.PVZParticles;
   import com.popcap.flash.games.pvz.resources.PVZReanims;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class Zombie extends GameObject
   {
      
      private static const GRIDSIZEX:int = 9;
      
      public static const SEED_PUFFSHROOM:int = 8;
      
      private static const COIN_MOTION_COIN:String = "coin";
      
      private static const HEIGHT_ZOMBIE_NORMAL:int = 0;
      
      private static const PHASE_ZOMBIE_BURNED:int = 2;
      
      public static const SEED_PEASHOOTER:int = 0;
      
      private static const DAMAGE_HITS_SHIELD_AND_BODY:int = 1;
      
      private static const CLIP_HEIGHT_LIMIT:Number = -67.5;
      
      private static const ATTACKTYPE_VAULT:int = 1;
      
      public static var mScratchPosition:ZombieDrawPosition = new ZombieDrawPosition();
      
      private static const PHASE_ZOMBIE_DYING:int = 1;
      
      private static const DAMAGE_SPIKE:int = 5;
      
      public static const ZOMBIE_NORMAL:int = 0;
      
      public static const ZOMBIE_WAVE_DEBUG:int = -1;
      
      public static const ZOMBIE_DOOR:int = 6;
      
      private static const LAWN_XMIN:int = 40;
      
      private static const SCENE_CHALLENGE:int = 7;
      
      public static const SEED_EXPLODE_O_NUT:int = 50;
      
      private static const COIN_NONE:String = "none";
      
      public static const SEED_SUNFLOWER:int = 1;
      
      private static const SCENE_PLAYING:int = 3;
      
      private static const PHASE_ZOMBIE_NORMAL:int = 0;
      
      private static const LAWN_XMAX:int = 760;
      
      private static const SCENE_CREDIT:int = 6;
      
      public static const SEED_NONE:int = -1;
      
      private static const SCENE_LOADING:int = 0;
      
      public static const SEED_CHOMPER:int = 6;
      
      public static const ZOMBIE_PAIL:int = 4;
      
      private static const HEIGHT_FALLING:int = 1;
      
      public static const SEED_CHERRYBOMB:int = 2;
      
      private static const SHIELDTYPE_DOOR:int = 1;
      
      private static const SCENE_MENU:int = 1;
      
      private static const COIN_SHOVEL:String = "shovel";
      
      private static const TICKS_BETWEEN_EATS:int = 4;
      
      private static const HELMTYPE_PAIL:int = 2;
      
      private static const SCENE_LEVEL_INTRO:int = 2;
      
      private static const HELMTYPE_FOOTBALL:int = 3;
      
      private static const SHIELDTYPE_NEWSPAPER:int = 2;
      
      public static const ZOMBIE_FOOTBALL:int = 7;
      
      private static const gChilledColor:Color = Color.ARGB(1,0.29,0.29,1);
      
      private static const DAMAGE_BYPASSES_SHIELD:int = 0;
      
      private static const DAMAGE_FREEZE:int = 2;
      
      private static const COIN_MOTION_FROM_PLANT:String = "from plant";
      
      private static const ATTACKTYPE_CHEW:int = 0;
      
      private static const COIN_FINAL_SEED_PACKET:String = "finalseedpacket";
      
      public static const ZOMBIE_WAVE_UI:int = -3;
      
      private static const CHILLED_SPEED_FACTOR:Number = 0.4;
      
      private static const CLIP_HEIGHT_OFF:Number = -135;
      
      private static const COIN_PRESENT_PLANT:String = "presentplant";
      
      private static const PHASE_NEWSPAPER_MAD:int = 9;
      
      public static const SEED_SUNSHROOM:int = 9;
      
      private static const LAWN_YMIN:int = 80;
      
      private static const PHASE_POLEVAULTER_IN_VAULT:int = 5;
      
      public static const SEED_WALLNUT:int = 3;
      
      public static const SEED_REPEATER:int = 7;
      
      public static const ZOMBIE_NEWSPAPER:int = 5;
      
      public static const SEED_FUMESHROOM:int = 10;
      
      private static const HELMTYPE_NONE:int = 0;
      
      private static const COIN_MOTION_FROM_SKY:String = "from sky";
      
      private static const SCENE_AWARD:int = 5;
      
      private static const COIN_SUN:String = "sun";
      
      public static const ZOMBIE_WAVE_WINNER:int = -4;
      
      private static const COIN_MOTION_FROM_SKY_SLOW:String = "from sky slow";
      
      private static const HELMTYPE_TRAFFIC_CONE:int = 1;
      
      public static const ZOMBIE_WAVE_CUTSCENE:int = -2;
      
      private static const DAMAGE_DOESNT_LEAVE_BODY:int = 4;
      
      public static const SEED_SNOWPEA:int = 5;
      
      private static const COIN_USABLE_SEED_PACKET:String = "usableseedpacket";
      
      public static const ZOMBIE_INVALID:int = -1;
      
      private static const PHASE_POLEVAULTER_PRE_VAULT:int = 4;
      
      private static const PHASE_NEWSPAPER_READING:int = 7;
      
      public static const ZOMBIE_TRAFFIC_CONE:int = 2;
      
      private static const BOARD_HEIGHT:int = 405;
      
      private static const LAWN_YMAX:int = 620;
      
      public static const SEED_SQUASH:int = 4;
      
      private static const PHASE_POLEVAULTER_POST_VAULT:int = 6;
      
      private static const SCENE_ZOMBIES_WON:int = 4;
      
      private static const PHASE_ZOMBIE_MOWERED:int = 3;
      
      private static const PHASE_NEWSPAPER_MADDENING:int = 8;
      
      private static const COIN_NOTE:String = "note";
      
      private static const SHIELDTYPE_NONE:int = 0;
      
      public static const ZOMBIE_FLAG:int = 1;
      
      private static const PHASE_RISING_FROM_GRAVE:int = 10;
      
      public static const SEED_LEFTPEATER:int = 49;
      
      private static const BOARD_WIDTH:int = 540;
      
      public static const ZOMBIE_POLEVAULTER:int = 3;
      
      private static const DAMAGE_DOESNT_CAUSE_FLASH:int = 3;
      
      private static const GRIDSIZEY:int = 5;
      
      public static const SEED_GRAVEBUSTER:int = 11;
       
      
      public var mZombieHeight:int;
      
      public var mAnimCounter:int;
      
      public var mZombieFade:int;
      
      public var mOnHighGround:Boolean;
      
      private var scratchDrawPos:ZombieDrawPosition;
      
      public var mFlatTires:Boolean;
      
      public var mAltitude:Number;
      
      public var mButteredCounter:int;
      
      public var mShieldHealth:int;
      
      public var mHasArm:Boolean;
      
      public var mTargetCol:int;
      
      public var mZombiePhase:int;
      
      private var mArmParticle:ParticleSystem;
      
      public var mShieldJustGotShotCounter:int;
      
      public var mVelX:Number;
      
      public var mIceTrapCounter:int;
      
      public var mVelZ:Number;
      
      public var mAnimFrames:int;
      
      public var mHasHead:Boolean;
      
      public var mSummonCounter:int;
      
      public var mDead:Boolean;
      
      private var mHitRectUpdated:Boolean = false;
      
      public var mYuckyFace:Boolean;
      
      public var mHasObject:Boolean;
      
      public var mPosX:Number;
      
      public var mPosY:Number;
      
      public var mParticleOffsetY:int;
      
      public var mShieldType:int;
      
      public var mParticleOffsetX:int;
      
      public var mZombieType:int;
      
      public var mJustGotShotCounter:int;
      
      public var mFlyingHealth:int;
      
      public var mIsEating:Boolean;
      
      public var mFlyingMaxHealth:int;
      
      public var mBodyHealth:int;
      
      private var mHelmParticle:ParticleSystem;
      
      public var mFrame:int;
      
      public var mZombieAge:int;
      
      public var mPrevFrame:int;
      
      public var mPhaseCounter:int;
      
      public var mHelmType:int;
      
      private var mFlagParticle:ParticleSystem;
      
      public var mUseLadderCol:int;
      
      public var mHitUmbrella:Boolean;
      
      public var mMindControlled:Boolean;
      
      public var mFromWave:int;
      
      public var mShieldMaxHealth:int;
      
      public var mBodyReanim:Reanimation;
      
      public var mVariant:Boolean;
      
      public var mBlowingAway:Boolean;
      
      public var mScaleZombie:Number;
      
      public var mAnimTicksPerFrame:int;
      
      public var mZombieRect:Rectangle;
      
      public var mOrginalAnimRate:Number;
      
      public var mAttachment:Reanimation;
      
      public var mChilledCounter:int;
      
      public var mHelmHealth:int;
      
      private var mOverrideColor:Color;
      
      private var mAdditiveColor:Color;
      
      private var mHeadParticle:ParticleSystem;
      
      public var mZombieAttackRect:Rectangle;
      
      private var mZombieHitRect:Rectangle;
      
      public var mInPool:Boolean;
      
      public var mPlayingSong:Boolean;
      
      public var mGroanCounter:int;
      
      public var mShieldRecoilCounter:int;
      
      public var mHelmMaxHealth:int;
      
      public var mDroppedLoot:Boolean;
      
      private var mScratchMatrix:Matrix;
      
      public var mBodyMaxHealth:int;
      
      public function Zombie()
      {
         this.mOverrideColor = Color.ARGB(1,1,1,1);
         this.mAdditiveColor = Color.ARGB(1,0,0,0);
         this.scratchDrawPos = new ZombieDrawPosition();
         this.mScratchMatrix = new Matrix();
         this.mZombieHitRect = new Rectangle();
         super();
      }
      
      public function CheckForBoardEdge() : void
      {
         var velocity:Number = NaN;
         var aWinPos:int = -50;
         if(this.mZombieType == ZOMBIE_POLEVAULTER)
         {
            aWinPos = -75;
         }
         else if(this.mZombieType == ZOMBIE_FOOTBALL)
         {
            aWinPos = -100;
         }
         if(mX <= aWinPos && this.mHasHead)
         {
            velocity = this.mBodyReanim.getTrackVelocity("_ground",true);
            this.mPosX = -95;
            mBoard.ZombiesWon(this);
         }
         if(mX <= aWinPos + 35 && !this.mHasHead)
         {
            this.TakeDamage(1800,DAMAGE_DOESNT_CAUSE_FLASH);
         }
      }
      
      public function UpdateZombieWalking() : void
      {
         var aSpeed:Number = NaN;
         var anEffect:ParticleSystem = null;
         if(this.ZombieNotWalking())
         {
            return;
         }
         if(this.mZombiePhase == PHASE_POLEVAULTER_IN_VAULT)
         {
            aSpeed = this.mVelX;
         }
         else if(this.mBodyReanim != null)
         {
            aSpeed = this.mBodyReanim.getTrackVelocity("_ground");
         }
         this.mPosX -= aSpeed;
         if(this.mZombiePhase == PHASE_POLEVAULTER_PRE_VAULT)
         {
            if(this.mBodyReanim.shouldTriggerTimedEvent(0.16))
            {
            }
            if(this.mBodyReanim.shouldTriggerTimedEvent(0.67))
            {
            }
         }
         if(this.mZombieType == ZOMBIE_FOOTBALL && this.mFromWave != ZOMBIE_WAVE_WINNER)
         {
            if(this.mBodyReanim.shouldTriggerTimedEvent(0.03))
            {
            }
            if(this.mBodyReanim.shouldTriggerTimedEvent(0.61))
            {
            }
         }
      }
      
      public function ZombieNotWalking() : Boolean
      {
         if(this.mIsEating)
         {
            return true;
         }
         if(this.mZombiePhase == PHASE_NEWSPAPER_MADDENING)
         {
            return true;
         }
         return false;
      }
      
      public function EatPlant(thePlant:CPlant) : void
      {
         if(thePlant.mSeedType == CPlant.SEED_CHERRYBOMB || thePlant.mSeedType == CPlant.SEED_SQUASH)
         {
            return;
         }
         this.StartEating();
         var aTriggerSpecial:Boolean = false;
         if(aTriggerSpecial)
         {
            thePlant.DoSpecial();
            return;
         }
         if(this.mChilledCounter > 0 && this.mZombieAge % 2 == 1)
         {
            this.mBodyReanim.animRate *= 0.5;
            return;
         }
         thePlant.mPlantHealth -= TICKS_BETWEEN_EATS;
         thePlant.mRecentlyEatenCountdown = 50;
         if(thePlant.mPlantHealth <= 0)
         {
            app.foleyManager.playFoley(PVZFoleyType.GULP);
            thePlant.Die();
            if(mBoard.mLevel >= 2 && mBoard.mLevel <= 4 && thePlant.mPlantCol > 4 && mBoard.mPlants.length < 15 && thePlant.mSeedType == SEED_PEASHOOTER)
            {
               mBoard.DisplayAdvice("[ADVICE_PEASHOOTER_DIED]",MessageWidget.MESSAGE_STYLE_HINT_TALL_FAST,Board.ADVICE_PEASHOOTER_DIED);
            }
         }
      }
      
      public function AttachShield() : void
      {
         var aAttachTrack:String = null;
         if(this.mShieldType == SHIELDTYPE_DOOR)
         {
            this.ShowDoorArms(true);
            this.mBodyReanim.setTrackVisible("Zombie_outerarm_screendoor",true);
            aAttachTrack = "anim_screendoor1";
         }
         else if(this.mShieldType == SHIELDTYPE_NEWSPAPER)
         {
            this.mBodyReanim.setTrackVisible("Zombie_paper_hands",true);
            this.mBodyReanim.setTrackVisible("Zombie_paper_paper2",false);
            this.mBodyReanim.setTrackVisible("Zombie_paper_paper3",false);
            aAttachTrack = "Zombie_paper_paper1";
         }
         this.mBodyReanim.setTrackVisible(aAttachTrack,true);
      }
      
      public function ApplyBurn() : void
      {
         var aCharredPosX:Number = NaN;
         var aCharredPosY:Number = NaN;
         var aCharredReanim:Reanimation = null;
         if(this.mDead || this.mZombiePhase == PHASE_ZOMBIE_BURNED)
         {
            return;
         }
         if(this.mZombieType == ZOMBIE_FOOTBALL && this.mHelmHealth >= 1800)
         {
            this.TakeDamage(1800,DAMAGE_HITS_SHIELD_AND_BODY);
            return;
         }
         if(this.mZombiePhase == PHASE_ZOMBIE_DYING || this.mZombiePhase == PHASE_POLEVAULTER_IN_VAULT)
         {
            this.DieWithLoot();
         }
         else
         {
            aCharredPosX = this.mPosX;
            aCharredPosY = this.mPosY - 8;
            aCharredReanim = app.reanimator.createReanimation("REANIM_ZOMBIE_CHARRED");
            aCharredReanim.currentTrack = "anim_crumble";
            aCharredReanim.loopType = Reanimation.LOOP_TYPE_ONCE_AND_DIE;
            aCharredReanim.x = aCharredPosX;
            aCharredReanim.y = aCharredPosY;
            aCharredReanim.animRate = 15;
            mBoard.mRenderManager.add(new ReanimationRenderable(aCharredReanim,RENDER_LAYER_ZOMBIE + mRow));
            this.DieWithLoot();
         }
      }
      
      public function FindPlantTarget(theAttackType:int) : CPlant
      {
         var aPlant:CPlant = null;
         var aPlantRect:Rectangle = null;
         var aOverlap:int = 0;
         var aAttackRect:Rectangle = this.GetZombieAttackRect();
         for each(aPlant in mBoard.mPlants)
         {
            if(mRow == aPlant.mRow)
            {
               aPlantRect = aPlant.GetPlantRect();
               aOverlap = mBoard.GetRectOverlap(aAttackRect,aPlantRect);
               if(aOverlap >= 20)
               {
                  if(this.CanTargetPlant(aPlant,theAttackType))
                  {
                     return aPlant;
                  }
               }
            }
         }
         return null;
      }
      
      public function IsImmobilizied() : Boolean
      {
         return false;
      }
      
      public function StopEating() : void
      {
         if(!this.mIsEating)
         {
            return;
         }
         this.mIsEating = false;
         this.StartWalkAnim(20);
         this.UpdateAnimSpeed();
      }
      
      public function SetupDrawZombieWon(g:Graphics2D) : Boolean
      {
         if(this.mFromWave != ZOMBIE_WAVE_WINNER)
         {
            return true;
         }
         if(!mBoard.mShowZombieWalking)
         {
            return false;
         }
         g.setClipRect(-85 - mX,0 - mY,540,405);
         return true;
      }
      
      public function PickRandomSpeed() : void
      {
         this.mVelX = TodCommon.RandRangeFloat(0.23,0.37);
         if(this.mZombiePhase == PHASE_NEWSPAPER_MAD)
         {
            this.mVelX = TodCommon.RandRangeFloat(0.89,0.91);
         }
         else if(this.mZombiePhase == PHASE_POLEVAULTER_PRE_VAULT)
         {
            this.mVelX = TodCommon.RandRangeFloat(0.66,0.68);
         }
         else if(this.mZombieType == ZOMBIE_FOOTBALL)
         {
            this.mVelX = TodCommon.RandRangeFloat(0.66,0.68);
         }
         else if(this.mZombieType == ZOMBIE_FLAG)
         {
            this.mVelX = 0.45;
         }
         else if(this.mVelX < 0.3)
         {
            this.mAnimTicksPerFrame = 12;
         }
         else
         {
            this.mAnimTicksPerFrame = 15;
         }
         this.UpdateAnimSpeed();
      }
      
      public function TakeHelmDamage(theDamage:int, theDamageFlags:int) : int
      {
         if(theDamageFlags != DAMAGE_DOESNT_CAUSE_FLASH)
         {
            this.mJustGotShotCounter = 25;
         }
         var aOldIndex:int = this.GetHelmDamageIndex();
         var aDamageApplied:int = Math.min(this.mHelmHealth,theDamage);
         var aDamageRemaining:int = theDamage - aDamageApplied;
         this.mHelmHealth -= aDamageApplied;
         if(theDamageFlags == DAMAGE_FREEZE)
         {
            this.ApplyChill(false);
         }
         if(this.mHelmHealth == 0)
         {
            this.DropHelm(theDamageFlags);
            return aDamageRemaining;
         }
         var aNewIndex:int = this.GetHelmDamageIndex();
         if(aOldIndex != aNewIndex)
         {
            if(this.mHelmType == HELMTYPE_TRAFFIC_CONE && aNewIndex == 1)
            {
               this.mBodyReanim.setTrackVisible("anim_cone1",false);
               this.mBodyReanim.setTrackVisible("anim_cone2",true);
            }
            else if(this.mHelmType == HELMTYPE_TRAFFIC_CONE && aNewIndex == 2)
            {
               this.mBodyReanim.setTrackVisible("anim_cone2",false);
               this.mBodyReanim.setTrackVisible("anim_cone3",true);
            }
            else if(this.mHelmType == HELMTYPE_PAIL && aNewIndex == 1)
            {
               this.mBodyReanim.setTrackVisible("anim_bucket1",false);
               this.mBodyReanim.setTrackVisible("anim_bucket2",true);
            }
            else if(this.mHelmType == HELMTYPE_PAIL && aNewIndex == 2)
            {
               this.mBodyReanim.setTrackVisible("anim_bucket2",false);
               this.mBodyReanim.setTrackVisible("anim_bucket3",true);
            }
            else if(this.mHelmType == HELMTYPE_FOOTBALL && aNewIndex == 1)
            {
               this.mBodyReanim.setTrackVisible("zombie_football_helmet1",false);
               this.mBodyReanim.setTrackVisible("zombie_football_helmet2",true);
            }
            else if(this.mHelmType == HELMTYPE_FOOTBALL && aNewIndex == 2)
            {
               this.mBodyReanim.setTrackVisible("zombie_football_helmet2",false);
               this.mBodyReanim.setTrackVisible("zombie_football_helmet3",true);
            }
         }
         return aDamageRemaining;
      }
      
      public function CheckIfPreyCaught() : void
      {
         var aPlant:CPlant = null;
         if(this.mZombiePhase == PHASE_POLEVAULTER_IN_VAULT || this.mZombiePhase == PHASE_POLEVAULTER_PRE_VAULT || this.mZombiePhase == PHASE_RISING_FROM_GRAVE)
         {
            return;
         }
         if(!this.mHasHead)
         {
            return;
         }
         var aTicksPerBite:int = TICKS_BETWEEN_EATS;
         if(this.mChilledCounter > 0)
         {
            aTicksPerBite *= 2;
         }
         if(this.mZombieAge % aTicksPerBite != 0)
         {
            return;
         }
         if(!this.mMindControlled)
         {
            aPlant = this.FindPlantTarget(ATTACKTYPE_CHEW);
            if(aPlant)
            {
               this.EatPlant(aPlant);
               return;
            }
         }
         if(this.mIsEating)
         {
            this.StopEating();
         }
      }
      
      public function GetDrawPos(theDrawPos:ZombieDrawPosition) : void
      {
         var aHeightLimit:Number = NaN;
         theDrawPos.mImageOffsetX = this.mPosX - Number(mX);
         theDrawPos.mImageOffsetY = this.mPosY - Number(mY);
         if(this.mIsEating)
         {
            theDrawPos.mHeadX = 31;
            theDrawPos.mHeadY = 3;
         }
         else if(this.mFrame == 0)
         {
            theDrawPos.mHeadX = 33;
            theDrawPos.mHeadY = 2;
         }
         else if(this.mFrame == 1)
         {
            theDrawPos.mHeadX = 33;
            theDrawPos.mHeadY = 1;
         }
         else if(this.mFrame == 2)
         {
            theDrawPos.mHeadX = 33;
            theDrawPos.mHeadY = 2;
         }
         else if(this.mFrame == 3)
         {
            theDrawPos.mHeadX = 32;
            theDrawPos.mHeadY = 3;
         }
         else if(this.mFrame == 4)
         {
            theDrawPos.mHeadX = 32;
            theDrawPos.mHeadY = 4;
         }
         else if(this.mFrame == 5)
         {
            theDrawPos.mHeadX = 32;
            theDrawPos.mHeadY = 3;
         }
         else if(this.mFrame == 6)
         {
            theDrawPos.mHeadX = 32;
            theDrawPos.mHeadY = 2;
         }
         else if(this.mFrame == 7)
         {
            theDrawPos.mHeadX = 33;
            theDrawPos.mHeadY = 1;
         }
         else if(this.mFrame == 8)
         {
            theDrawPos.mHeadX = 33;
            theDrawPos.mHeadY = 2;
         }
         else if(this.mFrame == 9)
         {
            theDrawPos.mHeadX = 33;
            theDrawPos.mHeadY = 3;
         }
         else if(this.mFrame == 10)
         {
            theDrawPos.mHeadX = 33;
            theDrawPos.mHeadY = 4;
         }
         else
         {
            theDrawPos.mHeadX = 33;
            theDrawPos.mHeadY = 3;
         }
         theDrawPos.mArmY = theDrawPos.mHeadY / 2;
         if(this.mZombieType == ZOMBIE_POLEVAULTER)
         {
            theDrawPos.mImageOffsetX += -6;
            theDrawPos.mImageOffsetY += -11;
         }
         if(this.mZombieType == ZOMBIE_FOOTBALL)
         {
            theDrawPos.mImageOffsetY += -16;
         }
         if(this.mZombiePhase == PHASE_RISING_FROM_GRAVE)
         {
            theDrawPos.mBodyY = -this.mAltitude;
            aHeightLimit = Math.min(Number(this.mPhaseCounter),40);
            theDrawPos.mClipHeight = theDrawPos.mBodyY + aHeightLimit;
         }
         theDrawPos.mBodyY = -this.mAltitude;
         theDrawPos.mClipHeight = CLIP_HEIGHT_OFF;
      }
      
      public function IsDeadOrDying() : Boolean
      {
         if(this.mDead || this.mZombiePhase == PHASE_ZOMBIE_DYING || this.mZombiePhase == PHASE_ZOMBIE_BURNED || this.mZombiePhase == PHASE_ZOMBIE_MOWERED)
         {
            return true;
         }
         return false;
      }
      
      public function UpdateBurn() : void
      {
         --this.mPhaseCounter;
         if(this.mPhaseCounter == 0)
         {
            this.DieWithLoot();
         }
      }
      
      public function DropLoot() : void
      {
         if(!this.IsOnBoard())
         {
            return;
         }
         this.TrySpawnLevelAward();
         if(this.mDroppedLoot)
         {
            return;
         }
         if(mBoard.HasLevelAwardDropped())
         {
            return;
         }
         if(!mBoard.CanDropLoot())
         {
            return;
         }
         this.mDroppedLoot = true;
      }
      
      public function StartEating() : void
      {
         if(this.mIsEating)
         {
            return;
         }
         this.mIsEating = true;
         if(this.mZombiePhase == PHASE_NEWSPAPER_MAD)
         {
            this.mBodyReanim.currentTrack = "anim_eat_nopaper";
         }
         else
         {
            this.mBodyReanim.currentTrack = "anim_eat";
         }
         if(this.mZombieType == ZOMBIE_POLEVAULTER)
         {
            this.mBodyReanim.animRate = 20;
         }
         else
         {
            this.mBodyReanim.animRate = 36;
         }
      }
      
      public function GetHelmDamageIndex() : int
      {
         if(this.mHelmHealth < this.mHelmMaxHealth / 3)
         {
            return 2;
         }
         if(this.mHelmHealth < this.mHelmMaxHealth * 2 / 3)
         {
            return 1;
         }
         return 0;
      }
      
      public function ZombieInitialize(theRow:int, theType:int, theVariant:Boolean, theParentZombie:Zombie, theFromWave:int, app:PVZApp, theBoard:Board) : void
      {
         var aIdlePermuation:Number = NaN;
         this.app = app;
         mBoard = theBoard;
         mRow = theRow;
         this.mFromWave = theFromWave;
         this.mPosX = BOARD_WIDTH - 13 + Math.random() * 27;
         this.mPosY = this.GetPosYBasedOnRow(theRow);
         mWidth = 81;
         mHeight = 81;
         this.mVelX = 0;
         this.mVelZ = 0;
         this.mFrame = 0;
         this.mPrevFrame = 0;
         this.mZombieType = theType;
         this.mVariant = theVariant;
         this.mIsEating = false;
         this.mJustGotShotCounter = 0;
         this.mShieldJustGotShotCounter = 0;
         this.mShieldRecoilCounter = 0;
         this.mChilledCounter = 0;
         this.mIceTrapCounter = 0;
         this.mButteredCounter = 0;
         this.mMindControlled = false;
         this.mBlowingAway = false;
         this.mHasHead = true;
         this.mHasArm = true;
         this.mHasObject = false;
         this.mInPool = false;
         this.mOnHighGround = false;
         this.mHelmType = HELMTYPE_NONE;
         this.mShieldType = SHIELDTYPE_NONE;
         this.mYuckyFace = false;
         this.mAnimCounter = 0;
         this.mGroanCounter = TodCommon.RandRangeInt(400,500);
         this.mAnimTicksPerFrame = 12;
         this.mAnimFrames = 12;
         this.mZombieAge = 0;
         this.mTargetCol = -1;
         this.mZombiePhase = PHASE_ZOMBIE_NORMAL;
         this.mZombieHeight = HEIGHT_ZOMBIE_NORMAL;
         this.mPhaseCounter = 0;
         this.mHitUmbrella = false;
         this.mDroppedLoot = false;
         this.mZombieRect = new Rectangle(25,0,28,77);
         this.mZombieAttackRect = new Rectangle(40,0,14,77);
         this.mPlayingSong = false;
         this.mZombieFade = -1;
         this.mFlatTires = false;
         this.mUseLadderCol = -1;
         this.mShieldHealth = 0;
         this.mHelmHealth = 0;
         this.mFlyingHealth = 0;
         this.mSummonCounter = 0;
         this.mScaleZombie = 1;
         this.mAltitude = 0;
         this.mOrginalAnimRate = 0;
         this.mBodyHealth = 270;
         switch(theType)
         {
            case ZOMBIE_NORMAL:
               this.mBodyReanim = app.reanimator.createReanimation("REANIM_ZOMBIE");
               this.mZombieAttackRect = new Rectangle(10,0,33,77);
               break;
            case ZOMBIE_TRAFFIC_CONE:
               this.mBodyReanim = app.reanimator.createReanimation("REANIM_ZOMBIE");
               this.mHelmType = HELMTYPE_TRAFFIC_CONE;
               this.mHelmHealth = 370;
               this.mZombieAttackRect = new Rectangle(10,0,33,77);
               break;
            case ZOMBIE_PAIL:
               this.mBodyReanim = app.reanimator.createReanimation("REANIM_ZOMBIE");
               this.mHelmType = HELMTYPE_PAIL;
               this.mHelmHealth = 1100;
               this.mZombieAttackRect = new Rectangle(10,0,33,77);
               break;
            case ZOMBIE_FLAG:
               this.mBodyReanim = app.reanimator.createReanimation("REANIM_ZOMBIE");
               this.mHasObject = true;
               this.mPosX = BOARD_WIDTH;
               this.mZombieAttackRect = new Rectangle(10,0,33,77);
               break;
            case ZOMBIE_DOOR:
               this.mBodyReanim = app.reanimator.createReanimation("REANIM_ZOMBIE");
               this.mHasObject = true;
               this.mShieldType = SHIELDTYPE_DOOR;
               this.mShieldHealth = 1100;
               this.mPosX = BOARD_WIDTH;
               this.mZombieAttackRect = new Rectangle(10,0,33,77);
               break;
            case ZOMBIE_NEWSPAPER:
               this.mBodyReanim = app.reanimator.createReanimation(PVZReanims.REANIM_ZOMBIE_PAPER);
               this.mHasObject = true;
               this.mShieldType = SHIELDTYPE_NEWSPAPER;
               this.mZombiePhase = PHASE_NEWSPAPER_READING;
               this.mShieldHealth = 150;
               this.mPosX = BOARD_WIDTH;
               this.mVariant = false;
               this.AttachShield();
               this.mZombieAttackRect = new Rectangle(10,0,33,77);
               if(this.IsOnBoard())
               {
                  this.mBodyReanim.currentTrack = "anim_walk";
                  this.mBodyReanim.loopType = Reanimation.LOOP_TYPE_ALWAYS;
                  this.PickRandomSpeed();
               }
               else
               {
                  this.mBodyReanim.currentTrack = "anim_idle";
                  this.mBodyReanim.loopType = Reanimation.LOOP_TYPE_ALWAYS;
                  this.mBodyReanim.animTime = Math.random() * 0.99;
                  this.mBodyReanim.animRate = TodCommon.RandRangeFloat(12,24);
               }
               break;
            case ZOMBIE_POLEVAULTER:
               this.mBodyReanim = app.reanimator.createReanimation("REANIM_ZOMBIE_POLEVAULTER");
               this.mHasObject = true;
               this.mZombiePhase = PHASE_POLEVAULTER_PRE_VAULT;
               this.mBodyHealth = 500;
               this.mVariant = false;
               this.mPosX = BOARD_WIDTH + 50 + Math.random() * 7;
               if(this.IsOnBoard())
               {
                  this.mBodyReanim.currentTrack = "anim_run";
                  this.mBodyReanim.loopType = Reanimation.LOOP_TYPE_ALWAYS;
                  this.PickRandomSpeed();
               }
               else
               {
                  this.mBodyReanim.currentTrack = "anim_idle";
                  this.mBodyReanim.loopType = Reanimation.LOOP_TYPE_ALWAYS;
                  this.mBodyReanim.animTime = Math.random() * 0.99;
                  this.mBodyReanim.animRate = TodCommon.RandRangeFloat(12,24);
               }
               if(mBoard.IsWallnutBowlingLevel())
               {
                  this.mZombieAttackRect = new Rectangle(-154,0,182,77);
               }
               else
               {
                  this.mZombieAttackRect = new Rectangle(-20,0,47,77);
               }
               break;
            case ZOMBIE_FOOTBALL:
               this.mBodyReanim = app.reanimator.createReanimation(PVZReanims.REANIM_ZOMBIE_FOOTBALL);
               this.mZombieRect = new Rectangle(34,0,38,77);
               this.mZombieAttackRect = new Rectangle(10,0,33,77);
               this.mHelmType = HELMTYPE_FOOTBALL;
               this.mHelmHealth = 2800;
               this.mAnimTicksPerFrame = 6;
               this.mVariant = false;
               if(this.IsOnBoard())
               {
                  this.mBodyReanim.setTrackVisible("anim_hair",false);
                  this.mBodyReanim.setTrackVisible("zombie_football_helmet2",false);
                  this.mBodyReanim.setTrackVisible("zombie_football_helmet3",false);
                  this.mBodyReanim.currentTrack = "anim_walk";
                  this.mBodyReanim.loopType = Reanimation.LOOP_TYPE_ALWAYS;
                  this.PickRandomSpeed();
               }
               else
               {
                  this.mBodyReanim.setTrackVisible("anim_hair",false);
                  this.mBodyReanim.currentTrack = "anim_idle";
                  this.mBodyReanim.loopType = Reanimation.LOOP_TYPE_ALWAYS;
                  this.mBodyReanim.animTime = Math.random() * 0.99;
                  this.mBodyReanim.animRate = TodCommon.RandRangeFloat(12,24);
               }
               break;
            default:
               this.mBodyReanim = app.reanimator.createReanimation("REANIM_ZOMBIE");
               this.mZombieAttackRect = new Rectangle(10,0,33,77);
         }
         if(Boolean(mBoard) && mBoard.IsFlagWave(this.mFromWave))
         {
            this.mPosX += 27;
         }
         if(theType == ZOMBIE_NORMAL || theType == ZOMBIE_TRAFFIC_CONE || theType == ZOMBIE_FLAG || theType == ZOMBIE_PAIL || theType == ZOMBIE_DOOR)
         {
            this.mBodyReanim.setTrackVisible("anim_hair",false);
            this.mBodyReanim.setTrackVisible("anim_cone1",false);
            this.mBodyReanim.setTrackVisible("anim_cone2",false);
            this.mBodyReanim.setTrackVisible("anim_cone3",false);
            this.mBodyReanim.setTrackVisible("anim_bucket1",false);
            this.mBodyReanim.setTrackVisible("anim_bucket2",false);
            this.mBodyReanim.setTrackVisible("anim_bucket3",false);
            this.mBodyReanim.setTrackVisible("anim_screendoor1",false);
            this.mBodyReanim.setTrackVisible("anim_screendoor2",false);
            this.mBodyReanim.setTrackVisible("anim_screendoor3",false);
            this.mBodyReanim.setTrackVisible("Zombie_flaghand",false);
            this.mBodyReanim.setTrackVisible("Zombie_duckytube",false);
            this.mBodyReanim.setTrackVisible("anim_tongue",false);
            this.mBodyReanim.setTrackVisible("Zombie_mustache",false);
            this.mBodyReanim.setTrackVisible("Zombie_innerarm_screendoor",false);
            this.mBodyReanim.setTrackVisible("Zombie_innerarm_screendoor_hand",false);
            this.mBodyReanim.setTrackVisible("Zombie_outerarm_screendoor",false);
            switch(theType)
            {
               case ZOMBIE_NORMAL:
                  this.mBodyReanim.setTrackVisible("anim_hair",true);
                  break;
               case ZOMBIE_TRAFFIC_CONE:
                  this.mBodyReanim.setTrackVisible("anim_cone1",true);
                  break;
               case ZOMBIE_PAIL:
                  this.mBodyReanim.setTrackVisible("anim_bucket1",true);
                  break;
               case ZOMBIE_FLAG:
                  this.mBodyReanim.setTrackVisible("Zombie_flaghand",true);
                  this.mBodyReanim.setTrackVisible("anim_hair",true);
                  this.mBodyReanim.setTrackVisible("anim_innerarm1",false);
                  this.mBodyReanim.setTrackVisible("anim_innerarm2",false);
                  this.mBodyReanim.setTrackVisible("anim_innerarm3",false);
                  this.mBodyReanim.setTrackVisible("Zombie_innerarm_screendoor",true);
                  break;
               case ZOMBIE_DOOR:
                  this.mBodyReanim.setTrackVisible("anim_hair",true);
                  this.mBodyReanim.setTrackVisible("anim_innerarm1",false);
                  this.mBodyReanim.setTrackVisible("anim_innerarm2",false);
                  this.mBodyReanim.setTrackVisible("anim_innerarm3",false);
                  this.AttachShield();
                  this.SetupDoorArms(true);
            }
            if(!this.IsOnBoard())
            {
               aIdlePermuation = Math.random() * 3;
               if(aIdlePermuation > 1 && theType != ZOMBIE_POLEVAULTER)
               {
                  this.mBodyReanim.animRate = TodCommon.RandRangeFloat(12,24);
                  this.mBodyReanim.currentTrack = "anim_idle2";
               }
               else
               {
                  this.mBodyReanim.animRate = TodCommon.RandRangeFloat(12,18);
                  this.mBodyReanim.currentTrack = "anim_idle";
               }
               this.mBodyReanim.animTime = Math.random() * 0.99;
            }
            else
            {
               this.StartWalkAnim(0);
            }
            this.mBodyReanim.loopType = Reanimation.LOOP_TYPE_ALWAYS;
            this.PickRandomSpeed();
         }
         this.UpdateAnimSpeed();
         if(this.mVariant)
         {
            this.mBodyReanim.setTrackVisible("anim_tongue",false);
         }
         this.mBodyMaxHealth = this.mBodyHealth;
         this.mHelmMaxHealth = this.mHelmHealth;
         this.mShieldMaxHealth = this.mShieldHealth;
         this.mDead = false;
         mX = int(this.mPosX);
         mY = int(this.mPosY);
         if(this.IsOnBoard())
         {
         }
         this.UpdateReanim();
      }
      
      public function GetZombieAttackRect() : Rectangle
      {
         var aRect:Rectangle = this.mZombieAttackRect.clone();
         var aDrawPos:ZombieDrawPosition = this.scratchDrawPos;
         this.GetDrawPos(aDrawPos);
         aRect.offset(mX,mY + aDrawPos.mBodyY);
         if(aDrawPos.mClipHeight > CLIP_HEIGHT_LIMIT)
         {
            aRect.height -= aDrawPos.mClipHeight;
         }
         return aRect;
      }
      
      public function ApplyChill(theIsIceTrap:Boolean) : void
      {
         if(!this.CanBeChilled())
         {
            return;
         }
         if(this.mChilledCounter == 0)
         {
            app.foleyManager.playFoley(PVZFoleyType.FROZEN);
         }
         var aTime:int = 1000;
         if(theIsIceTrap)
         {
            aTime = 2000;
         }
         this.mChilledCounter = Math.max(aTime,this.mChilledCounter);
         this.UpdateAnimSpeed();
      }
      
      public function TakeShieldDamage(theDamage:int, theDamageFlags:int) : int
      {
         if(theDamageFlags != DAMAGE_DOESNT_CAUSE_FLASH || this.mZombieType == ZOMBIE_DOOR || this.mZombieType == ZOMBIE_NEWSPAPER)
         {
            this.mShieldJustGotShotCounter = 25;
            if(this.mJustGotShotCounter < 0)
            {
               this.mJustGotShotCounter = 0;
            }
         }
         if(theDamageFlags != DAMAGE_DOESNT_CAUSE_FLASH && theDamageFlags != DAMAGE_HITS_SHIELD_AND_BODY)
         {
            this.mShieldRecoilCounter = 12;
            if(this.mShieldType == SHIELDTYPE_DOOR)
            {
               app.foleyManager.playFoley(PVZFoleyType.SHIELD_HIT);
            }
         }
         var aOldIndex:int = this.GetShieldDamageIndex();
         var aDamageApplied:int = Math.min(this.mShieldHealth,theDamage);
         var aDamageRemaining:int = theDamage - aDamageApplied;
         this.mShieldHealth -= aDamageApplied;
         if(this.mShieldHealth == 0)
         {
            this.DropShield(theDamageFlags);
            return aDamageRemaining;
         }
         var aNewIndex:int = this.GetShieldDamageIndex();
         if(aOldIndex != aNewIndex)
         {
            if(this.mShieldType == SHIELDTYPE_DOOR && aNewIndex == 1)
            {
               this.mBodyReanim.setTrackVisible("anim_screendoor1",false);
               this.mBodyReanim.setTrackVisible("anim_screendoor2",true);
            }
            else if(this.mShieldType == SHIELDTYPE_DOOR && aNewIndex == 2)
            {
               this.mBodyReanim.setTrackVisible("anim_screendoor2",false);
               this.mBodyReanim.setTrackVisible("anim_screendoor3",true);
            }
            else if(this.mShieldType == SHIELDTYPE_NEWSPAPER && aNewIndex == 1)
            {
               this.mBodyReanim.setTrackVisible("Zombie_paper_paper1",false);
               this.mBodyReanim.setTrackVisible("Zombie_paper_paper2",true);
            }
            else if(this.mShieldType == SHIELDTYPE_NEWSPAPER && aNewIndex == 2)
            {
               this.mBodyReanim.setTrackVisible("Zombie_paper_paper2",false);
               this.mBodyReanim.setTrackVisible("Zombie_paper_paper3",true);
            }
         }
         return aDamageRemaining;
      }
      
      public function DieNoLoot() : void
      {
         if(this.IsOnBoard() && !this.mDead)
         {
            ++app.mTotalZombiesKilled;
            app.adAPI.setScore(app.mTotalZombiesKilled);
            trace(app.mTotalZombiesKilled);
         }
         this.TrySpawnLevelAward();
         this.mDead = true;
      }
      
      public function ShowDoorArms(theShow:Boolean) : void
      {
         if(this.mBodyReanim)
         {
            this.SetupDoorArms(theShow);
            if(!this.mHasArm)
            {
               this.mBodyReanim.setTrackVisible("Zombie_outerarm_lower",false);
               this.mBodyReanim.setTrackVisible("Zombie_outerarm_hand",false);
            }
         }
      }
      
      public function UpdateZombiePosition() : void
      {
         var aDesiredY:Number = NaN;
         if(this.mZombiePhase == PHASE_RISING_FROM_GRAVE)
         {
            return;
         }
         this.UpdateZombieWalking();
         if(this.mBlowingAway)
         {
            this.mPosX += 10;
            if(mX > 850)
            {
               this.DieWithLoot();
               return;
            }
         }
         if(this.mZombieHeight == HEIGHT_ZOMBIE_NORMAL)
         {
            aDesiredY = this.GetPosYBasedOnRow(mRow);
            if(this.mPosY < aDesiredY)
            {
               this.mPosY += Math.min(1,aDesiredY - this.mPosY);
            }
            else if(this.mPosY > aDesiredY)
            {
               this.mPosY -= Math.min(1,this.mPosY - aDesiredY);
            }
         }
      }
      
      public function WalkIntoHouse() : void
      {
         this.mFromWave = ZOMBIE_WAVE_WINNER;
         if(this.mZombiePhase == PHASE_POLEVAULTER_PRE_VAULT)
         {
            this.mZombiePhase = PHASE_POLEVAULTER_POST_VAULT;
            this.StartWalkAnim(0);
         }
         this.mPosY = 196;
      }
      
      public function Animate() : void
      {
         var aEatingTicksPerFrame:int = 0;
         var aLeftHandTime:Number = NaN;
         var aRightHandTime:Number = NaN;
         this.mPrevFrame = this.mFrame;
         if(this.IsImmobilizied())
         {
            return;
         }
         ++this.mAnimCounter;
         if(this.mIsEating && this.mHasHead)
         {
            aEatingTicksPerFrame = 6;
            if(this.mChilledCounter > 0)
            {
               aEatingTicksPerFrame = 12;
            }
            if(this.mAnimCounter >= this.mAnimFrames * aEatingTicksPerFrame)
            {
               this.mAnimCounter = aEatingTicksPerFrame;
            }
            this.mFrame = this.mAnimCounter / aEatingTicksPerFrame;
            aLeftHandTime = 0.14;
            aRightHandTime = 0.68;
            if(this.mZombieType == ZOMBIE_POLEVAULTER)
            {
               aLeftHandTime = 0.38;
               aRightHandTime = 0.8;
            }
            else if(this.mZombieType == ZOMBIE_NEWSPAPER)
            {
               aLeftHandTime = 0.42;
               aRightHandTime = 0.42;
            }
            if(this.mBodyReanim.shouldTriggerTimedEvent(aLeftHandTime) || this.mBodyReanim.shouldTriggerTimedEvent(aRightHandTime))
            {
               this.AnimateChewSound();
               this.AnimateChewEffect();
            }
            return;
         }
         if(this.mAnimCounter >= this.mAnimFrames * this.mAnimTicksPerFrame)
         {
            this.mAnimCounter = 0;
         }
         this.mFrame = this.mAnimCounter / this.mAnimTicksPerFrame;
      }
      
      public function GetPosYBasedOnRow(theRow:int) : Number
      {
         if(!this.IsOnBoard())
         {
            return 0;
         }
         return mBoard.GetPosYBasedOnRow(this.mPosX + 40,theRow) - 30;
      }
      
      public function EffectedByDamage() : Boolean
      {
         if(this.IsDeadOrDying())
         {
            return false;
         }
         if(this.mZombiePhase == PHASE_POLEVAULTER_IN_VAULT || this.mZombiePhase == PHASE_RISING_FROM_GRAVE)
         {
            return false;
         }
         return true;
      }
      
      public function DropArm(theDamageFlags:int) : void
      {
         var anImage:ImageInst = null;
         if(!this.CanLoseBodyParts())
         {
            return;
         }
         if(!this.mHasArm)
         {
            return;
         }
         if(this.mShieldType == SHIELDTYPE_DOOR || this.mShieldType == SHIELDTYPE_NEWSPAPER)
         {
            return;
         }
         if(this.mZombiePhase == PHASE_NEWSPAPER_READING)
         {
            return;
         }
         this.mHasArm = false;
         if(this.mZombieType == ZOMBIE_NEWSPAPER)
         {
            this.mBodyReanim.setTrackVisible("Zombie_paper_hands",false);
            this.mBodyReanim.setTrackVisible("Zombie_paper_leftarm_lower",false);
         }
         else if(this.mZombieType == ZOMBIE_POLEVAULTER)
         {
            this.mBodyReanim.setTrackVisible("Zombie_polevaulter_outerarm_lower",false);
            this.mBodyReanim.setTrackVisible("Zombie_outerarm_hand",false);
         }
         else if(this.mZombieType == ZOMBIE_FOOTBALL)
         {
            this.mBodyReanim.setTrackVisible("Zombie_football_rightarm_lower",false);
            this.mBodyReanim.setTrackVisible("Zombie_football_rightarm_hand",false);
         }
         else
         {
            this.mBodyReanim.setTrackVisible("Zombie_outerarm_lower",false);
            this.mBodyReanim.setTrackVisible("Zombie_outerarm_hand",false);
         }
         if(this.mZombieType != ZOMBIE_NORMAL)
         {
            return;
         }
         var anEffect:String = PVZParticles.PARTICLE_ZOMBIEARM;
         var aDrawPos:ZombieDrawPosition = this.scratchDrawPos;
         this.GetDrawPos(aDrawPos);
         var aPosX:Number = this.mPosX + aDrawPos.mImageOffsetX + 20;
         var aPosY:Number = this.mPosY + aDrawPos.mImageOffsetY + aDrawPos.mBodyY + 78 * 0.675;
         var aPoint:Point = new Point(0,0);
         if(this.mZombiePhase == PHASE_ZOMBIE_MOWERED)
         {
            anEffect = PVZParticles.PARTICLE_MOWEREDZOMBIEARM;
         }
         aPosX += aPoint.x;
         aPosY += aPoint.y;
         this.mArmParticle = app.particleManager.spawnParticleSystem(anEffect);
         this.mArmParticle.setPosition(aPosX,aPosY);
         if(this.mChilledCounter > 0)
         {
            this.mArmParticle.mEmitterList[0].mColorOverride = gChilledColor;
         }
         app.foleyManager.playFoley(PVZFoleyType.LIMBS_POP);
      }
      
      public function Update() : void
      {
         this.mHitRectUpdated = false;
         ++this.mZombieAge;
         if(mBoard.mGameScene != SCENE_PLAYING && this.IsOnBoard() && this.mFromWave != ZOMBIE_WAVE_WINNER)
         {
            return;
         }
         if(this.mZombiePhase == PHASE_ZOMBIE_BURNED)
         {
            this.UpdateBurn();
         }
         else if(this.mZombiePhase == PHASE_ZOMBIE_MOWERED)
         {
            this.UpdateMowered();
         }
         else if(this.mZombiePhase == PHASE_ZOMBIE_DYING)
         {
            this.UpdateDeath();
            this.UpdateZombieWalking();
         }
         else
         {
            if(this.mPhaseCounter > 0 && !this.IsImmobilizied())
            {
               --this.mPhaseCounter;
            }
            if(mBoard.mGameScene == SCENE_ZOMBIES_WON)
            {
               if(mBoard.mShowZombieWalking)
               {
                  this.UpdateZombieWalking();
               }
            }
            else if(this.IsOnBoard())
            {
               this.UpdatePlaying();
            }
            this.Animate();
         }
         --this.mJustGotShotCounter;
         if(this.mShieldJustGotShotCounter > 0)
         {
            --this.mShieldJustGotShotCounter;
         }
         if(this.mZombieFade > 0)
         {
            --this.mZombieFade;
            if(this.mZombieFade == 0)
            {
               this.DieNoLoot();
            }
         }
         mX = int(this.mPosX);
         mY = int(this.mPosY);
         this.UpdateReanim();
         if(this.mHeadParticle != null)
         {
            if(this.mHeadParticle.mDead)
            {
            }
         }
         if(this.mArmParticle != null)
         {
            this.mArmParticle.update();
            if(this.mArmParticle.mDead)
            {
               this.mArmParticle = null;
            }
         }
         if(this.mHelmParticle != null)
         {
            this.mHelmParticle.update();
            if(this.mHelmParticle.mDead)
            {
               this.mHelmParticle = null;
            }
         }
         if(this.mFlagParticle != null)
         {
            this.mFlagParticle.update();
            if(this.mFlagParticle.mDead)
            {
               this.mFlagParticle = null;
            }
         }
      }
      
      public function UpdateZombieNewspaper() : void
      {
         var anImage:ImageInst = null;
         if(this.mZombiePhase == PHASE_NEWSPAPER_MADDENING)
         {
            if(this.mBodyReanim.currentTrack == "anim_walk_nopaper")
            {
               this.mZombiePhase = PHASE_NEWSPAPER_MAD;
               app.foleyManager.playFoley(PVZFoleyType.NEWSPAPER_RARRGH);
               this.StartWalkAnim(20);
               anImage = app.imageManager.getImageInst(PVZImages.IMAGE_REANIM_ZOMBIE_PAPER_MADHEAD);
               this.mBodyReanim.overrideImage("anim_head1",anImage);
            }
         }
      }
      
      public function DropHelm(theDamageFlags:int) : void
      {
         var aPoint:Point = null;
         var anEffect:String = null;
         if(this.mHelmType == HELMTYPE_NONE)
         {
            return;
         }
         var aDrawPos:ZombieDrawPosition = this.scratchDrawPos;
         this.GetDrawPos(aDrawPos);
         var aPosX:Number = this.mPosX + aDrawPos.mImageOffsetX + aDrawPos.mHeadX + 10;
         var aPosY:Number = this.mPosY + aDrawPos.mImageOffsetY + aDrawPos.mHeadY + aDrawPos.mBodyY + 13;
         if(this.mHelmType == HELMTYPE_TRAFFIC_CONE)
         {
            aPoint = this.mBodyReanim.getTrackPosition("anim_cone3");
            this.mBodyReanim.setTrackVisible("anim_cone1",false);
            this.mBodyReanim.setTrackVisible("anim_cone2",false);
            this.mBodyReanim.setTrackVisible("anim_cone3",false);
            this.mBodyReanim.setTrackVisible("anim_hair",true);
            anEffect = PVZParticles.PARTICLE_ZOMBIETRAFFICCONE;
         }
         else if(this.mHelmType == HELMTYPE_PAIL)
         {
            aPoint = this.mBodyReanim.getTrackPosition("anim_bucket3");
            this.mBodyReanim.setTrackVisible("anim_bucket1",false);
            this.mBodyReanim.setTrackVisible("anim_bucket2",false);
            this.mBodyReanim.setTrackVisible("anim_bucket3",false);
            this.mBodyReanim.setTrackVisible("anim_hair",true);
            anEffect = PVZParticles.PARTICLE_ZOMBIEPAIL;
         }
         else if(this.mHelmType == HELMTYPE_FOOTBALL)
         {
            aPoint = this.mBodyReanim.getTrackPosition("zombie_football_helmet3");
            this.mBodyReanim.setTrackVisible("zombie_football_helmet1",false);
            this.mBodyReanim.setTrackVisible("zombie_football_helmet2",false);
            this.mBodyReanim.setTrackVisible("zombie_football_helmet3",false);
            this.mBodyReanim.setTrackVisible("anim_hair",true);
            anEffect = PVZParticles.PARTICLE_ZOMBIEHELMET;
         }
         this.mHelmParticle = app.particleManager.spawnParticleSystem(anEffect);
         this.mHelmParticle.setPosition(aPosX + aPoint.x,aPosY + aPoint.y);
         this.mHelmType = HELMTYPE_NONE;
      }
      
      public function GetShieldDamageIndex() : int
      {
         if(this.mShieldHealth < this.mShieldMaxHealth / 3)
         {
            return 2;
         }
         if(this.mShieldHealth < this.mShieldMaxHealth * 2 / 3)
         {
            return 1;
         }
         return 0;
      }
      
      public function TakeDamage(theDamage:int, theDamageFlags:int) : void
      {
         if(this.IsDeadOrDying())
         {
            return;
         }
         var aDamageRemaining:int = theDamage;
         if(aDamageRemaining > 0 && this.mShieldType != SHIELDTYPE_NONE)
         {
            aDamageRemaining = this.TakeShieldDamage(theDamage,theDamageFlags);
            if(theDamageFlags == DAMAGE_HITS_SHIELD_AND_BODY)
            {
               aDamageRemaining = theDamage;
            }
         }
         if(aDamageRemaining > 0 && this.mHelmType != HELMTYPE_NONE)
         {
            aDamageRemaining = this.TakeHelmDamage(theDamage,theDamageFlags);
         }
         if(aDamageRemaining > 0)
         {
            this.TakeBodyDamage(aDamageRemaining,theDamageFlags);
         }
      }
      
      public function CanLoseBodyParts() : Boolean
      {
         return true;
      }
      
      public function DetachShield() : void
      {
         if(!this.mBodyReanim)
         {
            this.mShieldType = SHIELDTYPE_NONE;
            this.mShieldHealth = 0;
            return;
         }
         if(this.mShieldType == SHIELDTYPE_DOOR)
         {
            this.mBodyReanim.setTrackVisible("anim_screendoor3",false);
            this.ShowDoorArms(false);
         }
         else if(this.mShieldType == SHIELDTYPE_NEWSPAPER)
         {
            this.mBodyReanim.setTrackVisible("Zombie_paper_hands",true);
         }
         this.mShieldType = SHIELDTYPE_NONE;
         this.mShieldHealth = 0;
      }
      
      public function UpdatePlaying() : void
      {
         var aBleeding:* = false;
         var aBleedRate:int = 0;
         --this.mGroanCounter;
         var aZombiesOnScreen:int = int(mBoard.mZombies.length);
         if(this.mGroanCounter == 0 && Math.random() * aZombiesOnScreen == 0 && this.mHasHead && !mBoard.HasLevelAwardDropped())
         {
            if(this.mVariant)
            {
               app.foleyManager.playFoley(PVZFoleyType.BRAINS);
            }
            else
            {
               app.foleyManager.playFoley(PVZFoleyType.GROAN);
            }
            this.mGroanCounter = Math.random() * 1000 + 500;
         }
         if(this.mChilledCounter > 0)
         {
            --this.mChilledCounter;
            if(this.mChilledCounter == 0)
            {
               this.UpdateAnimSpeed();
            }
         }
         if(this.mZombiePhase == PHASE_RISING_FROM_GRAVE)
         {
            this.UpdateZombieRiseFromGrave();
            return;
         }
         if(!this.IsImmobilizied())
         {
            this.UpdateActions();
            this.UpdateZombiePosition();
            this.CheckIfPreyCaught();
            this.CheckForBoardEdge();
         }
         if(!this.IsDeadOrDying() && this.mFromWave != ZOMBIE_WAVE_WINNER)
         {
            aBleeding = !this.mHasHead;
            if(aBleeding)
            {
               aBleedRate = 1;
               if(this.mBodyMaxHealth >= 500)
               {
                  aBleedRate = 3;
               }
               if(int(Math.random() * 4) == 0)
               {
                  this.TakeDamage(aBleedRate,DAMAGE_DOESNT_CAUSE_FLASH);
               }
            }
         }
      }
      
      public function StopZombieSound() : void
      {
      }
      
      public function UpdateDeath() : void
      {
         if(this.mBodyReanim.mIsDead)
         {
            this.DieNoLoot();
            return;
         }
         if(this.mZombieHeight == HEIGHT_FALLING)
         {
            this.UpdateZombieFalling();
         }
         var aFallTime:Number = -1;
         if(this.mZombieType == ZOMBIE_NORMAL || this.mZombieType == ZOMBIE_FLAG || this.mZombieType == ZOMBIE_TRAFFIC_CONE || this.mZombieType == ZOMBIE_PAIL)
         {
            if(this.mBodyReanim.currentTrack == "anim_superlongdeath")
            {
               aFallTime = 0.78;
            }
            else if(this.mBodyReanim.currentTrack == "anim_death2")
            {
               aFallTime = 0.71;
            }
            else
            {
               aFallTime = 0.77;
            }
         }
         else if(this.mZombieType == ZOMBIE_POLEVAULTER)
         {
            aFallTime = 0.68;
         }
         else if(this.mZombieType == ZOMBIE_NEWSPAPER)
         {
            aFallTime = 0.63;
         }
         else if(this.mZombieType == ZOMBIE_FOOTBALL)
         {
            aFallTime = 0.52;
         }
         if(aFallTime > 0 && this.mBodyReanim.shouldTriggerTimedEvent(aFallTime))
         {
            app.foleyManager.playFoley(PVZFoleyType.ZOMBIE_FALLING);
         }
         if(this.mZombieFade == -1 && this.mBodyReanim.animTime == 1)
         {
            this.mZombieFade = 100;
         }
      }
      
      public function GetZombieRect() : Rectangle
      {
         var aDrawPos:ZombieDrawPosition = null;
         if(this.mHitRectUpdated == false)
         {
            this.mZombieHitRect.x = this.mZombieRect.x;
            this.mZombieHitRect.y = this.mZombieRect.y;
            this.mZombieHitRect.width = this.mZombieRect.width;
            this.mZombieHitRect.height = this.mZombieRect.height;
            aDrawPos = mScratchPosition;
            this.GetDrawPos(aDrawPos);
            this.mZombieHitRect.offset(mX,mY + aDrawPos.mBodyY);
            if(aDrawPos.mClipHeight > CLIP_HEIGHT_LIMIT)
            {
               this.mZombieHitRect.height -= aDrawPos.mClipHeight;
            }
            this.mHitRectUpdated = true;
         }
         return this.mZombieHitRect;
      }
      
      public function UpdateReanim() : void
      {
         this.mBodyReanim.update();
      }
      
      public function DieWithLoot() : void
      {
         this.DieNoLoot();
         this.DropLoot();
      }
      
      public function UpdateZombieFalling() : void
      {
         --this.mAltitude;
      }
      
      public function DropFlag() : void
      {
         if(this.mZombieType != ZOMBIE_FLAG || !this.mHasObject)
         {
            return;
         }
         this.mHasObject = false;
         var aPoint:Point = this.mBodyReanim.getTrackPosition("Zombie_flaghand");
         var aFlagPosX:Number = mX - 10;
         var aFlagPosY:Number = mY - 10;
         this.mFlagParticle = app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_ZOMBIEFLAG);
         this.mFlagParticle.setPosition(aFlagPosX,aFlagPosY);
      }
      
      public function CanBeChilled() : Boolean
      {
         if(this.IsDeadOrDying() || this.mZombiePhase == PHASE_RISING_FROM_GRAVE)
         {
            return false;
         }
         return true;
      }
      
      public function MowDown() : void
      {
         if(this.mDead || this.mZombiePhase == PHASE_ZOMBIE_MOWERED)
         {
            return;
         }
         var anEffect:ParticleSystem = app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_MOWERCLOUD);
         anEffect.setPosition(this.mPosX + 20,this.mPosY + 20);
         mBoard.mRenderManager.add(new ParticleRenderable(anEffect,RENDER_LAYER_PARTICLE));
         this.DropHead(0);
         this.DropArm(0);
         this.DropHelm(0);
         this.DropShield(0);
         this.DieWithLoot();
      }
      
      public function ZombieTargetLeadX(theTime:Number) : Number
      {
         var aSpeed:Number = this.mVelX;
         if(this.mChilledCounter > 0)
         {
            aSpeed *= CHILLED_SPEED_FACTOR;
         }
         if(this.ZombieNotWalking())
         {
            aSpeed = 0;
         }
         var aLeadAmount:Number = aSpeed * theTime;
         var aZombieRect:Rectangle = this.GetZombieRect();
         var aCenter:int = aZombieRect.x + aZombieRect.width / 2;
         return aCenter - aLeadAmount;
      }
      
      public function DrawReanim(g:Graphics2D, theDrawPos:ZombieDrawPosition) : void
      {
         var aDrawHeight:Number = NaN;
         var aFade:Number = NaN;
         var anOffsetX:Number = theDrawPos.mImageOffsetX;
         var anOffsetY:Number = theDrawPos.mImageOffsetY + theDrawPos.mBodyY - 52;
         if(theDrawPos.mClipHeight > CLIP_HEIGHT_LIMIT)
         {
            aDrawHeight = 120 - theDrawPos.mClipHeight + 71;
            g.setClipRect(anOffsetX - 200,anOffsetY,120 + 400,aDrawHeight);
         }
         var aAlpha:Number = 1;
         if(this.mZombieFade >= 0)
         {
            aAlpha = TodCommon.ClampInt(this.mZombieFade / 10,0,1);
         }
         var aColorOverride:Color = this.mOverrideColor;
         aColorOverride.alpha = aAlpha;
         aColorOverride.red = 1;
         aColorOverride.green = 1;
         aColorOverride.blue = 1;
         var aExtraAdditiveColor:Color = this.mAdditiveColor;
         aExtraAdditiveColor.alpha = 0;
         aExtraAdditiveColor.red = 0;
         aExtraAdditiveColor.green = 0;
         aExtraAdditiveColor.blue = 0;
         var aEnableExtraAdditiveDraw:Boolean = false;
         if(this.mZombiePhase == PHASE_ZOMBIE_BURNED)
         {
            aColorOverride.red = 0;
            aColorOverride.green = 0;
            aColorOverride.blue = 0;
            aEnableExtraAdditiveDraw = false;
         }
         else if(this.mChilledCounter > 0 || this.mIceTrapCounter > 0)
         {
            aColorOverride.red = gChilledColor.red;
            aColorOverride.green = gChilledColor.green;
            aColorOverride.blue = gChilledColor.blue;
            aExtraAdditiveColor.red = aColorOverride.red;
            aExtraAdditiveColor.green = aColorOverride.green;
            aExtraAdditiveColor.blue = aColorOverride.blue;
            aEnableExtraAdditiveDraw = true;
         }
         if(this.mJustGotShotCounter > 0)
         {
            aFade = this.mJustGotShotCounter * 10 / 255;
            aExtraAdditiveColor.red += aFade;
            aExtraAdditiveColor.red = aExtraAdditiveColor.red > 1 ? 1 : aExtraAdditiveColor.red;
            aExtraAdditiveColor.green += aFade;
            aExtraAdditiveColor.green = aExtraAdditiveColor.green > 1 ? 1 : aExtraAdditiveColor.green;
            aExtraAdditiveColor.blue += aFade;
            aExtraAdditiveColor.blue = aExtraAdditiveColor.blue > 1 ? 1 : aExtraAdditiveColor.blue;
            aEnableExtraAdditiveDraw = true;
         }
         this.mBodyReanim.useColor = aEnableExtraAdditiveDraw;
         this.mBodyReanim.overrideColor = aColorOverride;
         this.mBodyReanim.additiveColor = aExtraAdditiveColor;
         if(!this.IsOnBoard())
         {
            this.mBodyReanim.x = mX;
            this.mBodyReanim.y = mY;
            this.mBodyReanim.draw(g);
         }
         else if(this.mZombiePhase == PHASE_RISING_FROM_GRAVE)
         {
            this.mBodyReanim.x = mX;
            this.mBodyReanim.y = mY - this.mAltitude;
            g.setClipRect(mX,mY,mHeight,mWidth);
            this.mBodyReanim.drawLerp(g,this.mScratchMatrix);
         }
         else
         {
            this.mBodyReanim.x = mX;
            this.mBodyReanim.y = mY;
            this.mBodyReanim.draw(g);
         }
         g.clearClipRect();
      }
      
      public function DropShield(theDamageFlags:int) : void
      {
         var aPoint:Point = null;
         var anEffect:ParticleSystem = null;
         var anArray:Array = null;
         if(this.mShieldType == SHIELDTYPE_NONE)
         {
            return;
         }
         var aDrawPos:ZombieDrawPosition = mScratchPosition;
         this.GetDrawPos(aDrawPos);
         if(this.mShieldType == SHIELDTYPE_DOOR)
         {
            aPoint = this.mBodyReanim.getTrackPosition("anim_screendoor1");
            this.DetachShield();
            if(theDamageFlags != DAMAGE_DOESNT_LEAVE_BODY)
            {
               anEffect = app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_ZOMBIEDOOR);
               anEffect.setPosition(aPoint.x + mX,aPoint.y + mY);
               mBoard.mRenderManager.add(new ParticleRenderable(anEffect,RENDER_LAYER_PARTICLE));
            }
         }
         else if(this.mShieldType == SHIELDTYPE_NEWSPAPER)
         {
            aPoint = this.mBodyReanim.getTrackPosition("Zombie_paper_paper3");
            this.StopEating();
            this.mZombiePhase = PHASE_NEWSPAPER_MADDENING;
            anArray = new Array("anim_walk_nopaper");
            this.PlayZombieReanim("anim_gasp",new ReanimLoopQueue(anArray),8);
            this.DetachShield();
            if(theDamageFlags != DAMAGE_DOESNT_LEAVE_BODY)
            {
               anEffect = app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_ZOMBIENEWSPAPER);
               anEffect.setPosition(aPoint.x + mX,aPoint.y + mY);
               mBoard.mRenderManager.add(new ParticleRenderable(anEffect,RENDER_LAYER_PARTICLE));
            }
            if(theDamageFlags != DAMAGE_DOESNT_LEAVE_BODY && theDamageFlags != DAMAGE_BYPASSES_SHIELD)
            {
               app.foleyManager.playFoley(PVZFoleyType.NEWSPAPER_RIP);
            }
         }
         this.mShieldType = SHIELDTYPE_NONE;
      }
      
      public function Draw(g:Graphics2D) : void
      {
         this.GetDrawPos(this.scratchDrawPos);
         if(mBoard.mGameScene == SCENE_ZOMBIES_WON)
         {
            if(!this.SetupDrawZombieWon(g))
            {
               return;
            }
         }
         this.DrawReanim(g,this.scratchDrawPos);
         g.clearClipRect();
         if(this.mHeadParticle != null)
         {
         }
         if(this.mArmParticle != null)
         {
            this.mArmParticle.draw(g);
         }
         if(this.mHelmParticle != null)
         {
            this.mHelmParticle.draw(g);
         }
         if(this.mFlagParticle != null)
         {
            this.mFlagParticle.draw(g);
         }
      }
      
      public function DropPole() : void
      {
         if(this.mZombieType != ZOMBIE_POLEVAULTER)
         {
            return;
         }
         this.mBodyReanim.setTrackVisible("Zombie_polevaulter_innerarm_upper",false);
         this.mBodyReanim.setTrackVisible("Zombie_polevaulter_innerarm_lower",false);
         this.mBodyReanim.setTrackVisible("Zombie_polevaulter_innerhand",false);
         this.mBodyReanim.setTrackVisible("Zombie_polevaulter_pole",false);
         this.mBodyReanim.setTrackVisible("Zombie_polevaulter_pole2",false);
      }
      
      public function UpdateZombieRiseFromGrave() : void
      {
         this.mAltitude = TodCommon.TodAnimateCurve(50,0,this.mPhaseCounter,-200,0,TodCommon.CURVE_LINEAR);
         if(this.mPhaseCounter == 0)
         {
            this.mZombiePhase = PHASE_ZOMBIE_NORMAL;
         }
      }
      
      public function GetBodyDamageIndex() : int
      {
         if(this.mBodyHealth < this.mBodyMaxHealth / 3)
         {
            return 2;
         }
         if(this.mBodyHealth < this.mBodyMaxHealth * 2 / 3)
         {
            return 1;
         }
         return 0;
      }
      
      public function DropHead(theDamageFlags:int) : void
      {
         if(!this.CanLoseBodyParts())
         {
            return;
         }
         if(!this.mHasHead)
         {
            return;
         }
         this.mHasHead = false;
         this.mBodyReanim.setTrackVisible("anim_head1",false);
         this.mBodyReanim.setTrackVisible("anim_head2",false);
         this.mBodyReanim.setTrackVisible("anim_hair",false);
         this.mBodyReanim.setTrackVisible("anim_tongue",false);
         if(theDamageFlags == DAMAGE_DOESNT_LEAVE_BODY)
         {
            return;
         }
         if(this.mZombieType == ZOMBIE_NEWSPAPER)
         {
            this.mBodyReanim.setTrackVisible("anim_hairpiece",false);
            this.mBodyReanim.setTrackVisible("anim_head_jaw",false);
            this.mBodyReanim.setTrackVisible("anim_head_glasses",false);
         }
         var aDrawPos:ZombieDrawPosition = this.scratchDrawPos;
         this.GetDrawPos(aDrawPos);
         var aPosX:Number = this.mPosX + aDrawPos.mHeadX + aDrawPos.mImageOffsetX;
         var aPosY:Number = this.mPosY + aDrawPos.mHeadY + aDrawPos.mImageOffsetY;
         var aPoint:Point = this.mBodyReanim.getTrackPosition("anim_head1");
         aPosX += aPoint.x;
         aPosY += aPoint.y;
         if(this.mZombieType == ZOMBIE_POLEVAULTER)
         {
            aPosX += 0;
            aPosY += 40;
         }
         else if(this.mZombieType == ZOMBIE_NEWSPAPER)
         {
            aPosX += -2;
            aPosY += 22;
         }
         else if(this.mZombieType == ZOMBIE_FOOTBALL)
         {
            aPosX += 4;
            aPosY += 40;
         }
         else
         {
            aPosX += -15;
            aPosY += 15;
         }
         var anEffect:String = PVZParticles.PARTICLE_ZOMBIEHEAD;
         if(this.mZombiePhase == PHASE_ZOMBIE_MOWERED)
         {
            anEffect = PVZParticles.PARTICLE_MOWEREDZOMBIEHEAD;
         }
         else if(this.mZombieType == ZOMBIE_FOOTBALL)
         {
            anEffect = PVZParticles.PARTICLE_ZOMBIEFOOTBALLHEAD;
         }
         else if(this.mZombieType == ZOMBIE_NEWSPAPER)
         {
            anEffect = PVZParticles.PARTICLE_ZOMBIENEWSPAPERHEAD;
         }
         else if(this.mZombieType == ZOMBIE_POLEVAULTER)
         {
            anEffect = PVZParticles.PARTICLE_ZOMBIEPOLEVALUTHEAD;
         }
         if(this.mZombieType == ZOMBIE_POLEVAULTER)
         {
            this.DropPole();
         }
         else if(this.mZombieType == ZOMBIE_FLAG)
         {
            this.DropFlag();
         }
         this.mHeadParticle = app.particleManager.spawnParticleSystem(anEffect);
         this.mHeadParticle.setPosition(aPosX,aPosY);
         if(this.mChilledCounter > 0)
         {
            this.mHeadParticle.mEmitterList[0].mColorOverride = gChilledColor;
         }
         mBoard.mRenderManager.add(new ParticleRenderable(this.mHeadParticle,RENDER_LAYER_ZOMBIE + mRow));
         app.foleyManager.playFoley(PVZFoleyType.LIMBS_POP);
      }
      
      public function UpdateMowered() : void
      {
      }
      
      public function RiseFromGrave(theCol:int, theRow:int) : void
      {
         this.mPosX = mBoard.GridToPixelX(theCol,mRow);
         this.mPosY = this.GetPosYBasedOnRow(theRow);
         mRow = theRow;
         mX = int(this.mPosX);
         mY = int(this.mPosY);
         this.mZombiePhase = PHASE_RISING_FROM_GRAVE;
         this.mPhaseCounter = 150;
         this.mAltitude = -200;
         var aParticleX:int = int(this.mPosX) + 20;
         var aParticleY:int = int(this.mPosY) + 85;
         var anEffect:ParticleSystem = app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_ZOMBIERISE);
         anEffect.setPosition(aParticleX,aParticleY);
         mBoard.mRenderManager.add(new ParticleRenderable(anEffect,RENDER_LAYER_ZOMBIE - 1));
         app.foleyManager.playFoley(PVZFoleyType.GRAVESTONE_RUMBLE);
      }
      
      public function CanTargetPlant(thePlant:CPlant, theAttackType:int) : Boolean
      {
         if(mBoard.IsWallnutBowlingLevel() && theAttackType != ATTACKTYPE_VAULT)
         {
            return false;
         }
         if(theAttackType == ATTACKTYPE_CHEW)
         {
         }
         if(theAttackType == ATTACKTYPE_VAULT)
         {
         }
         return true;
      }
      
      public function IsOnBoard() : Boolean
      {
         if(this.mFromWave == -2)
         {
            return false;
         }
         return true;
      }
      
      public function PlayDeathAnim(theDamageFlags:int) : void
      {
         var aDeathAnimRate:Number = NaN;
         if(this.mZombiePhase == PHASE_ZOMBIE_DYING || this.mZombiePhase == PHASE_ZOMBIE_BURNED || this.mZombiePhase == PHASE_ZOMBIE_MOWERED)
         {
            return;
         }
         if(theDamageFlags == DAMAGE_DOESNT_LEAVE_BODY)
         {
            this.DieNoLoot();
            return;
         }
         this.StopEating();
         this.mZombiePhase = PHASE_ZOMBIE_DYING;
         this.mVelX = 0;
         if(this.mZombieType == ZOMBIE_FOOTBALL)
         {
            aDeathAnimRate = 24;
         }
         else
         {
            aDeathAnimRate = TodCommon.RandRangeFloat(24,30);
         }
         this.mBodyReanim.loopType = Reanimation.LOOP_TYPE_ONCE_AND_HOLD;
         this.mBodyReanim.currentTrack = "anim_death";
         this.mBodyReanim.animRate = aDeathAnimRate;
      }
      
      public function AnimateChewSound() : void
      {
         var aPlant:CPlant = this.FindPlantTarget(ATTACKTYPE_CHEW);
         if(aPlant == null)
         {
            return;
         }
         if(aPlant)
         {
            if(aPlant.mSeedType == SEED_WALLNUT)
            {
               app.foleyManager.playFoley(PVZFoleyType.CHOMP_SOFT);
            }
            else
            {
               app.foleyManager.playFoley(PVZFoleyType.CHOMP);
            }
         }
      }
      
      public function UpdateZombiePolevaulter() : void
      {
         var aPlant:CPlant = null;
         var aAnimDuration:Number = NaN;
         var aJumpDistance:int = 0;
         var aLanded:Boolean = false;
         var aOldPosX:Number = NaN;
         if(this.mZombiePhase == PHASE_POLEVAULTER_PRE_VAULT && this.mHasHead && this.mZombieHeight == HEIGHT_ZOMBIE_NORMAL)
         {
            aPlant = this.FindPlantTarget(ATTACKTYPE_VAULT);
            if(aPlant)
            {
               this.mZombiePhase = PHASE_POLEVAULTER_IN_VAULT;
               this.PlayZombieReanim("anim_jump",Reanimation.LOOP_TYPE_ONCE_AND_HOLD,24);
               aAnimDuration = this.mBodyReanim.frameCount / this.mBodyReanim.animRate * 100;
               aJumpDistance = mX - aPlant.mX - 54;
               if(mBoard.IsWallnutBowlingLevel())
               {
                  aJumpDistance = 0;
               }
               this.mVelX = Number(aJumpDistance) / Number(aAnimDuration);
               this.mHasObject = false;
            }
         }
         else if(this.mZombiePhase == PHASE_POLEVAULTER_IN_VAULT)
         {
            aLanded = false;
            if(this.mBodyReanim.animTime == 1)
            {
               this.mBodyReanim.animRate = 24;
               this.mBodyReanim.currentTrack = "anim_walk";
               this.mBodyReanim.loopType = Reanimation.LOOP_TYPE_ALWAYS;
               aLanded = true;
               this.mPosX -= 101;
            }
            if(this.mBodyReanim.shouldTriggerTimedEvent(0.2))
            {
            }
            if(this.mBodyReanim.shouldTriggerTimedEvent(0.4))
            {
               app.foleyManager.playFoley(PVZFoleyType.POLEVAULT);
            }
            if(aLanded)
            {
               mX = this.mPosX;
               this.mZombiePhase = PHASE_POLEVAULTER_POST_VAULT;
               this.mZombieAttackRect = new Rectangle(10,0,33,77);
               this.StartWalkAnim(0);
            }
            else
            {
               aOldPosX = this.mPosX;
               this.mPosX -= 150 * this.mBodyReanim.animTime;
               this.mPosY = this.GetPosYBasedOnRow(mRow);
               this.mPosX = aOldPosX;
            }
         }
      }
      
      public function TakeBodyDamage(theDamage:int, theDamageFlags:int) : void
      {
         if(theDamageFlags != DAMAGE_DOESNT_CAUSE_FLASH)
         {
            this.mJustGotShotCounter = 25;
         }
         if(theDamageFlags == DAMAGE_FREEZE)
         {
            this.ApplyChill(false);
         }
         var aOldHealth:int = this.mBodyHealth;
         var oldIndex:int = this.GetBodyDamageIndex();
         this.mBodyHealth -= theDamage;
         var newIndex:int = this.GetBodyDamageIndex();
         this.UpdateDamageStates(theDamageFlags);
         if(this.mBodyHealth <= 0)
         {
            this.mBodyHealth = 0;
            this.PlayDeathAnim(theDamageFlags);
            this.DropLoot();
         }
      }
      
      public function UpdateAnimSpeed() : void
      {
         var aTrackIndex:int = 0;
         if(!this.IsOnBoard())
         {
            return;
         }
         if(this.IsDeadOrDying())
         {
            this.mBodyReanim.animRate = this.mOrginalAnimRate;
            return;
         }
         if(this.mIsEating)
         {
            if(this.mZombieType == ZOMBIE_POLEVAULTER)
            {
               if(this.mChilledCounter > 0)
               {
                  this.mBodyReanim.animRate = 10;
               }
               else
               {
                  this.mBodyReanim.animRate = 20;
               }
            }
            else if(this.mChilledCounter > 0)
            {
               this.mBodyReanim.animRate = 18;
            }
            else
            {
               this.mBodyReanim.animRate = 36;
            }
            return;
         }
         if(this.ZombieNotWalking())
         {
            this.mBodyReanim.animRate = this.mOrginalAnimRate;
            return;
         }
         for(var i:int = 0; i < this.mBodyReanim.definition.tracks.length; i++)
         {
            if(this.mBodyReanim.definition.tracks[i].name == "_ground")
            {
               aTrackIndex = i;
               break;
            }
         }
         var aDistance:Number = this.mBodyReanim.getTrackVelocity("_ground",true);
         if(isNaN(aDistance) || aDistance < TodCommon.EPSILON)
         {
            return;
         }
         var aFramesPerPixel:Number = this.mBodyReanim.frameCount / aDistance;
         var aSpeed:Number = this.mVelX * aFramesPerPixel * 31 / this.mScaleZombie;
         if(isNaN(aSpeed))
         {
            throw new Error();
         }
         this.mBodyReanim.animRate = aSpeed;
         if(this.mChilledCounter > 0)
         {
            this.mBodyReanim.animRate *= 0.5;
         }
      }
      
      public function UpdateActions() : void
      {
         if(this.mZombieHeight == HEIGHT_FALLING)
         {
            this.UpdateZombieFalling();
         }
         if(this.mZombieType == ZOMBIE_POLEVAULTER)
         {
            this.UpdateZombiePolevaulter();
         }
         if(this.mZombieType == ZOMBIE_NEWSPAPER)
         {
            this.UpdateZombieNewspaper();
         }
      }
      
      public function UpdateDamageStates(theDamageFlags:int) : void
      {
         if(!this.CanLoseBodyParts())
         {
            return;
         }
         var aHealthLeft:Number = this.mBodyHealth / this.mBodyMaxHealth;
         if(this.mHasArm && aHealthLeft <= 0.66 && this.mBodyHealth > 0)
         {
            this.DropArm(theDamageFlags);
         }
         if(this.mHasHead && aHealthLeft <= 0.33)
         {
            this.DropHead(theDamageFlags);
            this.DropLoot();
            this.StopZombieSound();
            if(mBoard.HasLevelAwardDropped())
            {
               this.PlayDeathAnim(theDamageFlags);
            }
         }
      }
      
      public function StartWalkAnim(theBlendTime:int) : void
      {
         if(this.mZombiePhase == PHASE_NEWSPAPER_MAD)
         {
            this.PickRandomSpeed();
            this.PlayZombieReanim("anim_walk_nopaper",Reanimation.LOOP_TYPE_ALWAYS,0);
            return;
         }
         var aWalkPermuation:int = Math.random() * 2;
         if(this.mZombieType == ZOMBIE_FLAG)
         {
            aWalkPermuation = 0;
         }
         if(aWalkPermuation == 0)
         {
            if(this.mZombieType != ZOMBIE_POLEVAULTER && this.mZombieType != ZOMBIE_NEWSPAPER && this.mZombieType != ZOMBIE_FOOTBALL)
            {
               this.mBodyReanim.currentTrack = "anim_walk2";
               return;
            }
         }
         this.mBodyReanim.currentTrack = "anim_walk";
         this.PickRandomSpeed();
      }
      
      public function AnimateChewEffect() : void
      {
         var aDrawPos:ZombieDrawPosition = null;
         var aPosX:Number = NaN;
         var aPosY:Number = NaN;
         var anEffect:ParticleSystem = null;
         var aPlant:CPlant = this.FindPlantTarget(ATTACKTYPE_CHEW);
         if(aPlant == null)
         {
            return;
         }
         if(aPlant)
         {
            if(aPlant.mSeedType == SEED_WALLNUT)
            {
               aDrawPos = this.scratchDrawPos;
               this.GetDrawPos(aDrawPos);
               aPosX = this.mPosX + 37;
               aPosY = this.mPosY + 40 + aDrawPos.mBodyY;
               anEffect = app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_WALLNUTEATSMALL);
               anEffect.setPosition(aPosX,aPosY);
               mBoard.mRenderManager.add(new ParticleRenderable(anEffect,RENDER_LAYER_PARTICLE));
            }
         }
         aPlant.mEatenFlashCountdown = Math.max(aPlant.mEatenFlashCountdown,25);
      }
      
      public function SetupDoorArms(theShow:Boolean) : void
      {
         var aRenderArms:Boolean = true;
         var aRenderDoor:Boolean = false;
         if(theShow)
         {
            aRenderArms = false;
            aRenderDoor = true;
         }
         this.mBodyReanim.setTrackVisible("anim_innerarm1",aRenderArms);
         this.mBodyReanim.setTrackVisible("anim_innerarm2",aRenderArms);
         this.mBodyReanim.setTrackVisible("anim_innerarm3",aRenderArms);
         this.mBodyReanim.setTrackVisible("Zombie_outerarm_lower",aRenderArms);
         this.mBodyReanim.setTrackVisible("Zombie_outerarm_hand",aRenderArms);
         this.mBodyReanim.setTrackVisible("Zombie_outerarm_upper",aRenderArms);
         this.mBodyReanim.setTrackVisible("anim_innerarm",aRenderArms);
         this.mBodyReanim.setTrackVisible("Zombie_outerarm_screendoor",aRenderDoor);
         this.mBodyReanim.setTrackVisible("Zombie_innerarm_screendoor",aRenderDoor);
         this.mBodyReanim.setTrackVisible("Zombie_innerarm_screendoor_hand",aRenderDoor);
      }
      
      public function TrySpawnLevelAward() : Boolean
      {
         var aCoinType:String = null;
         var aGridX:int = 0;
         if(!this.IsOnBoard())
         {
            return false;
         }
         if(mBoard.HasLevelAwardDropped())
         {
            return false;
         }
         if(this.mDroppedLoot)
         {
            return false;
         }
         if(app.IsScaryPotterLevel())
         {
            if(!mBoard.mChallenge.ScaryPotterIsCompleted())
            {
               return false;
            }
         }
         else
         {
            if(mBoard.mCurrentWave < mBoard.mNumWaves)
            {
               return false;
            }
            if(mBoard.AreEnemyZombiesOnScreen())
            {
               return false;
            }
         }
         mBoard.mLevelAwardSpawned = true;
         app.mBoardResult = PVZApp.BOARDRESULT_WON;
         var aZombieRect:Rectangle = this.GetZombieRect();
         var aCenterX:int = aZombieRect.x + aZombieRect.width / 2;
         var aCenterY:int = aZombieRect.y + aZombieRect.height / 4;
         mBoard.RemoveAllZombies();
         if(mBoard.mLevel == 14)
         {
            aCoinType = COIN_NONE;
            mBoard.FadeOutLevel();
         }
         else if(app.IsScaryPotterLevel())
         {
            aCoinType = COIN_NONE;
            aGridX = mBoard.PixelToGridXKeepOnBoard(this.mPosX + 75,this.mPosY);
            mBoard.mChallenge.PuzzlePhaseComplete(aGridX,mRow);
         }
         else if(app.IsAdventureMode() && mBoard.mLevel < 14)
         {
            if(mBoard.mLevel == 9)
            {
               aCoinType = COIN_NOTE;
            }
            else if(mBoard.mLevel == 4)
            {
               aCoinType = COIN_SHOVEL;
            }
            else
            {
               aCoinType = COIN_FINAL_SEED_PACKET;
            }
         }
         else if(app.IsSurvivalMode())
         {
            aCoinType = COIN_NONE;
            mBoard.FadeOutLevel();
         }
         else
         {
            aCoinType == COIN_NONE;
         }
         var aMotion:String = COIN_MOTION_COIN;
         app.foleyManager.playFoley(PVZFoleyType.SPAWN_SUN);
         mBoard.AddCoin(aCenterX,aCenterY,aCoinType,aMotion);
         this.mDroppedLoot = true;
         return true;
      }
      
      public function PlayZombieReanim(theTrackName:String, theLoopType:ReanimLoopType, theAnimRate:Number) : void
      {
         if(!this.mBodyReanim)
         {
            return;
         }
         this.mBodyReanim.currentTrack = theTrackName;
         this.mBodyReanim.loopType = theLoopType;
         this.mBodyReanim.animRate = theAnimRate;
         if(theAnimRate != 0)
         {
            this.mOrginalAnimRate = theAnimRate;
         }
         this.UpdateAnimSpeed();
      }
   }
}
