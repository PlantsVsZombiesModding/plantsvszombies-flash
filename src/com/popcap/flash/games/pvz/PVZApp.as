package com.popcap.flash.games.pvz
{
   import com.popcap.flash.framework.AppBase;
   import com.popcap.flash.framework.resources.foley.FoleyManager;
   import com.popcap.flash.framework.resources.foley.FoleyType;
   import com.popcap.flash.framework.resources.particles.ParticleManager;
   import com.popcap.flash.framework.resources.reanimator.Reanimator;
   import com.popcap.flash.games.pvz.logic.AwardScreen;
   import com.popcap.flash.games.pvz.logic.Board;
   import com.popcap.flash.games.pvz.logic.ChallengeScreen;
   import com.popcap.flash.games.pvz.logic.SeedChooserScreen;
   import com.popcap.flash.games.pvz.logic.UI.DialogBox;
   import com.popcap.flash.games.pvz.logic.UI.OptionsDialog;
   import com.popcap.flash.games.pvz.logic.UI.UpsellScreen;
   import com.popcap.flash.games.pvz.resources.PVZResources;
   import com.popcap.flash.games.pvz.states.loading.LoadingState;
   import com.popcap.flash.games.pvz.states.loading.TitleScreenState;
   import com.popcap.flash.games.pvz.states.mainmenu.MainMenuState;
   import com.popcap.flash.games.pvz.states.playing.ChallengeScreenState;
   import com.popcap.flash.games.pvz.states.playing.ChooseSeedsState;
   import com.popcap.flash.games.pvz.states.playing.CrazyDaveState;
   import com.popcap.flash.games.pvz.states.playing.DialogState;
   import com.popcap.flash.games.pvz.states.playing.LawnViewState;
   import com.popcap.flash.games.pvz.states.playing.LevelIntroState;
   import com.popcap.flash.games.pvz.states.playing.OptionsMenuState;
   import com.popcap.flash.games.pvz.states.playing.PanLeftState;
   import com.popcap.flash.games.pvz.states.playing.PanRightState;
   import com.popcap.flash.games.pvz.states.playing.PauseState;
   import com.popcap.flash.games.pvz.states.playing.PlayLevelState;
   import com.popcap.flash.games.pvz.states.playing.ReadySetStartState;
   import com.popcap.flash.games.pvz.states.playing.ShowAwardState;
   import com.popcap.flash.games.pvz.states.playing.SlideUIState;
   import com.popcap.flash.games.pvz.states.playing.SodRollState;
   import com.popcap.flash.games.pvz.states.playing.StartLevelState;
   import com.popcap.flash.games.pvz.states.playing.SurvivalRepickState;
   import com.popcap.flash.games.pvz.states.playing.UpsellScreenState;
   import com.popcap.flash.games.pvz.states.playing.ZombiesWonState;
   import flash.display.Loader;
   import flash.utils.describeType;
   
   public class PVZApp extends AppBase
   {
      
      public static const STATE_PAUSE_SCREEN:String = "PauseScreen";
      
      public static const STATE_RESUME_FROM_PAUSE:String = "ResumeFromPause";
      
      public static const GAMEMODE_SURVIVAL_ENDLESS_STAGE_2:int = 1;
      
      public static const STATE_SLIDE_UI:String = "SlideUI";
      
      public static const BACKGROUND_IMAGE_WIDTH:int = 945;
      
      public static const STATE_SHOWAWARD:String = "ShowAward";
      
      public static const BOARDRESULT_RESTART:int = 3;
      
      public static const STATE_SODROLL:String = "SodRoll";
      
      public static const APP_ID:String = "pvz";
      
      public static const STATE_PLAY_LEVEL:String = "PlayLevel";
      
      public static const SCENE_CREDIT:int = 6;
      
      public static const STATE_UPSELL_SCREEN:String = "UpsellScreen";
      
      public static const GAMEMODE_SURVIVAL_NORMAL_STAGE_3:int = 3;
      
      public static const GAMEMODE_SURVIVAL_NORMAL_STAGE_5:int = 5;
      
      public static const STATE_SURVIVAL_REPICK:String = "SurvivalRepick";
      
      public static const SCENE_CHALLENGE:int = 7;
      
      public static const GAMEMODE_SURVIVAL_NORMAL_STAGE_4:int = 4;
      
      public static const SCENE_PLAYING:int = 3;
      
      public static const GAMEMODE_SURVIVAL_NORMAL_STAGE_2:int = 17;
      
      public static const BOARD_OFFSET:int = 148;
      
      public static const SCENE_LOADING:int = 0;
      
      public static const STATE_LOADING:String = "Loading";
      
      public static const SCENE_MENU:int = 1;
      
      public static const STATE_ZOMBIES_WON:String = "ZombiesWon";
      
      public static const GAMEMODE_UPSELL:int = 7;
      
      public static const STATE_START_LEVEL:String = "StartLevel";
      
      public static const STATE_TITLE_SCREEN:String = "TitleScreen";
      
      public static const SCENE_LEVEL_INTRO:int = 2;
      
      public static const STATE_PAN_RIGHT:String = "PanRight";
      
      public static const BOARDRESULT_QUIT_APP:int = 5;
      
      public static const STATE_READY_SET_START:String = "ReadySetStart";
      
      public static const BOARDRESULT_LOST:int = 2;
      
      public static const STATE_CRAZY_DAVE:String = "CrazyDave";
      
      public static const STATE_OPTIONS_MENU:String = "OptionsMenu";
      
      public static const BOARDRESULT_NONE:int = 0;
      
      public static const STATE_PAN_LEFT:String = "PanLeft";
      
      public static const BOARDRESULT_WON:int = 1;
      
      public static const GAMEMODE_CHALLENGE_WALLNUT_BOWLING:int = 6;
      
      public static const STATE_LAWN_VIEW:String = "LawnView";
      
      public static const BOARDRESULT_QUIT:int = 4;
      
      public static const SCENE_CRAZY_DAVE:int = 8;
      
      public static const GAMEMODE_SCARY_POTTER_1:int = 8;
      
      public static const GAMEMODE_SCARY_POTTER_2:int = 9;
      
      public static const SCENE_AWARD:int = 5;
      
      public static const GAMEMODE_SCARY_POTTER_6:int = 13;
      
      public static const GAMEMODE_SCARY_POTTER_8:int = 15;
      
      public static const GAMEMODE_SCARY_POTTER_9:int = 16;
      
      public static const GAMEMODE_SCARY_POTTER_3:int = 10;
      
      public static const GAMEMODE_SCARY_POTTER_4:int = 11;
      
      public static const GAMEMODE_SCARY_POTTER_5:int = 12;
      
      public static const STATE_SEEDCHOOSER:String = "SeedChooser";
      
      public static const GAMEMODE_SCARY_POTTER_7:int = 14;
      
      public static const STATE_DIALOG_BOX:String = "DialogBox";
      
      public static const GAMEMODE_ADVENTURE:int = 0;
      
      public static const SCENE_ZOMBIES_WON:int = 4;
      
      public static const GAMEMODE_SCARY_POTTER_ENDLESS:int = 2;
      
      public static const STATE_MAIN_MENU:String = "MainMenu";
      
      public static const BOARDRESULT_CHEAT:int = 6;
      
      public static const STATE_LEVEL_INTRO:String = "LevelIntro";
      
      public static const STATE_CHALLENGE_SCREEN:String = "ChallengeScreen";
       
      
      public var mBoard:Board;
      
      public var mChallengeScreen:ChallengeScreen;
      
      private var mFoleyManager:FoleyManager;
      
      public var mCutsceneTime:int;
      
      public var mSurvivalFlags:int;
      
      private var mResourceLoader:Loader;
      
      private var mParticleManager:ParticleManager;
      
      public var mLevel:int;
      
      public var mSoundOn:Boolean;
      
      public var mPlacedZombies:Boolean = false;
      
      public var mMaxTime:int;
      
      public var mSeedChooserScreen:SeedChooserScreen;
      
      public var mSurvivalLocked:Boolean;
      
      public var mMusicOn:Boolean;
      
      public var mUpsellOn:Boolean;
      
      public var mGameMode:int;
      
      public var mUpsellScreen:UpsellScreen;
      
      public var mGamesPlayed:int;
      
      public var mSodTime:int;
      
      public var mMaxPlays:int;
      
      public var mTotalZombiesKilled:int = 0;
      
      public var mUpsellLink:String;
      
      private var mReanimator:Reanimator;
      
      public var mSaveObject:Object;
      
      public var mOptionsMenu:OptionsDialog;
      
      public var mPuzzleLocked:Boolean;
      
      public var mDialogBox:DialogBox;
      
      public var adAPI:MSNAdAPI;
      
      public var mMaxExecutions:int;
      
      public var mShowedCrazyDaveVasebreaker:Boolean;
      
      public var mAwardScreen:AwardScreen;
      
      public var mBoardResult:int;
      
	  public static var mPVZResources:PVZResources;
	  
      public function PVZApp()
      {
         this.mResourceLoader = new Loader();
         super(APP_ID);
      }
      
      override public function togglePause(isPaused:Boolean) : void
      {
         super.togglePause(isPaused);
         if(isPaused)
         {
            stateManager.pushState(STATE_PAUSE_SCREEN);
         }
         else
         {
            stateManager.popState();
         }
      }
      
      public function get foleyManager() : FoleyManager
      {
         return this.mFoleyManager;
      }
      
      public function GetPlayerData() : void
      {
         this.mSaveObject = getSaveData();
         if(this.mSaveObject.level != undefined)
         {
            this.mLevel = int(this.mSaveObject.level);
         }
         else
         {
            this.mSaveObject.level = 1;
            this.mLevel = 1;
         }
         if(this.mSaveObject.puzzleLocked != undefined)
         {
            this.mPuzzleLocked = Boolean(this.mSaveObject.puzzleLocked);
         }
         else
         {
            this.mSaveObject.puzzleLocked = true;
            this.mPuzzleLocked = true;
         }
         if(this.mSaveObject.survivalLocked != undefined)
         {
            this.mSurvivalLocked = Boolean(this.mSaveObject.survivalLocked);
         }
         else
         {
            this.mSaveObject.survivalLocked = true;
            this.mSurvivalLocked = true;
         }
         if(this.mSaveObject.soundOn != undefined)
         {
            this.mSoundOn = Boolean(this.mSaveObject.soundOn);
         }
         else
         {
            this.mSaveObject.soundOn = true;
            this.mSoundOn = true;
         }
         if(this.mSaveObject.musicOn != undefined)
         {
            this.mMusicOn = Boolean(this.mSaveObject.musicOn);
         }
         else
         {
            this.mSaveObject.musicOn = true;
            this.mMusicOn = true;
         }
         setSaveData(this.mSaveObject);
      }
      
      override public function init() : void
      {
         var constant:XML = null;
         var foleyName:String = null;
         var ft:FoleyType = null;
         super.init();
         this.adAPI = new MSNAdAPI(this);
         this.mReanimator = new Reanimator(this);
         this.mParticleManager = new ParticleManager(this);
         this.mFoleyManager = new FoleyManager(this);
         var foleyType:XML = describeType(PVZFoleyType);
         for each(constant in foleyType.constant)
         {
            foleyName = constant.@name;
            ft = PVZFoleyType[foleyName] as FoleyType;
            this.mFoleyManager.loadFoley(ft);
         }
         musicManager.registerMusic(PVZMusic.CEREBRAWL,PVZMusic.CEREBRAWL_FILE);
         musicManager.registerMusic(PVZMusic.CHOOSE_YOUR_SEEDS,PVZMusic.CHOOSE_YOUR_SEEDS_FILE);
         musicManager.registerMusic(PVZMusic.CONVEYOR,PVZMusic.CONVEYOR_FILE);
         musicManager.registerMusic(PVZMusic.CRAZY_DAVE,PVZMusic.CRAZY_DAVE_FILE);
         musicManager.registerMusic(PVZMusic.GRASS_WALK,PVZMusic.GRASS_WALK_FILE);
         musicManager.registerMusic(PVZMusic.LOON_BOON,PVZMusic.LOON_BOON_FILE);
         musicManager.registerMusic(PVZMusic.WINMUSIC,PVZMusic.WINMUSIC_FILE);
         musicManager.registerMusic(PVZMusic.LOSEMUSIC,PVZMusic.LOSEMUSIC_FILE);
         musicManager.registerMusic(PVZMusic.ZENGARDEN,PVZMusic.ZENGARDEN_FILE);
         musicManager.registerMusic(PVZMusic.MOONGRAINS,PVZMusic.MOONGRAINS_FILE);
      }
      
      public function IsSurvivalEndless() : Boolean
      {
         if(this.mGameMode == GAMEMODE_SURVIVAL_ENDLESS_STAGE_2)
         {
            return true;
         }
         return false;
      }
      
      public function IsAdventureMode() : Boolean
      {
         if(this.mGameMode == GAMEMODE_ADVENTURE)
         {
            return true;
         }
         return false;
      }
      
      public function get reanimator() : Reanimator
      {
         return this.mReanimator;
      }
      
      public function IsScaryPotterLevel() : Boolean
      {
         if(this.mGameMode == GAMEMODE_SCARY_POTTER_ENDLESS)
         {
            return true;
         }
         return false;
      }
      
      public function get particleManager() : ParticleManager
      {
         return this.mParticleManager;
      }
      
      override public function start() : void
      {
         this.GetPlayerData();
         stateManager.bindState(STATE_LOADING,new LoadingState(this));
         stateManager.bindState(STATE_TITLE_SCREEN,new TitleScreenState(this));
         stateManager.bindState(STATE_MAIN_MENU,new MainMenuState(this));
         stateManager.bindState(STATE_LEVEL_INTRO,new LevelIntroState(this));
         stateManager.bindState(STATE_LAWN_VIEW,new LawnViewState(this));
         stateManager.bindState(STATE_PAN_LEFT,new PanLeftState(this));
         stateManager.bindState(STATE_PAN_RIGHT,new PanRightState(this));
         stateManager.bindState(STATE_SEEDCHOOSER,new ChooseSeedsState(this));
         stateManager.bindState(STATE_READY_SET_START,new ReadySetStartState(this));
         stateManager.bindState(STATE_SLIDE_UI,new SlideUIState(this));
         stateManager.bindState(STATE_START_LEVEL,new StartLevelState(this));
         stateManager.bindState(STATE_SODROLL,new SodRollState(this));
         stateManager.bindState(STATE_SHOWAWARD,new ShowAwardState(this));
         stateManager.bindState(STATE_ZOMBIES_WON,new ZombiesWonState(this));
         stateManager.bindState(STATE_CRAZY_DAVE,new CrazyDaveState(this));
         stateManager.bindState(STATE_SURVIVAL_REPICK,new SurvivalRepickState(this));
         stateManager.bindState(STATE_OPTIONS_MENU,new OptionsMenuState(this));
         stateManager.bindState(STATE_CHALLENGE_SCREEN,new ChallengeScreenState(this));
         stateManager.bindState(STATE_DIALOG_BOX,new DialogState(this));
         stateManager.bindState(STATE_PLAY_LEVEL,new PlayLevelState(this));
         stateManager.bindState(STATE_UPSELL_SCREEN,new UpsellScreenState(this));
         stateManager.bindState(STATE_PAUSE_SCREEN,new PauseState(this));
         if(!this.mSoundOn)
         {
            soundManager.mute();
         }
         if(!this.mMusicOn)
         {
            musicManager.mute();
         }
         stateManager.changeState(STATE_LOADING);
         this.adAPI.init();
         super.start();
      }
      
      public function IsSurvivalMode() : Boolean
      {
         if(this.mGameMode == GAMEMODE_SURVIVAL_ENDLESS_STAGE_2)
         {
            return true;
         }
         return false;
      }
   }
}
