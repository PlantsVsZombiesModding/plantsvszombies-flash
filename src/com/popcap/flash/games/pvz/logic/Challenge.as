package com.popcap.flash.games.pvz.logic
{
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.resources.particles.ParticleSystem;
   import com.popcap.flash.framework.resources.reanimator.Reanimation;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.PVZFoleyType;
   import com.popcap.flash.games.pvz.logic.Plants.CPlant;
   import com.popcap.flash.games.pvz.logic.Zombies.Zombie;
   import com.popcap.flash.games.pvz.renderables.GridItemRenderable;
   import com.popcap.flash.games.pvz.renderables.ParticleRenderable;
   import com.popcap.flash.games.pvz.renderables.ReanimationRenderable;
   import com.popcap.flash.games.pvz.resources.PVZImages;
   import com.popcap.flash.games.pvz.resources.PVZParticles;
   
   public class Challenge
   {
      
      private static const OBJECT_TYPE_PLANT:int = 1;
      
      private static const CURSOR_TYPE_HAMMER:int = 4;
      
      public static const FLAG_RAISE_TIME:int = 100;
      
      public static const GRIDSQUARE_NONE:int = 0;
      
      public static const REANIM_CHERRYBOMB:int = 3;
      
      public static const BACKGROUND_1_DAY:int = 0;
      
      private static const CURSOR_TYPE_NORMAL:int = 0;
      
      private static const OBJECT_TYPE_NONE:int = 0;
      
      public static const ZOMBIE_DOOR:int = 6;
      
      public static const SCARYPOT_SUN:int = 3;
      
      private static const SCENE_CREDIT:int = 6;
      
      private static const COIN_NONE:String = "none";
      
      private static const SCENE_CHALLENGE:int = 7;
      
      public static const PLANTROW_DIRT:int = 1;
      
      public static const GRIDSQUARE_GRASS:int = 1;
      
      private static const LAWN_XMIN:int = 20;
      
      public static const SCARYPOT_SEED:int = 1;
      
      public static const MAX_ZOMBIE_WAVES:int = 100;
      
      private static const OBJECT_TYPE_SHOVEL:int = 5;
      
      private static const SCENE_LOADING:int = 0;
      
      public static const GRIDITEM_STATE_SCARY_POT_LEAF:int = 4;
      
      public static const GRIDITEM_STATE_SCARY_POT_QUESTION:int = 3;
      
      private static const SEED_NONE:int = -1;
      
      private static const SEED_CHERRYBOMB:int = 2;
      
      private static const SCENE_LEVEL_INTRO:int = 2;
      
      public static const GRIDSQUARE_DIRT:int = 2;
      
      public static const RENDER_LAYER_GROUND:int = 200000;
      
      public static const PROGRESS_METER_COUNTER:int = 100;
      
      private static const COIN_FINAL_SEED_PACKET:String = "finalseedpacket";
      
      public static const MAX_SCARY_POTS:int = 9 * 6;
      
      private static const LAWN_YMIN:int = 77;
      
      public static const SEED_FUMESHROOM:int = 10;
      
      private static const SCENE_AWARD:int = 5;
      
      private static const ZOMBIE_COUNTDOWN_MIN:int = 400;
      
      private static const ZOMBIE_COUNTDOWN_FIRST_WAVE:int = 1800;
      
      private static const SEED_SNOWPEA:int = 5;
      
      public static const ZOMBIE_INVALID:int = -1;
      
      private static const BOARD_HEIGHT:int = 405;
      
      private static const COIN_MOTION_COIN:String = "coin";
      
      private static const SEED_SQUASH:int = 4;
      
      private static const SCENE_ZOMBIES_WON:int = 4;
      
      private static const ZOMBIE_COUNTDOWN_BEFORE_REPICK:int = 5500;
      
      public static const SCARYPOT_DYNAMITE:int = 4;
      
      public static const REANIM_PEASHOOTER:int = 0;
      
      public static const STATECHALLENGE_NORMAL:int = 0;
      
      public static const SEED_LEFTPEATER:int = 49;
      
      private static const BOARD_WIDTH:int = 540;
      
      public static const ZOMBIE_POLEVAULTER:int = 3;
      
      public static const REANIM_WALLNUT:int = 1;
      
      private static const GRIDSIZEX:int = 9;
      
      private static const GRIDSIZEY:int = 5;
      
      public static const RENDER_LAYER_COIN_BANK:int = 600000;
      
      public static const SEED_GRAVEBUSTER:int = 11;
      
      public static const SCARYPOT_NONE:int = 0;
      
      private static const CURSOR_TYPE_PLANT_FROM_BANK:int = 1;
      
      public static const SEED_PUFFSHROOM:int = 8;
      
      private static const OBJECT_TYPE_PROJECTILE:int = 2;
      
      private static const CURSOR_TYPE_PLANT_FROM_USABLE_COIN:int = 2;
      
      private static const SEED_PEASHOOTER:int = 0;
      
      public static const REANIM_SQUASH:int = 4;
      
      public static const ZOMBIE_NORMAL:int = 0;
      
      public static const RENDER_LAYER_FOG:int = 500000;
      
      private static const SEED_EXPLODE_O_NUT:int = 50;
      
      private static const ZOMBIE_COUNTDOWN:int = 2500;
      
      private static const NUM_ZOMBIE_TYPES:int = 8;
      
      private static const SCENE_PLAYING:int = 3;
      
      private static const LAWN_XMAX:int = 513;
      
      private static const SEED_SUNFLOWER:int = 1;
      
      private static const SUN_COUNTDOWN_MAX:int = 950;
      
      private static const SEED_CHOMPER:int = 6;
      
      public static const ZOMBIE_PAIL:int = 4;
      
      private static const SCENE_MENU:int = 1;
      
      private static const ZOMBIE_COUNTDOWN_RANGE:int = 600;
      
      private static const SUN_COUNTDOWN_RANGE:int = 275;
      
      private static const OBJECT_TYPE_SEEDPACKET:int = 4;
      
      public static const ZOMBIE_FOOTBALL:int = 7;
      
      public static const SCARYPOT_ZOMBIE:int = 2;
      
      public static const GRIDITEM_STATE_PORTAL_CLOSED:int = 2;
      
      private static const COIN_MOTION_FROM_PLANT:String = "from plant";
      
      private static const OBJECT_TYPE_COIN:int = 3;
      
      private static const COIN_SUN:String = "sun";
      
      private static const PLANTING_OK:String = "ok";
      
      public static const MAX_ZOMBIES_IN_WAVE:int = 50;
      
      public static const SEED_SUNSHROOM:int = 9;
      
      private static const SEED_WALLNUT:int = 3;
      
      private static const SEED_REPEATER:int = 7;
      
      public static const PLANTROW_NORMAL:int = 0;
      
      private static const COIN_MOTION_FROM_SKY_SLOW:String = "from sky slow";
      
      public static const GRIDITEM_STATE_NORMAL:int = 0;
      
      public static const GRIDITEM_STATE_GRAVESTONE_SPECIAL:int = 1;
      
      private static const LAWN_YMAX:int = 385;
      
      public static const BOARD_SHAKE_TIME:int = 12;
      
      public static const ZOMBIE_NEWSPAPER:int = 5;
      
      public static const RENDER_LAYER_LAWN:int = 300000;
      
      public static const RENDER_LAYER_PROJECTILE:int = RENDER_LAYER_LAWN + 5000;
      
      public static const RENDER_LAYER_ZOMBIE:int = RENDER_LAYER_LAWN + 3000;
      
      public static const RENDER_LAYER_GRAVE_STONE:int = RENDER_LAYER_LAWN + 1000;
      
      public static const RENDER_LAYER_LAWN_MOWER:int = RENDER_LAYER_LAWN + 6000;
      
      public static const RENDER_LAYER_PLANT:int = RENDER_LAYER_LAWN + 2000;
      
      private static const PLANTING_NOT_HERE:String = "not here";
      
      private static const COIN_MOTION_FROM_SKY:String = "from sky";
      
      private static const ZOMBIE_COUNTDOWN_BEFORE_FLAG:int = 4500;
      
      public static const RENDER_LAYER_ABOVE_UI:int = 800000;
      
      public static const STATECHALLENGE_SCARY_POTTER_MALLETING:int = 1;
      
      public static const RENDER_LAYER_PARTICLE:int = RENDER_LAYER_LAWN + 7000;
      
      private static const COIN_USABLE_SEED_PACKET:String = "usableseedpacket";
      
      private static const SUN_COUNTDOWN:int = 425;
      
      public static const GRIDITEM_STATE_SCARY_POT_ZOMBIE:int = 5;
      
      public static const REANIM_SUNFLOWER:int = 2;
      
      public static const ZOMBIE_TRAFFIC_CONE:int = 2;
      
      public static const REANIM_NONE:int = -1;
      
      public static const RENDER_LAYER_TOP:int = 400000;
      
      private static const CURSOR_TYPE_SHOVEL:int = 3;
      
      public static const RENDER_LAYER_UI_TOP:int = 700000;
      
      public static const ZOMBIE_FLAG:int = 1;
      
      public static const RENDER_LAYER_SCREEN_FADE:int = 900000;
      
      public static const RENDER_LAYER_UI_BOTTOM:int = 100000;
       
      
      public var mConveyorBeltCounter:int;
      
      private var mBoard:Board;
      
      public var mScaryPotterPots:int;
      
      private var app:PVZApp;
      
      public var mChallengeState:int;
      
      public var mChallengeScore:int;
      
      public var mChallengeStateCounter:int;
      
      public var mShowBowlingLine:Boolean;
      
      public var mSurvivalStage:int;
      
      public var mMalletReanim:Reanimation;
      
      public var mLastConveyorSeedType:int;
      
      public var mChallengeGridX:int;
      
      public var mChallengeGridY:int;
      
      public function Challenge(app:PVZApp, theBoard:Board)
      {
         super();
         this.app = app;
         this.mBoard = theBoard;
         this.mChallengeStateCounter = 0;
         this.mConveyorBeltCounter = 0;
         this.mChallengeScore = 0;
         this.mShowBowlingLine = false;
         this.mLastConveyorSeedType = SEED_NONE;
         this.mSurvivalStage = 0;
         this.mChallengeGridX = 0;
         this.mChallengeGridY = 0;
         this.mScaryPotterPots = 0;
      }
      
      public function GetScaryPotAt(theGridX:int, theGridY:int) : GridItem
      {
         var aGridItem:GridItem = null;
         for each(aGridItem in this.mBoard.mGridItems)
         {
            if(!(aGridItem.mGridX != theGridX || aGridItem.mGridY != theGridY))
            {
               return aGridItem;
            }
         }
         return null;
      }
      
      public function MouseUp(x:int, y:int) : Boolean
      {
         return false;
      }
      
      public function ScaryPotterCountPots() : int
      {
         var aGridItem:GridItem = null;
         var aPots:int = 0;
         for each(aGridItem in this.mBoard.mGridItems)
         {
            if(aGridItem.mGridItemType == GridItem.GRIDITEM_SCARY_POT)
            {
               aPots++;
            }
         }
         return aPots;
      }
      
      public function GraveDangerSpawnRandomGrave() : void
      {
         var y:int = 0;
         var aWeightedGridArray:WeightedGridArray = null;
         var aPlant:CPlant = null;
         var aPicks:Array = new Array();
         var aPickCount:int = 0;
         for(var x:int = 4; x < GRIDSIZEX; x++)
         {
            for(y = 0; y < GRIDSIZEY; y++)
            {
               aWeightedGridArray = new WeightedGridArray();
               aPicks[aPickCount] = aWeightedGridArray;
               if(this.mBoard.CanAddGraveStoneAt(x,y))
               {
                  aPlant = this.mBoard.GetPlantsOnLawn(x,y);
                  if(aPlant)
                  {
                     aPicks[aPickCount].mWeight = 1;
                  }
                  else
                  {
                     aPicks[aPickCount].mWeight = 100000;
                  }
                  aPicks[aPickCount].mX = x;
                  aPicks[aPickCount].mY = y;
                  aPickCount++;
               }
            }
         }
         if(aPickCount == 0)
         {
            return;
         }
         var aResultItem:WeightedGridArray = TodCommon.TodPickFromWeightedGridArray(aPicks,aPickCount);
         this.GraveDangerSpawnGraveAt(aResultItem.mX,aResultItem.mY);
      }
      
      public function UpdateZombieSpawning() : Boolean
      {
         if(this.app.IsScaryPotterLevel())
         {
            return true;
         }
         return false;
      }
      
      public function PuzzlePhaseComplete(theGridX:int, theGridY:int) : void
      {
         if(this.app.mGameMode == PVZApp.GAMEMODE_SCARY_POTTER_ENDLESS)
         {
            if(this.mSurvivalStage + 1 == 15)
            {
            }
         }
         this.mBoard.FadeOutLevel();
      }
      
      public function ScaryPotterJackExplode(aPosX:int, aPosY:int) : void
      {
         var aGridItem:GridItem = null;
         var aGridX:int = this.mBoard.PixelToGridX(aPosX,aPosY);
         var aGridY:int = this.mBoard.PixelToGridY(aPosX,aPosY);
         for each(aGridItem in this.mBoard.mGridItems)
         {
            if(aGridItem.mGridItemType == GridItem.GRIDITEM_SCARY_POT)
            {
               if(!(aGridItem.mGridX < aGridX - 1 || aGridItem.mGridX > aGridX + 1 || aGridItem.mGridY < aGridY - 1 || aGridItem.mGridY > aGridY + 1))
               {
                  this.ScaryPotterOpenPot(aGridItem);
               }
            }
         }
      }
      
      public function InitZombieWavesSurvival() : void
      {
         var aZombieType:int = 0;
         this.mBoard.mZombieAllowed[ZOMBIE_NORMAL] = true;
         var aEasyZombieRand:int = Math.random() * 5;
         if(aEasyZombieRand == 0)
         {
            this.mBoard.mZombieAllowed[ZOMBIE_NEWSPAPER] = true;
         }
         else
         {
            this.mBoard.mZombieAllowed[ZOMBIE_TRAFFIC_CONE] = true;
         }
         var aNumZombieTypes:int = Math.min(this.mSurvivalStage + 1,5);
         while(aNumZombieTypes > 0)
         {
            aZombieType = Math.random() * NUM_ZOMBIE_TYPES;
            if(!this.mBoard.mZombieAllowed[aZombieType])
            {
               this.mBoard.mZombieAllowed[aZombieType] = true;
               aNumZombieTypes--;
            }
         }
      }
      
      public function GraveDangerSpawnGraveAt(x:int, y:int) : void
      {
         var aPlant:CPlant = null;
         var aGraveStone:GridItem = null;
         for each(aPlant in this.mBoard.mPlants)
         {
            if(aPlant.mPlantCol == x && aPlant.mRow == y)
            {
               aPlant.Die();
            }
         }
         this.mBoard.mEnableGraveStones = true;
         aGraveStone = this.mBoard.AddAGraveStone(x,y);
         aGraveStone.AddGraveStoneParticles();
      }
      
      public function ScaryPotterDontPlaceInCol(theCol:int, theGridArray:Array, theGridArrayCount:int) : void
      {
         for(var i:int = 0; i < theGridArrayCount; i++)
         {
            if(theGridArray[i].mX == theCol)
            {
               theGridArray[i].mWeight = 0;
            }
         }
      }
      
      public function ScaryPotterUpdate() : void
      {
         var aGridItem:GridItem = null;
         if(this.mChallengeState == STATECHALLENGE_SCARY_POTTER_MALLETING)
         {
            if(this.mMalletReanim.mIsDead)
            {
               aGridItem = this.GetScaryPotAt(this.mChallengeGridX,this.mChallengeGridY);
               if(aGridItem)
               {
                  this.ScaryPotterOpenPot(aGridItem);
               }
               this.mChallengeGridX = 0;
               this.mChallengeGridY = 0;
               this.mMalletReanim.mIsDead = true;
               this.mMalletReanim = null;
               this.mChallengeState = STATECHALLENGE_NORMAL;
            }
         }
      }
      
      public function ScaryPotterMalletPot(theScaryPot:GridItem) : void
      {
         this.mChallengeGridX = theScaryPot.mGridX;
         this.mChallengeGridY = theScaryPot.mGridY;
         var aXPos:int = this.mBoard.GridToPixelX(theScaryPot.mGridX,theScaryPot.mGridY);
         var aYPos:int = this.mBoard.GridToPixelY(theScaryPot.mGridX,theScaryPot.mGridY);
         this.mMalletReanim = this.app.reanimator.createReanimation("REANIM_HAMMER");
         this.mMalletReanim.x = aXPos;
         this.mMalletReanim.y = aYPos;
         this.mMalletReanim.currentTrack = "anim_open_pot";
         this.mMalletReanim.animRate = 40;
         this.mMalletReanim.loopType = Reanimation.LOOP_TYPE_ONCE_AND_DIE;
         this.mBoard.mRenderManager.add(new ReanimationRenderable(this.mMalletReanim,Board.RENDER_LAYER_ABOVE_UI));
         this.mChallengeState = STATECHALLENGE_SCARY_POTTER_MALLETING;
         this.app.foleyManager.playFoley(PVZFoleyType.SWING);
      }
      
      public function ScaryPotterPlacePot(theScaryPotType:int, theZombieType:int, theSeedType:int, theCount:int, theGridArray:Array, theGridArrayCount:int) : void
      {
         var aResult:WeightedGridArray = null;
         var aGridItem:GridItem = null;
         for(var i:int = 0; i < theCount; i++)
         {
            aResult = TodCommon.TodPickFromWeightedGridArray(theGridArray,theGridArrayCount);
            aResult.mWeight = 0;
            aGridItem = new GridItem(this.app,this.mBoard);
            aGridItem.mGridItemType = GridItem.GRIDITEM_SCARY_POT;
            aGridItem.mGridItemState = GridItem.GRIDITEM_STATE_SCARY_POT_QUESTION;
            aGridItem.mGridX = aResult.mX;
            aGridItem.mGridY = aResult.mY;
            aGridItem.mSeedType = theSeedType;
            aGridItem.mZombieType = theZombieType;
            aGridItem.mScaryPotType = theScaryPotType;
            this.mBoard.mGridItems.push(aGridItem);
            this.mBoard.mRenderManager.add(new GridItemRenderable(aGridItem,RENDER_LAYER_PLANT));
            if(theScaryPotType == SCARYPOT_SUN)
            {
               aGridItem.mSunCount = TodCommon.RandRangeInt(1,3);
            }
         }
      }
      
      public function InitLevel() : void
      {
         if(this.mBoard.mLevel == 5)
         {
            this.mBoard.NewPlant(5,1,SEED_PEASHOOTER);
            this.mBoard.NewPlant(7,2,SEED_PEASHOOTER);
            this.mBoard.NewPlant(6,3,SEED_PEASHOOTER);
         }
         if(this.app.IsScaryPotterLevel())
         {
            this.ScaryPotterPopulate();
         }
      }
      
      public function PuzzleNextStageClear() : void
      {
         var aZombie:Zombie = null;
         var aPlant:CPlant = null;
         var aCoin:Coin = null;
         var aGridItem:GridItem = null;
         var anEffect:ParticleSystem = null;
         this.app.foleyManager.playFoley(PVZFoleyType.HUGEWAVE);
         this.mBoard.mNextSurvivalStageCounter = 0;
         this.mBoard.mProgressMeterWidth = 0;
         for each(aZombie in this.mBoard.mZombies)
         {
            if(aZombie.IsOnBoard())
            {
               aZombie.DieNoLoot();
            }
         }
         for each(aPlant in this.mBoard.mPlants)
         {
            if(aPlant.IsOnBoard())
            {
               aPlant.Die();
            }
         }
         this.mBoard.RefreshSeedPacketFromCursor();
         for each(aCoin in this.mBoard.mCoins)
         {
            if(aCoin.mType == COIN_USABLE_SEED_PACKET)
            {
               aCoin.Die();
            }
         }
         for each(aGridItem in this.mBoard.mGridItems)
         {
            aGridItem.GridItemDie();
         }
         ++this.mSurvivalStage;
         this.mBoard.ClearAdviceImmediately();
         this.mBoard.mLevelAwardSpawned = false;
         anEffect = this.app.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_SCREENFLASH);
         anEffect.setPosition(0,0);
         this.mBoard.mRenderManager.add(new ParticleRenderable(anEffect,Board.RENDER_LAYER_SCREEN_FADE));
      }
      
      public function InitZombieWaves() : void
      {
         var aZombieList:Array = null;
         if(this.app.IsSurvivalMode())
         {
            if(this.mSurvivalStage == 0)
            {
               aZombieList = new Array(ZOMBIE_NORMAL,ZOMBIE_TRAFFIC_CONE,ZOMBIE_PAIL);
               this.InitZombieWavesFromList(aZombieList,aZombieList.length);
            }
            else
            {
               this.InitZombieWavesSurvival();
            }
         }
      }
      
      public function MouseDown(x:int, y:int, theHitResult:HitResult) : Boolean
      {
         if(this.mBoard.mGameScene != SCENE_PLAYING)
         {
            return false;
         }
         if(theHitResult.mObjectType == OBJECT_TYPE_COIN)
         {
            return false;
         }
         if(this.app.IsScaryPotterLevel() && theHitResult.mObjectType == Board.OBJECT_TYPE_SCARY_POT)
         {
            this.ScaryPotterMalletPot(GridItem(theHitResult.mObject));
            this.mBoard.ClearCursor();
            return true;
         }
         return false;
      }
      
      public function InitZombieWavesFromList(theZombieList:Array, theListLength:int) : void
      {
         var aZombieType:int = 0;
         for(var i:int = 0; i < theListLength; i++)
         {
            aZombieType = int(theZombieList[i]);
            this.mBoard.mZombieAllowed[aZombieType] = true;
         }
      }
      
      public function ScaryPotterPopulate() : void
      {
         var y:int = 0;
         var aGridItem:WeightedGridArray = null;
         var aNumExtraGargantuars:int = 0;
         var aGridArray:Array = new Array();
         var aGridArrayCount:int = 0;
         for(var x:int = 0; x < 9; x++)
         {
            for(y = 0; y < 5; y++)
            {
               aGridItem = new WeightedGridArray();
               aGridArray[aGridArrayCount] = aGridItem;
               aGridArray[aGridArrayCount].mX = x;
               aGridArray[aGridArrayCount].mY = y;
               aGridArray[aGridArrayCount].mWeight = 1;
               aGridArrayCount++;
            }
         }
         if(this.app.mGameMode == PVZApp.GAMEMODE_SCARY_POTTER_ENDLESS)
         {
            if(this.mSurvivalStage == 0)
            {
               this.ScaryPotterDontPlaceInCol(0,aGridArray,aGridArrayCount);
               this.ScaryPotterDontPlaceInCol(1,aGridArray,aGridArrayCount);
               this.ScaryPotterDontPlaceInCol(2,aGridArray,aGridArrayCount);
               this.ScaryPotterDontPlaceInCol(3,aGridArray,aGridArrayCount);
               this.ScaryPotterDontPlaceInCol(4,aGridArray,aGridArrayCount);
               this.ScaryPotterDontPlaceInCol(5,aGridArray,aGridArrayCount);
               this.ScaryPotterPlacePot(SCARYPOT_SEED,ZOMBIE_INVALID,SEED_PEASHOOTER,5,aGridArray,aGridArrayCount);
               this.ScaryPotterPlacePot(SCARYPOT_SEED,ZOMBIE_INVALID,SEED_SQUASH,5,aGridArray,aGridArrayCount);
               this.ScaryPotterPlacePot(SCARYPOT_ZOMBIE,ZOMBIE_NORMAL,SEED_NONE,4,aGridArray,aGridArrayCount);
               this.ScaryPotterPlacePot(SCARYPOT_ZOMBIE,ZOMBIE_PAIL,SEED_NONE,1,aGridArray,aGridArrayCount);
            }
            else if(this.mSurvivalStage == 1)
            {
               this.ScaryPotterDontPlaceInCol(0,aGridArray,aGridArrayCount);
               this.ScaryPotterDontPlaceInCol(1,aGridArray,aGridArrayCount);
               this.ScaryPotterDontPlaceInCol(2,aGridArray,aGridArrayCount);
               this.ScaryPotterDontPlaceInCol(3,aGridArray,aGridArrayCount);
               this.ScaryPotterDontPlaceInCol(4,aGridArray,aGridArrayCount);
               this.ScaryPotterPlacePot(SCARYPOT_SEED,ZOMBIE_INVALID,SEED_PEASHOOTER,4,aGridArray,aGridArrayCount);
               this.ScaryPotterPlacePot(SCARYPOT_SEED,ZOMBIE_INVALID,SEED_SQUASH,4,aGridArray,aGridArrayCount);
               this.ScaryPotterPlacePot(SCARYPOT_SEED,ZOMBIE_INVALID,SEED_SNOWPEA,5,aGridArray,aGridArrayCount);
               this.ScaryPotterPlacePot(SCARYPOT_ZOMBIE,ZOMBIE_NORMAL,SEED_NONE,5,aGridArray,aGridArrayCount);
               this.ScaryPotterPlacePot(SCARYPOT_ZOMBIE,ZOMBIE_PAIL,SEED_NONE,1,aGridArray,aGridArrayCount);
               this.ScaryPotterPlacePot(SCARYPOT_ZOMBIE,ZOMBIE_FOOTBALL,SEED_NONE,1,aGridArray,aGridArrayCount);
               this.ScaryPotterChangePotType(GRIDITEM_STATE_SCARY_POT_LEAF,2);
            }
            else if(this.mSurvivalStage == 2)
            {
               this.ScaryPotterDontPlaceInCol(0,aGridArray,aGridArrayCount);
               this.ScaryPotterDontPlaceInCol(1,aGridArray,aGridArrayCount);
               this.ScaryPotterDontPlaceInCol(2,aGridArray,aGridArrayCount);
               this.ScaryPotterDontPlaceInCol(8,aGridArray,aGridArrayCount);
               this.ScaryPotterPlacePot(SCARYPOT_SEED,ZOMBIE_INVALID,SEED_LEFTPEATER,7,aGridArray,aGridArrayCount);
               this.ScaryPotterPlacePot(SCARYPOT_SEED,ZOMBIE_INVALID,SEED_SQUASH,2,aGridArray,aGridArrayCount);
               this.ScaryPotterPlacePot(SCARYPOT_SEED,ZOMBIE_INVALID,SEED_SNOWPEA,3,aGridArray,aGridArrayCount);
               this.ScaryPotterPlacePot(SCARYPOT_SEED,ZOMBIE_INVALID,SEED_WALLNUT,3,aGridArray,aGridArrayCount);
               this.ScaryPotterPlacePot(SCARYPOT_ZOMBIE,ZOMBIE_NORMAL,SEED_NONE,6,aGridArray,aGridArrayCount);
               this.ScaryPotterPlacePot(SCARYPOT_ZOMBIE,ZOMBIE_PAIL,SEED_NONE,3,aGridArray,aGridArrayCount);
               this.ScaryPotterPlacePot(SCARYPOT_DYNAMITE,ZOMBIE_INVALID,SEED_NONE,1,aGridArray,aGridArrayCount);
               this.ScaryPotterChangePotType(GRIDITEM_STATE_SCARY_POT_LEAF,2);
            }
            else
            {
               aNumExtraGargantuars = TodCommon.ClampInt(this.mSurvivalStage / 10,0,8);
               this.ScaryPotterDontPlaceInCol(0,aGridArray,aGridArrayCount);
               this.ScaryPotterDontPlaceInCol(1,aGridArray,aGridArrayCount);
               this.ScaryPotterPlacePot(SCARYPOT_SEED,ZOMBIE_INVALID,SEED_LEFTPEATER,8,aGridArray,aGridArrayCount);
               this.ScaryPotterPlacePot(SCARYPOT_SEED,ZOMBIE_INVALID,SEED_SNOWPEA,2,aGridArray,aGridArrayCount);
               this.ScaryPotterPlacePot(SCARYPOT_SEED,ZOMBIE_INVALID,SEED_PEASHOOTER,2,aGridArray,aGridArrayCount);
               this.ScaryPotterPlacePot(SCARYPOT_SEED,ZOMBIE_INVALID,SEED_SQUASH,5,aGridArray,aGridArrayCount);
               this.ScaryPotterPlacePot(SCARYPOT_SEED,ZOMBIE_INVALID,SEED_WALLNUT,2,aGridArray,aGridArrayCount);
               this.ScaryPotterPlacePot(SCARYPOT_SUN,ZOMBIE_INVALID,SEED_NONE,1,aGridArray,aGridArrayCount);
               this.ScaryPotterPlacePot(SCARYPOT_ZOMBIE,ZOMBIE_NORMAL,SEED_NONE,8 - aNumExtraGargantuars,aGridArray,aGridArrayCount);
               this.ScaryPotterPlacePot(SCARYPOT_ZOMBIE,ZOMBIE_PAIL,SEED_NONE,5,aGridArray,aGridArrayCount);
               this.ScaryPotterPlacePot(SCARYPOT_ZOMBIE,ZOMBIE_FOOTBALL,SEED_NONE,1 + aNumExtraGargantuars,aGridArray,aGridArrayCount);
               this.ScaryPotterPlacePot(SCARYPOT_DYNAMITE,ZOMBIE_INVALID,SEED_NONE,1,aGridArray,aGridArrayCount);
               this.ScaryPotterChangePotType(GRIDITEM_STATE_SCARY_POT_LEAF,2);
            }
         }
      }
      
      public function ScaryPotterOpenPot(theScaryPot:GridItem) : void
      {
         var aCoin:Coin = null;
         var aParticleType:String = null;
         var aZombie:Zombie = null;
         var aNumSum:int = 0;
         var i:int = 0;
         var aXPos:int = this.mBoard.GridToPixelX(theScaryPot.mGridX,theScaryPot.mGridY);
         var aYPos:int = this.mBoard.GridToPixelY(theScaryPot.mGridX,theScaryPot.mGridY);
         switch(theScaryPot.mScaryPotType)
         {
            case SCARYPOT_DYNAMITE:
               aCoin = this.mBoard.AddCoin(aXPos,aYPos,Coin.COIN_DYNAMITE,COIN_MOTION_COIN);
               break;
            case SCARYPOT_SEED:
               aCoin = this.mBoard.AddCoin(aXPos + 20,aYPos,COIN_USABLE_SEED_PACKET,COIN_MOTION_FROM_PLANT);
               aCoin.mUsableSeedType = theScaryPot.mSeedType;
               break;
            case SCARYPOT_ZOMBIE:
               aZombie = this.mBoard.AddZombieInRow(theScaryPot.mZombieType,theScaryPot.mGridY,0);
               aZombie.mPosX = aXPos;
               break;
            case SCARYPOT_SUN:
               aNumSum = theScaryPot.mSunCount;
               for(i = 0; i < aNumSum; i++)
               {
                  this.mBoard.AddCoin(aXPos,aYPos,COIN_SUN,COIN_MOTION_FROM_PLANT);
                  aXPos += 15;
               }
         }
         theScaryPot.GridItemDie();
         if(this.ScaryPotterIsCompleted())
         {
            this.PuzzlePhaseComplete(theScaryPot.mGridX,theScaryPot.mGridY);
         }
         this.app.foleyManager.playFoley(PVZFoleyType.BONK);
         this.app.foleyManager.playFoley(PVZFoleyType.VASE_BREAKING);
         if(theScaryPot.mGridItemState == GRIDITEM_STATE_SCARY_POT_LEAF)
         {
            aParticleType = PVZParticles.PARTICLE_VASESHATTERLEAF;
         }
         else if(theScaryPot.mGridItemState == GRIDITEM_STATE_SCARY_POT_ZOMBIE)
         {
            aParticleType = PVZParticles.PARTICLE_VASESHATTERZOMBIE;
         }
         else
         {
            aParticleType = PVZParticles.PARTICLE_VASESHATTER;
         }
         var anEffect:ParticleSystem = this.app.particleManager.spawnParticleSystem(aParticleType);
         anEffect.setPosition(aXPos + 20,aYPos);
         this.mBoard.mRenderManager.add(new ParticleRenderable(anEffect,Board.RENDER_LAYER_PARTICLE + 1));
      }
      
      public function ScaryPotterIsCompleted() : Boolean
      {
         var aGridItem:GridItem = null;
         for each(aGridItem in this.mBoard.mGridItems)
         {
            if(aGridItem.mGridItemType == GridItem.GRIDITEM_SCARY_POT && !aGridItem.mDead)
            {
               return false;
            }
         }
         if(this.mBoard.AreEnemyZombiesOnScreen())
         {
            return false;
         }
         return true;
      }
      
      public function StartLevel() : void
      {
         var aMessage:String = null;
         if(this.mBoard.IsWallnutBowlingLevel())
         {
            this.mBoard.mZombieCountDown = 200;
            this.mBoard.mZombieCountDownStart = this.mBoard.mZombieCountDown;
            this.mBoard.mSeedBank.AddSeed(SEED_WALLNUT,false);
            this.mConveyorBeltCounter = 400;
         }
         if(this.mBoard.IsWallnutBowlingLevel())
         {
            this.mShowBowlingLine = true;
         }
         if(this.app.IsSurvivalMode() && this.mSurvivalStage == 0)
         {
            aMessage = "[ADVICE_SURVIVE_ENDLESS]";
            this.mBoard.DisplayAdvice(aMessage,Board.MESSAGE_STYLE_HINT_FAST,Board.ADVICE_SURVIVE_FLAGS);
         }
         if(this.mBoard.mLevel == 10)
         {
            this.mBoard.mZombieCountDown = 100;
            this.mBoard.mZombieCountDownStart = this.mBoard.mZombieCountDown;
            this.mConveyorBeltCounter = 200;
         }
      }
      
      public function ClearCursor() : void
      {
      }
      
      public function PuzzleIsAwardStage() : Boolean
      {
         if(this.app.IsAdventureMode())
         {
            return false;
         }
         var aStagesPerAward:int = 1;
         if(this.app.mGameMode == PVZApp.GAMEMODE_SCARY_POTTER_ENDLESS)
         {
            aStagesPerAward = 10;
         }
         if((this.mSurvivalStage + 1) % aStagesPerAward == 0)
         {
            return true;
         }
         return false;
      }
      
      public function Update() : void
      {
         var aTotalSun:int = 0;
         var anImage:ImageInst = null;
         if(this.mBoard.mPaused)
         {
            return;
         }
         if(this.mBoard.mGameScene != SCENE_PLAYING)
         {
            return;
         }
         if(this.mBoard.HasConveyorBeltSeedBank())
         {
            this.UpdateConveyorBelt();
         }
         if(this.app.IsScaryPotterLevel())
         {
            this.ScaryPotterUpdate();
         }
         if(this.app.IsScaryPotterLevel())
         {
            if(this.mBoard.mSeedBank.mY < 0)
            {
               aTotalSun = this.mBoard.mSunMoney + this.mBoard.CountSunBeingCollected();
               anImage = this.app.imageManager.getImageInst(PVZImages.IMAGE_SEEDBANK);
               if(aTotalSun > 0)
               {
               }
               if(aTotalSun > 0 || this.mBoard.mSeedBank.mY > -78)
               {
                  this.mBoard.mSeedBank.mVisible = true;
                  this.mBoard.mSeedBank.mY += 2;
                  trace(this.mBoard.mSeedBank.mY);
                  if(this.mBoard.mSeedBank.mY > 0)
                  {
                     this.mBoard.mSeedBank.mY = 0;
                  }
               }
            }
         }
      }
      
      public function SpawnZombieWave() : void
      {
         var aCount:int = 0;
         var i:int = 0;
         var aIsFlagWave:Boolean = this.mBoard.IsFlagWave(this.mBoard.mCurrentWave);
         if(this.app.IsSurvivalMode() && this.mBoard.mBackground == Board.BACKGROUND_2_NIGHT)
         {
            if(this.mBoard.mCurrentWave == this.mBoard.mNumWaves - 1)
            {
               aCount = this.mBoard.GetGraveStoneCount();
               for(i = 0; i < this.mSurvivalStage + 1; i++)
               {
                  if(aCount < 12)
                  {
                     this.GraveDangerSpawnRandomGrave();
                  }
               }
            }
         }
      }
      
      public function ScaryPotterChangePotType(thePotType:int, theCount:int) : void
      {
         var aGridItem:GridItem = null;
         var aResult:WeightedArray = null;
         var theGridItem:GridItem = null;
         var aPotArray:Array = new Array();
         var aPotArrayCount:int = 0;
         for(var i:int = 0; i < this.mBoard.mGridItems.length; i++)
         {
            aGridItem = this.mBoard.mGridItems[i];
            aPotArray[aPotArrayCount] = new WeightedArray();
            if(aGridItem.mGridItemState == GRIDITEM_STATE_SCARY_POT_QUESTION)
            {
               if(!(thePotType == GRIDITEM_STATE_SCARY_POT_LEAF && aGridItem.mScaryPotType != SCARYPOT_SEED))
               {
                  if(thePotType != GRIDITEM_STATE_SCARY_POT_ZOMBIE)
                  {
                     aPotArray[aPotArrayCount].mItem = i;
                     aPotArray[aPotArrayCount].mWeight = 1;
                     aPotArrayCount++;
                  }
               }
            }
         }
         if(theCount > aPotArrayCount)
         {
            theCount = aPotArrayCount;
         }
         for(i = 0; i < theCount; i++)
         {
            aResult = TodCommon.TodPickArrayItemFromWeightedArray(aPotArray,aPotArrayCount);
            aResult.mWeight = 0;
            theGridItem = this.mBoard.mGridItems[aResult.mItem];
            theGridItem.mGridItemState = thePotType;
         }
      }
      
      public function ScaryPotterStart() : void
      {
         if(this.app.IsAdventureMode())
         {
         }
      }
      
      public function UpdateConveyorBelt() : void
      {
         var aSeedType:int = 0;
         var aArrayItem:WeightedArray = null;
         var aCountInBank:int = 0;
         if(this.mBoard.HasLevelAwardDropped())
         {
            return;
         }
         this.mBoard.mSeedBank.UpdateConveyorBelt();
         --this.mConveyorBeltCounter;
         if(this.mConveyorBeltCounter > 0)
         {
            return;
         }
         var aConveyorSpeedMultiplier:Number = 1;
         if(this.mBoard.mSeedBank.GetNumSeedsOnConveyorBelt() > 8)
         {
            this.mConveyorBeltCounter = 1000 * aConveyorSpeedMultiplier;
         }
         else if(this.mBoard.mSeedBank.GetNumSeedsOnConveyorBelt() > 6)
         {
            this.mConveyorBeltCounter = 500 * aConveyorSpeedMultiplier;
         }
         else if(this.mBoard.mSeedBank.GetNumSeedsOnConveyorBelt() > 4)
         {
            this.mConveyorBeltCounter = 425 * aConveyorSpeedMultiplier;
         }
         else
         {
            this.mConveyorBeltCounter = 400 * aConveyorSpeedMultiplier;
         }
         var MAX_SPAWNING_SEED_TYPES:int = 20;
         var aSeedPickArray:Array = new Array();
         var aNumSeedsType:int = 0;
         for(var i:int = 0; i < 7; i++)
         {
            aSeedPickArray[i] = new WeightedArray();
         }
         if(this.mBoard.mLevel == 10)
         {
            aSeedPickArray[aNumSeedsType].mItem = SEED_PEASHOOTER;
            aSeedPickArray[aNumSeedsType].mWeight = 20;
            aNumSeedsType++;
            aSeedPickArray[aNumSeedsType].mItem = SEED_CHERRYBOMB;
            aSeedPickArray[aNumSeedsType].mWeight = 20;
            aNumSeedsType++;
            aSeedPickArray[aNumSeedsType].mItem = SEED_WALLNUT;
            aSeedPickArray[aNumSeedsType].mWeight = 15;
            aNumSeedsType++;
            aSeedPickArray[aNumSeedsType].mItem = SEED_REPEATER;
            aSeedPickArray[aNumSeedsType].mWeight = 20;
            aNumSeedsType++;
            aSeedPickArray[aNumSeedsType].mItem = SEED_SNOWPEA;
            aSeedPickArray[aNumSeedsType].mWeight = 10;
            aNumSeedsType++;
            aSeedPickArray[aNumSeedsType].mItem = SEED_CHOMPER;
            aSeedPickArray[aNumSeedsType].mWeight = 5;
            aNumSeedsType++;
            aSeedPickArray[aNumSeedsType].mItem = SEED_SQUASH;
            aSeedPickArray[aNumSeedsType].mWeight = 10;
            aNumSeedsType++;
         }
         else if(this.mBoard.IsWallnutBowlingLevel())
         {
            aSeedPickArray[aNumSeedsType].mItem = SEED_WALLNUT;
            aSeedPickArray[aNumSeedsType].mWeight = 85;
            aNumSeedsType++;
            aSeedPickArray[aNumSeedsType].mItem = SEED_EXPLODE_O_NUT;
            aSeedPickArray[aNumSeedsType].mWeight = 15;
            aNumSeedsType++;
         }
         for(i = 0; i < aNumSeedsType; i++)
         {
            aArrayItem = aSeedPickArray[i];
            aSeedType = aArrayItem.mItem;
            aCountInBank = this.mBoard.mSeedBank.CountOfTypeOnConveyorBelt(aArrayItem.mItem);
            if(aNumSeedsType > 2)
            {
               if(aCountInBank >= 4)
               {
                  aArrayItem.mWeight = 1;
               }
               else if(aCountInBank >= 3)
               {
                  aArrayItem.mWeight = 5;
               }
               else if(aSeedType == this.mLastConveyorSeedType)
               {
                  aArrayItem.mWeight /= 2;
               }
            }
         }
         aSeedType = TodCommon.TodPickFromWeightedArray(aSeedPickArray,aNumSeedsType);
         this.mBoard.mSeedBank.AddSeed(aSeedType,false);
         this.mLastConveyorSeedType = aSeedType;
      }
   }
}
