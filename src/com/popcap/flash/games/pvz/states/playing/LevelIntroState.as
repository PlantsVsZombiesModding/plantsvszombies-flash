package com.popcap.flash.games.pvz.states.playing
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.states.IState;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.PVZMusic;
   import com.popcap.flash.games.pvz.logic.Board;
   import com.popcap.flash.games.pvz.logic.TodCommon;
   import com.popcap.flash.games.pvz.logic.WeightedGridArray;
   import com.popcap.flash.games.pvz.logic.Zombies.Zombie;
   import com.popcap.flash.games.pvz.renderables.ZombieRenderable;
   
   public class LevelIntroState implements IState
   {
      
      public static var TimeRollSodStart:int = 7500;
      
      public static var TimeRollSodEnd:int = TimeRollSodStart + 2000;
       
      
      private var app:PVZApp;
      
      private var boardImg:ImageInst;
      
      public function LevelIntroState(app:PVZApp)
      {
         super();
         this.app = app;
      }
      
      public function onEnter() : void
      {
         this.app.widgetManager.removeAllWidgets();
         if(this.app.mBoard != null)
         {
            this.app.widgetManager.removeWidget(this.app.mBoard);
            this.app.mBoard = null;
         }
         this.app.mBoard = new Board(this.app);
         this.app.widgetManager.addWidget(this.app.mBoard);
         this.app.widgetManager.setFocus(this.app.mBoard);
         this.app.widgetManager.addWidget(this.app.mBoard.mMenuButton);
         this.app.mBoard.mMenuButton.setVisible(false);
         this.app.mBoard.mSeedBank.mVisible = false;
         this.app.mBoard.mToolTip.mVisible = false;
         this.app.mBoard.mGameScene = PVZApp.SCENE_LEVEL_INTRO;
         this.app.mBoard.initLevel();
         this.app.mCutsceneTime = 0;
         var aHasSod:Boolean = false;
         if(this.app.IsAdventureMode())
         {
            if(this.app.mBoard.mLevel == 1 || this.app.mBoard.mLevel == 2 || this.app.mBoard.mLevel == 4)
            {
               aHasSod = true;
            }
         }
         if(aHasSod)
         {
            this.app.mSodTime = TimeRollSodEnd - TimeRollSodStart;
            this.app.mBoard.mSodPosition = 0;
         }
         else
         {
            this.app.mSodTime = 0;
            this.app.mBoard.mSodPosition = 1000;
         }
         this.app.mBoard.PlaceStreetZombies();
         if(this.app.mBoard.IsWallnutBowlingLevel())
         {
            this.app.musicManager.playMusic(PVZMusic.CRAZY_DAVE,true,50);
            this.app.stateManager.changeState(PVZApp.STATE_CRAZY_DAVE);
         }
         else if(this.app.IsScaryPotterLevel())
         {
            this.app.mBoard.mSeedBank.Move(0,-78);
            if(this.app.mShowedCrazyDaveVasebreaker)
            {
               this.app.musicManager.playMusic(PVZMusic.CEREBRAWL,true,50);
               this.app.stateManager.changeState(PVZApp.STATE_START_LEVEL);
            }
            else
            {
               this.app.mShowedCrazyDaveVasebreaker = true;
               this.app.musicManager.playMusic(PVZMusic.CRAZY_DAVE,true,50);
               this.app.stateManager.changeState(PVZApp.STATE_CRAZY_DAVE);
            }
         }
         else if(this.app.IsAdventureMode() && this.app.mLevel == 11)
         {
            this.app.musicManager.playMusic(PVZMusic.CRAZY_DAVE,true,50);
            this.app.stateManager.changeState(PVZApp.STATE_CRAZY_DAVE);
         }
         else
         {
            this.app.musicManager.playMusic(PVZMusic.CHOOSE_YOUR_SEEDS,true,50);
            this.app.stateManager.changeState(PVZApp.STATE_PAN_RIGHT);
         }
      }
      
      public function PlaceStreetZombies() : void
      {
         var aZombieType:int = 0;
         var aGridY:int = 0;
         var aZombieArray:Array = null;
         var aNumToShow:int = 0;
         var aZombieIndex:int = 0;
         if(this.app.mPlacedZombies)
         {
            return;
         }
         this.app.mPlacedZombies = true;
         var aTotalZombieCount:int = 0;
         var aZombieTypeCount:Array = new Array();
         var aZombieValueTotal:int = 0;
         for(var i:int = 0; i < 8; i++)
         {
            aZombieTypeCount[i] = 0;
         }
         for(var aWaveIndex:int = 0; aWaveIndex < this.app.mBoard.mNumWaves; aWaveIndex++)
         {
            for(i = 0; i < Board.MAX_ZOMBIES_IN_WAVE; i++)
            {
               aZombieType = int(this.app.mBoard.mZombiesInWave[aWaveIndex][i]);
               if(aZombieType == Board.ZOMBIE_INVALID)
               {
                  break;
               }
               aZombieValueTotal += this.app.mBoard.GetZombieDefinition(aZombieType).mZombieValue;
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
         var aApproxNumberToShow:int = 10;
         for(aZombieType = 0; aZombieType < 7; aZombieType++)
         {
            if(aZombieTypeCount[aZombieType] != 0)
            {
               aNumToShow = aZombieTypeCount[aZombieType] * aApproxNumberToShow / aTotalZombieCount;
               aNumToShow = TodCommon.ClampInt(aNumToShow,1,aZombieTypeCount[aZombieType]);
               for(aZombieIndex = 0; aZombieIndex < aNumToShow; aZombieIndex++)
               {
                  this.FindAndPlaceZombie(int(aZombieType),aZombieGrid);
               }
            }
         }
      }
      
      public function draw(g:Graphics2D) : void
      {
         this.app.widgetManager.drawScreen(g);
      }
      
      public function PlaceAZombie(theZombieType:int, theGridX:int, theGridY:int) : void
      {
         var aZombie:Zombie = new Zombie();
         var aVariant:Boolean = false;
         if(Math.random() * 5 == 0)
         {
            aVariant = true;
         }
         aZombie.ZombieInitialize(0,theZombieType,aVariant,null,-2,this.app,this.app.mBoard);
         this.app.mBoard.mZombies.push(aZombie);
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
         this.app.mBoard.mRenderManager.add(new ZombieRenderable(aZombie,Board.RENDER_LAYER_ZOMBIE + aZombie.mPosY));
      }
      
      public function onPush() : void
      {
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
      
      public function FindAndPlaceZombie(theZombieType:int, theZombieGrid:Array) : void
      {
         var aGridX:int = 0;
         var aGridY:int = 0;
         this.FindPlaceForStreetZombies(theZombieType,theZombieGrid,aGridX,aGridY);
      }
      
      public function update() : void
      {
         this.app.widgetManager.updateFrame();
         if(this.app.resourceManager.isLoading())
         {
            return;
         }
      }
      
      public function onPop() : void
      {
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
                  aPicks.push(aWeightedGridArray);
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
      
      public function onExit() : void
      {
         this.app.mPlacedZombies = false;
      }
   }
}
