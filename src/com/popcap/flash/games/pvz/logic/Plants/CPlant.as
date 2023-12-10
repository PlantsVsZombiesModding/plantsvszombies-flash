package com.popcap.flash.games.pvz.logic.Plants
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.resources.particles.ParticleSystem;
   import com.popcap.flash.framework.resources.reanimator.ReanimLoopType;
   import com.popcap.flash.framework.resources.reanimator.Reanimation;
   import com.popcap.flash.games.pvz.PVZFoleyType;
   import com.popcap.flash.games.pvz.logic.Board;
   import com.popcap.flash.games.pvz.logic.GameObject;
   import com.popcap.flash.games.pvz.logic.TodCommon;
   import com.popcap.flash.games.pvz.logic.Zombies.Zombie;
   import com.popcap.flash.games.pvz.renderables.ParticleRenderable;
   import com.popcap.flash.games.pvz.resources.PVZParticles;
   import flash.geom.Rectangle;
   
   public class CPlant extends GameObject
   {
      
      public static const SEED_PUFFSHROOM:int = 8;
      
      public static const STATE_SQUASH_RISING:int = 5;
      
      public static const STATE_CHOMPER_BITING:int = 8;
      
      public static const PHASE_ZOMBIE_BURNED:int = 2;
      
      public static const SEED_PEASHOOTER:int = 0;
      
      public static const STATE_BOWLING_DOWN:int = 14;
      
      public static const REANIM_CHERRYBOMB:int = 3;
      
      public static const PHASE_ZOMBIE_DYING:int = 1;
      
      public static const RENDER_LAYER_SCREEN_FADE:int = 900000;
      
      public static const PROJECTILE_PUFF:int = 2;
      
      public static const STATE_SUNSHROOM_GROWING:int = 16;
      
      public static const DAMAGE_HITS_SHIELD_AND_BODY:int = 1;
      
      public static const REANIM_SQUASH:int = 4;
      
      public static const SEED_GRAVEBUSTER:int = 11;
      
      public static const RENDER_LAYER_FOG:int = 500000;
      
      public static const STATE_BOWLING_UP:int = 13;
      
      public static const DAMAGE_SPIKE:int = 5;
      
      public static const STATE_CHOMPER_SWALLOWING:int = 12;
      
      public static const SEED_EXPLODE_O_NUT:int = 50;
      
      public static const STATE_READY:int = 1;
      
      public static const SEED_SUNFLOWER:int = 1;
      
      private static const HELMTYPE_PAIL:int = 2;
      
      public static const PHASE_ZOMBIE_NORMAL:int = 0;
      
      public static const SEED_NONE:int = -1;
      
      public static const SEED_CHERRYBOMB:int = 2;
      
      public static const STATE_CHOMPER_DIGESTING:int = 11;
      
      public static const SEED_CHOMPER:int = 6;
      
      public static const PROJECTILE_SNOWPEA:int = 1;
      
      public static const RENDER_LAYER_GROUND:int = 200000;
      
      public static const DAMAGE_FREEZE:int = 2;
      
      public static const STATE_DOINGSPECIAL:int = 2;
      
      public static const DAMAGE_BYPASSES_SHIELD:int = 0;
      
      public static const TICKS_PER_SECOND:int = 100;
      
      public static const SEED_SUNSHROOM:int = 9;
      
      public static const SEED_WALLNUT:int = 3;
      
      public static const PHASE_POLEVAULTER_IN_VAULT:int = 5;
      
      private static const HELMTYPE_NONE:int = 0;
      
      public static const STATE_SQUASH_PRE_LAUNCH:int = 4;
      
      public static const RENDER_LAYER_LAWN:int = 300000;
      
      public static const RENDER_LAYER_PARTICLE:int = RENDER_LAYER_LAWN + 7000;
      
      public static const RENDER_LAYER_PLANT:int = RENDER_LAYER_LAWN + 2000;
      
      public static const RENDER_LAYER_PROJECTILE:int = RENDER_LAYER_LAWN + 5000;
      
      public static const PROJECTILE_PEA:int = 0;
      
      private static const HELMTYPE_TRAFFIC_CONE:int = 1;
      
      public static const RENDER_LAYER_ABOVE_UI:int = 800000;
      
      public static const SEED_REPEATER:int = 7;
      
      public static const STATE_SUNSHROOM_BIG:int = 17;
      
      public static const STATE_GRAVEBUSTER_LANDING:int = 18;
      
      public static const STATE_GRAVEBUSTER_EATING:int = 19;
      
      public static const STATE_CHOMPER_BITING_MISSED:int = 10;
      
      public static const SEED_FUMESHROOM:int = 10;
      
      public static const SEED_SNOWPEA:int = 5;
      
      public static const STATE_CHOMPER_BITING_GOT_ONE:int = 9;
      
      public static const STATE_NOTREADY:int = 0;
      
      public static const WEAPON_PRIMARY:int = 0;
      
      public static const PHASE_POLEVAULTER_PRE_VAULT:int = 4;
      
      public static const RENDER_LAYER_TOP:int = 400000;
      
      public static const RENDER_LAYER_LAWN_MOWER:int = RENDER_LAYER_LAWN + 6000;
      
      public static const DAMAGE_DOESNT_LEAVE_BODY:int = 4;
      
      public static const REANIM_SUNFLOWER:int = 2;
      
      public static const SEED_SQUASH:int = 4;
      
      public static const PHASE_POLEVAULTER_POST_VAULT:int = 6;
      
      public static const STATE_SQUASH_LOOK:int = 3;
      
      public static const REANIM_NONE:int = -1;
      
      public static const REANIM_PEASHOOTER:int = 0;
      
      public static const STATE_SQUASH_DONE_FALLING:int = 7;
      
      public static const RENDER_LAYER_UI_TOP:int = 700000;
      
      public static const PHASE_ZOMBIE_MOWERED:int = 3;
      
      public static const REANIM_WALLNUT:int = 1;
      
      public static const SEED_LEFTPEATER:int = 49;
      
      public static const RENDER_LAYER_COIN_BANK:int = 600000;
      
      public static const RENDER_LAYER_GRAVE_STONE:int = RENDER_LAYER_LAWN + 1000;
      
      public static const STATE_SQUASH_FALLING:int = 6;
      
      public static const STATE_SUNSHROOM_SMALL:int = 15;
      
      public static const GRAVE_BUSTER_EAT_TIME:int = 400;
      
      public static const DAMAGE_DOESNT_CAUSE_FLASH:int = 3;
      
      public static const RENDER_LAYER_ZOMBIE:int = RENDER_LAYER_LAWN + 3000;
      
      public static const RENDER_LAYER_UI_BOTTOM:int = 100000;
       
      
      public var mPlantMaxHealth:int;
      
      public var mFrameLength:int;
      
      public var mFrame:int;
      
      public var mPlantRect:Rectangle;
      
      public var mLaunchRate:int;
      
      public var mBodyReanimation:Reanimation;
      
      public var mBlinkCountdown:int;
      
      public var mDisappearCountdown:int;
      
      public var mHeadReanimation:Reanimation;
      
      public var mPlantCol:int;
      
      public var mState:int;
      
      public var mStartRow:int;
      
      public var mTargetZombie:Zombie;
      
      public var mHighlighted:Boolean;
      
      public var mWakeUpCounter:int;
      
      public var mSquished:Boolean;
      
      public var mTargetX:int;
      
      public var mTargetY:int;
      
      public var mAnimPing:Boolean;
      
      public var mBlinkReanimation:Reanimation;
      
      public var mSubclass:int;
      
      public var mRecentlyEatenCountdown:int;
      
      public var mEatenFlashCountdown:int;
      
      public var mSeedType:int;
      
      public var mLaunchCounter:int;
      
      public var mReanimationType:int;
      
      public var mNumFrames:int;
      
      public var mPlantAttackRect:Rectangle;
      
      public var mShootingCounter:int;
      
      public var mIsAsleep:Boolean;
      
      public var mDoSpecialCountdown:int;
      
      public var mDead:Boolean;
      
      public var mStateCountdown:int;
      
      public var mPlantHealth:int;
      
      public var mAnimCounter:int;
      
      public function CPlant()
      {
         super();
      }
      
      public function GetPlantAttackRect(thePlantWeapon:int) : Rectangle
      {
         var aRect:Rectangle = null;
         if(mBoard.IsWallnutBowlingLevel())
         {
            aRect = new Rectangle(mX + 0,mY,mWidth - 14,mHeight);
         }
         else if(this.mSeedType == SEED_SQUASH)
         {
            aRect = new Rectangle(mX + 14,mY,mWidth - 23,mHeight);
         }
         else if(this.mSeedType == SEED_CHOMPER)
         {
            aRect = new Rectangle(mX + 54,mY,28,mHeight);
         }
         else if(this.mSeedType == SEED_PUFFSHROOM)
         {
            aRect = new Rectangle(mX + 40,mY,155,mHeight);
         }
         else if(this.mSeedType == SEED_FUMESHROOM)
         {
            aRect = new Rectangle(mX + 40,mY,230,mHeight);
         }
         else if(this.mSeedType == SEED_LEFTPEATER)
         {
            aRect = new Rectangle(0,mY,mX,mHeight);
         }
         else
         {
            aRect = new Rectangle(mX + 41,mY,540,mHeight);
         }
         return aRect;
      }
      
      public function UpdateReanim() : void
      {
         this.mBodyReanimation.update();
         if(!this.mHeadReanimation)
         {
         }
      }
      
      public function DoSpecial() : void
      {
      }
      
      public function FindTargetZombie(theRow:int, thePlantWeapon:int) : Zombie
      {
         var aZombie:Zombie = null;
         var aRowDiff:int = 0;
         var aRange:int = 0;
         var aZombieRect:Rectangle = null;
         var aOverlap:int = 0;
         var aPickWeight:int = 0;
         var aAttackRect:Rectangle = this.GetPlantAttackRect(thePlantWeapon);
         var aHighestWeight:int = 0;
         var aBestZombie:Zombie = null;
         for each(aZombie in mBoard.mZombies)
         {
            aRowDiff = aZombie.mRow - theRow;
            aRange = 0;
            if(aRowDiff == 0)
            {
               if(aZombie.EffectedByDamage())
               {
                  if(aZombie.mFromWave != Zombie.ZOMBIE_WAVE_CUTSCENE)
                  {
                     if(this.mSeedType == SEED_CHOMPER)
                     {
                        if(aZombie.IsDeadOrDying() || !aZombie.mHasHead)
                        {
                           continue;
                        }
                        if(aZombie.mIsEating || this.mState == STATE_CHOMPER_BITING)
                        {
                           aRange = 60;
                        }
                     }
                     if(this.mSeedType == SEED_EXPLODE_O_NUT)
                     {
                        if(aZombie.mZombiePhase == PHASE_POLEVAULTER_IN_VAULT)
                        {
                           continue;
                        }
                     }
                     aZombieRect = aZombie.GetZombieRect();
                     aOverlap = mBoard.GetRectOverlap(aAttackRect,aZombieRect);
                     if(aOverlap >= -aRange)
                     {
                        aPickWeight = -aZombieRect.x;
                        if(!aBestZombie || aPickWeight > aHighestWeight)
                        {
                           aHighestWeight = aPickWeight;
                           aBestZombie = aZombie;
                        }
                     }
                  }
               }
            }
         }
         return aBestZombie;
      }
      
      public function PlayBodyReanim(theTrackName:String, theLoopType:ReanimLoopType, theBlendTime:int, theAnimRate:Number) : void
      {
      }
      
      public function SetSleeping(theIsAsleep:Boolean) : void
      {
         var aAnimTime:Number = NaN;
         if(this.mIsAsleep == theIsAsleep)
         {
            return;
         }
         this.mIsAsleep = theIsAsleep;
         if(theIsAsleep)
         {
            aAnimTime = this.mBodyReanimation.animTime;
            this.mBodyReanimation.currentTrack = "anim_sleep";
            this.mBodyReanimation.animTime = aAnimTime;
         }
         else
         {
            aAnimTime = this.mBodyReanimation.animTime;
            this.mBodyReanimation.currentTrack = "anim_idle";
            this.mBodyReanimation.animTime = aAnimTime;
         }
      }
      
      public function UpdateBowling() : void
      {
         var aPosX:int = 0;
         var aPosY:int = 0;
         var anEffect:ParticleSystem = null;
         var aSpeed:Number = this.mBodyReanimation.getTrackVelocity("_ground");
         mX -= aSpeed;
         if(mX > 540)
         {
            this.Die();
         }
         var aRowSpeed:int = 2;
         if(this.mState == STATE_BOWLING_UP)
         {
            mY -= aRowSpeed;
         }
         else if(this.mState == STATE_BOWLING_DOWN)
         {
            mY += aRowSpeed;
         }
         var aDiffY:int = mBoard.GridToPixelY(0,mRow) - mY;
         if(aDiffY > 2 || aDiffY < -2)
         {
            return;
         }
         var aNewState:int = this.mState;
         if(aNewState == STATE_BOWLING_UP && mRow == 0)
         {
            aNewState = STATE_BOWLING_DOWN;
         }
         else if(aNewState == STATE_BOWLING_DOWN && mRow == 4)
         {
            aNewState = STATE_BOWLING_UP;
         }
         var aZombie:Zombie = this.FindTargetZombie(mRow,WEAPON_PRIMARY);
         if(aZombie)
         {
            aPosX = mX + mWidth / 2;
            aPosY = mY + mHeight / 2;
            if(this.mSeedType == SEED_EXPLODE_O_NUT)
            {
               app.foleyManager.playFoley(PVZFoleyType.CHERRYBOMB);
               app.foleyManager.playFoley(PVZFoleyType.BOWLINGIMPACT2);
               mBoard.KillAllZombiesInRadius(mRow,aPosX,aPosY,90,1,true);
               anEffect = app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_POWIE);
               anEffect.setPosition(aPosX,aPosY);
               mBoard.mRenderManager.add(new ParticleRenderable(anEffect));
               mBoard.ShakeBoard(2,-4);
               this.Die();
               return;
            }
            app.foleyManager.playFoley(PVZFoleyType.BOWLINGIMPACT);
            if(aZombie.mHelmType != HELMTYPE_NONE)
            {
               if(aZombie.mHelmType == HELMTYPE_PAIL)
               {
                  app.foleyManager.playFoley(PVZFoleyType.SHIELD_HIT);
               }
               else if(aZombie.mHelmType == HELMTYPE_TRAFFIC_CONE)
               {
                  app.foleyManager.playFoley(PVZFoleyType.PLASTIC_HIT);
               }
               aZombie.TakeHelmDamage(900,0);
            }
            else
            {
               aZombie.TakeDamage(1800,0);
            }
            if(mRow == 4 || this.mState == STATE_BOWLING_DOWN)
            {
               aNewState = STATE_BOWLING_UP;
            }
            else if(mRow == 0 || this.mState == STATE_BOWLING_UP)
            {
               aNewState = STATE_BOWLING_DOWN;
            }
            else if(Math.random() * 2 == 0)
            {
               aNewState = STATE_BOWLING_DOWN;
            }
            else
            {
               aNewState = STATE_BOWLING_UP;
            }
         }
         if(aNewState == STATE_BOWLING_UP)
         {
            this.mState = STATE_BOWLING_UP;
            --mRow;
         }
         else if(aNewState == STATE_BOWLING_DOWN)
         {
            this.mState = STATE_BOWLING_DOWN;
            ++mRow;
         }
      }
      
      public function IsOnBoard() : Boolean
      {
         return true;
      }
      
      public function DoBlink() : void
      {
      }
      
      public function IsNocturnal(theSeedtype:int) : Boolean
      {
         if(theSeedtype == SEED_PUFFSHROOM || theSeedtype == SEED_SUNSHROOM || theSeedtype == SEED_FUMESHROOM)
         {
            return true;
         }
         return false;
      }
      
      public function Animate() : void
      {
      }
      
      public function getRow() : int
      {
         return mRow;
      }
      
      public function MouseDown(x:int, y:int) : void
      {
      }
      
      public function getCol() : int
      {
         return this.mPlantCol;
      }
      
      public function UpdateReanimColor() : void
      {
         var aFade:Number = NaN;
         if(this.mSeedType == SEED_EXPLODE_O_NUT)
         {
            this.mBodyReanimation.useColor = true;
            this.mBodyReanimation.overrideColor.alpha = 1;
            this.mBodyReanimation.overrideColor.red = 1;
            this.mBodyReanimation.overrideColor.green = 0.25;
            this.mBodyReanimation.overrideColor.blue = 0.25;
         }
         if(this.mHighlighted)
         {
            this.mBodyReanimation.useColor = true;
            this.mBodyReanimation.overrideColor.alpha = 1;
            this.mBodyReanimation.overrideColor.red = 1;
            this.mBodyReanimation.overrideColor.green = 1;
            this.mBodyReanimation.overrideColor.blue = 1;
            this.mBodyReanimation.additiveColor.alpha = 50 / 255;
            this.mBodyReanimation.additiveColor.red = 0.25;
            this.mBodyReanimation.additiveColor.green = 0.25;
            this.mBodyReanimation.additiveColor.blue = 0.25;
         }
         else if(this.mEatenFlashCountdown > 0)
         {
            aFade = TodCommon.ClampInt(this.mEatenFlashCountdown * 3,0,255);
            aFade /= 255;
            this.mBodyReanimation.useColor = true;
            this.mBodyReanimation.additiveColor.alpha = 0;
            this.mBodyReanimation.additiveColor.red = aFade;
            this.mBodyReanimation.additiveColor.green = aFade;
            this.mBodyReanimation.additiveColor.blue = aFade;
         }
         else
         {
            this.mBodyReanimation.useColor = false;
         }
      }
      
      public function GetPlantRect() : Rectangle
      {
         var aRect:Rectangle = null;
         aRect = new Rectangle(mX + 10,mY,mWidth - 8,mHeight);
         if(this.mSeedType == SEED_LEFTPEATER)
         {
            aRect.x += 20;
         }
         return aRect;
      }
      
      public function IsInPlay() : Boolean
      {
         return true;
      }
      
      public function Draw(g:Graphics2D) : void
      {
         var aImageIndex:int = 0;
         if(mBoard.mGameScene == Board.SCENE_ZOMBIES_WON || mBoard.mGameScene == Board.SCENE_AWARD)
         {
         }
         var aImageRow:int = 0;
         var aOffsetX:Number = 0;
         var aOffsetY:Number = 0;
         this.mBodyReanimation.x = mX;
         this.mBodyReanimation.y = mY;
         if(mBoard.IsWallnutBowlingLevel())
         {
            this.mBodyReanimation.drawLerp(g);
         }
         else
         {
            this.mBodyReanimation.draw(g);
         }
         if(!this.mHeadReanimation)
         {
         }
      }
      
      public function EndBlink() : void
      {
      }
      
      public function Update() : void
      {
      }
      
      public function getDead() : Boolean
      {
         return this.mDead;
      }
      
      public function UpdateBlink() : void
      {
      }
      
      public function Die() : void
      {
         this.mDead = true;
      }
      
      public function PlayIdleAnim(theRate:Number) : void
      {
      }
   }
}
