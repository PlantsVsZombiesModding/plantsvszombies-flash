package com.popcap.flash.games.pvz.logic
{
   import com.popcap.flash.framework.graphics.Color;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.render.RenderManager;
   import com.popcap.flash.framework.resources.fonts.FontInst;
   import com.popcap.flash.framework.resources.images.ImageData;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.resources.particles.ParticleSystem;
   import com.popcap.flash.framework.resources.reanimator.Reanimation;
   import com.popcap.flash.framework.utils.Utils;
   import com.popcap.flash.framework.widgets.CWidget;
   import com.popcap.flash.framework.widgets.ui.IButtonListener;
   import com.popcap.flash.framework.widgets.ui.ImageButtonWidget;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.PVZFoleyType;
   import com.popcap.flash.games.pvz.PVZMusic;
   import com.popcap.flash.games.pvz.logic.Plants.CPlant;
   import com.popcap.flash.games.pvz.logic.Plants.CherryBomb;
   import com.popcap.flash.games.pvz.logic.Plants.Chomper;
   import com.popcap.flash.games.pvz.logic.Plants.ExplodoNut;
   import com.popcap.flash.games.pvz.logic.Plants.FumeShroom;
   import com.popcap.flash.games.pvz.logic.Plants.GraveBuster;
   import com.popcap.flash.games.pvz.logic.Plants.LeftPeater;
   import com.popcap.flash.games.pvz.logic.Plants.PeaShooter;
   import com.popcap.flash.games.pvz.logic.Plants.PuffShroom;
   import com.popcap.flash.games.pvz.logic.Plants.Repeater;
   import com.popcap.flash.games.pvz.logic.Plants.SnowPea;
   import com.popcap.flash.games.pvz.logic.Plants.Squash;
   import com.popcap.flash.games.pvz.logic.Plants.SunShroom;
   import com.popcap.flash.games.pvz.logic.Plants.Sunflower;
   import com.popcap.flash.games.pvz.logic.Plants.Wallnut;
   import com.popcap.flash.games.pvz.logic.UI.OptionsDialog;
   import com.popcap.flash.games.pvz.logic.UI.ToolTipWidget;
   import com.popcap.flash.games.pvz.logic.Zombies.Zombie;
   import com.popcap.flash.games.pvz.logic.Zombies.ZombieDef;
   import com.popcap.flash.games.pvz.logic.Zombies.ZombiePicker;
   import com.popcap.flash.games.pvz.renderables.CoinRenderable;
   import com.popcap.flash.games.pvz.renderables.GridItemRenderable;
   import com.popcap.flash.games.pvz.renderables.ImageRenderable;
   import com.popcap.flash.games.pvz.renderables.LawnMowerRenderable;
   import com.popcap.flash.games.pvz.renderables.ParticleRenderable;
   import com.popcap.flash.games.pvz.renderables.PlantRenderable;
   import com.popcap.flash.games.pvz.renderables.ProjectileRenderable;
   import com.popcap.flash.games.pvz.renderables.ZombieRenderable;
   import com.popcap.flash.games.pvz.resources.PVZFonts;
   import com.popcap.flash.games.pvz.resources.PVZImages;
   import com.popcap.flash.games.pvz.resources.PVZParticles;
   import com.popcap.flash.games.pvz.resources.PVZReanims;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class Board extends CWidget implements IButtonListener
   {
      
      public static const TUTORIAL_MORESUN_COMPLETED:int = 12;
      
      public static const OBJECT_TYPE_PLANT:int = 1;
      
      public static const RENDER_LAYER_SCREEN_FADE:int = 900000;
      
      public static const GRIDITEM_SCARY_POT:int = 2;
      
      public static const ADVICE_CLICK_TO_CONTINUE:int = 7;
      
      public static const MESSAGE_STYLE_TUTORIAL_LATER:int = 3;
      
      public static const FLAG_RAISE_TIME:int = 100;
      
      public static const GRIDSQUARE_NONE:int = 0;
      
      public static const REANIM_CHERRYBOMB:int = 3;
      
      public static const BACKGROUND_1_DAY:int = 0;
      
      public static const ADVICE_NONE:int = -1;
      
      public static const CURSOR_TYPE_NORMAL:int = 0;
      
      public static const OBJECT_TYPE_NONE:int = 0;
      
      public static const ZOMBIE_DOOR:int = 6;
      
      public static const SCARYPOT_SUN:int = 3;
      
      public static const SCENE_CREDIT:int = 6;
      
      public static const GRIDITEM_GRAVESTONE:int = 1;
      
      public static const CURSOR_TYPE_HAMMER:int = 4;
      
      public static const SCARYPOT_SEED:int = 1;
      
      public static const COIN_NONE:String = "none";
      
      public static const PLANTING_NOT_PASSED_LINE:String = "not passed line";
      
      public static const SCENE_CHALLENGE:int = 7;
      
      public static const GRIDSQUARE_GRASS:int = 1;
      
      public static const LAWN_XMIN:int = 25;
      
      public static const PLANTING_ONLY_ON_GRAVES:String = "only on graves";
      
      public static const PLANTROW_DIRT:int = 1;
      
      public static const TUTORIAL_SHOVEL_DIG:int = 14;
      
      public static const MESSAGE_STYLE_TUTORIAL_LEVEL1:int = 0;
      
      public static const MESSAGE_STYLE_TUTORIAL_LEVEL2:int = 2;
      
      public static const MAX_ZOMBIE_WAVES:int = 100;
      
      public static const OBJECT_TYPE_SHOVEL:int = 5;
      
      public static const SCENE_LOADING:int = 0;
      
      public static const SEED_NONE:int = -1;
      
      public static const TUTORIAL_SHOVEL_COMPLETED:int = 16;
      
      public static const GRIDITEM_NONE:int = 0;
      
      public static const SEED_CHERRYBOMB:int = 2;
      
      public static const GRIDSQUARE_DIRT:int = 2;
      
      public static const SCENE_LEVEL_INTRO:int = 2;
      
      public static const ADVICE_PLANT_SUNFLOWER5:int = 5;
      
      public static const ADVICE_CLICK_ON_SUN:int = 0;
      
      public static const PROGRESS_METER_COUNTER:int = 100;
      
      public static const TUTORIAL_SHOVEL_PICKUP:int = 13;
      
      public static const TUTORIAL_LEVEL_2_PICK_UP_SUNFLOWER:int = 5;
      
      public static const TUTORIAL_SHOVEL_KEEP_DIGGING:int = 15;
      
      public static const ADVICE_UNLOCKED_MODE:int = 9;
      
      public static const RENDER_LAYER_GROUND:int = 200000;
      
      public static const COIN_FINAL_SEED_PACKET:String = "finalseedpacket";
      
      public static const MESSAGE_STYLE_HUGE_WAVE:int = 14;
      
      public static const TUTORIAL_LEVEL_2_PLANT_SUNFLOWER:int = 6;
      
      public static const LAWN_YMIN:int = 77;
      
      public static const MESSAGE_STYLE_BIG_MIDDLE:int = 11;
      
      public static const TUTORIAL_LEVEL_1_COMPLETED:int = 4;
      
      public static const SEED_FUMESHROOM:int = 10;
      
      public static const ZOMBIE_COUNTDOWN_MIN:int = 400;
      
      public static const SCENE_CRAZY_DAVE:int = 8;
      
      public static const ZOMBIE_COUNTDOWN_FIRST_WAVE:int = 1800;
      
      public static const SCENE_AWARD:int = 5;
      
      public static const SEED_SNOWPEA:int = 5;
      
      public static const MESSAGE_STYLE_HINT_TALL_FAST:int = 8;
      
      public static const BOARD_HEIGHT:int = 405;
      
      public static const ZOMBIE_INVALID:int = -1;
      
      public static const COIN_MOTION_COIN:String = "coin";
      
      public static const SEED_SQUASH:int = 4;
      
      public static const TUTORIAL_LEVEL_1_REFRESH_PEASHOOTER:int = 3;
      
      public static const SCENE_ZOMBIES_WON:int = 4;
      
      public static const ADVICE_SEED_REFRESH:int = 3;
      
      public static const MESSAGE_STYLE_HINT_TALL_LONG:int = 10;
      
      public static const MESSAGE_STYLE_BIG_MIDDLE_FAST:int = 12;
      
      public static const ADVICE_PLANT_NOT_PASSED_LINE:int = 13;
      
      public static const ZOMBIE_COUNTDOWN_BEFORE_REPICK:int = 5500;
      
      public static const REANIM_PEASHOOTER:int = 0;
      
      public static const BOARD_WIDTH:int = 540;
      
      public static const TUTORIAL_OFF:int = 0;
      
      public static const REANIM_WALLNUT:int = 1;
      
      public static const SEED_LEFTPEATER:int = 49;
      
      public static const GRIDSIZEY:int = 5;
      
      public static const RENDER_LAYER_COIN_BANK:int = 600000;
      
      public static const SEED_GRAVEBUSTER:int = 11;
      
      public static const SCARYPOT_NONE:int = 0;
      
      public static const ADVICE_PEASHOOTER_DIED:int = 10;
      
      public static const ZOMBIE_POLEVAULTER:int = 3;
      
      public static const GRIDSIZEX:int = 9;
      
      public static const CURSOR_TYPE_PLANT_FROM_BANK:int = 1;
      
      public static const SEED_PUFFSHROOM:int = 8;
      
      public static const CURSOR_TYPE_PLANT_FROM_USABLE_COIN:int = 2;
      
      public static const OBJECT_TYPE_PROJECTILE:int = 2;
      
      public static const TUTORIAL_MORESUN_PICK_UP_SUNFLOWER:int = 9;
      
      public static const REANIM_SQUASH:int = 4;
      
      public static const SEED_PEASHOOTER:int = 0;
      
      public static const ZOMBIE_NORMAL:int = 0;
      
      public static const RENDER_LAYER_FOG:int = 500000;
      
      public static const TUTORIAL_MORESUN_PLANT_SUNFLOWER:int = 10;
      
      public static const ADVICE_CLICKED_ON_SUN:int = 1;
      
      public static const MESSAGE_STYLE_HOUSE_NAME:int = 13;
      
      public static const SEED_EXPLODE_O_NUT:int = 50;
      
      public static const NUM_ZOMBIE_TYPES:int = 8;
      
      public static const TUTORIAL_LEVEL_2_REFRESH_SUNFLOWER:int = 7;
      
      public static const LAWN_XMAX:int = 513;
      
      public static const SEED_SUNFLOWER:int = 1;
      
      public static const SUN_COUNTDOWN_MAX:int = 950;
      
      public static const ZOMBIE_COUNTDOWN:int = 2500;
      
      public static const MESSAGE_STYLE_OFF:int = -1;
      
      public static const SCENE_PLAYING:int = 3;
      
      public static const SEED_CHOMPER:int = 6;
      
      public static const ZOMBIE_PAIL:int = 4;
      
      public static const TUTORIAL_LEVEL_1_PICK_UP_PEASHOOTER:int = 1;
      
      public static const SCENE_MENU:int = 1;
      
      public static const ZOMBIE_COUNTDOWN_RANGE:int = 600;
      
      public static const ADVICE_PLANT_GRAVEBUSTERS_ON_GRAVES:int = 12;
      
      public static const PLANTING_NOT_ON_GRAVE:String = "not on graves";
      
      public static const OBJECT_TYPE_SEEDPACKET:int = 4;
      
      public static const LEVELS_PER_AREA:int = 10;
      
      public static const TUTORIAL_LEVEL_2_COMPLETED:int = 8;
      
      public static const SUN_COUNTDOWN_RANGE:int = 275;
      
      public static const SCARYPOT_ZOMBIE:int = 2;
      
      public static const ZOMBIE_FOOTBALL:int = 7;
      
      public static const COIN_MOTION_FROM_PLANT:String = "from plant";
      
      public static const ADVICE_CLICKED_ON_COIN:int = 2;
      
      public static const OBJECT_TYPE_COIN:int = 3;
      
      public static const COIN_SUN:String = "sun";
      
      public static const PLANTING_OK:String = "ok";
      
      public static const MESSAGE_STYLE_HINT_STAY:int = 7;
      
      public static const ADVICE_HUGE_WAVE:int = 6;
      
      public static const OBJECT_TYPE_MENU_BUTTON:int = 7;
      
      public static const MESSAGE_STYLE_HINT_FAST:int = 6;
      
      public static const SEED_REPEATER:int = 7;
      
      public static const PLANTROW_NORMAL:int = 0;
      
      public static const COIN_MOTION_FROM_SKY_SLOW:String = "from sky slow";
      
      public static const BACKGROUND_2_NIGHT:int = 1;
      
      public static const SEED_SUNSHROOM:int = 9;
      
      public static const LAWN_YMAX:int = 385;
      
      public static const BOARD_SHAKE_TIME:int = 12;
      
      public static const ZOMBIE_NEWSPAPER:int = 5;
      
      public static const RENDER_LAYER_LAWN:int = 300000;
      
      public static const RENDER_LAYER_PROJECTILE:int = RENDER_LAYER_LAWN + 5000;
      
      public static const RENDER_LAYER_ZOMBIE:int = RENDER_LAYER_LAWN + 3000;
      
      public static const RENDER_LAYER_GRAVE_STONE:int = RENDER_LAYER_LAWN + 1000;
      
      public static const RENDER_LAYER_LAWN_MOWER:int = RENDER_LAYER_LAWN + 6000;
      
      public static const RENDER_LAYER_PLANT:int = RENDER_LAYER_LAWN + 2000;
      
      public static const SEED_WALLNUT:int = 3;
      
      public static const ZOMBIE_COUNTDOWN_BEFORE_FLAG:int = 4500;
      
      public static const OBJECT_TYPE_SCARY_POT:int = 6;
      
      public static const PLANTING_NOT_HERE:String = "not here";
      
      public static const ADVICE_PLANT_NOT_ON_GRAVE:int = 11;
      
      public static const RENDER_LAYER_ABOVE_UI:int = 800000;
      
      public static const MESSAGE_STYLE_HINT_LONG:int = 5;
      
      public static const ADVICE_SURVIVE_FLAGS:int = 8;
      
      public static const COIN_MOTION_FROM_SKY:String = "from sky";
      
      public static const TUTORIAL_LEVEL_1_PLANT_PEASHOOTER:int = 2;
      
      public static const MESSAGE_STYLE_HINT_TALL_UNLOCKMESSAGE:int = 9;
      
      public static const MESSAGE_STYLE_TUTORIAL_LATER_STAY:int = 4;
      
      public static const REANIM_SUNFLOWER:int = 2;
      
      public static const SUN_COUNTDOWN:int = 425;
      
      public static const REANIM_NONE:int = -1;
      
      public static const ZOMBIE_TRAFFIC_CONE:int = 2;
      
      public static const TUTORIAL_MORESUN_REFRESH_SUNFLOWER:int = 11;
      
      public static const CURSOR_TYPE_SHOVEL:int = 3;
      
      public static const ZOMBIE_FLAG:int = 1;
      
      public static const ADVICE_CANT_AFFORD_PLANT:int = 4;
      
      public static const RENDER_LAYER_UI_TOP:int = 700000;
      
      public static const MAX_ZOMBIES_IN_WAVE:int = 50;
      
      public static const RENDER_LAYER_TOP:int = 400000;
      
      public static const MESSAGE_STYLE_TUTORIAL_LEVEL1_STAY:int = 1;
      
      public static const RENDER_LAYER_PARTICLE:int = RENDER_LAYER_LAWN + 7000;
      
      public static const RENDER_LAYER_UI_BOTTOM:int = 100000;
       
      
      public var mLevelFont:FontInst;
      
      private var mLevelLabel:ImageInst;
      
      private var seeds:Array;
      
      public var mSodPosition:int;
      
      public var mCursorPreview:CursorPreview;
      
      public var mShakeAmountX:int;
      
      public var mShakeAmountY:int;
      
      public var mHelpIndex:int;
      
      public var mGridItems:Array;
      
      private var sod3Row:ImageInst;
      
      public var mPlants:Array;
      
      private var cursorObject:CursorObject;
      
      public var mNumWaves:int;
      
      public var mShowShovel:Boolean;
      
      public var mTimeStopCounter:int;
      
      public var mZombieCountDownStart:int;
      
      public var mTutorialState:int;
      
      public var mZombiePail:Array;
      
      private var FlagMeterFlag:ImageInst;
      
      public var mTriggeredLawnMowers:int;
      
      public var mOptionsMenu:OptionsDialog;
      
      private var seed:SeedPacket;
      
      public var mSunCountDown:int;
      
      private var mApp:PVZApp;
      
      public var mChallenge:Challenge;
      
      public var mZombieHealthWaveStart:int;
      
      private var lastTime:Number = 0;
      
      private var mFlagRaiseCounter:int;
      
      private var mLevelLabelString:String = "";
      
      public var mOutOfMoneyCounter:int;
      
      public var mNextSurvivalStageCounter:int;
      
      public var mZombieCountDown:int;
      
      public var mEnableGraveStones:Boolean;
      
      public var mNumSunsFallen:int;
      
      public var mLawnMowers:Array;
      
      private var mFinalWaveSoundCounter:int;
      
      public var mZombiePolevaulter:Array;
      
      public var mZombieHealthToNextWave:int;
      
      public var mMaxZombiesInWave:Array;
      
      public var mToolTip:ToolTipWidget;
      
      public var mZombieNewsPaper:Array;
      
      private var doorOverlay:ImageInst;
      
      public var mZombieGoldenPail:Array;
      
      public var mShovelBankImage:ImageInst;
      
      private var FlagMeterHead:ImageInst;
      
      public var mCutScene:CutScene;
      
      private var seedBack:ImageInst;
      
      public var mLevelAwardSpawned:Boolean;
      
      public var mPlantRow:Array;
      
      public var mProjectiles:Array;
      
      public var mZombieFlag:Array;
      
      public var mZombieAllowedLevels:Array;
      
      public var mLastBungeeWave:int;
      
      public var mProgressMeterWidth:int;
      
      public var mLevel:int;
      
      public var mTutorialTimer:int;
      
      public var mShakeCounter:int;
      
      private var background:ImageInst;
      
      public var mHelpDisplayed:Array;
      
      public var mZombieAllowed:Array;
      
      public var mGridCelLook:Array;
      
      public var mCursorObject:CursorObject;
      
      public var mBoardFadeOutCounter:int;
      
      private var grid:Array;
      
      public var mGravesCleared:int;
      
      public var mMainCounter:int;
      
      public var mSunMoney:int;
      
      public var mCurrentWave:int;
      
      public var mZombieWaves:Array;
      
      public var mGridCelOffset:Array;
      
      private var activeGrid:Object = null;
      
      public var mLevelComplete:Boolean;
      
      private var sod1Row:ImageInst;
      
      private var FlagMeterBar:ImageInst;
      
      public var mHugeWaveCountDown:int;
      
      public var mBackground:int;
      
      public var mRowPickingArray:Array;
      
      public var mShowZombieWalking:Boolean;
      
      public var mZombieTraffic:Array;
      
      public var mZombieScreenDoor:Array;
      
      public var mCoins:Array;
      
      private var FlagMeterFull:ImageInst;
      
      private var unsoddedBackground:ImageInst;
      
      public var mGridSquareType:Array;
      
      public var mEasyPlantingCheat:Boolean;
      
      private var mWaveWarning:WaveWarning;
      
      public var mZombieNormal:Array;
      
      public var mAdviceFont:FontInst;
      
      public var mZombiesInWave:Array;
      
      public var mAdvice:MessageWidget;
      
      public var mShovelButtonRect:Rectangle;
      
      private var doorMask:ImageInst;
      
      public var mRenderManager:RenderManager;
      
      public var mShovelImage:ImageInst;
      
      private var mSpecialGraveStoneX:int;
      
      private var mSpecialGraveStoneY:int;
      
      public var mGameScene:int;
      
      public var mMenuButton:ImageButtonWidget;
      
      public var mTotalSpawnedWaves:int;
      
      private var plantTime:Number = 0;
      
      public var mSeedBank:SeedBank;
      
      public var mWaveRowGotLawnMowered:Array;
      
      public var mTutorialArrow:ParticleSystem;
      
      public var mZombies:Array;
      
      private var FlagMeterEmpty:ImageInst;
      
      public var mShownMoreSunTutorial:Boolean = false;
      
      public var Menu_button:int = 100;
      
      public var mPaused:Boolean;
      
      public var mRiseFromGraveCounter:int;
      
      public function Board(app:PVZApp)
      {
         this.seeds = new Array();
         this.grid = new Array();
         this.mPlants = new Array();
         this.mPlantRow = new Array();
         this.mGridSquareType = new Array();
         this.mProjectiles = new Array();
         this.mCoins = new Array();
         this.mLawnMowers = new Array();
         this.mZombies = new Array();
         this.mZombieWaves = new Array(4,6,8,10,8,10,20,10,20,20,10,20,10,20,10,10,20,10,20,20);
         this.mZombieNormal = new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1);
         this.mZombieFlag = new Array(1,1,1,1,1,1,1,1,1,1,1,1,1,1);
         this.mZombieTraffic = new Array(0,0,1,1,1,1,1,1,1,1,0,1,1,1);
         this.mZombiePolevaulter = new Array(0,0,0,0,0,1,1,0,1,1,0,0,0,1);
         this.mZombiePail = new Array(0,0,0,0,0,0,0,1,1,1,0,1,0,0);
         this.mZombieGoldenPail = new Array(0,0,0,0,0,0,0,0,0,0);
         this.mZombieNewsPaper = new Array(0,0,0,0,0,0,0,0,0,0,1,1,0,0);
         this.mZombieScreenDoor = new Array(0,0,0,0,0,0,0,0,0,0,0,0,1,1);
         this.mZombieAllowedLevels = new Array(this.mZombieNormal,this.mZombieFlag,this.mZombieTraffic,this.mZombiePolevaulter,this.mZombiePail,this.mZombieNewsPaper,this.mZombieScreenDoor);
         this.mZombieAllowed = new Array();
         this.mMaxZombiesInWave = new Array(MAX_ZOMBIES_IN_WAVE);
         this.mZombiesInWave = new Array(MAX_ZOMBIE_WAVES);
         this.mRowPickingArray = new Array(GRIDSIZEY);
         this.mGridItems = new Array();
         this.mGridCelLook = new Array();
         this.mGridCelOffset = new Array();
         this.mWaveRowGotLawnMowered = new Array(GRIDSIZEY);
         this.mShovelButtonRect = new Rectangle(402,0,63,65);
         this.mHelpDisplayed = new Array();
         this.mRenderManager = new RenderManager();
         super();
         app.registerCheat("refreshSeedsCheat",this.refreshSeedsCheat);
         app.registerCheat("spawnAwardCheat",this.spawnAwardCheat);
         app.registerCheat("freePlantingCheat",this.freePlantingCheat);
         app.registerCheat("previousLevelCheat",this.previousLevelCheat);
         app.registerCheat("nextLevelCheat",this.nextLevelCheat);
         app.registerCheat("spawnWaveCheat",this.spawnWaveCheat);
         app.registerCheat("spawnNormalZombieCheat",this.spawnNormalZombieCheat);
         app.registerCheat("spawnScreendoorZombieCheat",this.spawnScreendoorZombieCheat);
         app.registerCheat("spawnNewspaperZombieCheat",this.spawnNewspaperZombieCheat);
         app.registerCheat("spawnFootballZombieCheat",this.spawnFootballZombieCheat);
         app.registerCheat("spawnBucketZombieCheat",this.spawnBucketZombieCheat);
         app.registerCheat("spawnConeheadZombieCheat",this.spawnConeheadZombieCheat);
         app.registerCheat("spawnPolevaultZombieCheat",this.spawnPolevaultZombieCheat);
         app.registerCheat("spawnGraveZombieCheat",this.spawnGraveZombieCheat);
         x = 0;
         y = 0;
         width = 540;
         height = 405;
         this.mApp = app;
         this.mCursorObject = new CursorObject(app,this);
         this.mCursorPreview = new CursorPreview(app,this);
         this.mSpecialGraveStoneX = -1;
         this.mSpecialGraveStoneY = -1;
         this.mEnableGraveStones = false;
         this.mGravesCleared = 0;
         this.mRiseFromGraveCounter = 0;
         this.mEasyPlantingCheat = false;
         this.mNextSurvivalStageCounter = 0;
         this.mToolTip = new ToolTipWidget(this.mApp,this);
         this.mTimeStopCounter = 0;
         this.mLevel = this.mApp.mLevel;
         if(this.mLevel > 10 || this.mApp.IsSurvivalMode() || this.mApp.IsScaryPotterLevel())
         {
            this.background = app.imageManager.getImageInst(PVZImages.IMAGE_BACKGROUND2);
            this.doorOverlay = app.imageManager.getImageInst(PVZImages.IMAGE_BACKGROUND2_GAMEOVER_INTERIOR_OVERLAY);
            this.doorMask = app.imageManager.getImageInst(PVZImages.IMAGE_BACKGROUND2_GAMEOVER_MASK);
         }
         else
         {
            this.background = app.imageManager.getImageInst(PVZImages.IMAGE_BACKGROUND1);
            this.doorOverlay = app.imageManager.getImageInst(PVZImages.IMAGE_BACKGROUND1_GAMEOVER_INTERIOR_OVERLAY);
            this.doorMask = app.imageManager.getImageInst(PVZImages.IMAGE_BACKGROUND1_GAMEOVER_MASK);
         }
         this.unsoddedBackground = app.imageManager.getImageInst(PVZImages.IMAGE_BACKGROUND1UNSODDED);
         this.sod1Row = app.imageManager.getImageInst(PVZImages.IMAGE_SOD1ROW);
         this.sod3Row = app.imageManager.getImageInst(PVZImages.IMAGE_SOD3ROW);
         this.FlagMeterBar = app.imageManager.getImageInst(PVZImages.IMAGE_FLAGMETERBAR);
         this.FlagMeterFlag = app.imageManager.getImageInst(PVZImages.IMAGE_FLAGMETERFLAG);
         this.FlagMeterHead = app.imageManager.getImageInst(PVZImages.IMAGE_FLAGMETERHEAD);
         this.FlagMeterFull = app.imageManager.getImageInst(PVZImages.IMAGE_FLAGMETERFULL);
         this.FlagMeterEmpty = app.imageManager.getImageInst(PVZImages.IMAGE_FLAGMETEREMPTY);
         this.mAdvice = null;
         this.mAdviceFont = app.fontManager.getFontInst(PVZFonts.FONT_HOUSEOFTERROR28);
         this.mLevelFont = app.fontManager.getFontInst(PVZFonts.FONT_HOUSEOFTERROR16);
         this.mAdvice = new MessageWidget(app,this);
         this.mSeedBank = new SeedBank(app,this);
         this.mLevelAwardSpawned = false;
         this.mLevelComplete = false;
         this.mBoardFadeOutCounter = -1;
         this.mFlagRaiseCounter = 0;
         this.mTriggeredLawnMowers = 0;
         this.mShowShovel = false;
         this.mShowZombieWalking = false;
         this.mTutorialState = TUTORIAL_OFF;
         this.mTutorialTimer = -1;
         this.mShovelImage = app.imageManager.getImageInst(PVZImages.IMAGE_SHOVEL_SMALL);
         this.mShovelBankImage = app.imageManager.getImageInst(PVZImages.IMAGE_SHOVELBANK);
         this.mChallenge = new Challenge(this.mApp,this);
         this.MakeMenuButton();
         this.mWaveWarning = new WaveWarning(app);
      }
      
      public function CanZombieSpawnOnLevel(theZombieType:int, theLevel:int) : Boolean
      {
         var aZombieDef:ZombieDef = this.GetZombieDefinition(theZombieType);
         if(theLevel < aZombieDef.mStartingLevel)
         {
            return false;
         }
         if(aZombieDef.mPickWeight == 0)
         {
            return false;
         }
         var aLevelIndex:int = TodCommon.ClampInt(theLevel - 1,0,14 - 1);
         if(this.mZombieAllowedLevels[theZombieType][aLevelIndex] == 0)
         {
            return false;
         }
         return true;
      }
      
      public function SpawnZombieWave() : void
      {
         var aZombieType:int = 0;
         this.mChallenge.SpawnZombieWave();
         var counter:int = 0;
         for(var i:int = 0; i < MAX_ZOMBIES_IN_WAVE; i++)
         {
            aZombieType = int(this.mZombiesInWave[this.mCurrentWave][i]);
            if(this.mCurrentWave == 4)
            {
            }
            if(aZombieType == ZOMBIE_INVALID)
            {
               break;
            }
            counter++;
            this.AddZombie(aZombieType,this.mCurrentWave);
         }
         if(this.mCurrentWave == this.mNumWaves - 1)
         {
            this.mRiseFromGraveCounter = 200;
         }
         if(this.IsFlagWave(this.mCurrentWave))
         {
            this.mFlagRaiseCounter = FLAG_RAISE_TIME;
         }
         ++this.mCurrentWave;
         ++this.mTotalSpawnedWaves;
      }
      
      public function CanZombieGoInGridSpot(theZombieType:int, theGridX:int, theGridY:int, theZombieGrid:Array) : Boolean
      {
         if(theZombieGrid[theGridX][theGridY])
         {
            return false;
         }
         if(theGridX == 4 && theGridY == 0)
         {
            return false;
         }
         if(theZombieType == Board.ZOMBIE_POLEVAULTER)
         {
            if(theGridX == 0)
            {
               return false;
            }
            if(theGridX == 1 && theGridY == 0)
            {
               return false;
            }
         }
         return true;
      }
      
      public function AddZombie(theZombieType:int, theFromWave:int, row:int = -1) : Zombie
      {
         var aRow:int = row;
         if(aRow == -1)
         {
            aRow = this.PickRowForNewZombie(theZombieType);
         }
         return this.AddZombieInRow(theZombieType,aRow,theFromWave);
      }
      
      public function PlantingPixelToGridY(theX:int, theY:int, theSeedType:int) : int
      {
         var aPlantingY:int = theY;
         return this.PixelToGridY(theX,aPlantingY);
      }
      
      public function IsFinalSurvivalStage() : Boolean
      {
         return false;
      }
      
      public function CountPlantByType(theSeedType:int) : int
      {
         var aPlant:CPlant = null;
         var aCount:int = 0;
         for each(aPlant in this.mPlants)
         {
            if(aPlant.mSeedType == theSeedType)
            {
               aCount++;
            }
         }
         return aCount;
      }
      
      public function CanDropLoot() : Boolean
      {
         return false;
      }
      
      public function GetPlantDefinition(theSeedType:int) : String
      {
         var aReanimType:String = null;
         switch(theSeedType)
         {
            case SEED_PEASHOOTER:
               aReanimType = PVZReanims.REANIM_PEASHOOTERSINGLE;
               break;
            case SEED_SUNFLOWER:
               aReanimType = PVZReanims.REANIM_SUNFLOWER;
               break;
            case SEED_CHERRYBOMB:
               aReanimType = PVZReanims.REANIM_CHERRYBOMB;
               break;
            case SEED_CHOMPER:
               aReanimType = PVZReanims.REANIM_CHOMPER;
               break;
            case SEED_SNOWPEA:
               aReanimType = PVZReanims.REANIM_SNOWPEA;
               break;
            case SEED_SQUASH:
               aReanimType = PVZReanims.REANIM_SQUASH;
               break;
            case SEED_WALLNUT:
            case SEED_EXPLODE_O_NUT:
               aReanimType = PVZReanims.REANIM_WALLNUT;
               break;
            case SEED_REPEATER:
               aReanimType = PVZReanims.REANIM_PEASHOOTER;
               break;
            case SEED_PUFFSHROOM:
               aReanimType = PVZReanims.REANIM_PUFFSHROOM;
               break;
            case SEED_SUNSHROOM:
               aReanimType = PVZReanims.REANIM_SUNSHROOM;
               break;
            case SEED_FUMESHROOM:
               aReanimType = PVZReanims.REANIM_FUMESHROOM;
               break;
            case SEED_GRAVEBUSTER:
               aReanimType = PVZReanims.REANIM_GRAVEBUSTER;
               break;
            case SEED_LEFTPEATER:
               aReanimType = PVZReanims.REANIM_PEASHOOTER;
         }
         return aReanimType;
      }
      
      public function FindAndPlaceZombie(theZombieType:int, theZombieGrid:Array) : void
      {
         var aGridX:int = 0;
         var aGridY:int = 0;
         this.FindPlaceForStreetZombies(theZombieType,theZombieGrid,aGridX,aGridY);
      }
      
      public function PutZombieInWave(theZombieType:int, theWaveNumber:int, theZombiePicker:ZombiePicker) : void
      {
         this.mZombiesInWave[theWaveNumber][theZombiePicker.mZombieCount] = theZombieType;
         ++theZombiePicker.mZombieCount;
         if(theZombiePicker.mZombieCount < MAX_ZOMBIES_IN_WAVE)
         {
            this.mZombiesInWave[theWaveNumber][theZombiePicker.mZombieCount] = ZOMBIE_INVALID;
         }
         var aIntroZombieDef:ZombieDef = this.GetZombieDefinition(theZombieType);
         theZombiePicker.mZombiePoints -= aIntroZombieDef.mZombieValue;
         ++theZombiePicker.mZombieTypeCount[theZombieType];
         ++theZombiePicker.mAllWavesZombieTypeCount[theZombieType];
      }
      
      public function IsSlotMachineLevel() : Boolean
      {
         return false;
      }
      
      public function ChooseSeedsOnCurrentLevel() : Boolean
      {
         if(this.HasConveyorBeltSeedBank())
         {
            return false;
         }
         if(this.mApp.IsSurvivalMode())
         {
            return true;
         }
         if(this.mLevel <= 7)
         {
            return false;
         }
         return true;
      }
      
      public function UpdateZombieSpawning() : void
      {
         var SPAWN_DELAY_AFTER_HEALTH_TRIGGER:int = 0;
         var aTotalHealth:int = 0;
         if(this.mFinalWaveSoundCounter > 0)
         {
            --this.mFinalWaveSoundCounter;
            if(this.mFinalWaveSoundCounter == 0)
            {
            }
         }
         if(this.mTutorialState == TUTORIAL_LEVEL_1_PICK_UP_PEASHOOTER || this.mTutorialState == TUTORIAL_LEVEL_1_PLANT_PEASHOOTER || this.mTutorialState == TUTORIAL_LEVEL_1_REFRESH_PEASHOOTER)
         {
            return;
         }
         if(this.HasLevelAwardDropped())
         {
            return;
         }
         if(this.mRiseFromGraveCounter > 0)
         {
            --this.mRiseFromGraveCounter;
            if(this.mRiseFromGraveCounter == 0)
            {
               this.SpawnZombiesFromGraves();
            }
         }
         if(this.mHugeWaveCountDown)
         {
            --this.mHugeWaveCountDown;
            if(this.mHugeWaveCountDown == 0)
            {
               this.ClearAdvice(ADVICE_HUGE_WAVE);
               this.NextWaveComing();
               this.mZombieCountDown = 1;
            }
            else if(this.mHugeWaveCountDown != 725)
            {
               return;
            }
         }
         if(this.mChallenge.UpdateZombieSpawning())
         {
            return;
         }
         if(this.mCurrentWave == this.mNumWaves)
         {
            if(!this.mApp.IsSurvivalMode())
            {
               return;
            }
         }
         --this.mZombieCountDown;
         if(this.mCurrentWave == this.mNumWaves && this.mApp.IsSurvivalMode())
         {
            if(this.mZombieCountDown == 0)
            {
               this.FadeOutLevel();
            }
            return;
         }
         var aTimeSinceLastSpawn:int = this.mZombieCountDownStart - this.mZombieCountDown;
         if(this.mZombieCountDown > 5 && aTimeSinceLastSpawn > ZOMBIE_COUNTDOWN_MIN)
         {
            SPAWN_DELAY_AFTER_HEALTH_TRIGGER = 200;
            aTotalHealth = this.TotalZombiesHealthInWave(this.mCurrentWave - 1);
            if(aTotalHealth <= this.mZombieHealthToNextWave && this.mZombieCountDown > SPAWN_DELAY_AFTER_HEALTH_TRIGGER)
            {
               this.mZombieCountDown = SPAWN_DELAY_AFTER_HEALTH_TRIGGER;
            }
         }
         if(this.mZombieCountDown == 5)
         {
            if(this.IsFlagWave(this.mCurrentWave))
            {
               this.mHugeWaveCountDown = 750;
               this.mWaveWarning.showHugeWave(this.mHugeWaveCountDown);
               return;
            }
            this.NextWaveComing();
         }
         if(this.mZombieCountDown != 0)
         {
            return;
         }
         this.SpawnZombieWave();
         this.mZombieHealthWaveStart = this.TotalZombiesHealthInWave(this.mCurrentWave - 1);
         var aNoPauseBeforeHugeWave:Boolean = this.IsWallnutBowlingLevel();
         if(this.mCurrentWave == this.mNumWaves && this.mApp.IsSurvivalMode())
         {
            this.mZombieHealthToNextWave = 0;
            this.mZombieCountDown = ZOMBIE_COUNTDOWN_BEFORE_REPICK;
         }
         else if(this.IsFlagWave(this.mCurrentWave) && !aNoPauseBeforeHugeWave)
         {
            this.mZombieHealthToNextWave = 0;
            this.mZombieCountDown = ZOMBIE_COUNTDOWN_BEFORE_FLAG;
         }
         else
         {
            this.mZombieHealthToNextWave = int(TodCommon.RandRangeFloat(0.5,0.65) * Number(this.mZombieHealthWaveStart));
            this.mZombieCountDown = ZOMBIE_COUNTDOWN + Math.random() * ZOMBIE_COUNTDOWN_RANGE;
         }
         this.mZombieCountDownStart = this.mZombieCountDown;
      }
      
      public function PlantingPixelToGridX(theX:int, theY:int, theSeedType:int) : int
      {
         var aPlantingY:int = theY;
         return this.PixelToGridX(theX,aPlantingY);
      }
      
      public function GetGraveStoneAt(theGridX:int, theGridY:int) : GridItem
      {
         return this.GetGridItemAt(GRIDITEM_GRAVESTONE,theGridX,theGridY);
      }
      
      public function UpdateGameObjects() : void
      {
         this.mRenderManager.update();
         this.mCursorObject.update();
         this.mCursorPreview.update();
         for(var i:int = 0; i < this.mSeedBank.mNumPackets; i++)
         {
            this.mSeedBank.mSeedPackets[i].update();
         }
      }
      
      public function GetPlantSeedImage(g:Graphics2D) : void
      {
      }
      
      public function GetScaryPotAt(theGridX:int, theGridY:int) : GridItem
      {
         return this.GetGridItemAt(GRIDITEM_SCARY_POT,theGridX,theGridY);
      }
      
      public function MakeMenuButton() : void
      {
         var w:Number = 79;
         var h:Number = 31;
         this.mMenuButton = new ImageButtonWidget(this.Menu_button,this);
         this.mMenuButton.resize(465,0,w,h);
         this.mMenuButton.setDisabled(false);
         var x:int = 0;
         var y:int = 0;
         var theText:String = this.mApp.stringManager.translateString("[MENU_BUTTON]");
         var upImage:ImageInst = new ImageInst(new ImageData(new BitmapData(w,h,true,0)));
         var bufferG:Graphics2D = upImage.graphics;
         var anImage:ImageInst = this.mApp.imageManager.getImageInst(PVZImages.IMAGE_BUTTON_LEFT);
         bufferG.drawImage(anImage,x,y);
         x += anImage.width;
         anImage = this.mApp.imageManager.getImageInst(PVZImages.IMAGE_BUTTON_MIDDLE);
         bufferG.drawImage(anImage,x,y);
         x += anImage.width;
         anImage = this.mApp.imageManager.getImageInst(PVZImages.IMAGE_BUTTON_RIGHT);
         bufferG.drawImage(anImage,x,y);
         var font:FontInst = this.mApp.fontManager.getFontInst(PVZFonts.FONT_DWARVENTODCRAFT36GREENINSET);
         font.scale = 0.4;
         var offsetX:Number = (w - font.stringImageWidth(theText)) / 2;
         var offsetY:Number = (h - font.getHeight() - 5) / 2;
         bufferG.setFont(font);
         bufferG.drawString(theText,offsetX,offsetY);
         x = 0;
         y = 0;
         var downImage:ImageInst = new ImageInst(new ImageData(new BitmapData(w,h,true,0)));
         bufferG = downImage.graphics;
         anImage = this.mApp.imageManager.getImageInst(PVZImages.IMAGE_BUTTON_DOWN_LEFT);
         bufferG.drawImage(anImage,x,y);
         x += anImage.width;
         anImage = this.mApp.imageManager.getImageInst(PVZImages.IMAGE_BUTTON_DOWN_MIDDLE);
         bufferG.drawImage(anImage,x,y);
         x += anImage.width;
         anImage = this.mApp.imageManager.getImageInst(PVZImages.IMAGE_BUTTON_DOWN_RIGHT);
         bufferG.drawImage(anImage,x,y);
         font = this.mApp.fontManager.getFontInst(PVZFonts.FONT_DWARVENTODCRAFT36BRIGHTGREENINSET);
         font.scale = 0.4;
         bufferG.setFont(font);
         bufferG.drawString(theText,offsetX + 1,offsetY + 1);
         x = 0;
         y = 0;
         var overImage:ImageInst = new ImageInst(new ImageData(new BitmapData(w,h,true,0)));
         bufferG = overImage.graphics;
         anImage = this.mApp.imageManager.getImageInst(PVZImages.IMAGE_BUTTON_LEFT);
         bufferG.drawImage(anImage,x,y);
         x += anImage.width;
         anImage = this.mApp.imageManager.getImageInst(PVZImages.IMAGE_BUTTON_MIDDLE);
         bufferG.drawImage(anImage,x,y);
         x += anImage.width;
         anImage = this.mApp.imageManager.getImageInst(PVZImages.IMAGE_BUTTON_RIGHT);
         bufferG.drawImage(anImage,x,y);
         font = this.mApp.fontManager.getFontInst(PVZFonts.FONT_DWARVENTODCRAFT36BRIGHTGREENINSET);
         font.scale = 0.4;
         bufferG.setFont(font);
         bufferG.drawString(theText,offsetX,offsetY);
         this.mMenuButton.mUpImage = upImage;
         this.mMenuButton.mOverImage = overImage;
         this.mMenuButton.mDownImage = downImage;
         this.mMenuButton.mDownOffset = new Point(1,1);
         this.mMenuButton.mDisabledImage = upImage;
      }
      
      private function spawnWaveCheat() : void
      {
         if(this.mHugeWaveCountDown > 0)
         {
            this.mHugeWaveCountDown = 1;
         }
         else
         {
            this.mZombieCountDown = 6;
         }
      }
      
      public function ClearCursor() : void
      {
         this.mCursorObject.mType = SEED_NONE;
         this.mCursorObject.mCursorType = CURSOR_TYPE_NORMAL;
         this.mCursorObject.mSeedBankIndex = -1;
         if(this.mTutorialState == TUTORIAL_LEVEL_1_PLANT_PEASHOOTER)
         {
            this.SetTutorialState(TUTORIAL_LEVEL_1_PICK_UP_PEASHOOTER);
         }
         else if(this.mTutorialState == TUTORIAL_LEVEL_2_PLANT_SUNFLOWER || this.mTutorialState == TUTORIAL_LEVEL_2_REFRESH_SUNFLOWER)
         {
            if(!this.mSeedBank.mSeedPackets[1].CanPickUp())
            {
               this.SetTutorialState(TUTORIAL_LEVEL_2_REFRESH_SUNFLOWER);
            }
            else
            {
               this.SetTutorialState(TUTORIAL_LEVEL_2_PICK_UP_SUNFLOWER);
            }
         }
         else if(this.mTutorialState == TUTORIAL_MORESUN_PLANT_SUNFLOWER || this.mTutorialState == TUTORIAL_MORESUN_REFRESH_SUNFLOWER)
         {
            if(!this.mSeedBank.mSeedPackets[1].CanPickUp())
            {
               this.SetTutorialState(TUTORIAL_MORESUN_REFRESH_SUNFLOWER);
            }
            else
            {
               this.SetTutorialState(TUTORIAL_MORESUN_PICK_UP_SUNFLOWER);
            }
         }
         else if(this.mTutorialState == TUTORIAL_SHOVEL_DIG)
         {
            this.SetTutorialState(TUTORIAL_SHOVEL_PICKUP);
         }
      }
      
      public function SpawnZombiesFromGraves() : void
      {
         var aGridItem:GridItem = null;
         var aZombieType:int = 0;
         var aZombieDef:ZombieDef = null;
         var aZombie:Zombie = null;
         var aZombiePoints:int = this.GetGraveStoneCount();
         for each(aGridItem in this.mGridItems)
         {
            if(aGridItem.mGridItemType == GRIDITEM_GRAVESTONE)
            {
               if(aGridItem.mGridItemCounter >= 100)
               {
                  aZombieType = this.PickGraveRisingZombieType(aZombiePoints);
                  aZombieDef = this.GetZombieDefinition(aZombieType);
                  aZombie = this.AddZombie(aZombieType,this.mCurrentWave,aGridItem.mGridY);
                  if(!aZombie)
                  {
                     return;
                  }
                  aZombie.RiseFromGrave(aGridItem.mGridX,aGridItem.mGridY);
                  aZombiePoints -= aZombieDef.mZombieValue;
                  aZombiePoints = Math.max(1,aZombiePoints);
               }
            }
         }
      }
      
      public function IsWallnutBowlingLevel() : Boolean
      {
         if(this.mLevel == 5)
         {
            return true;
         }
         return false;
      }
      
      public function FindPlaceForStreetZombies(theZombieType:int, theZombieGrid:Array, thePosX:int, thePosY:int) : void
      {
         var y:int = 0;
         var aWeightedGridArray:WeightedGridArray = null;
         var aPicks:Array = new Array();
         var aPickCount:int = 0;
         for(var x:int = 0; x < 5; x++)
         {
            for(y = 0; y < 5; y++)
            {
               if(this.CanZombieGoInGridSpot(theZombieType,x,y,theZombieGrid))
               {
                  aWeightedGridArray = new WeightedGridArray();
                  aPicks[aPickCount] = aWeightedGridArray;
                  aPicks[aPickCount].mX = x;
                  aPicks[aPickCount].mY = y;
                  aPicks[aPickCount].mWeight = 1;
                  aPickCount++;
               }
            }
         }
         if(aPickCount == 0)
         {
            thePosX = 2;
            thePosY = 2;
            return;
         }
         var aResultItem:WeightedGridArray = TodCommon.TodPickFromWeightedGridArray(aPicks,aPickCount);
         thePosX = aResultItem.mX;
         thePosY = aResultItem.mY;
         theZombieGrid[thePosX][thePosY] = true;
         this.PlaceAZombie(theZombieType,thePosX,thePosY);
      }
      
      public function buttonMouseEnter(id:Number) : void
      {
      }
      
      public function PlaceStreetZombies() : void
      {
         var aZombieType:int = 0;
         var aGridY:int = 0;
         var aZombieArray:Array = null;
         var aNumToShow:int = 0;
         var aZombieIndex:int = 0;
         if(this.mApp.mPlacedZombies)
         {
            return;
         }
         this.mApp.mPlacedZombies = true;
         var aTotalZombieCount:int = 0;
         var aZombieTypeCount:Array = new Array();
         var aZombieValueTotal:int = 0;
         for(var i:int = 0; i < 8; i++)
         {
            aZombieTypeCount[i] = 0;
         }
         for(var aWaveIndex:int = 0; aWaveIndex < this.mApp.mBoard.mNumWaves; aWaveIndex++)
         {
            for(i = 0; i < Board.MAX_ZOMBIES_IN_WAVE; i++)
            {
               aZombieType = int(this.mApp.mBoard.mZombiesInWave[aWaveIndex][i]);
               if(aZombieType == Board.ZOMBIE_INVALID)
               {
                  break;
               }
               aZombieValueTotal += this.mApp.mBoard.GetZombieDefinition(aZombieType).mZombieValue;
               if(aZombieType != Board.ZOMBIE_FLAG)
               {
                  ++aZombieTypeCount[aZombieType];
                  aTotalZombieCount++;
               }
            }
         }
         var aZombieGrid:Array = new Array();
         for(var aGridX:int = 0; aGridX < 5; aGridX++)
         {
            for(aGridY = 0; aGridY < 5; aGridY++)
            {
               aZombieArray = new Array();
               aZombieGrid.push(aZombieArray);
               aZombieGrid[aGridX][aGridY] = false;
            }
         }
         var amApproxNumberToShow:int = 10;
         if(this.mLevel == 10)
         {
            amApproxNumberToShow = 18;
         }
         for(aZombieType = 0; aZombieType < 8; aZombieType++)
         {
            if(aZombieTypeCount[aZombieType] != 0)
            {
               aNumToShow = aZombieTypeCount[aZombieType] * amApproxNumberToShow / aTotalZombieCount;
               aNumToShow = TodCommon.ClampInt(aNumToShow,1,aZombieTypeCount[aZombieType]);
               for(aZombieIndex = 0; aZombieIndex < aNumToShow; aZombieIndex++)
               {
                  this.FindAndPlaceZombie(int(aZombieType),aZombieGrid);
               }
            }
         }
      }
      
      public function buttonPress(id:Number) : void
      {
      }
      
      public function ClearAdviceImmediately() : void
      {
         this.ClearAdvice(ADVICE_NONE);
         this.mAdvice.mDuration = 0;
      }
      
      public function RefreshSeedPacketFromCursor() : void
      {
         var aCoin:Coin = null;
         var aSeedPacket:SeedPacket = null;
         if(this.mCursorObject.mCursorType == CURSOR_TYPE_PLANT_FROM_USABLE_COIN)
         {
            aCoin = this.mCursorObject.mCoin;
            aCoin.DroppedUsableSeed();
         }
         if(this.mCursorObject.mCursorType == CURSOR_TYPE_PLANT_FROM_BANK)
         {
            aSeedPacket = this.mSeedBank.mSeedPackets[this.mCursorObject.mSeedBankIndex];
            aSeedPacket.Activate();
         }
         this.ClearCursor();
      }
      
      public function MouseDownWithPlant(x:int, y:int) : void
      {
         var aCost:int = 0;
         var aPlant:CPlant = null;
         var aPeashooters:int = 0;
         var aSuns:int = 0;
         var aPlantingSeedType:int = this.GetSeedTypeInCursor();
         var aGridX:int = this.PlantingPixelToGridX(x,y,aPlantingSeedType);
         var aGridY:int = this.PlantingPixelToGridY(x,y,aPlantingSeedType);
         if(aGridX < 0 || aGridX >= GRIDSIZEX || aGridY < 0 || aGridY >= GRIDSIZEY)
         {
            this.RefreshSeedPacketFromCursor();
            this.mApp.foleyManager.playFoley(PVZFoleyType.DROP);
            return;
         }
         var aReason:String = this.CanPlantAt(aGridX,aGridY,aPlantingSeedType);
         if(aReason != PLANTING_OK)
         {
            if(aReason == PLANTING_ONLY_ON_GRAVES)
            {
               this.DisplayAdvice("[ADVICE_GRAVEBUSTERS_ON_GRAVES]",MESSAGE_STYLE_HINT_FAST,ADVICE_PLANT_GRAVEBUSTERS_ON_GRAVES);
            }
            else if(aReason == PLANTING_NOT_PASSED_LINE)
            {
               this.DisplayAdvice("[ADVICE_NOT_PASSED_LINE]",MESSAGE_STYLE_HINT_FAST,ADVICE_PLANT_NOT_PASSED_LINE);
            }
            else if(aReason == PLANTING_NOT_ON_GRAVE)
            {
               this.DisplayAdvice("[ADVICE_PLANT_NOT_ON_GRAVE]",MESSAGE_STYLE_HINT_FAST,ADVICE_PLANT_NOT_ON_GRAVE);
            }
            return;
         }
         this.ClearAdvice(ADVICE_PLANT_NOT_ON_GRAVE);
         this.ClearAdvice(ADVICE_PLANT_NOT_PASSED_LINE);
         this.ClearAdvice(ADVICE_PLANT_GRAVEBUSTERS_ON_GRAVES);
         this.ClearAdvice(ADVICE_SURVIVE_FLAGS);
         if(this.mCursorObject.mCursorType == CURSOR_TYPE_PLANT_FROM_BANK && !this.HasConveyorBeltSeedBank())
         {
            aCost = this.GetCurrentPlantCost(this.mCursorObject.mType);
            if(!this.TakeSunMoney(aCost))
            {
               return;
            }
         }
         if(this.mCursorObject.mCursorType == CURSOR_TYPE_PLANT_FROM_USABLE_COIN)
         {
            this.AddPlant(aGridX,aGridY,this.mCursorObject.mType);
            this.mCursorObject.mCoin.Die();
            this.mCursorObject.mCoin = null;
         }
         else if(this.mCursorObject.mCursorType == CURSOR_TYPE_PLANT_FROM_BANK)
         {
            aPlant = this.AddPlant(aGridX,aGridY,this.mCursorObject.mType);
            this.mSeedBank.mSeedPackets[this.mCursorObject.mSeedBankIndex].WasPlanted();
         }
         if(this.mTutorialState == TUTORIAL_LEVEL_1_PLANT_PEASHOOTER)
         {
            aPeashooters = int(this.mPlants.length);
            if(aPeashooters >= 2)
            {
               this.SetTutorialState(TUTORIAL_LEVEL_1_COMPLETED);
            }
            else
            {
               this.SetTutorialState(TUTORIAL_LEVEL_1_REFRESH_PEASHOOTER);
            }
         }
         if(this.mTutorialState == TUTORIAL_LEVEL_2_PLANT_SUNFLOWER)
         {
            aSuns = this.CountSunFlowers();
            if(aPlantingSeedType == SEED_SUNFLOWER && aSuns == 2)
            {
               this.DisplayAdvice("[ADVICE_MORE_SUNFLOWERS]",MESSAGE_STYLE_TUTORIAL_LEVEL2,ADVICE_NONE);
            }
            if(aSuns >= 3)
            {
               this.SetTutorialState(TUTORIAL_LEVEL_2_COMPLETED);
            }
            else if(!this.mSeedBank.mSeedPackets[1].CanPickUp())
            {
               this.SetTutorialState(TUTORIAL_LEVEL_2_REFRESH_SUNFLOWER);
            }
            else
            {
               this.SetTutorialState(TUTORIAL_LEVEL_2_PICK_UP_SUNFLOWER);
            }
         }
         if(this.mTutorialState == TUTORIAL_MORESUN_PLANT_SUNFLOWER)
         {
            aSuns = this.CountSunFlowers();
            if(aSuns >= 3)
            {
               this.SetTutorialState(TUTORIAL_MORESUN_COMPLETED);
               this.DisplayAdvice("[ADVICE_PLANT_SUNFLOWER5]",MESSAGE_STYLE_TUTORIAL_LATER,ADVICE_PLANT_SUNFLOWER5);
               this.mTutorialTimer = -1;
            }
            else if(!this.mSeedBank.mSeedPackets[1].CanPickUp())
            {
               this.SetTutorialState(TUTORIAL_MORESUN_REFRESH_SUNFLOWER);
            }
            else
            {
               this.SetTutorialState(TUTORIAL_MORESUN_PICK_UP_SUNFLOWER);
            }
         }
         if(this.IsWallnutBowlingLevel())
         {
         }
         this.ClearCursor();
      }
      
      private function previousLevelCheat() : void
      {
         if(this.mApp.IsAdventureMode())
         {
            --this.mApp.mLevel;
            if(this.mApp.mLevel < 1)
            {
               this.mApp.mLevel = 1;
            }
         }
         else if(this.mApp.IsSurvivalMode())
         {
         }
         this.mApp.stateManager.changeState(PVZApp.STATE_LEVEL_INTRO);
      }
      
      public function DisplayAdvice(theAdvice:String, theMessageStyle:int, theHelpIndex:int) : void
      {
         if(theHelpIndex != ADVICE_NONE)
         {
            if(this.mHelpDisplayed[theHelpIndex])
            {
               return;
            }
            this.mHelpDisplayed[theHelpIndex] = true;
         }
         this.mAdvice.SetLabel(theAdvice,theMessageStyle);
         this.mHelpIndex = theHelpIndex;
      }
      
      public function GetCircleRectOverlap(theCircleX:int, theCircleY:int, theRadius:int, theRect:Rectangle) : Boolean
      {
         var distSquared:int = 0;
         var aCircleIsLeftOrRight:Boolean = false;
         var aCircleIsAboveOrBelow:Boolean = false;
         var aDistX:int = 0;
         var aDistY:int = 0;
         if(theCircleX < theRect.x)
         {
            aCircleIsLeftOrRight = true;
            aDistX = theRect.x - theCircleX;
         }
         else if(theCircleX > theRect.x + theRect.width)
         {
            aCircleIsLeftOrRight = true;
            aDistX = theCircleX - theRect.x - theRect.width;
         }
         if(theCircleY < theRect.y)
         {
            aCircleIsAboveOrBelow = true;
            aDistY = theRect.y - theCircleY;
         }
         else if(theCircleY > theRect.y + theRect.height)
         {
            aCircleIsAboveOrBelow = true;
            aDistY = theCircleY - theRect.y - theRect.height;
         }
         if(!aCircleIsAboveOrBelow && !aCircleIsLeftOrRight)
         {
            return true;
         }
         if(aCircleIsLeftOrRight && aCircleIsAboveOrBelow)
         {
            distSquared = aDistX * aDistX + aDistY * aDistY;
            return distSquared <= theRadius * theRadius;
         }
         if(aCircleIsLeftOrRight)
         {
            return aDistX <= theRadius;
         }
         return aDistY <= theRadius;
      }
      
      public function UpdateSunSpawning() : void
      {
         if(this.StageIsNight())
         {
            return;
         }
         if(this.mApp.IsScaryPotterLevel())
         {
            return;
         }
         if(this.HasLevelAwardDropped())
         {
            return;
         }
         if(this.HasConveyorBeltSeedBank())
         {
            return;
         }
         if(this.mTutorialState == TUTORIAL_LEVEL_1_PICK_UP_PEASHOOTER || this.mTutorialState == TUTORIAL_LEVEL_1_PLANT_PEASHOOTER)
         {
            if(this.mPlants.length == 0)
            {
               return;
            }
         }
         --this.mSunCountDown;
         if(this.mSunCountDown != 0)
         {
            return;
         }
         var x:int = 67 + Math.random() * 371;
         ++this.mNumSunsFallen;
         this.mSunCountDown = Math.min(SUN_COUNTDOWN_MAX,SUN_COUNTDOWN + this.mNumSunsFallen * 10) + Math.random() * SUN_COUNTDOWN_RANGE;
         var aCoinType:String = COIN_SUN;
         this.AddCoin(x,40,aCoinType,COIN_MOTION_FROM_SKY);
      }
      
      public function DrawLevelLabel(g:Graphics2D) : void
      {
         var aLevelStr:String = null;
         var aFlags:int = 0;
         var aFlagStr:String = null;
         var aCompletedStr:String = null;
         var aStreak:int = 0;
         var aStr:String = null;
         var screenBounds:Rectangle = null;
         if(this.mGameScene != PVZApp.SCENE_PLAYING)
         {
            return;
         }
         if(this.mApp.IsSurvivalMode())
         {
            aFlags = this.GetSurvivalFlagsCompleted();
            if(aFlags > 0)
            {
               aFlagStr = this.Pluralize(aFlags,"[ONE_FLAG]","[COUNT_FLAGS]");
               aCompletedStr = this.mApp.stringManager.translateString("[FLAGS_COMPLETED]").replace("{FLAGS}",aFlagStr);
               aLevelStr = this.mApp.stringManager.translateString("[SURVIVAL_POOL_ENDLESS]") + " " + aCompletedStr;
            }
            else
            {
               aLevelStr = this.mApp.stringManager.translateString("[SURVIVAL_POOL_ENDLESS]");
            }
         }
         else if(this.mApp.IsAdventureMode())
         {
            aLevelStr = this.mApp.stringManager.translateString("[LEVEL]") + " " + this.GetStageString(this.mLevel);
         }
         else if(this.mApp.IsScaryPotterLevel())
         {
            aStreak = this.mChallenge.mSurvivalStage;
            if(this.mNextSurvivalStageCounter > 0)
            {
               aStreak++;
            }
            if(aStreak > 0)
            {
               aStr = this.mApp.stringManager.translateString("[ENDLESS_STREAK]").replace("{STREAK}",aStreak);
               aLevelStr = aStr;
            }
            else
            {
               aLevelStr = this.mApp.stringManager.translateString("[SCARY_POTTER_ENDLESS]");
            }
         }
         if(aLevelStr != this.mLevelLabelString)
         {
            this.mLevelLabel = null;
         }
         this.mLevelLabelString = aLevelStr;
         if(this.mLevelLabel == null)
         {
            screenBounds = new Rectangle(0,0,this.mApp.screenWidth,this.mApp.screenHeight);
            this.mLevelFont.setColor(1,224 / 255,187 / 255,98 / 255);
            this.mLevelLabel = Utils.createStringImage(aLevelStr,this.mLevelFont,screenBounds,Utils.JUSTIFY_CENTER);
         }
         var aPosX:int = 530;
         var aPosY:int = 375;
         if(this.HasProgressMeter())
         {
            aPosX = 400;
         }
         aPosX -= this.mLevelLabel.width;
         g.drawImage(this.mLevelLabel,aPosX,aPosY);
      }
      
      private function spawnNewspaperZombieCheat() : void
      {
         this.AddZombieInRow(ZOMBIE_NEWSPAPER,int(Math.random() * 5),1);
      }
      
      public function PickBackground() : void
      {
         var newArray:Array = null;
         var newGridCelArray:Array = null;
         var newGridCellOffsetArray:Array = null;
         var y:int = 0;
         var anArray:Array = null;
         if(this.mApp.IsAdventureMode() && this.mLevel <= 10)
         {
            this.mBackground = BACKGROUND_1_DAY;
         }
         else
         {
            this.mBackground = BACKGROUND_2_NIGHT;
         }
         if(this.mBackground == BACKGROUND_1_DAY || this.mBackground == BACKGROUND_2_NIGHT)
         {
            this.mPlantRow[0] = PLANTROW_NORMAL;
            this.mPlantRow[1] = PLANTROW_NORMAL;
            this.mPlantRow[2] = PLANTROW_NORMAL;
            this.mPlantRow[3] = PLANTROW_NORMAL;
            this.mPlantRow[4] = PLANTROW_NORMAL;
            this.mPlantRow[5] = PLANTROW_DIRT;
            if(this.mLevel == 1)
            {
               this.mPlantRow[0] = PLANTROW_DIRT;
               this.mPlantRow[1] = PLANTROW_DIRT;
               this.mPlantRow[3] = PLANTROW_DIRT;
               this.mPlantRow[4] = PLANTROW_DIRT;
            }
            else if(this.mLevel == 2 || this.mLevel == 3)
            {
               this.mPlantRow[0] = PLANTROW_DIRT;
               this.mPlantRow[4] = PLANTROW_DIRT;
            }
         }
         for(var x:int = 0; x < GRIDSIZEX; x++)
         {
            newArray = new Array();
            this.mGridSquareType.push(newArray);
            newGridCelArray = new Array();
            this.mGridCelLook.push(newGridCelArray);
            newGridCellOffsetArray = new Array();
            this.mGridCelOffset.push(newGridCellOffsetArray);
            for(y = 0; y < GRIDSIZEY; y++)
            {
               this.mGridCelLook[x][y] = Math.random() * 20;
               anArray = new Array();
               this.mGridCelOffset[x].push(anArray);
               this.mGridCelOffset[x][y][0] = Math.random() * 6 - 3;
               this.mGridCelOffset[x][y][1] = Math.random() * 6 - 3;
               if(this.mPlantRow[y] == PLANTROW_DIRT)
               {
                  this.mGridSquareType[x][y] = GRIDSQUARE_DIRT;
               }
               else
               {
                  this.mGridSquareType[x][y] = GRIDSQUARE_GRASS;
               }
            }
         }
         if(this.mBackground == BACKGROUND_2_NIGHT)
         {
            if(!this.mApp.IsAdventureMode() && !this.mApp.IsScaryPotterLevel())
            {
               this.AddGraveStones(4,1);
               this.AddGraveStones(5,1);
               this.AddGraveStones(6,2);
               this.AddGraveStones(7,2);
               this.AddGraveStones(8,3);
            }
            else if(this.mLevel == 11 || this.mLevel == 12 || this.mLevel == 13)
            {
               this.AddGraveStones(6,1);
               this.AddGraveStones(7,1);
               this.AddGraveStones(8,2);
            }
            else if(this.mLevel == 14 || this.mLevel == 16 || this.mLevel == 18)
            {
               this.AddGraveStones(5,1);
               this.AddGraveStones(6,1);
               this.AddGraveStones(7,2);
               this.AddGraveStones(8,3);
            }
         }
         this.PickSpecialGraveStone();
      }
      
      public function StageIsNight() : Boolean
      {
         if(this.mBackground == BACKGROUND_2_NIGHT)
         {
            return true;
         }
         return false;
      }
      
      public function DrawProgressMeter(g:Graphics2D) : void
      {
         var aNumWavesPerFlag:int = 0;
         var i:int = 0;
         var aWave:int = 0;
         var aHeight:int = 0;
         var aLeft:int = 0;
         var aRight:int = 0;
         var aPosX:int = 0;
         if(!this.HasProgressMeter())
         {
            return;
         }
         if(this.mGameScene != PVZApp.SCENE_PLAYING)
         {
            return;
         }
         var aMeterX:int = 405;
         var aMeterY:int = 388;
         g.drawImage(this.FlagMeterFull,aMeterX,aMeterY);
         var aBarSize:int = TodCommon.TodAnimateCurve(0,PROGRESS_METER_COUNTER,this.mProgressMeterWidth,107,0,TodCommon.CURVE_LINEAR);
         g.pushState();
         g.setClipRect(aMeterX,aMeterY,aBarSize,16);
         g.drawImage(this.FlagMeterEmpty,aMeterX,aMeterY);
         g.popState();
         if(this.ProgressMeterHasFlags())
         {
            aNumWavesPerFlag = this.GetNumWavesPerFlag();
            for(i = 1; i <= this.mNumWaves / aNumWavesPerFlag; i++)
            {
               aWave = i * aNumWavesPerFlag;
               aHeight = 0;
               if(aWave < this.mCurrentWave)
               {
                  aHeight = 11;
               }
               else if(aWave == this.mCurrentWave)
               {
                  aHeight = TodCommon.TodAnimateCurve(FLAG_RAISE_TIME,0,this.mFlagRaiseCounter,0,11,TodCommon.CURVE_LINEAR);
               }
               aLeft = aMeterX + 4;
               aRight = aMeterX + 107 - 8;
               aPosX = TodCommon.TodAnimateCurve(0,this.mNumWaves,aWave,aRight,aLeft,TodCommon.CURVE_LINEAR);
               g.drawImage(this.FlagMeterBar,aPosX,aMeterY - 4);
               g.drawImage(this.FlagMeterFlag,aPosX,aMeterY - aHeight - 3);
            }
         }
         g.drawImage(this.FlagMeterBar,aMeterX + 30,aMeterY + 11);
         var aHeadPosX:int = TodCommon.TodAnimateCurve(0,PROGRESS_METER_COUNTER,this.mProgressMeterWidth,0,100,TodCommon.CURVE_LINEAR);
         g.drawImage(this.FlagMeterHead,aMeterX + 107 - aHeadPosX - 14,aMeterY - 2);
      }
      
      public function KillAllZombies() : void
      {
         var aZombies:Zombie = null;
         for each(aZombies in this.mZombies)
         {
            aZombies.DieNoLoot();
         }
      }
      
      public function PutInMissingZombies(theWaveNumber:int, theZombiePicker:ZombiePicker) : void
      {
         var aZombieType:int = 0;
         for(var i:int = 0; i < NUM_ZOMBIE_TYPES; i++)
         {
            aZombieType = i;
            if(theZombiePicker.mZombieTypeCount[aZombieType] <= 0)
            {
               if(this.CanZombieSpawnOnLevel(aZombieType,this.mLevel))
               {
                  this.PutZombieInWave(aZombieType,theWaveNumber,theZombiePicker);
               }
            }
         }
      }
      
      public function StartLevel() : void
      {
         if(this.mApp.IsSurvivalMode() && this.mChallenge.mSurvivalStage > 0)
         {
         }
         this.mChallenge.StartLevel();
      }
      
      public function initLevel() : void
      {
         var bounds:Rectangle = null;
         var aSmoothArray:SmoothArray = null;
         var aSeedPacket:SeedPacket = null;
         this.mMainCounter = 0;
         this.mEnableGraveStones = false;
         this.mSodPosition = 0;
         if(!this.mApp.IsAdventureMode())
         {
            this.mLevel = 0;
         }
         this.PickBackground();
         this.mCurrentWave = 0;
         this.InitZombieWaves();
         if(this.mApp.IsAdventureMode() && this.mLevel == 1)
         {
            this.mSunMoney = 150;
            bounds = new Rectangle(0,0,40,15);
            this.mSeedBank.mSunText = Utils.createStringImage(String(this.mSunMoney),this.mSeedBank.mSeedBankFont,bounds,Utils.JUSTIFY_CENTER);
         }
         else if(this.mApp.IsScaryPotterLevel())
         {
            this.mSunMoney = 0;
            bounds = new Rectangle(0,0,40,15);
            this.mSeedBank.mSunText = Utils.createStringImage(String(this.mSunMoney),this.mSeedBank.mSeedBankFont,bounds,Utils.JUSTIFY_CENTER);
         }
         else
         {
            this.mSunMoney = 50;
            bounds = new Rectangle(0,0,40,15);
            this.mSeedBank.mSunText = Utils.createStringImage(String(this.mSunMoney),this.mSeedBank.mSeedBankFont,bounds,Utils.JUSTIFY_CENTER);
         }
         for(var y:int = 0; y < GRIDSIZEY; y++)
         {
            this.mWaveRowGotLawnMowered[y] = -100;
            aSmoothArray = new SmoothArray();
            this.mRowPickingArray[y] = aSmoothArray;
            this.mRowPickingArray[y].mItem = y;
            this.mRowPickingArray[y].mLastPicked = 0;
            this.mRowPickingArray[y].mSecondLastPicked = 0;
         }
         this.mNumSunsFallen = 0;
         if(!this.StageIsNight())
         {
            this.mSunCountDown = TodCommon.RandRangeInt(SUN_COUNTDOWN,SUN_COUNTDOWN + SUN_COUNTDOWN_RANGE);
         }
         for(var i:int = 0; i < 17; i++)
         {
            this.mHelpDisplayed[i] = false;
         }
         this.mSeedBank.mNumPackets = this.GetNumSeedsInBank();
         for(i = 0; i < SeedBank.SEEDBANK_MAX; i++)
         {
            aSeedPacket = new SeedPacket(this.mApp,this);
            aSeedPacket.mIndex = i;
            aSeedPacket.mX = this.GetSeedPacketPositionX(i);
            if(this.HasConveyorBeltSeedBank())
            {
               aSeedPacket.mY = 5;
            }
            else
            {
               aSeedPacket.mY = 6;
            }
            aSeedPacket.mPacketType = SEED_NONE;
            this.mSeedBank.mSeedPackets[i] = aSeedPacket;
         }
         if(this.mApp.IsScaryPotterLevel())
         {
            this.mSeedBank.mSeedPackets[0].mPacketType = SEED_CHERRYBOMB;
         }
         else if(!this.ChooseSeedsOnCurrentLevel() && !this.HasConveyorBeltSeedBank())
         {
            this.mSeedBank.mNumPackets = this.GetNumSeedsInBank();
            for(i = 0; i < this.mSeedBank.mNumPackets; i++)
            {
               this.mSeedBank.mSeedPackets[i].mPacketType = i;
               if(this.mSeedBank.mSeedPackets[i].GetRefreshTime(this.mSeedBank.mSeedPackets[i].mPacketType) == 3000)
               {
                  this.mSeedBank.mSeedPackets[i].mRefreshCounter = 0;
                  this.mSeedBank.mSeedPackets[i].mRefreshing = true;
                  this.mSeedBank.mSeedPackets[i].mRefreshTime = 2000;
                  this.mSeedBank.mSeedPackets[i].mActive = false;
               }
               else if(this.mSeedBank.mSeedPackets[i].GetRefreshTime(this.mSeedBank.mSeedPackets[i].mPacketType) == 5000)
               {
                  this.mSeedBank.mSeedPackets[i].mRefreshCounter = 0;
                  this.mSeedBank.mSeedPackets[i].mRefreshing = true;
                  this.mSeedBank.mSeedPackets[i].mRefreshTime = 5000;
                  this.mSeedBank.mSeedPackets[i].mActive = false;
               }
            }
         }
         this.mApp.widgetManager.markAllDirty();
         this.mPaused = false;
         this.mOutOfMoneyCounter = 0;
         this.InitLawnMowers();
         this.doorMask.x = -PVZApp.BOARD_OFFSET;
         this.doorMask.y = 154;
         this.mRenderManager.add(new ImageRenderable(this.doorMask,RENDER_LAYER_ABOVE_UI));
         this.mChallenge.InitLevel();
      }
      
      public function ProcessDeleteQueue() : void
      {
         var newGridItems:Array = null;
         var aGridItem:GridItem = null;
         var newCoins:Array = null;
         var aCoin:Coin = null;
         var newZombies:Array = null;
         var aZombie:Zombie = null;
         var newLawnMowers:Array = null;
         var aLawnMower:LawnMower = null;
         var aPlantFilter:Function = function(element:*, index:int, arr:Array):Boolean
         {
            var aPlant:CPlant = CPlant(element);
            return !aPlant.mDead;
         };
         this.mPlants = this.mPlants.filter(aPlantFilter);
         if(this.mGridItems.length > 0)
         {
            newGridItems = new Array();
            for each(aGridItem in this.mGridItems)
            {
               if(!aGridItem.mDead)
               {
                  newGridItems.push(aGridItem);
               }
            }
            this.mGridItems = newGridItems;
         }
         if(this.mCoins.length > 0)
         {
            newCoins = new Array();
            for each(aCoin in this.mCoins)
            {
               if(!aCoin.mDead)
               {
                  newCoins.push(aCoin);
               }
            }
            this.mCoins = newCoins;
         }
         if(this.mZombies.length > 0)
         {
            newZombies = new Array();
            for each(aZombie in this.mZombies)
            {
               if(!aZombie.mDead)
               {
                  newZombies.push(aZombie);
               }
            }
            this.mZombies = newZombies;
         }
         if(this.mLawnMowers.length > 0)
         {
            newLawnMowers = new Array();
            for each(aLawnMower in this.mLawnMowers)
            {
               if(!aLawnMower.mDead)
               {
                  newLawnMowers.push(aLawnMower);
               }
            }
            this.mLawnMowers = newLawnMowers;
         }
      }
      
      public function GridToPixelX(theGridX:int, theGridY:int) : int
      {
         return theGridX * 54 + LAWN_XMIN;
      }
      
      public function buttonRelease(id:Number) : void
      {
         switch(id)
         {
            case this.Menu_button:
               this.mPaused = true;
               this.mApp.stateManager.pushState(PVZApp.STATE_OPTIONS_MENU);
         }
      }
      
      private function freePlantingCheat() : void
      {
         this.mEasyPlantingCheat = true;
      }
      
      public function ZombiesWon(aZombie:Zombie) : void
      {
         var aOtherZombie:Zombie = null;
         var aRect:Rectangle = null;
         if(this.mGameScene == SCENE_ZOMBIES_WON)
         {
            return;
         }
         if(this.mNextSurvivalStageCounter > 0)
         {
            this.mNextSurvivalStageCounter = 0;
         }
         for each(aOtherZombie in this.mZombies)
         {
            if(aOtherZombie != aZombie)
            {
               aRect = aOtherZombie.GetZombieRect();
               if(aRect.x < -35)
               {
                  aOtherZombie.DieNoLoot();
               }
            }
         }
         this.mGameScene = SCENE_ZOMBIES_WON;
         aZombie.WalkIntoHouse();
         this.TutorialArrowRemove();
         this.ClearCursor();
         this.UpdateCursor();
         this.mApp.stateManager.changeState(PVZApp.STATE_ZOMBIES_WON);
      }
      
      public function UpdateGame() : void
      {
         this.UpdateGameObjects();
         if(this.mGameScene != PVZApp.SCENE_PLAYING)
         {
            return;
         }
         ++this.mMainCounter;
         this.UpdateSunSpawning();
         this.UpdateZombieSpawning();
         if(this.mMainCounter == 1)
         {
            if(this.mLevel == 1)
            {
               this.SetTutorialState(TUTORIAL_LEVEL_1_PICK_UP_PEASHOOTER);
            }
            else if(this.mLevel == 2)
            {
               this.SetTutorialState(TUTORIAL_LEVEL_2_PICK_UP_SUNFLOWER);
               this.DisplayAdvice("[ADVICE_PLANT_SUNFLOWER1]",MESSAGE_STYLE_TUTORIAL_LEVEL2,ADVICE_NONE);
               this.mTutorialTimer = 500;
            }
         }
         this.UpdateProgressMeter();
      }
      
      public function GetNumWavesPerSurvivalStage() : int
      {
         return 20;
      }
      
      public function HasConveyorBeltSeedBank() : Boolean
      {
         if(this.IsWallnutBowlingLevel() || this.mLevel == 10)
         {
            return true;
         }
         return false;
      }
      
      private function spawnAwardCheat() : void
      {
         var aCoinType:String = null;
         if(this.mApp.IsAdventureMode() && this.mLevel <= 14)
         {
            if(this.mLevel == 9)
            {
               aCoinType = Coin.COIN_NOTE;
            }
            else if(this.mLevel == 4)
            {
               aCoinType = Coin.COIN_SHOVEL;
            }
            else
            {
               aCoinType = Coin.COIN_FINAL_SEED_PACKET;
            }
            this.AddCoin(200,200,aCoinType,COIN_MOTION_COIN);
            this.mLevelAwardSpawned = true;
         }
      }
      
      public function MouseHitTest(x:int, y:int, theHitResult:HitResult) : Boolean
      {
         var aTopCoin:Coin = null;
         var aCoin:Coin = null;
         var aHitResultCoin:HitResult = null;
         var aHitCoin:Coin = null;
         var aGridX:int = 0;
         var aGridY:int = 0;
         var aGridItem:GridItem = null;
         if(this.mBoardFadeOutCounter >= 0)
         {
            theHitResult.mObject = null;
            theHitResult.mObjectType = OBJECT_TYPE_NONE;
            return false;
         }
         if(this.mSeedBank.MouseHitTest(x,y,theHitResult))
         {
            if(this.mCursorObject.mCursorType == CURSOR_TYPE_NORMAL || this.mCursorObject.mCursorType == CURSOR_TYPE_HAMMER)
            {
               return true;
            }
         }
         if(this.mShowShovel && this.mShovelButtonRect.contains(x,y))
         {
            theHitResult.mObjectType = OBJECT_TYPE_SHOVEL;
            return true;
         }
         if(this.mCursorObject.mCursorType == CURSOR_TYPE_NORMAL || this.mCursorObject.mCursorType == CURSOR_TYPE_HAMMER)
         {
            aTopCoin = null;
            for each(aCoin in this.mCoins)
            {
               aHitResultCoin = new HitResult();
               if(aCoin.MouseHitTest(x,y,aHitResultCoin))
               {
                  aHitCoin = Coin(aHitResultCoin.mObject);
                  if(!aTopCoin || aHitCoin.mRenderOrder >= aTopCoin.mRenderOrder)
                  {
                     theHitResult.mObject = aHitResultCoin.mObject;
                     theHitResult.mObjectType = aHitResultCoin.mObjectType;
                     aTopCoin = aHitCoin;
                  }
               }
            }
            if(aTopCoin)
            {
               return true;
            }
         }
         if(this.MouseHitTestPlant(x,y,theHitResult))
         {
            return true;
         }
         if(this.mApp.IsScaryPotterLevel())
         {
            if(this.mCursorObject.mCursorType == CURSOR_TYPE_NORMAL && this.mChallenge.mChallengeState != Challenge.STATECHALLENGE_SCARY_POTTER_MALLETING && this.mGameScene == SCENE_PLAYING)
            {
               aGridX = this.PixelToGridX(x,y);
               aGridY = this.PixelToGridY(x,y);
               aGridItem = this.GetScaryPotAt(aGridX,aGridY);
               if(aGridItem)
               {
                  theHitResult.mObject = aGridItem;
                  theHitResult.mObjectType = OBJECT_TYPE_SCARY_POT;
                  return true;
               }
            }
         }
         theHitResult.mObject = null;
         theHitResult.mObjectType = OBJECT_TYPE_NONE;
         return false;
      }
      
      public function KillAllZombiesInRadius(theRow:int, theX:int, theY:int, theRadius:int, theRowRange:int, theBurn:Boolean) : void
      {
         var aZombie:Zombie = null;
         var aZombieRect:Rectangle = null;
         var aRowDiff:int = 0;
         for each(aZombie in this.mZombies)
         {
            aZombieRect = aZombie.GetZombieRect();
            aRowDiff = aZombie.mRow - theRow;
            if(!(aRowDiff > theRowRange || aRowDiff < -theRowRange))
            {
               if(this.GetCircleRectOverlap(theX,theY,theRadius,aZombieRect))
               {
                  if(theBurn)
                  {
                     aZombie.ApplyBurn();
                  }
                  else
                  {
                     aZombie.TakeDamage(1800,1);
                  }
               }
            }
         }
      }
      
      public function UpdateMousePosition() : void
      {
         var aPlant:CPlant = null;
         var aCursorSeedType:int = 0;
         var aMouseX:int = 0;
         var aMouseY:int = 0;
         var aGridItem:GridItem = null;
         var aHitResult:HitResult = null;
         var aScaryPot:GridItem = null;
         this.UpdateCursor();
         this.UpdateToolTip();
         for each(aPlant in this.mPlants)
         {
            aPlant.mHighlighted = false;
         }
         aCursorSeedType = this.GetSeedTypeInCursor();
         aMouseX = this.mApp.widgetManager.lastMouseX - x;
         aMouseY = this.mApp.widgetManager.lastMouseY - y;
         if(this.mApp.IsScaryPotterLevel())
         {
            for each(aGridItem in this.mGridItems)
            {
               if(aGridItem.mGridItemType == GRIDITEM_SCARY_POT)
               {
                  aGridItem.mHighlighted = false;
               }
            }
            aHitResult = new HitResult();
            this.MouseHitTest(aMouseX,aMouseY,aHitResult);
            if(aHitResult.mObjectType == OBJECT_TYPE_SCARY_POT)
            {
               aScaryPot = GridItem(aHitResult.mObject);
               aScaryPot.mHighlighted = true;
               return;
            }
         }
         if(this.mCursorObject.mCursorType == CURSOR_TYPE_SHOVEL)
         {
            this.HighlightPlantsForMouse(aMouseX,aMouseY);
         }
      }
      
      public function NextWaveComing() : void
      {
         var aShowFinalWaveMessage:Boolean = false;
         if(this.mCurrentWave + 1 == this.mNumWaves)
         {
            aShowFinalWaveMessage = true;
            if(this.mApp.IsSurvivalMode())
            {
               aShowFinalWaveMessage = false;
            }
            if(aShowFinalWaveMessage)
            {
               this.mFinalWaveSoundCounter = 60;
               this.mWaveWarning.showFinalWave(460);
            }
         }
         if(this.mCurrentWave == 0)
         {
            this.mApp.foleyManager.playFoley(PVZFoleyType.AWOOGA);
         }
         else if(this.IsFlagWave(this.mCurrentWave))
         {
         }
      }
      
      public function CanPlantAt(theGridX:int, theGridY:int, theType:int) : String
      {
         var aPlantOnLawn:CPlant = null;
         if(theGridX < 0 || theGridX >= GRIDSIZEX || theGridY < 0 || theGridY >= GRIDSIZEY)
         {
            return PLANTING_NOT_HERE;
         }
         if(this.IsWallnutBowlingLevel())
         {
            if(theGridX > 2)
            {
               return PLANTING_NOT_PASSED_LINE;
            }
         }
         aPlantOnLawn = this.GetPlantsOnLawn(theGridX,theGridY);
         var aHasGraveStone:* = this.GetGraveStoneAt(theGridX,theGridY) != null;
         if(theType == SEED_GRAVEBUSTER)
         {
            if(aPlantOnLawn)
            {
               return PLANTING_NOT_HERE;
            }
            if(aHasGraveStone)
            {
               return PLANTING_OK;
            }
            return PLANTING_ONLY_ON_GRAVES;
         }
         if(aHasGraveStone)
         {
            return PLANTING_NOT_ON_GRAVE;
         }
         var aHasScaryPot:* = this.GetScaryPotAt(theGridX,theGridY) != null;
         if(aHasScaryPot)
         {
            return PLANTING_NOT_HERE;
         }
         if(this.mGridSquareType[theGridX][theGridY] == GRIDSQUARE_DIRT)
         {
            return PLANTING_NOT_HERE;
         }
         if(aPlantOnLawn == null)
         {
            return PLANTING_OK;
         }
         return PLANTING_NOT_HERE;
      }
      
      private function spawnPolevaultZombieCheat() : void
      {
         this.AddZombieInRow(ZOMBIE_POLEVAULTER,int(Math.random() * 5),1);
      }
      
      public function PickUpTool(theObjectType:int) : void
      {
         if(theObjectType == OBJECT_TYPE_SHOVEL)
         {
            if(this.mTutorialState == TUTORIAL_SHOVEL_PICKUP)
            {
               this.SetTutorialState(TUTORIAL_SHOVEL_DIG);
            }
            this.mCursorObject.mCursorType = CURSOR_TYPE_SHOVEL;
            this.mApp.foleyManager.playFoley(PVZFoleyType.SHOVEL);
         }
      }
      
      public function HighlightPlantsForMouse(theMouseX:int, theMouseY:int) : void
      {
         var aPlant:CPlant = this.ToolHitTest(theMouseX,theMouseY);
         if(aPlant)
         {
            aPlant.mHighlighted = true;
         }
      }
      
      public function UpdateLevelEndSequence() : void
      {
         var aFlags:int = 0;
         var aIsRepick:Boolean = false;
         var aIsNote:Boolean = false;
         if(this.mNextSurvivalStageCounter > 0)
         {
            --this.mNextSurvivalStageCounter;
            if(this.mNextSurvivalStageCounter == 0)
            {
               if(this.mApp.IsScaryPotterLevel())
               {
                  if(this.mApp.adAPI.enabled)
                  {
                     this.mApp.musicManager.pauseMusic();
                     this.mApp.soundManager.pauseAll();
                     this.mApp.adAPI.GameBreak(this.mChallenge.mSurvivalStage,this.ContinueVasebreaker);
                  }
                  else
                  {
                     this.mChallenge.PuzzleNextStageClear();
                     this.mChallenge.ScaryPotterPopulate();
                     this.mMenuButton.visible = true;
                  }
               }
               else
               {
                  this.mLevelComplete = true;
                  this.RemoveZombiesForRepick();
                  aFlags = this.GetSurvivalFlagsCompleted() + 1;
                  if(this.mApp.IsSurvivalEndless() && aFlags == 20)
                  {
                  }
               }
               return;
            }
         }
         if(this.mBoardFadeOutCounter < 0)
         {
            return;
         }
         --this.mBoardFadeOutCounter;
         if(this.mBoardFadeOutCounter == 0)
         {
            this.mLevelComplete = true;
            return;
         }
         if(this.mBoardFadeOutCounter == 300)
         {
            aIsRepick = this.mApp.IsSurvivalMode();
            aIsNote = this.mLevel == 9 || this.mLevel == 19 || this.mLevel == 29 || this.mLevel == 39 || this.mLevel == 49;
            if(!aIsRepick && !aIsNote)
            {
            }
         }
         if(!this.CanDropLoot())
         {
            return;
         }
         if(this.mApp.IsSurvivalMode())
         {
            return;
         }
      }
      
      public function StageHasGraveStones() : Boolean
      {
         if(this.IsWallnutBowlingLevel() || this.mApp.IsScaryPotterLevel())
         {
            return false;
         }
         if(this.mBackground == BACKGROUND_2_NIGHT)
         {
            return true;
         }
         return false;
      }
      
      public function GetSeedTypeInCursor() : int
      {
         if(!this.IsPlantInCursor())
         {
            return SEED_NONE;
         }
         return this.mCursorObject.mType;
      }
      
      public function GridToPixelY(theGridX:int, theGridY:int) : int
      {
         var aResult:int = 0;
         return theGridY * 67 + LAWN_YMIN;
      }
      
      public function AddZombieInRow(theZombieType:int, theRow:int, theFromWave:int) : Zombie
      {
         var aVariant:Boolean = false;
         if(Math.random() * 5 == 0)
         {
            aVariant = true;
         }
         var aZombie:Zombie = new Zombie();
         aZombie.ZombieInitialize(theRow,theZombieType,aVariant,null,theFromWave,this.mApp,this);
         this.mZombies.push(aZombie);
         this.mRenderManager.add(new ZombieRenderable(aZombie,RENDER_LAYER_ZOMBIE + aZombie.mRow));
         return aZombie;
      }
      
      public function AddPlant(theGridX:int, theGridY:int, theSeedType:int) : CPlant
      {
         var aPlant:CPlant = this.NewPlant(theGridX,theGridY,theSeedType);
         this.DoPlantingEffects(theGridX,theGridY,aPlant);
         return aPlant;
      }
      
      public function SetTutorialState(theTutorialState:int) : void
      {
         var aPosX:Number = NaN;
         var aPosY:Number = NaN;
         var aShovelButtonRect:Rectangle = null;
         if(theTutorialState == TUTORIAL_LEVEL_1_PICK_UP_PEASHOOTER)
         {
            if(this.mPlants.length == 0)
            {
               aPosX = this.mSeedBank.mX + this.mSeedBank.mSeedPackets[0].mX + this.mSeedBank.mSeedPackets[0].mWidth / 2;
               aPosY = this.mSeedBank.mY + this.mSeedBank.mSeedPackets[0].mY + this.mSeedBank.mSeedPackets[0].mHeight;
               this.TutorialArrowShow(aPosX,aPosY);
               this.DisplayAdvice("[ADVICE_CLICK_SEED_PACKET]",MESSAGE_STYLE_TUTORIAL_LEVEL1_STAY,ADVICE_NONE);
            }
            else
            {
               this.DisplayAdvice("[ADVICE_ENOUGH_SUN]",MESSAGE_STYLE_TUTORIAL_LEVEL1_STAY,ADVICE_NONE);
               this.mTutorialTimer = 400;
            }
         }
         else if(theTutorialState == TUTORIAL_LEVEL_1_PLANT_PEASHOOTER)
         {
            this.mTutorialTimer = -1;
            this.TutorialArrowRemove();
            if(this.mPlants.length == 0)
            {
               this.DisplayAdvice("[ADVICE_CLICK_ON_GRASS]",MESSAGE_STYLE_TUTORIAL_LEVEL1_STAY,ADVICE_NONE);
            }
            else
            {
               this.ClearAdvice(ADVICE_NONE);
            }
         }
         else if(theTutorialState == TUTORIAL_LEVEL_1_REFRESH_PEASHOOTER)
         {
            this.DisplayAdvice("[ADVICE_PLANTED_PEASHOOTER]",MESSAGE_STYLE_TUTORIAL_LEVEL1,ADVICE_NONE);
            this.mSunCountDown = 200;
         }
         else if(theTutorialState == TUTORIAL_LEVEL_1_COMPLETED)
         {
            this.DisplayAdvice("[ADVICE_ZOMBIE_ONSLAUGHT]",MESSAGE_STYLE_TUTORIAL_LEVEL1,ADVICE_NONE);
            this.mZombieCountDown = 100;
            this.mZombieCountDownStart = this.mZombieCountDown;
         }
         else if(theTutorialState == TUTORIAL_LEVEL_2_PICK_UP_SUNFLOWER || theTutorialState == TUTORIAL_MORESUN_PICK_UP_SUNFLOWER)
         {
            aPosX = this.mSeedBank.mX + this.mSeedBank.mSeedPackets[1].mX + this.mSeedBank.mSeedPackets[1].mWidth / 2;
            aPosY = this.mSeedBank.mY + this.mSeedBank.mSeedPackets[1].mY + this.mSeedBank.mSeedPackets[1].mHeight;
            this.TutorialArrowShow(aPosX,aPosY);
         }
         else if(theTutorialState == TUTORIAL_LEVEL_2_PLANT_SUNFLOWER || theTutorialState == TUTORIAL_LEVEL_2_REFRESH_SUNFLOWER || theTutorialState == TUTORIAL_MORESUN_PLANT_SUNFLOWER || theTutorialState == TUTORIAL_MORESUN_REFRESH_SUNFLOWER)
         {
            this.TutorialArrowRemove();
         }
         else if(theTutorialState == TUTORIAL_LEVEL_2_COMPLETED)
         {
            if(this.mCurrentWave == 0)
            {
               this.mZombieCountDown = 1000;
               this.mZombieCountDownStart = this.mZombieCountDown;
            }
         }
         else if(theTutorialState == TUTORIAL_SHOVEL_PICKUP)
         {
            this.DisplayAdvice("[ADVICE_CLICK_SHOVEL]",MESSAGE_STYLE_HINT_STAY,ADVICE_NONE);
            aShovelButtonRect = this.mShovelButtonRect;
            aPosX = aShovelButtonRect.x + aShovelButtonRect.width / 2;
            aPosY = aShovelButtonRect.y + aShovelButtonRect.height;
            this.TutorialArrowShow(aPosX,aPosY);
         }
         else if(theTutorialState == TUTORIAL_SHOVEL_DIG)
         {
            this.DisplayAdvice("[ADVICE_CLICK_PLANT]",MESSAGE_STYLE_HINT_STAY,ADVICE_NONE);
            this.TutorialArrowRemove();
         }
         else if(theTutorialState == TUTORIAL_SHOVEL_KEEP_DIGGING)
         {
            this.DisplayAdvice("[ADVICE_KEEP_DIGGING]",MESSAGE_STYLE_HINT_STAY,ADVICE_NONE);
         }
         else if(theTutorialState == TUTORIAL_SHOVEL_COMPLETED)
         {
            this.ClearAdvice(ADVICE_NONE);
         }
         this.mTutorialState = theTutorialState;
      }
      
      public function AddCoin(theX:int, theY:int, theCoinType:String, theCoinMotion:String) : Coin
      {
         var aCoin:Coin = new Coin();
         aCoin.CoinInitialize(theX,theY,theCoinType,theCoinMotion,this.mApp,this);
         if(this.mLevel == 1)
         {
            this.DisplayAdvice("[ADVICE_CLICK_ON_SUN]",MESSAGE_STYLE_TUTORIAL_LEVEL1_STAY,ADVICE_CLICK_ON_SUN);
         }
         this.mCoins.push(aCoin);
         this.mRenderManager.add(new CoinRenderable(aCoin,RENDER_LAYER_COIN_BANK));
         return aCoin;
      }
      
      public function GetCurrentPlantCost(theSeedType:int) : int
      {
         var aCost:int = 0;
         switch(theSeedType)
         {
            case SEED_PEASHOOTER:
               aCost = 100;
               break;
            case SEED_SUNFLOWER:
               aCost = 50;
               break;
            case SEED_CHERRYBOMB:
               aCost = 150;
               break;
            case SEED_WALLNUT:
               aCost = 50;
               break;
            case SEED_CHOMPER:
               aCost = 150;
               break;
            case SEED_SQUASH:
               aCost = 50;
               break;
            case SEED_SNOWPEA:
               aCost = 175;
               break;
            case SEED_REPEATER:
               aCost = 200;
               break;
            case SEED_PUFFSHROOM:
               aCost = 0;
               break;
            case SEED_SUNSHROOM:
               aCost = 25;
               break;
            case SEED_FUMESHROOM:
               aCost = 75;
               break;
            case SEED_GRAVEBUSTER:
               aCost = 75;
               break;
            default:
               aCost = 100;
         }
         return aCost;
      }
      
      public function PickSpecialGraveStone() : void
      {
         var aGridItem:GridItem = null;
         var MAX_GRAVE_STONES:int = GRIDSIZEX * GRIDSIZEY;
         var aPicks:Array = new Array();
         var aPickCount:int = 0;
         for each(aGridItem in this.mGridItems)
         {
            if(aGridItem.mGridItemType == GRIDITEM_GRAVESTONE)
            {
               aPicks[aPickCount] = aGridItem;
               aPickCount++;
            }
         }
         if(aPickCount == 0)
         {
            return;
         }
         var aResultItem:GridItem = GridItem(aPicks[TodCommon.TodPickFromArray(aPicks,aPickCount)]);
         aResultItem.mGridItemState = GridItem.GRIDITEM_STATE_GRAVESTONE_SPECIAL;
      }
      
      public function UpdateToolTip() : void
      {
         var aZombie:Zombie = null;
         var aZombieDef:ZombieDef = null;
         var aZombieName:* = null;
         var aRect:Rectangle = null;
         var aSeedPacket:SeedPacket = null;
         var aUseSeedType:int = 0;
         var aCost:int = 0;
         if(this.mTimeStopCounter > 0 || this.mGameScene == SCENE_ZOMBIES_WON || this.mPaused)
         {
            this.mToolTip.mVisible = false;
            return;
         }
         var aMouseX:int = this.mApp.widgetManager.lastMouseX - x;
         var aMouseY:int = this.mApp.widgetManager.lastMouseY - y;
         if(this.mGameScene != SCENE_LEVEL_INTRO && aMouseY > 80)
         {
            this.mToolTip.mVisible = false;
            return;
         }
         if(this.mGameScene == SCENE_LEVEL_INTRO && this.ChooseSeedsOnCurrentLevel())
         {
            aZombie = this.ZombieHitTest(aMouseX,aMouseY);
            if(aZombie == null || aZombie.mFromWave != Zombie.ZOMBIE_WAVE_CUTSCENE)
            {
               this.mToolTip.mVisible = false;
               return;
            }
            aZombieDef = this.GetZombieDefinition(aZombie.mZombieType);
            aZombieName = "[" + aZombieDef.mZombieName + "]";
            this.mToolTip.SetTitle(aZombieName);
            this.mToolTip.SetLabel("");
            this.mToolTip.SetWarningText("");
            aRect = aZombie.GetZombieRect();
            this.mToolTip.mX = aRect.x + aRect.width / 2 + 5;
            this.mToolTip.mY = aRect.y + aRect.height - 10;
            this.mToolTip.mVisible = true;
            this.mToolTip.mCenter = true;
            this.mToolTip.mMinLeft = this.mApp.imageManager.getImageInst(PVZImages.IMAGE_SEEDCHOOSER_BACKGROUND).width;
            this.mToolTip.mMaxBottom = BOARD_HEIGHT;
            return;
         }
         if(this.mGameScene != SCENE_PLAYING)
         {
            return;
         }
         this.mToolTip.mMinLeft = 0;
         this.mToolTip.mMaxBottom = BOARD_HEIGHT;
         this.mToolTip.SetLabel("");
         this.mToolTip.SetTitle("");
         this.mToolTip.SetWarningText("");
         this.mToolTip.mCenter = false;
         var aHitResult:HitResult = new HitResult();
         this.MouseHitTest(aMouseX,aMouseY,aHitResult);
         if(aHitResult.mObjectType == OBJECT_TYPE_SHOVEL)
         {
            this.mToolTip.SetLabel("[SHOVEL_TOOLTIP]");
            this.mToolTip.mX = this.mShovelButtonRect.x + 35;
            this.mToolTip.mY = this.mShovelButtonRect.y + 72;
            this.mToolTip.mCenter = true;
            this.mToolTip.mVisible = true;
         }
         else if(aHitResult.mObjectType == OBJECT_TYPE_SEEDPACKET)
         {
            aSeedPacket = SeedPacket(aHitResult.mObject);
            aUseSeedType = aSeedPacket.mPacketType;
            this.mToolTip.SetLabel(this.GetSeedName(aSeedPacket.mPacketType));
            aCost = this.GetCurrentPlantCost(aSeedPacket.mPacketType);
            if(this.mEasyPlantingCheat)
            {
               this.mToolTip.SetWarningText("FREE_PLANTING_CHEAT");
            }
            else if(!aSeedPacket.mActive)
            {
               this.mToolTip.SetWarningText("[WAITING_FOR_SEED]");
            }
            else if(!this.CanTakeSunMoney(aCost) && !this.HasConveyorBeltSeedBank())
            {
               this.mToolTip.SetWarningText("[NOT_ENOUGH_SUN]");
            }
            this.mToolTip.mX = this.mSeedBank.mX + aSeedPacket.mX + aSeedPacket.mOffsetX + (50 - this.mToolTip.mWidth) / 2;
            this.mToolTip.mY = this.mSeedBank.mY + aSeedPacket.mY + 70;
            this.mToolTip.mVisible = true;
         }
         else
         {
            this.mToolTip.mVisible = false;
         }
      }
      
      public function GetRectOverlap(rect1:Rectangle, rect2:Rectangle) : int
      {
         var aLeft1:int = 0;
         var aRight1:int = 0;
         var aLeft2:int = 0;
         var aRight2:int = 0;
         if(rect1.x < rect2.x)
         {
            aLeft1 = rect1.x;
            aRight1 = rect1.x + rect1.width;
            aLeft2 = rect2.x;
            aRight2 = rect2.x + rect2.width;
         }
         else
         {
            aLeft1 = rect2.x;
            aRight1 = rect2.x + rect2.width;
            aLeft2 = rect1.x;
            aRight2 = rect1.x + rect1.width;
         }
         if(aRight1 <= aLeft2)
         {
            return aRight1 - aLeft2;
         }
         if(aRight1 <= aRight2)
         {
            return aRight1 - aLeft2;
         }
         return aRight2 - aLeft2;
      }
      
      public function GetNumWavesPerFlag() : int
      {
         if(this.mApp.IsAdventureMode() && this.mNumWaves < 10)
         {
            return this.mNumWaves;
         }
         return 10;
      }
      
      public function GetPosYBasedOnRow(thePosX:Number, theRow:int) : Number
      {
         return Number(this.GridToPixelY(0,theRow));
      }
      
      public function InitZombieWaves() : void
      {
         for(var i:int = 0; i < 8; i++)
         {
            this.mZombieAllowed[i] = false;
         }
         if(this.mApp.IsAdventureMode())
         {
            this.InitZombieWavesForLevel(this.mLevel);
         }
         else
         {
            this.mChallenge.InitZombieWaves();
         }
         this.PickZombieWaves();
         this.mCurrentWave = 0;
         this.mTotalSpawnedWaves = 0;
         if(this.mLevel == 2)
         {
            this.mZombieCountDown = 5000;
         }
         else if(this.mApp.IsSurvivalMode() && this.mChallenge.mSurvivalStage > 0)
         {
            this.mZombieCountDown = 600;
         }
         else
         {
            this.mZombieCountDown = 1800;
         }
         this.mZombieCountDownStart = this.mZombieCountDown;
         this.mZombieHealthToNextWave = -1;
         this.mZombieHealthWaveStart = 0;
         this.mLastBungeeWave = 0;
         this.mProgressMeterWidth = 0;
         this.mHugeWaveCountDown = 0;
         this.mLevelAwardSpawned = false;
      }
      
      private function spawnGraveZombieCheat() : void
      {
         this.SpawnZombiesFromGraves();
      }
      
      private function spawnBucketZombieCheat() : void
      {
         this.AddZombieInRow(ZOMBIE_PAIL,int(Math.random() * 5),1);
      }
      
      public function NewPlant(theGridX:int, theGridY:int, theSeedType:int) : CPlant
      {
         var aPlant:CPlant = null;
         switch(theSeedType)
         {
            case SEED_PEASHOOTER:
               aPlant = new PeaShooter(theGridX,theGridY,theSeedType,this.mApp,this);
               break;
            case SEED_SUNFLOWER:
               aPlant = new Sunflower(theGridX,theGridY,theSeedType,this.mApp,this);
               break;
            case SEED_CHERRYBOMB:
               aPlant = new CherryBomb(theGridX,theGridY,theSeedType,this.mApp,this);
               break;
            case SEED_WALLNUT:
               aPlant = new Wallnut(theGridX,theGridY,theSeedType,this.mApp,this);
               break;
            case SEED_SQUASH:
               aPlant = new Squash(theGridX,theGridY,theSeedType,this.mApp,this);
               break;
            case SEED_CHOMPER:
               aPlant = new Chomper(theGridX,theGridY,theSeedType,this.mApp,this);
               break;
            case SEED_SNOWPEA:
               aPlant = new SnowPea(theGridX,theGridY,theSeedType,this.mApp,this);
               break;
            case SEED_REPEATER:
               aPlant = new Repeater(theGridX,theGridY,theSeedType,this.mApp,this);
               break;
            case SEED_EXPLODE_O_NUT:
               aPlant = new ExplodoNut(theGridX,theGridY,theSeedType,this.mApp,this);
               break;
            case SEED_PUFFSHROOM:
               aPlant = new PuffShroom(theGridX,theGridY,theSeedType,this.mApp,this);
               break;
            case SEED_FUMESHROOM:
               aPlant = new FumeShroom(theGridX,theGridY,theSeedType,this.mApp,this);
               break;
            case SEED_SUNSHROOM:
               aPlant = new SunShroom(theGridX,theGridY,theSeedType,this.mApp,this);
               break;
            case SEED_GRAVEBUSTER:
               aPlant = new GraveBuster(theGridX,theGridY,theSeedType,this.mApp,this);
               break;
            case SEED_LEFTPEATER:
               aPlant = new LeftPeater(theGridX,theGridY,theSeedType,this.mApp,this);
               break;
            default:
               aPlant = new PeaShooter(theGridX,theGridY,theSeedType,this.mApp,this);
         }
         this.mPlants.push(aPlant);
         this.mRenderManager.add(new PlantRenderable(aPlant,RENDER_LAYER_PLANT));
         return aPlant;
      }
      
      private function spawnNormalZombieCheat() : void
      {
         this.AddZombieInRow(ZOMBIE_NORMAL,int(Math.random() * 5),1);
      }
      
      public function TutorialArrowShow(x:int, y:int) : void
      {
         this.TutorialArrowRemove();
         this.mTutorialArrow = this.mApp.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_SEEDPACKETPICK);
         this.mTutorialArrow.setPosition(x,y + 10);
         this.mRenderManager.add(new ParticleRenderable(this.mTutorialArrow,RENDER_LAYER_TOP));
      }
      
      override public function onKeyDown(keyCode:uint) : void
      {
      }
      
      override public function onKeyUp(keyCode:uint) : void
      {
         switch(keyCode)
         {
            case 32:
               if(!this.mMenuButton.visible)
               {
                  return;
               }
               if(this.mPaused)
               {
                  this.mPaused = false;
                  this.mApp.stateManager.changeState(PVZApp.STATE_PLAY_LEVEL);
               }
               else
               {
                  this.mPaused = true;
                  this.mApp.stateManager.changeState(PVZApp.STATE_OPTIONS_MENU);
               }
               break;
         }
      }
      
      public function DrawSeedType(g:Graphics2D, theSeedType:int, theDrawVariation:String, thePosX:Number, thePosY:Number) : void
      {
         var thePlant:Reanimation = null;
         var aTransform:Matrix = null;
         var aOffsetX:Number = 0;
         var aOffsetY:Number = 0;
         var aFrame:int = 2;
         var aRow:int = 0;
         var aDrawSeedType:int = theSeedType;
         var aDrawVariation:String = theDrawVariation;
         var aPlantDef:String = this.GetPlantDefinition(aDrawSeedType);
         if(aPlantDef != "none")
         {
            thePlant = this.mApp.reanimator.createReanimation(aPlantDef);
            thePlant.x = thePosX + aOffsetX;
            thePlant.y = thePosY + aOffsetY;
            if(theSeedType == SEED_PEASHOOTER)
            {
               thePlant.currentTrack = "anim_full_idle";
            }
            else
            {
               thePlant.currentTrack = "anim_idle";
            }
            thePlant.update();
            aTransform = new Matrix();
            if(theDrawVariation == "cursor")
            {
               thePlant.drawLerp(g,aTransform,0.5);
            }
            else
            {
               thePlant.drawLerp(g,aTransform);
            }
            return;
         }
      }
      
      public function PixelToGridY(theX:int, theY:int) : int
      {
         var aGridX:int = this.PixelToGridX(theX,theY);
         if(aGridX == -1 || theY < LAWN_YMIN)
         {
            return -1;
         }
         return TodCommon.ClampInt((theY - LAWN_YMIN) / 67,0,4);
      }
      
      public function buttonDownTick(id:Number) : void
      {
      }
      
      public function RemoveCutsceneZombies() : void
      {
         var aZombie:Zombie = null;
         for each(aZombie in this.mZombies)
         {
            if(aZombie.mFromWave == -2)
            {
               aZombie.DieNoLoot();
            }
         }
      }
      
      override public function update() : void
      {
         markDirty();
         this.UpdateMousePosition();
         this.ProcessDeleteQueue();
         if(this.mPaused)
         {
            this.mChallenge.Update();
            this.mCursorPreview.mVisible = false;
            this.mCursorObject.mVisible = false;
            return;
         }
         this.mAdvice.Update();
         this.UpdateTutorial();
         if(this.mOutOfMoneyCounter > 0)
         {
            --this.mOutOfMoneyCounter;
         }
         if(this.mShakeCounter > 0)
         {
            --this.mShakeCounter;
            if(this.mShakeCounter == 0)
            {
               x = 0;
               y = 0;
            }
            else
            {
               if(Math.random() * 2 == 0)
               {
                  this.mShakeAmountX = -this.mShakeAmountX;
               }
               x = TodCommon.TodAnimateCurve(BOARD_SHAKE_TIME,0,this.mShakeCounter,0,this.mShakeAmountX,TodCommon.CURVE_BOUNCE);
               y = TodCommon.TodAnimateCurve(BOARD_SHAKE_TIME,0,this.mShakeCounter,0,this.mShakeAmountY,TodCommon.CURVE_BOUNCE);
               move(x,y);
            }
         }
         this.UpdateGridItems();
         this.UpdateGame();
         this.mChallenge.Update();
         this.UpdateLevelEndSequence();
         this.mWaveWarning.update();
      }
      
      public function HasLevelAwardDropped() : Boolean
      {
         if(this.mLevelAwardSpawned)
         {
            return true;
         }
         if(this.mNextSurvivalStageCounter > 0 || this.mBoardFadeOutCounter >= 0)
         {
            return true;
         }
         return false;
      }
      
      public function UpdateProgressMeter() : void
      {
         var aNumFlags:int = 0;
         var aNumFlagsPassed:int = 0;
         var aTotalHealth:int = 0;
         var aHealthRange:int = 0;
         var aHealthFraction:Number = NaN;
         if(this.mCurrentWave == 0)
         {
            return;
         }
         if(this.mFlagRaiseCounter > 0)
         {
            --this.mFlagRaiseCounter;
         }
         var FLAG_GAP_SIZE:int = 9;
         var aWaveMeterPixelsToCover:int = PROGRESS_METER_COUNTER;
         var aNumWavesPerFlag:int = this.GetNumWavesPerFlag();
         if(this.ProgressMeterHasFlags())
         {
            aNumFlags = this.mNumWaves / aNumWavesPerFlag;
            aWaveMeterPixelsToCover -= aNumFlags * FLAG_GAP_SIZE;
         }
         var aWaveWidth:int = aWaveMeterPixelsToCover / (this.mNumWaves - 1);
         var aFlagMeterWidthPrev:int = (this.mCurrentWave - 1) * aWaveMeterPixelsToCover / (this.mNumWaves - 1);
         var aFlagMeterWidthNext:int = this.mCurrentWave * aWaveMeterPixelsToCover / (this.mNumWaves - 1);
         if(this.ProgressMeterHasFlags())
         {
            aNumFlagsPassed = this.mCurrentWave / aNumWavesPerFlag;
            aFlagMeterWidthPrev += aNumFlagsPassed * FLAG_GAP_SIZE;
            aFlagMeterWidthNext += aNumFlagsPassed * FLAG_GAP_SIZE;
         }
         var aFraction:Number = Number(this.mZombieCountDownStart - this.mZombieCountDown) / Number(this.mZombieCountDownStart);
         if(this.mZombieHealthToNextWave != -1)
         {
            aTotalHealth = this.TotalZombiesHealthInWave(this.mCurrentWave - 1);
            aHealthRange = Math.max(this.mZombieHealthWaveStart - this.mZombieHealthToNextWave,1);
            aHealthFraction = Number(aHealthRange - aTotalHealth + this.mZombieHealthToNextWave) / Number(aHealthRange);
            if(aHealthFraction > aFraction)
            {
               aFraction = aHealthFraction;
            }
         }
         var aDestPosition:int = aFlagMeterWidthPrev + Math.round(Number(aFlagMeterWidthNext - aFlagMeterWidthPrev) * aFraction);
         aDestPosition = TodCommon.ClampInt(aDestPosition,1,PROGRESS_METER_COUNTER);
         var aDelta:int = aDestPosition - this.mProgressMeterWidth;
         if(aDelta > aWaveWidth && this.mMainCounter % 5 == 0)
         {
            ++this.mProgressMeterWidth;
         }
         else if(aDelta > 0 && this.mMainCounter % 20 == 0)
         {
            ++this.mProgressMeterWidth;
         }
      }
      
      public function RowCanHaveZombies(theRow:int) : Boolean
      {
         if(theRow < 0 || theRow >= GRIDSIZEY)
         {
            return false;
         }
         if(this.mPlantRow[theRow] == PLANTROW_DIRT)
         {
            return false;
         }
         return true;
      }
      
      public function GetSeedPacketPositionX(theIndex:int) : int
      {
         var aSeedsInBank:int = this.mSeedBank.mNumPackets;
         if(this.IsSlotMachineLevel())
         {
            return theIndex * 59 + 247;
         }
         if(this.HasConveyorBeltSeedBank())
         {
            return theIndex * 47 + 5;
         }
         if(aSeedsInBank <= 6)
         {
            return theIndex * 54 + 74;
         }
         if(aSeedsInBank == 7)
         {
            return theIndex * 59 + 85;
         }
         if(aSeedsInBank == 8)
         {
            return theIndex * 54 + 81;
         }
         if(aSeedsInBank == 9)
         {
            return theIndex * 52 + 80;
         }
         return theIndex * 51 + 79;
      }
      
      public function PickGraveRisingZombieType(theZombiePoints:int) : int
      {
         var aZombieType:int = 0;
         var aZombieDef:ZombieDef = null;
         var aZombieWeightArray:Array = new Array();
         var aPickCount:int = 0;
         aZombieWeightArray[aPickCount] = new WeightedArray();
         aZombieWeightArray[aPickCount].mItem = ZOMBIE_NORMAL;
         aZombieWeightArray[aPickCount].mWeight = this.GetZombieDefinition(ZOMBIE_NORMAL).mPickWeight;
         aPickCount++;
         aZombieWeightArray[aPickCount] = new WeightedArray();
         aZombieWeightArray[aPickCount].mItem = ZOMBIE_TRAFFIC_CONE;
         aZombieWeightArray[aPickCount].mWeight = this.GetZombieDefinition(ZOMBIE_TRAFFIC_CONE).mPickWeight;
         aPickCount++;
         if(!this.StageHasGraveStones())
         {
            aZombieWeightArray[aPickCount] = new WeightedArray();
            aZombieWeightArray[aPickCount].mItem = ZOMBIE_PAIL;
            aZombieWeightArray[aPickCount].mWeight = this.GetZombieDefinition(ZOMBIE_PAIL).mPickWeight;
            aPickCount++;
         }
         for(var i:int = 0; i < aPickCount; i++)
         {
            aZombieType = int(aZombieWeightArray[i].mItem);
            aZombieDef = this.GetZombieDefinition(aZombieType);
            if(this.mLevel < aZombieDef.mStartingLevel)
            {
               aZombieWeightArray[i].mWeight = 0;
            }
            else if(!this.mZombieAllowed[aZombieType] && aZombieType != ZOMBIE_NORMAL)
            {
               aZombieWeightArray[i].mWeight = 0;
            }
            else
            {
               aZombieWeightArray[i].mWeight = aZombieDef.mPickWeight;
            }
         }
         return int(TodCommon.TodPickFromWeightedArray(aZombieWeightArray,aPickCount));
      }
      
      public function DrawDebugRects(g:Graphics2D) : void
      {
         var x:int = 0;
         var y:int = 0;
         var h:int = 0;
         var w:int = 0;
         var aRect:Rectangle = null;
         var aPlant:CPlant = null;
         var aZombie:Zombie = null;
         for each(aPlant in this.mPlants)
         {
            aRect = aPlant.GetPlantRect();
            g.fillRect(aRect.x,aRect.y,aRect.width,aRect.height,4293263360);
         }
         for each(aZombie in this.mZombies)
         {
            aRect = aZombie.GetZombieRect();
            g.fillRect(aRect.x,aRect.y,aRect.width,aRect.height,4293263360);
            aRect = aZombie.GetZombieAttackRect();
            g.fillRect(aRect.x,aRect.y,aRect.width,aRect.height,4278248982);
         }
      }
      
      public function HasProgressMeter() : Boolean
      {
         if(this.mProgressMeterWidth == 0)
         {
            return false;
         }
         if(this.mApp.IsScaryPotterLevel())
         {
            return false;
         }
         return true;
      }
      
      public function AreEnemyZombiesOnScreen() : Boolean
      {
         var aZombie:Zombie = null;
         if(this.mZombies.length == 0)
         {
            return false;
         }
         for each(aZombie in this.mZombies)
         {
            if(aZombie.mHasHead)
            {
               if(!aZombie.IsDeadOrDying())
               {
                  if(!aZombie.mMindControlled)
                  {
                     return true;
                  }
               }
            }
         }
         return false;
      }
      
      private function refreshSeedsCheat() : void
      {
         var aSeedPacket:SeedPacket = null;
         for each(aSeedPacket in this.mSeedBank.mSeedPackets)
         {
            if(aSeedPacket.mPacketType == SEED_NONE)
            {
               break;
            }
            if(aSeedPacket.mRefreshing)
            {
               aSeedPacket.mRefreshCounter = 0;
               aSeedPacket.mRefreshing = false;
               aSeedPacket.Activate();
               aSeedPacket.FlashIfReady();
            }
         }
      }
      
      override public function onMouseMove(x:Number, y:Number) : void
      {
      }
      
      public function InitSurvivalStage() : void
      {
         this.RefreshSeedPacketFromCursor();
         this.mLevelComplete = false;
         this.InitZombieWaves();
         this.mGameScene = SCENE_LEVEL_INTRO;
         for(var y:int = 0; y < GRIDSIZEY; y++)
         {
            this.mWaveRowGotLawnMowered[y] = -100;
         }
      }
      
      private function nextLevelCheat() : void
      {
         if(this.mApp.IsAdventureMode())
         {
            ++this.mApp.mLevel;
            if(this.mApp.mLevel > 14)
            {
               this.mApp.mLevel = 14;
            }
            this.mApp.stateManager.changeState(PVZApp.STATE_LEVEL_INTRO);
         }
         else if(this.mApp.IsSurvivalMode())
         {
            this.KillAllZombies();
            ++this.mChallenge.mSurvivalStage;
            this.InitSurvivalStage();
            this.PlaceStreetZombies();
            this.mApp.mCutsceneTime = 0;
            this.mApp.stateManager.changeState(PVZApp.STATE_SURVIVAL_REPICK);
         }
      }
      
      public function PickZombieWaves() : void
      {
         var aWaveLevelIndex:int = 0;
         var aZombieWave:Array = null;
         var aIsFlagWave:Boolean = false;
         var aIsFinalWave:* = false;
         var aSpawnIntroZombie:Boolean = false;
         var aBasicZombiePoints:int = 0;
         var i:int = 0;
         var aZombieType:int = 0;
         if(this.mApp.IsAdventureMode())
         {
            aWaveLevelIndex = TodCommon.ClampInt(this.mLevel - 1,0,14 - 1);
            this.mNumWaves = this.mZombieWaves[aWaveLevelIndex];
         }
         else if(this.mApp.IsSurvivalMode())
         {
            this.mNumWaves = this.GetNumWavesPerSurvivalStage();
         }
         var aZombiePicker:ZombiePicker = new ZombiePicker();
         this.ZombiePickerInit(aZombiePicker);
         var aIntroZombieType:int = this.GetIntroducedZombieType();
         for(var aWaveNumber:int = 0; aWaveNumber < this.mNumWaves; aWaveNumber++)
         {
            this.ZombiePickerInitForWave(aZombiePicker);
            aZombieWave = new Array();
            this.mZombiesInWave[aWaveNumber] = aZombieWave;
            this.mZombiesInWave[aWaveNumber][0] = ZOMBIE_INVALID;
            aIsFlagWave = this.IsFlagWave(aWaveNumber);
            aIsFinalWave = aWaveNumber == this.mNumWaves - 1;
            if(this.mApp.IsSurvivalMode() && this.mChallenge.mSurvivalStage > 0)
            {
               aZombiePicker.mZombiePoints = (this.mChallenge.mSurvivalStage * this.GetNumWavesPerSurvivalStage() + aWaveNumber) * 2 / 5 + 1;
            }
            else
            {
               aZombiePicker.mZombiePoints = aWaveNumber / 3 + 1;
            }
            if(aIsFlagWave)
            {
               aBasicZombiePoints = Math.min(aZombiePicker.mZombiePoints,8);
               aZombiePicker.mZombiePoints *= 2.5;
               for(i = 0; i < aBasicZombiePoints; i++)
               {
                  this.PutZombieInWave(ZOMBIE_NORMAL,aWaveNumber,aZombiePicker);
               }
               this.PutZombieInWave(ZOMBIE_FLAG,aWaveNumber,aZombiePicker);
            }
            if(this.IsWallnutBowlingLevel())
            {
               aZombiePicker.mZombiePoints *= 4;
            }
            else if(this.mApp.IsAdventureMode() && this.mLevel == 10)
            {
               aZombiePicker.mZombiePoints *= 3;
            }
            aSpawnIntroZombie = false;
            if(aWaveNumber == this.mNumWaves / 2 || aIsFinalWave)
            {
               aSpawnIntroZombie = true;
            }
            if(aSpawnIntroZombie)
            {
               if(aIntroZombieType != ZOMBIE_INVALID)
               {
                  this.PutZombieInWave(aIntroZombieType,aWaveNumber,aZombiePicker);
               }
            }
            if(this.mApp.IsAdventureMode() && aIsFinalWave)
            {
               this.PutInMissingZombies(aWaveNumber,aZombiePicker);
            }
            while(aZombiePicker.mZombiePoints > 0 && aZombiePicker.mZombieCount < MAX_ZOMBIES_IN_WAVE)
            {
               aZombieType = this.PickZombieType(aZombiePicker.mZombiePoints,aWaveNumber,aZombiePicker);
               this.PutZombieInWave(aZombieType,aWaveNumber,aZombiePicker);
            }
         }
         for(i = 0; i < MAX_ZOMBIES_IN_WAVE; i++)
         {
         }
      }
      
      public function InitZombieWavesForLevel(aForLevel:int) : void
      {
         for(var i:int = 0; i < NUM_ZOMBIE_TYPES; i++)
         {
            this.mZombieAllowed[i] = this.CanZombieSpawnOnLevel(i,aForLevel);
            if(this.CanZombieSpawnOnLevel(i,aForLevel))
            {
            }
         }
      }
      
      public function PlaceAZombie(theZombieType:int, theGridX:int, theGridY:int) : void
      {
         var aZombie:Zombie = new Zombie();
         var aVariant:Boolean = false;
         if(Math.random() * 5 == 0)
         {
            aVariant = true;
         }
         aZombie.ZombieInitialize(0,theZombieType,aVariant,null,-2,this.mApp,this.mApp.mBoard);
         this.mApp.mBoard.mZombies.push(aZombie);
         aZombie.mPosX = 600 + 28 * theGridX;
         aZombie.mPosY = 77 + 50 * theGridY;
         if(theGridX % 2 == 1)
         {
            aZombie.mPosY += 21;
         }
         else
         {
            aZombie.mPosY += Math.random() * 10;
            aZombie.mPosX += Math.random() * 10;
         }
         this.mApp.mBoard.mRenderManager.add(new ZombieRenderable(aZombie,Board.RENDER_LAYER_ZOMBIE + aZombie.mPosY));
      }
      
      public function CanAddGraveStoneAt(theGridX:int, theGridY:int) : Boolean
      {
         var aGridItem:GridItem = null;
         if(this.mGridSquareType[theGridX][theGridY] != GRIDSQUARE_GRASS)
         {
            return false;
         }
         for each(aGridItem in this.mGridItems)
         {
            if(!(aGridItem.mGridX != theGridX || aGridItem.mGridY != theGridY))
            {
               if(aGridItem.mGridItemType == GRIDITEM_GRAVESTONE)
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      public function ZombiePickerInitForWave(theZombiePicker:ZombiePicker) : void
      {
         theZombiePicker.mZombieCount = 0;
         theZombiePicker.mZombiePoints = 0;
         for(var i:int = 0; i < NUM_ZOMBIE_TYPES; i++)
         {
            theZombiePicker.mZombieTypeCount[i] = 0;
         }
      }
      
      public function buttonMouseMove(id:Number, x:Number, y:Number) : void
      {
      }
      
      public function DrawShovel(g:Graphics2D) : void
      {
         var x:int = 0;
         if(this.HasConveyorBeltSeedBank())
         {
            this.mShovelButtonRect.x = 387;
            x = 387;
         }
         else
         {
            x = 401;
         }
         if(this.mShowShovel)
         {
            g.blitImage(this.mShovelBankImage,x,0);
            if(this.mCursorObject.mCursorType != CURSOR_TYPE_SHOVEL)
            {
               g.blitImage(this.mShovelImage,x + 11,12);
            }
         }
      }
      
      public function GetSeedToolTip(theType:int) : String
      {
         var aName:String = null;
         switch(theType)
         {
            case 0:
               aName = "[PEASHOOTER_TOOLTIP]";
               break;
            case 1:
               aName = "[SUNFLOWER_TOOLTIP]";
               break;
            case 2:
               aName = "[CHERRY_BOMB_TOOLTIP]";
               break;
            case 3:
               aName = "[WALL_NUT_TOOLTIP]";
               break;
            case 4:
               aName = "[SQUASH_TOOLTIP]";
               break;
            case 5:
               aName = "[SNOW_PEA_TOOLTIP]";
               break;
            case 6:
               aName = "[CHOMPER_TOOLTIP]";
               break;
            case 7:
               aName = "[REPEATER_TOOLTIP]";
               break;
            case 8:
               aName = "[PUFF_SHROOM_TOOLTIP]";
               break;
            case 9:
               aName = "[SUN_SHROOM_TOOLTIP]";
               break;
            case 10:
               aName = "[FUME_SHROOM_TOOLTIP]";
               break;
            case 11:
               aName = "[GRAVE_BUSTER_TOOLTIP]";
               break;
            case 50:
               aName = "[EXPLODE_O_NUT_TOOLTIP]";
         }
         return aName;
      }
      
      private function spawnFootballZombieCheat() : void
      {
         this.AddZombieInRow(ZOMBIE_FOOTBALL,int(Math.random() * 5),1);
      }
      
      public function Pluralize(theCount:int, theSingular:String, thePlural:String) : String
      {
         var aResult:String = null;
         if(theCount == 1)
         {
            aResult = this.mApp.stringManager.translateString(theSingular);
            if(aResult.match("{COUNT}") != null)
            {
               aResult.replace("{COUNT}",theCount + " ");
            }
            return aResult;
         }
         aResult = this.mApp.stringManager.translateString(thePlural);
         if(aResult.match("{COUNT}") != null)
         {
            aResult = aResult.replace("{COUNT}",theCount + " ");
         }
         return aResult;
      }
      
      public function UpdateGridItems() : void
      {
         var aGridItem:GridItem = null;
         for each(aGridItem in this.mGridItems)
         {
            if(this.mEnableGraveStones && aGridItem.mGridItemType == GRIDITEM_GRAVESTONE)
            {
               if(aGridItem.mGridItemCounter < 100)
               {
                  ++aGridItem.mGridItemCounter;
               }
            }
         }
      }
      
      public function TotalZombiesHealthInWave(theWaveIndex:int) : int
      {
         var aZombie:Zombie = null;
         var aTotalHealth:int = 0;
         for each(aZombie in this.mZombies)
         {
            if(aZombie.mFromWave == theWaveIndex)
            {
               if(!aZombie.IsDeadOrDying())
               {
                  aTotalHealth += aZombie.mBodyHealth;
                  aTotalHealth += aZombie.mHelmHealth;
                  aTotalHealth += aZombie.mShieldHealth * 0.2;
                  aTotalHealth += aZombie.mFlyingHealth;
               }
            }
         }
         return aTotalHealth;
      }
      
      public function RemoveZombiesForRepick() : void
      {
         var aZombie:Zombie = null;
         for each(aZombie in this.mZombies)
         {
            if(!aZombie.IsDeadOrDying())
            {
               if(aZombie.mMindControlled && aZombie.mPosX > 486)
               {
                  aZombie.DieNoLoot();
               }
            }
         }
      }
      
      public function GetNumSeedsInBank() : int
      {
         if(this.mApp.IsScaryPotterLevel())
         {
            return 1;
         }
         if(this.HasConveyorBeltSeedBank())
         {
            return 8;
         }
         var aSeedPackets:int = 6;
         if(this.mApp.IsSurvivalMode())
         {
            aSeedPackets = 4;
         }
         else if(this.mLevel < aSeedPackets)
         {
            aSeedPackets = this.mLevel;
         }
         else if(this.mLevel == 6)
         {
            aSeedPackets = 5;
         }
         return aSeedPackets;
      }
      
      public function DrawFadeOut(g:Graphics2D) : void
      {
         if(this.mBoardFadeOutCounter < 0)
         {
            return;
         }
         if(this.mApp.IsSurvivalMode() && !this.IsFinalSurvivalStage())
         {
            return;
         }
         if(this.mLevel == 14)
         {
            return;
         }
         var aAlpha:int = TodCommon.TodAnimateCurve(200,0,this.mBoardFadeOutCounter,0,255,TodCommon.CURVE_LINEAR);
         g.pushState();
         var aColor:uint = uint(aAlpha << 24);
         if(this.mLevel == 9 || this.mLevel == 19 || this.mLevel == 29 || this.mLevel == 39 || this.mLevel == 49)
         {
            aColor |= 0;
         }
         else
         {
            aColor |= 16777215;
         }
         g.fillRect(0,0,BOARD_WIDTH,BOARD_HEIGHT,aColor);
         g.popState();
      }
      
      public function GetSurvivalFlagsCompleted() : int
      {
         var aNumWavesPerFlag:int = this.GetNumWavesPerFlag();
         var aFromPreviousStages:int = this.mChallenge.mSurvivalStage * this.GetNumWavesPerSurvivalStage() / aNumWavesPerFlag;
         if(this.IsFlagWave(this.mCurrentWave - 1) && this.mBoardFadeOutCounter < 0 && this.mNextSurvivalStageCounter == 0)
         {
            return (this.mCurrentWave - 1) / aNumWavesPerFlag + aFromPreviousStages;
         }
         return this.mCurrentWave / aNumWavesPerFlag + aFromPreviousStages;
      }
      
      public function DoPlantingEffects(gridX:Number, gridY:Number, plant:CPlant) : void
      {
         var aXPos:Number = this.GridToPixelX(gridX,gridY) + 41 * 0.675;
         var aYPos:Number = this.GridToPixelY(gridY,gridY) + 74 * 0.675;
         this.mApp.foleyManager.playFoley(PVZFoleyType.PLANT);
         var anEffect:ParticleSystem = this.mApp.particleManager.spawnParticleSystem(PVZParticles.PARTICLE_PLANTING);
         anEffect.setPosition(aXPos,aYPos);
         this.mRenderManager.add(new ParticleRenderable(anEffect,RENDER_LAYER_PARTICLE));
      }
      
      private function spawnScreendoorZombieCheat() : void
      {
         this.AddZombieInRow(ZOMBIE_DOOR,int(Math.random() * 5),1);
      }
      
      public function IsInShovelTutorial() : Boolean
      {
         if(this.mTutorialState == TUTORIAL_SHOVEL_PICKUP || this.mTutorialState == TUTORIAL_SHOVEL_DIG || this.mTutorialState == TUTORIAL_SHOVEL_KEEP_DIGGING)
         {
            return true;
         }
         return false;
      }
      
      public function AddProjectile(theX:int, theY:int, aRenderOrder:int, theRow:int, projectileType:int) : Projectile
      {
         var proj:Projectile = null;
         var aProjectile:Projectile = null;
         var aNumProjectiles:int = int(this.mProjectiles.length);
         for(var i:int = 0; i < aNumProjectiles; i++)
         {
            proj = this.mProjectiles[i];
            if(proj.mDead)
            {
               aProjectile = proj;
               break;
            }
         }
         if(aProjectile == null)
         {
            aProjectile = new Projectile();
            this.mProjectiles.push(aProjectile);
         }
         aProjectile.ProjectileInitialize(theX,theY,aRenderOrder,theRow,projectileType,this.mApp,this);
         this.mRenderManager.add(new ProjectileRenderable(aProjectile,RENDER_LAYER_PROJECTILE));
         return aProjectile;
      }
      
      override public function draw(g:Graphics2D) : void
      {
         this.DrawBackdrop(g);
         this.mAdvice.Draw(g);
         if(this.mGameScene != SCENE_LEVEL_INTRO)
         {
            if(this.mGameScene != SCENE_ZOMBIES_WON)
            {
               this.mSeedBank.Draw(g);
               this.DrawShovel(g);
            }
            this.mRenderManager.draw(g);
         }
         else
         {
            this.mRenderManager.draw(g);
            if(this.mGameScene != SCENE_ZOMBIES_WON)
            {
               this.mSeedBank.Draw(g);
               this.DrawShovel(g);
            }
         }
         this.mWaveWarning.draw(g);
         this.DrawProgressMeter(g);
         this.DrawLevelLabel(g);
         this.mCursorPreview.draw(g);
         this.mCursorObject.draw(g);
         this.mToolTip.Draw(g);
         this.DrawFadeOut(g);
      }
      
      private function spawnConeheadZombieCheat() : void
      {
         this.AddZombieInRow(ZOMBIE_TRAFFIC_CONE,int(Math.random() * 5),1);
      }
      
      public function CanTakeSunMoney(theAmount:int) : Boolean
      {
         if(theAmount <= this.mSunMoney + this.CountSunBeingCollected())
         {
            return true;
         }
         return false;
      }
      
      public function DisplayAdviceAgain(theAdvice:String, theMessageStyle:int, theHelpIndex:int) : void
      {
         if(theHelpIndex != ADVICE_NONE && Boolean(this.mHelpDisplayed[theHelpIndex]))
         {
            this.mHelpDisplayed[theHelpIndex] = false;
         }
         this.DisplayAdvice(theAdvice,theMessageStyle,theHelpIndex);
      }
      
      public function SetZombieDefinitions() : void
      {
      }
      
      public function AddAGraveStone(theGridX:int, theGridY:int) : GridItem
      {
         var aGridItem:GridItem = new GridItem(this.mApp,this);
         aGridItem.mGridItemType = GRIDITEM_GRAVESTONE;
         aGridItem.mGridItemCounter = Math.random() * -50;
         aGridItem.mGridX = theGridX;
         aGridItem.mGridY = theGridY;
         this.mRenderManager.add(new GridItemRenderable(aGridItem,RENDER_LAYER_GRAVE_STONE));
         this.mGridItems.push(aGridItem);
         return aGridItem;
      }
      
      public function GetGridItemAt(theGridItemType:int, theGridX:int, theGridY:int) : GridItem
      {
         var aGridItem:GridItem = null;
         for each(aGridItem in this.mGridItems)
         {
            if(!(aGridItem.mGridX != theGridX || aGridItem.mGridY != theGridY))
            {
               if(aGridItem.mGridItemType == theGridItemType)
               {
                  return aGridItem;
               }
            }
         }
         return null;
      }
      
      public function ProgressMeterHasFlags() : Boolean
      {
         if(this.mLevel == 1)
         {
            return false;
         }
         return true;
      }
      
      public function RowCanHaveZombieType(theRow:int, theZombieType:int) : Boolean
      {
         if(!this.RowCanHaveZombies(theRow))
         {
            return false;
         }
         var aWaveNumber:int = this.mCurrentWave;
         return true;
      }
      
      public function UpdateTutorial() : void
      {
         var aPosX:int = 0;
         var aPosY:int = 0;
         if(this.mTutorialTimer > 0)
         {
            --this.mTutorialTimer;
         }
         if(this.mTutorialState == TUTORIAL_LEVEL_1_PICK_UP_PEASHOOTER)
         {
            if(this.mTutorialTimer == 0)
            {
               this.DisplayAdvice("[ADVICE_CLICK_PEASHOOTER]",MESSAGE_STYLE_TUTORIAL_LEVEL1_STAY,ADVICE_NONE);
               aPosX = this.mSeedBank.mX + this.mSeedBank.mSeedPackets[0].mX + this.mSeedBank.mSeedPackets[0].mWidth / 2;
               aPosY = this.mSeedBank.mY + this.mSeedBank.mSeedPackets[0].mY + this.mSeedBank.mSeedPackets[0].mHeight;
               this.TutorialArrowShow(aPosX,aPosY);
               this.mTutorialTimer = -1;
            }
         }
         if(this.mTutorialState == TUTORIAL_LEVEL_2_PICK_UP_SUNFLOWER || this.mTutorialState == TUTORIAL_LEVEL_2_PLANT_SUNFLOWER || this.mTutorialState == TUTORIAL_LEVEL_2_REFRESH_SUNFLOWER)
         {
            if(this.mTutorialTimer == 0)
            {
               this.DisplayAdvice("[ADVICE_PLANT_SUNFLOWER2]",MESSAGE_STYLE_TUTORIAL_LEVEL2,ADVICE_NONE);
               this.mTutorialTimer = -1;
            }
            else if(this.mZombieCountDown == 750 && this.mCurrentWave == 0)
            {
               this.DisplayAdvice("[ADVICE_PLANT_SUNFLOWER3]",MESSAGE_STYLE_TUTORIAL_LEVEL2,ADVICE_NONE);
            }
         }
         if(this.mTutorialState == TUTORIAL_MORESUN_PICK_UP_SUNFLOWER || this.mTutorialState == TUTORIAL_MORESUN_PLANT_SUNFLOWER || this.mTutorialState == TUTORIAL_MORESUN_REFRESH_SUNFLOWER)
         {
            if(this.mTutorialTimer == 0)
            {
               this.DisplayAdvice("[ADVICE_PLANT_SUNFLOWER5]",MESSAGE_STYLE_TUTORIAL_LATER,ADVICE_PLANT_SUNFLOWER5);
               this.mTutorialTimer = -1;
            }
         }
         if(this.mLevel >= 3 && this.mLevel != 5 && this.mLevel <= 7 && this.mTutorialState == TUTORIAL_OFF && this.mCurrentWave >= 5 && !this.mShownMoreSunTutorial && this.mSeedBank.mSeedPackets[1].CanPickUp() && this.CountPlantByType(SEED_SUNFLOWER) < 3)
         {
            this.DisplayAdvice("[ADVICE_PLANT_SUNFLOWER4]",MESSAGE_STYLE_TUTORIAL_LATER_STAY,ADVICE_NONE);
            this.mShownMoreSunTutorial = true;
            this.SetTutorialState(TUTORIAL_MORESUN_PICK_UP_SUNFLOWER);
            this.mTutorialTimer = 500;
         }
      }
      
      public function IsPlantInCursor() : Boolean
      {
         if(this.mCursorObject.mCursorType == CURSOR_TYPE_PLANT_FROM_BANK || this.mCursorObject.mCursorType == CURSOR_TYPE_PLANT_FROM_USABLE_COIN)
         {
            return true;
         }
         return false;
      }
      
      public function GetPlantsOnLawn(theGridX:int, theGridY:int) : CPlant
      {
         var aPlant:CPlant = null;
         if(this.IsWallnutBowlingLevel() && !this.IsInShovelTutorial())
         {
            return null;
         }
         if(theGridX < 0 || theGridX >= GRIDSIZEX || theGridY < 0 || theGridY >= GRIDSIZEY)
         {
            return null;
         }
         for each(aPlant in this.mPlants)
         {
            if(!(aPlant.getCol() != theGridX || aPlant.getRow() != theGridY))
            {
               return aPlant;
            }
         }
         return null;
      }
      
      public function GetGraveStoneCount() : int
      {
         var aGridItem:GridItem = null;
         var aCount:int = 0;
         for each(aGridItem in this.mGridItems)
         {
            if(aGridItem.mGridItemType == GRIDITEM_GRAVESTONE)
            {
               aCount++;
            }
         }
         return aCount;
      }
      
      public function PixelToGridX(theX:int, theY:int) : int
      {
         if(theX < LAWN_XMIN)
         {
            return -1;
         }
         return TodCommon.ClampInt((theX - LAWN_XMIN) / 54,0,GRIDSIZEX - 1);
      }
      
      public function MouseDownWithTool(x:int, y:int, theCursorType:int) : void
      {
         var aPlant:CPlant = this.ToolHitTest(x,y);
         if(!aPlant)
         {
            this.mApp.foleyManager.playFoley(PVZFoleyType.DROP);
            this.ClearCursor();
            return;
         }
         if(theCursorType == CURSOR_TYPE_SHOVEL)
         {
            this.mApp.foleyManager.playFoley(PVZFoleyType.USE_SHOVEL);
            aPlant.Die();
            if(this.mTutorialState == TUTORIAL_SHOVEL_DIG || this.mTutorialState == TUTORIAL_SHOVEL_KEEP_DIGGING)
            {
               if(this.CountPlantByType(SEED_PEASHOOTER) == 1)
               {
                  this.SetTutorialState(TUTORIAL_SHOVEL_COMPLETED);
               }
               else
               {
                  this.SetTutorialState(TUTORIAL_SHOVEL_KEEP_DIGGING);
               }
            }
         }
         this.ClearCursor();
      }
      
      public function GetZombieDefinition(aZombieType:int) : ZombieDef
      {
         var aZombieDef:ZombieDef = new ZombieDef();
         switch(aZombieType)
         {
            case ZOMBIE_NORMAL:
               aZombieDef.mZombieValue = 1;
               aZombieDef.mStartingLevel = 1;
               aZombieDef.mFirstAllowedWave = 1;
               aZombieDef.mPickWeight = 4000;
               aZombieDef.mZombieName = "ZOMBIE";
               break;
            case ZOMBIE_FLAG:
               aZombieDef.mZombieValue = 1;
               aZombieDef.mStartingLevel = 1;
               aZombieDef.mFirstAllowedWave = 1;
               aZombieDef.mPickWeight = 0;
               aZombieDef.mZombieName = "FLAG_ZOMBIE";
               break;
            case ZOMBIE_TRAFFIC_CONE:
               aZombieDef.mZombieValue = 2;
               aZombieDef.mStartingLevel = 3;
               aZombieDef.mFirstAllowedWave = 1;
               aZombieDef.mPickWeight = 4000;
               aZombieDef.mZombieName = "CONEHEAD_ZOMBIE";
               break;
            case ZOMBIE_POLEVAULTER:
               aZombieDef.mZombieValue = 2;
               aZombieDef.mStartingLevel = 6;
               aZombieDef.mFirstAllowedWave = 5;
               aZombieDef.mPickWeight = 2000;
               aZombieDef.mZombieName = "POLE_VAULTING_ZOMBIE";
               break;
            case ZOMBIE_PAIL:
               aZombieDef.mZombieValue = 4;
               aZombieDef.mStartingLevel = 8;
               aZombieDef.mFirstAllowedWave = 1;
               aZombieDef.mPickWeight = 3000;
               aZombieDef.mZombieName = "BUCKETHEAD_ZOMBIE";
               break;
            case ZOMBIE_NEWSPAPER:
               aZombieDef.mZombieValue = 2;
               aZombieDef.mStartingLevel = 11;
               aZombieDef.mFirstAllowedWave = 1;
               aZombieDef.mPickWeight = 1000;
               aZombieDef.mZombieName = "NEWSPAPER_ZOMBIE";
               break;
            case ZOMBIE_DOOR:
               aZombieDef.mZombieValue = 4;
               aZombieDef.mStartingLevel = 13;
               aZombieDef.mFirstAllowedWave = 5;
               aZombieDef.mPickWeight = 3500;
               aZombieDef.mZombieName = "SCREEN_DOOR_ZOMBIE";
               break;
            case ZOMBIE_FOOTBALL:
               aZombieDef.mZombieValue = 7;
               aZombieDef.mStartingLevel = 16;
               aZombieDef.mFirstAllowedWave = 5;
               aZombieDef.mPickWeight = 2000;
               aZombieDef.mZombieName = "FOOTBALL_ZOMBIE";
         }
         return aZombieDef;
      }
      
      public function FindLawnMowerInRow(theRow:int) : LawnMower
      {
         var aLawnMower:LawnMower = null;
         for each(aLawnMower in this.mLawnMowers)
         {
            if(aLawnMower.mRow == theRow)
            {
               return aLawnMower;
            }
         }
         return null;
      }
      
      public function CountSunBeingCollected() : int
      {
         var aCoin:Coin = null;
         var anAmount:int = 0;
         for each(aCoin in this.mCoins)
         {
            if(aCoin.mIsBeingCollected && aCoin.IsSun())
            {
               anAmount += aCoin.GetSunValue();
            }
         }
         return anAmount;
      }
      
      public function TutorialArrowRemove() : void
      {
         if(this.mTutorialArrow != null)
         {
            this.mTutorialArrow.die();
         }
         this.mTutorialArrow = null;
      }
      
      public function FadeOutLevel() : void
      {
         var aCoin:Coin = null;
         var aMessage:String = null;
         var aIsNote:Boolean = false;
         this.mMenuButton.visible = false;
         if(this.mGameScene != SCENE_PLAYING)
         {
            this.RefreshSeedPacketFromCursor();
            this.mLevelComplete = true;
            return;
         }
         if(this.mLevel == 14)
         {
            this.mApp.mSaveObject.level = 1;
            this.mApp.mLevel = 1;
            if(this.mApp.mSaveObject.puzzleLocked)
            {
               this.mApp.mSaveObject.puzzleLocked = false;
               this.mApp.mPuzzleLocked = false;
            }
            if(this.mApp.mSaveObject.survivalLocked)
            {
               this.mApp.mSaveObject.survivalLocked = false;
               this.mApp.mSurvivalLocked = false;
            }
            this.mApp.setSaveData(this.mApp.mSaveObject);
         }
         var aCutMusic:Boolean = true;
         if(this.mApp.IsSurvivalMode() || this.mApp.IsScaryPotterLevel())
         {
            aCutMusic = false;
         }
         if(aCutMusic)
         {
            this.mApp.musicManager.playMusic(PVZMusic.WINMUSIC,false);
         }
         if(this.mLevel == 14)
         {
            this.mBoardFadeOutCounter = 600;
         }
         else if(this.mApp.IsScaryPotterLevel())
         {
            this.mLevelAwardSpawned = true;
            this.mNextSurvivalStageCounter = 500;
            for each(aCoin in this.mCoins)
            {
               if(aCoin.mType == Coin.COIN_USABLE_SEED_PACKET)
               {
                  aCoin.Die();
               }
               else
               {
                  aCoin.TryAutoCollectAfterLevelAward();
               }
            }
            aMessage = this.mApp.stringManager.translateString("[ADVICE_MORE_SCARY_POTS]").replace("{STREAK}",this.mChallenge.mSurvivalStage + 1);
            this.ClearAdvice(ADVICE_NONE);
            this.DisplayAdvice(aMessage,MESSAGE_STYLE_BIG_MIDDLE,ADVICE_NONE);
         }
         else if(!this.mApp.IsSurvivalMode())
         {
            this.RefreshSeedPacketFromCursor();
            this.mMenuButton.visible = false;
            this.mBoardFadeOutCounter = 600;
            for each(aCoin in this.mCoins)
            {
               aCoin.TryAutoCollectAfterLevelAward();
            }
            aIsNote = this.mLevel == 9 || this.mLevel == 19 || this.mLevel == 29 || this.mLevel == 39 || this.mLevel == 49;
            if(aIsNote)
            {
               this.mBoardFadeOutCounter = 500;
            }
         }
         else
         {
            this.mNextSurvivalStageCounter = 500;
            this.DisplayAdvice("[ADVICE_MORE_ZOMBIES]",MESSAGE_STYLE_BIG_MIDDLE,ADVICE_NONE);
            this.mApp.foleyManager.playFoley(PVZFoleyType.HUGEWAVE);
         }
      }
      
      public function AddSunMoney(theAmount:int) : void
      {
         this.mSunMoney += theAmount;
         if(this.mSunMoney > 9990)
         {
            this.mSunMoney = 9990;
         }
         var bounds:Rectangle = new Rectangle(0,0,40,15);
         this.mSeedBank.mSunText = Utils.createStringImage(String(this.mSunMoney),this.mSeedBank.mSeedBankFont,bounds,Utils.JUSTIFY_CENTER);
      }
      
      public function ClearAdvice(theHelpIndex:int) : void
      {
         if(theHelpIndex != ADVICE_NONE && theHelpIndex != this.mHelpIndex)
         {
            return;
         }
         this.mAdvice.ClearLabel();
         this.mHelpIndex = ADVICE_NONE;
      }
      
      public function PixelToGridXKeepOnBoard(theX:int, theY:int) : int
      {
         return Math.max(this.PixelToGridX(theX,theY),0);
      }
      
      public function ZombieHitTest(theMouseX:int, theMouseY:int) : Zombie
      {
         var aZombie:Zombie = null;
         var aRect:Rectangle = null;
         var aTopZombie:Zombie = null;
         for each(aZombie in this.mZombies)
         {
            if(!aZombie.IsDeadOrDying())
            {
               aRect = aZombie.GetZombieRect();
               if(aRect.contains(theMouseX,theMouseY))
               {
                  if(!aTopZombie || aZombie.mY > aTopZombie.mY)
                  {
                     aTopZombie = aZombie;
                  }
               }
            }
         }
         return aTopZombie;
      }
      
      public function ZombiePickerInit(theZombiePicker:ZombiePicker) : void
      {
         this.ZombiePickerInitForWave(theZombiePicker);
         for(var i:int = 0; i < NUM_ZOMBIE_TYPES; i++)
         {
            theZombiePicker.mAllWavesZombieTypeCount[i] = 0;
         }
      }
      
      public function PickRowForNewZombie(theZombieType:int) : int
      {
         var aWavesSinceMowed:int = 0;
         for(var i:int = 0; i < GRIDSIZEY; i++)
         {
            if(!this.RowCanHaveZombieType(i,theZombieType))
            {
               this.mRowPickingArray[i].mWeight = 0;
            }
            else
            {
               aWavesSinceMowed = this.mCurrentWave - this.mWaveRowGotLawnMowered[i];
               if(aWavesSinceMowed <= 1)
               {
                  this.mRowPickingArray[i].mWeight = 0.01;
               }
               else if(aWavesSinceMowed <= 2)
               {
                  this.mRowPickingArray[i].mWeight = 0.5;
               }
               else
               {
                  this.mRowPickingArray[i].mWeight = 1;
               }
            }
         }
         for(i = 0; i < GRIDSIZEY; i++)
         {
         }
         return TodCommon.TodPickFromSmoothArray(this.mRowPickingArray,GRIDSIZEY);
      }
      
      public function UpdateCursor() : void
      {
         var aHitResult:HitResult = null;
         var aSeedPacket:SeedPacket = null;
         var aShowFinger:Boolean = false;
         var aShowDrag:Boolean = false;
         var aHideCursor:Boolean = false;
         var aMouseX:int = this.mApp.widgetManager.lastMouseX - x;
         var aMouseY:int = this.mApp.widgetManager.lastMouseY - y;
         if(Boolean(this.mApp.mSeedChooserScreen) && this.mApp.mSeedChooserScreen.contains(aMouseX + x,aMouseY + y))
         {
            return;
         }
         if(this.mPaused || this.mBoardFadeOutCounter >= 0 || this.mTimeStopCounter > 0 || this.mGameScene == SCENE_ZOMBIES_WON)
         {
            aShowFinger = false;
         }
         else
         {
            aHitResult = new HitResult();
            this.MouseHitTest(aMouseX,aMouseY,aHitResult);
            if(aHitResult.mObjectType == OBJECT_TYPE_SHOVEL || aHitResult.mObjectType == OBJECT_TYPE_COIN)
            {
               aShowFinger = true;
            }
            else if(aHitResult.mObjectType == OBJECT_TYPE_SEEDPACKET)
            {
               aSeedPacket = SeedPacket(aHitResult.mObject);
               if(aSeedPacket.CanPickUp())
               {
                  aShowFinger = true;
               }
            }
            else if(aHitResult.mObjectType == OBJECT_TYPE_SCARY_POT)
            {
               aShowFinger = true;
            }
         }
         showFinger(aShowFinger);
      }
      
      public function ShakeBoard(theShakeAmountX:int, theShakeAmountY:int) : void
      {
         this.mShakeCounter = BOARD_SHAKE_TIME;
         this.mShakeAmountX = theShakeAmountX;
         this.mShakeAmountY = theShakeAmountY;
      }
      
      public function GetStageString(theLevel:int) : String
      {
         var aArea:int = TodCommon.ClampInt((theLevel - 1) / LEVELS_PER_AREA + 1,1,6);
         var aSubArea:int = theLevel - (aArea - 1) * LEVELS_PER_AREA;
         return String(aArea) + "-" + String(aSubArea);
      }
      
      public function GetSeedBankExtraWidth() : int
      {
         return 0;
      }
      
      public function TakeSunMoney(theAmount:int) : Boolean
      {
         var bounds:Rectangle = null;
         if(this.mEasyPlantingCheat)
         {
            return true;
         }
         if(theAmount <= this.mSunMoney + this.CountSunBeingCollected())
         {
            this.mSunMoney -= theAmount;
            bounds = new Rectangle(0,0,40,15);
            this.mSeedBank.mSunText = Utils.createStringImage(String(this.mSunMoney),this.mSeedBank.mSeedBankFont,bounds,Utils.JUSTIFY_CENTER);
            return true;
         }
         this.mApp.foleyManager.playFoley(PVZFoleyType.BUZZER);
         this.mOutOfMoneyCounter = 70;
         return false;
      }
      
      public function PickZombieType(theZombiePoints:int, theWaveIndex:int, theZombiePicker:ZombiePicker) : int
      {
         var aFlags:int = 0;
         var aWeightedArray:WeightedArray = null;
         var aZombieType:int = 0;
         var aZombieDef:ZombieDef = null;
         var aFirstWave:int = 0;
         var aWeight:int = 0;
         var aWavesEarlier:int = 0;
         var aLimit:int = 0;
         var aZombieWeightArray:Array = new Array(NUM_ZOMBIE_TYPES);
         var aPickCount:int = 0;
         for(var i:int = 0; i < NUM_ZOMBIE_TYPES; i++)
         {
            aWeightedArray = new WeightedArray();
            aZombieWeightArray[aPickCount] = aWeightedArray;
            aZombieType = i;
            aZombieDef = this.GetZombieDefinition(aZombieType);
            if(this.mZombieAllowed[aZombieType])
            {
               aFirstWave = aZombieDef.mFirstAllowedWave;
               if(this.mApp.IsSurvivalEndless())
               {
                  aFlags = this.GetSurvivalFlagsCompleted();
                  aWavesEarlier = TodCommon.TodAnimateCurve(18,50,aFlags,0,15,TodCommon.CURVE_LINEAR);
                  aFirstWave = Math.max(aFirstWave - aWavesEarlier,1);
               }
               if(theWaveIndex + 1 >= aFirstWave)
               {
                  if(theZombiePoints >= aZombieDef.mZombieValue)
                  {
                     aWeight = aZombieDef.mPickWeight;
                     if(this.mApp.IsSurvivalMode())
                     {
                        aFlags = this.GetSurvivalFlagsCompleted();
                        if(aZombieType == 8)
                        {
                           aLimit = TodCommon.TodAnimateCurve(10,50,aFlags,2,50,TodCommon.CURVE_LINEAR);
                           if(theZombiePicker.mZombieTypeCount[aZombieType] >= aLimit)
                           {
                              continue;
                           }
                        }
                        if(aZombieType == 8)
                        {
                           if(this.IsFlagWave(theWaveIndex))
                           {
                              aLimit = TodCommon.TodAnimateCurve(14,100,aFlags,1,50,TodCommon.CURVE_LINEAR);
                              if(theZombiePicker.mZombieTypeCount[aZombieType] >= aLimit)
                              {
                                 continue;
                              }
                           }
                           else
                           {
                              aLimit = TodCommon.TodAnimateCurve(10,110,aFlags,1,50,TodCommon.CURVE_LINEAR);
                              if(theZombiePicker.mAllWavesZombieTypeCount[aZombieType] >= aLimit)
                              {
                                 continue;
                              }
                              aWeight = 1000;
                           }
                        }
                        if(aZombieType == ZOMBIE_NORMAL)
                        {
                           aWeight = TodCommon.TodAnimateCurve(10,50,aFlags,aZombieDef.mPickWeight,aZombieDef.mPickWeight / 10,TodCommon.CURVE_LINEAR);
                        }
                        if(aZombieType == ZOMBIE_TRAFFIC_CONE)
                        {
                           aWeight = TodCommon.TodAnimateCurve(10,50,aFlags,aZombieDef.mPickWeight,aZombieDef.mPickWeight / 4,TodCommon.CURVE_LINEAR);
                        }
                     }
                     aZombieWeightArray[aPickCount].mItem = i;
                     aZombieWeightArray[aPickCount].mWeight = aWeight;
                     aPickCount++;
                  }
               }
            }
         }
         return TodCommon.TodPickFromWeightedArray(aZombieWeightArray,aPickCount);
      }
      
      public function KillAllPlantsInRadius(theX:int, theY:int, theRadius:int) : void
      {
         var aPlant:CPlant = null;
         var aPlantRect:Rectangle = null;
         for each(aPlant in this.mPlants)
         {
            aPlantRect = aPlant.GetPlantRect();
            if(this.GetCircleRectOverlap(theX,theY,theRadius,aPlantRect))
            {
               aPlant.Die();
            }
         }
      }
      
      override public function onMouseDown(x:Number, y:Number) : void
      {
         var aCoin:Coin = null;
         var aSeedPacket:SeedPacket = null;
         if(this.mPaused)
         {
            return;
         }
         var aHitResult:HitResult = new HitResult();
         this.MouseHitTest(x,y,aHitResult);
         if(this.mChallenge.MouseDown(x,y,aHitResult))
         {
            return;
         }
         if(this.mGameScene == SCENE_ZOMBIES_WON)
         {
            return;
         }
         if(aHitResult.mObjectType == OBJECT_TYPE_COIN)
         {
            aCoin = Coin(aHitResult.mObject);
            aCoin.MouseDown(x,y);
         }
         else if(this.mCursorObject.mCursorType == CURSOR_TYPE_SHOVEL)
         {
            this.MouseDownWithTool(x,y,this.mCursorObject.mCursorType);
         }
         else if(this.IsPlantInCursor())
         {
            this.MouseDownWithPlant(x,y);
         }
         else if(aHitResult.mObjectType == OBJECT_TYPE_SEEDPACKET)
         {
            aSeedPacket = SeedPacket(aHitResult.mObject);
            aSeedPacket.MouseDown(x,y);
         }
         else if(aHitResult.mObjectType == OBJECT_TYPE_SHOVEL)
         {
            this.PickUpTool(aHitResult.mObjectType);
         }
         this.UpdateCursor();
      }
      
      public function ContinueVasebreaker() : void
      {
         if(this.mApp.adAPI.enabled)
         {
            this.mApp.musicManager.resumeMusic();
            this.mApp.soundManager.resumeAll();
         }
         this.mChallenge.PuzzleNextStageClear();
         this.mChallenge.ScaryPotterPopulate();
         this.mMenuButton.visible = true;
      }
      
      public function AddGraveStones(theGridX:int, theCount:int) : void
      {
         var aGridY:int = 0;
         for(var i:int = 0; i < theCount; i++)
         {
            aGridY = int(Math.random() * GRIDSIZEY);
            if(this.CanAddGraveStoneAt(theGridX,aGridY))
            {
               this.AddAGraveStone(theGridX,aGridY);
            }
         }
      }
      
      public function GetIntroducedZombieType() : int
      {
         var aZombieType:int = 0;
         var aZombieDef:ZombieDef = null;
         if(!this.mApp.IsAdventureMode() || this.mLevel == 1)
         {
            return ZOMBIE_INVALID;
         }
         for(var i:int = 0; i < NUM_ZOMBIE_TYPES; i++)
         {
            aZombieType = i;
            aZombieDef = this.GetZombieDefinition(aZombieType);
            if(aZombieDef.mStartingLevel == this.mLevel)
            {
               return aZombieType;
            }
         }
         return ZOMBIE_INVALID;
      }
      
      public function DrawBackdrop(g:Graphics2D) : void
      {
         var aWidth:int = 0;
         var aSrcRect:Rectangle = null;
         var aImage:ImageInst = null;
         var flashSod:ImageInst = null;
         var aFlashingColor:Color = null;
         if(this.mApp.IsAdventureMode())
         {
            if(this.mLevel == 1)
            {
               g.blitImage(this.unsoddedBackground,-PVZApp.BOARD_OFFSET,0);
               aWidth = TodCommon.TodAnimateCurve(0,1000,this.mSodPosition,0,this.sod1Row.width,TodCommon.CURVE_LINEAR);
               aSrcRect = new Rectangle(0,0,aWidth,this.sod1Row.height);
               g.pushState();
               g.setClipRect(-PVZApp.BOARD_OFFSET + 161.5,197,aWidth,this.sod1Row.height);
               g.drawImage(this.sod1Row,-PVZApp.BOARD_OFFSET + 161.5,197);
               g.popState();
            }
            else if(this.mLevel == 2 || this.mLevel == 3)
            {
               g.blitImage(this.unsoddedBackground,-PVZApp.BOARD_OFFSET,0);
               g.drawImage(this.sod1Row,-PVZApp.BOARD_OFFSET + 161.5,197);
               aWidth = TodCommon.TodAnimateCurve(0,1000,this.mSodPosition,0,this.sod3Row.width,TodCommon.CURVE_LINEAR);
               g.pushState();
               if(this.mLevel == 2)
               {
                  g.setClipRect(-PVZApp.BOARD_OFFSET + 158.7,118.5,aWidth,this.sod3Row.height);
               }
               g.drawImage(this.sod3Row,-PVZApp.BOARD_OFFSET + 158.5,118.5);
               g.popState();
            }
            else if(this.mLevel == 4)
            {
               g.drawImage(this.unsoddedBackground,-PVZApp.BOARD_OFFSET,0);
               g.drawImage(this.sod3Row,-PVZApp.BOARD_OFFSET + 158.7,118.5);
               aWidth = TodCommon.TodAnimateCurve(0,1000,this.mSodPosition,0,this.sod3Row.width,TodCommon.CURVE_LINEAR);
               g.pushState();
               aSrcRect = new Rectangle(156,0,aWidth,this.background.height);
               g.setClipRect(-PVZApp.BOARD_OFFSET + 158.7,0,aWidth,this.background.height);
               g.drawImage(this.background,-PVZApp.BOARD_OFFSET,0);
               g.popState();
            }
            else
            {
               g.blitImage(this.background,-PVZApp.BOARD_OFFSET,0);
            }
         }
         else
         {
            g.blitImage(this.background,-PVZApp.BOARD_OFFSET,0);
         }
         if(this.mGameScene == SCENE_ZOMBIES_WON)
         {
            g.blitImage(this.doorOverlay,-85,168);
         }
         if(this.IsWallnutBowlingLevel())
         {
            if(this.mChallenge.mShowBowlingLine)
            {
               aImage = this.mApp.imageManager.getImageInst(PVZImages.IMAGE_WALLNUT_BOWLINGSTRIPE);
               g.drawImage(aImage,179,65);
            }
         }
         if(this.mTutorialState == TUTORIAL_LEVEL_1_PLANT_PEASHOOTER)
         {
            flashSod = this.mApp.imageManager.getImageInst(PVZImages.IMAGE_SOD1ROW);
            g.pushState();
            aFlashingColor = TodCommon.GetFlashingColor(this.mMainCounter,75);
            flashSod.useColor = true;
            flashSod.setColor(aFlashingColor.alpha,aFlashingColor.red,aFlashingColor.blue,aFlashingColor.green);
            g.drawImage(flashSod,-PVZApp.BOARD_OFFSET + 161.5,197);
            g.popState();
         }
      }
      
      public function MouseHitTestPlant(x:int, y:int, theHitResult:HitResult) : Boolean
      {
         var aGridX:int = this.PixelToGridX(x,y);
         var aGridY:int = this.PixelToGridY(x,y);
         var aPlant:CPlant = this.GetPlantsOnLawn(aGridX,aGridY);
         if(aPlant)
         {
            theHitResult.mObject = aPlant;
            theHitResult.mObjectType = OBJECT_TYPE_PLANT;
            return true;
         }
         return false;
      }
      
      public function InitLawnMowers() : void
      {
         var aHasMower:Boolean = false;
         var aLawnMower:LawnMower = null;
         for(var y:int = 0; y < GRIDSIZEY; y++)
         {
            if(this.mApp.IsScaryPotterLevel())
            {
               aHasMower = false;
            }
            else if(this.mPlantRow[y] == PLANTROW_DIRT)
            {
               aHasMower = false;
            }
            else
            {
               aHasMower = true;
            }
            if(aHasMower)
            {
               aLawnMower = new LawnMower(this.mApp,this,y);
               aLawnMower.mVisible = false;
               this.mRenderManager.add(new LawnMowerRenderable(aLawnMower,RENDER_LAYER_ZOMBIE + y + 1));
               this.mLawnMowers.push(aLawnMower);
            }
         }
      }
      
      public function CountSunFlowers() : int
      {
         var aPlant:CPlant = null;
         var aCount:int = 0;
         for each(aPlant in this.mPlants)
         {
            if(!aPlant.mSeedType != SEED_SUNFLOWER)
            {
               aCount++;
            }
         }
         return aCount;
      }
      
      public function buttonMouseLeave(id:Number) : void
      {
      }
      
      public function ToolHitTest(x:int, y:int) : CPlant
      {
         var aHitResult:HitResult = new HitResult();
         this.MouseHitTest(x,y,aHitResult);
         if(aHitResult.mObjectType != OBJECT_TYPE_PLANT)
         {
            return null;
         }
         return CPlant(aHitResult.mObject);
      }
      
      public function IsFlagWave(theWaveNumber:int) : Boolean
      {
         if(this.mApp.IsAdventureMode() && this.mLevel == 1)
         {
            return false;
         }
         var aNumWavesPerFlag:int = this.GetNumWavesPerFlag();
         return theWaveNumber % aNumWavesPerFlag == aNumWavesPerFlag - 1;
      }
      
      public function GetSeedName(theType:int) : String
      {
         var aName:String = null;
         switch(theType)
         {
            case 0:
               aName = "[PEASHOOTER]";
               break;
            case 1:
               aName = "[SUNFLOWER]";
               break;
            case 2:
               aName = "[CHERRY_BOMB]";
               break;
            case 3:
               aName = "[WALL_NUT]";
               break;
            case 4:
               aName = "[SQUASH]";
               break;
            case 5:
               aName = "[SNOW_PEA]";
               break;
            case 6:
               aName = "[CHOMPER]";
               break;
            case 7:
               aName = "[REPEATER]";
               break;
            case 8:
               aName = "[PUFF_SHROOM]";
               break;
            case 9:
               aName = "[SUN_SHROOM]";
               break;
            case 10:
               aName = "[FUME_SHROOM]";
               break;
            case 11:
               aName = "[GRAVE_BUSTER]";
               break;
            case 50:
               aName = "[EXPLODE_O_NUT]";
         }
         return aName;
      }
      
      public function RemoveAllZombies() : void
      {
         var aZombie:Zombie = null;
         for each(aZombie in this.mZombies)
         {
            if(!aZombie.IsDeadOrDying())
            {
               aZombie.DieNoLoot();
            }
         }
      }
   }
}
