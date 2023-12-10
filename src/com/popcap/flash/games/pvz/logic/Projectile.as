package com.popcap.flash.games.pvz.logic
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.resources.particles.ParticleSystem;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.PVZFoleyType;
   import com.popcap.flash.games.pvz.logic.Zombies.Zombie;
   import com.popcap.flash.games.pvz.renderables.ParticleRenderable;
   import com.popcap.flash.games.pvz.resources.PVZImages;
   import com.popcap.flash.games.pvz.resources.PVZParticles;
   import flash.geom.Rectangle;
   
   public class Projectile extends GameObject
   {
      
      private static const BOARD_HEIGHT:int = 405;
      
      private static const BOARD_WIDTH:int = 540;
      
      public static const MOTION_BACKWARDS:int = 2;
      
      private static const LAWN_YMIN:int = 60;
      
      private static const DAMAGE_HITS_SHIELD_AND_BODY:int = 1;
      
      public static const PROJECTILE_PEA:int = 0;
      
      private static const PROJECTILE_SPEED:Number = 3.33 * 0.67;
      
      public static const PROJECTILE_PUFF:int = 2;
      
      private static const DAMAGE_SPIKE:int = 5;
      
      private static const LAWN_YMAX:int = 365;
      
      public static const MOTION_STRAIGHT:int = 0;
      
      private static const DAMAGE_FREEZE:int = 2;
      
      private static const DAMAGE_DOESNT_CAUSE_FLASH:int = 3;
      
      private static const LAWN_XMIN:int = 20;
      
      public static const MOTION_PUFF:int = 1;
      
      private static const DAMAGE_BYPASSES_SHIELD:int = 0;
      
      private static const GRIDSIZEY:int = 5;
      
      public static const PROJECTILE_SNOWPEA:int = 1;
      
      private static const GRIDSIZEX:int = 9;
      
      private static const DAMAGE_DOESNT_LEAVE_BODY:int = 4;
      
      private static const LAWN_XMAX:int = 513;
       
      
      public var mDead:Boolean;
      
      private var mSnowPeaParticlesRenderable:ParticleRenderable;
      
      private var renderCounter:int;
      
      private var mSnowPeaParticles:ParticleSystem;
      
      public var mProjectileType:int;
      
      private var mPosX:Number = 0;
      
      private var mPosY:Number = 0;
      
      private var mImpactRect:Rectangle;
      
      public var mMotionType:int;
      
      public var mDamageRangeFlags:int;
      
      public var mProjectileAge:int;
      
      public var mClickBackoffCounter:int;
      
      public var mDamage:int;
      
      public var mTargetZombieID:Zombie;
      
      public function Projectile()
      {
         super();
         this.mImpactRect = new Rectangle();
      }
      
      public function FindCollisionTarget() : Zombie
      {
         var aZombie:Zombie = null;
         var aRowDiff:int = 0;
         var aZombieRect:Rectangle = null;
         var aProjectileRect:Rectangle = this.mImpactRect;
         var aZombieClosest:Zombie = null;
         var aFarthestLeft:int = 0;
         for each(aZombie in mBoard.mZombies)
         {
            aRowDiff = aZombie.mRow - mRow;
            if(aRowDiff == 0)
            {
               if(!aZombie.IsDeadOrDying())
               {
                  if(aZombie.EffectedByDamage())
                  {
                     aZombieRect = aZombie.GetZombieRect();
                     if(aZombieRect.left <= this.mImpactRect.right)
                     {
                        if(aZombieRect.right >= this.mImpactRect.left)
                        {
                           if(!(Boolean(aZombieClosest) && aZombie.mX >= aFarthestLeft))
                           {
                              aZombieClosest = aZombie;
                              aFarthestLeft = aZombie.mX;
                           }
                        }
                     }
                  }
               }
            }
         }
         return aZombieClosest;
      }
      
      public function DoImpact(theZombie:Zombie) : void
      {
         var aSplatParticleType:String = null;
         var zType:int = 0;
         var aDamageFlags:Number = 0;
         if(this.mProjectileType == PROJECTILE_SNOWPEA)
         {
            aDamageFlags = DAMAGE_FREEZE;
         }
         theZombie.TakeDamage(this.mDamage,aDamageFlags);
         if(theZombie.mHelmHealth > 0)
         {
            zType = theZombie.mZombieType;
            if(theZombie.mZombieType == Zombie.ZOMBIE_TRAFFIC_CONE)
            {
               app.foleyManager.playFoley(PVZFoleyType.PLASTIC_HIT);
            }
            else if(zType == Zombie.ZOMBIE_PAIL || zType == Zombie.ZOMBIE_DOOR)
            {
               app.foleyManager.playFoley(PVZFoleyType.SHIELD_HIT);
            }
         }
         app.foleyManager.playFoley(PVZFoleyType.SPLAT);
         var aSplatPosX:Number = mX + 12 * 0.675;
         var aSplatPosY:Number = mY + 12 * 0.675;
         if(this.mProjectileType == PROJECTILE_PEA)
         {
            aSplatParticleType = PVZParticles.PARTICLE_PEASPLAT;
         }
         else if(this.mProjectileType == PROJECTILE_SNOWPEA)
         {
            aSplatParticleType = PVZParticles.PARTICLE_SNOWPEASPLAT;
         }
         else if(this.mProjectileType == PROJECTILE_PUFF)
         {
            aSplatPosX -= 5;
            aSplatParticleType = PVZParticles.PARTICLE_PUFFSPLAT;
         }
         if(this.mMotionType == MOTION_BACKWARDS)
         {
            aSplatPosX -= 30;
         }
         var anEffect:ParticleSystem = app.particleManager.spawnParticleSystem(aSplatParticleType);
         anEffect.setPosition(aSplatPosX,aSplatPosY);
         mBoard.mRenderManager.add(new ParticleRenderable(anEffect,RENDER_LAYER_PARTICLE));
         this.Die();
      }
      
      public function Die() : void
      {
         if(this.mSnowPeaParticles != null)
         {
            if(this.mSnowPeaParticles.mDead == false)
            {
               this.mSnowPeaParticles.die();
            }
         }
         this.mDead = true;
      }
      
      public function CheckForCollision() : void
      {
         if(mX > BOARD_WIDTH || mX + mWidth < 0)
         {
            this.Die();
            return;
         }
         var aZombie:Zombie = this.FindCollisionTarget();
         if(aZombie != null)
         {
            this.DoImpact(aZombie);
         }
      }
      
      public function Draw(g:Graphics2D) : void
      {
         var aImage:ImageInst = null;
         var aScale:Number = NaN;
         if(this.mProjectileType == PROJECTILE_PEA)
         {
            aImage = app.imageManager.getImageInst(PVZImages.IMAGE_PROJECTILEPEA);
            g.drawImage(aImage,mX,mY);
         }
         else if(this.mProjectileType == PROJECTILE_PUFF)
         {
            aImage = app.imageManager.getImageInst(PVZImages.IMAGE_PUFFSHROOM_PUFF1);
            aScale = TodCommon.TodAnimateCurveFloat(0,30,this.mProjectileAge,0.3,1,TodCommon.CURVE_LINEAR);
            g.pushState();
            g.scale(aScale,aScale);
            g.drawImage(aImage,mX,mY);
            g.popState();
         }
         else
         {
            this.mSnowPeaParticles.draw(g);
            aImage = app.imageManager.getImageInst(PVZImages.IMAGE_PROJECTILESNOWPEA);
            g.drawImage(aImage,mX,mY);
         }
      }
      
      public function Update() : void
      {
         if(mBoard.mGameScene == Board.SCENE_ZOMBIES_WON || mBoard.mGameScene == Board.SCENE_AWARD || mBoard.mGameScene == Board.SCENE_LEVEL_INTRO)
         {
            return;
         }
         ++this.mProjectileAge;
         var aPopToFrontAge:int = 20;
         if(this.mProjectileType == PROJECTILE_PEA || this.mProjectileType == PROJECTILE_SNOWPEA)
         {
            aPopToFrontAge = 0;
         }
         var aParticleOffsetX:Number = 6;
         var aParticleOffsetY:Number = 10;
         if(this.mProjectileType == PROJECTILE_SNOWPEA && this.mSnowPeaParticles != null)
         {
            this.mSnowPeaParticles.update();
            this.mSnowPeaParticles.setPosition(mX + aParticleOffsetX,mY + aParticleOffsetY);
         }
         if(this.mProjectileAge > aPopToFrontAge)
         {
         }
         var deltaX:Number = 0;
         if(this.mMotionType == MOTION_BACKWARDS)
         {
            deltaX -= PROJECTILE_SPEED;
         }
         else
         {
            deltaX += PROJECTILE_SPEED;
         }
         this.mPosX += deltaX;
         mX = int(this.mPosX);
         this.mImpactRect.x = mX;
         if(this.mProjectileType == PROJECTILE_PEA || this.mProjectileType == PROJECTILE_SNOWPEA)
         {
            this.mImpactRect.x -= 15 * 0.675;
         }
         this.CheckForCollision();
      }
      
      public function ProjectileInitialize(theX:int, theY:int, theRenderOrder:int, theRow:int, theProjectileType:int, app:PVZApp, theBoard:Board) : void
      {
         var aParticleOffsetX:Number = NaN;
         var aParticleOffsetY:Number = NaN;
         this.app = app;
         mBoard = theBoard;
         this.mPosX = theX;
         this.mPosY = theY;
         var aGridX:int = mBoard.PixelToGridXKeepOnBoard(theX,theY);
         this.mDamage = 20;
         this.mProjectileType = theProjectileType;
         if(this.mProjectileType == PROJECTILE_PUFF)
         {
            this.mMotionType = MOTION_PUFF;
         }
         else
         {
            this.mMotionType = MOTION_STRAIGHT;
         }
         mRow = theRow;
         this.mDamageRangeFlags = 0;
         this.mDead = false;
         this.mTargetZombieID = null;
         this.mProjectileAge = 0;
         this.mClickBackoffCounter = 0;
         mWidth = int(40 * 0.675);
         mHeight = int(40 * 0.675);
         if(this.mProjectileType == PROJECTILE_SNOWPEA)
         {
            aParticleOffsetX = 8 * 0.675;
            aParticleOffsetY = 13 * 0.675;
            this.mSnowPeaParticles = app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_SNOWPEATRAIL);
            this.mSnowPeaParticles.setPosition(mX + aParticleOffsetX,mY + aParticleOffsetY);
            this.renderCounter = 0;
         }
         mX = int(this.mPosX);
         mY = int(this.mPosY);
         this.mImpactRect.x = mX;
         this.mImpactRect.y = mY;
         this.mImpactRect.width = mWidth;
         this.mImpactRect.height = mHeight;
      }
   }
}
