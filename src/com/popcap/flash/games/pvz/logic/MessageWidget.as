package com.popcap.flash.games.pvz.logic
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.resources.fonts.FontInst;
   import com.popcap.flash.framework.resources.images.ImageData;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.resources.reanimator.Reanimation;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.renderables.ImageRenderable;
   import com.popcap.flash.games.pvz.renderables.StringRenderable;
   import com.popcap.flash.games.pvz.resources.PVZFonts;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   
   public class MessageWidget
   {
      
      public static const MESSAGE_STYLE_HINT_TALL_UNLOCKMESSAGE:int = 9;
      
      public static const MESSAGE_STYLE_TUTORIAL_LATER_STAY:int = 4;
      
      public static const MESSAGE_STYLE_TUTORIAL_LEVEL1:int = 0;
      
      public static const MESSAGE_STYLE_TUTORIAL_LEVEL2:int = 2;
      
      public static const MESSAGE_STYLE_HINT_STAY:int = 7;
      
      public static const MESSAGE_STYLE_TUTORIAL_LATER:int = 3;
      
      public static const MESSAGE_STYLE_HINT_FAST:int = 6;
      
      public static const MESSAGE_STYLE_OFF:int = -1;
      
      public static const MESSAGE_STYLE_BIG_MIDDLE:int = 11;
      
      public static const MESSAGE_STYLE_HUGE_WAVE:int = 14;
      
      public static const MESSAGE_STYLE_BIG_MIDDLE_FAST:int = 12;
      
      public static const MIN_MESSAGE_TIME:int = 100;
      
      public static const MESSAGE_STYLE_HINT_TALL_LONG:int = 10;
      
      public static const MESSAGE_STYLE_HINT_LONG:int = 5;
      
      public static const MESSAGE_STYLE_TUTORIAL_LEVEL1_STAY:int = 1;
      
      public static const SLIDE_OFF_TIME:int = 100;
      
      public static const MESSAGE_STYLE_HOUSE_NAME:int = 13;
      
      public static const MESSAGE_STYLE_HINT_TALL_FAST:int = 8;
       
      
      public var mLabel:String;
      
      public var mDisplayTime:int;
      
      public var mMessageStyleNext:int;
      
      public var mReanim:Reanimation;
      
      public var mLabelNext:String;
      
      public var app:PVZApp;
      
      public var mFont:FontInst;
      
      public var mBounds:Rectangle;
      
      public var mDuration:int;
      
      public var mBoxRenderable:ImageRenderable;
      
      public var mMessageStyle:int;
      
      public var mBoard:Board;
      
      public var mText:StringRenderable;
      
      public var mSupplementalText:StringRenderable;
      
      public var mSlideOffTime:int;
      
      public function MessageWidget(app:PVZApp, theBoard:Board)
      {
         super();
         this.app = app;
         this.mBoard = theBoard;
         this.mDuration = 0;
         this.mLabel = null;
         this.mMessageStyle = MESSAGE_STYLE_OFF;
         this.mLabelNext = null;
         this.mMessageStyleNext = MESSAGE_STYLE_OFF;
         this.mSlideOffTime = SLIDE_OFF_TIME;
         this.mFont = app.fontManager.getFontInst(PVZFonts.FONT_HOUSEOFTERROR28);
         this.mFont.setColor(1,1,1,1);
         this.mFont.scale = 0.8;
         this.mText = new StringRenderable(Board.RENDER_LAYER_ABOVE_UI + 1);
         this.mText.setBounds(0,0,1,1);
         this.mText.font = this.mFont;
         this.mText.text = " ";
         this.mText.x = 0;
         this.mText.y = 0;
         this.mSupplementalText = new StringRenderable(Board.RENDER_LAYER_ABOVE_UI + 1);
         this.mSupplementalText.setBounds(0,0,1,1);
         this.mSupplementalText.font = app.fontManager.getFontInst(PVZFonts.FONT_HOUSEOFTERROR16);
         this.mSupplementalText.text = "";
         this.mSupplementalText.x = 0;
         this.mSupplementalText.y = 0;
         this.mBoard.mRenderManager.add(this.mText);
         this.mBoard.mRenderManager.add(this.mSupplementalText);
         var anImage:ImageInst = this.MakeGreyBox(100);
         anImage.x = 0;
         anImage.y = 270;
         this.mBoxRenderable = new ImageRenderable(anImage,Board.RENDER_LAYER_ABOVE_UI);
         this.mBoard.mRenderManager.add(this.mBoxRenderable);
      }
      
      public function MakeGreyBox(height:int) : ImageInst
      {
         var h:int = height;
         var w:int = 540;
         var aBufferedImage:ImageInst = new ImageInst(new ImageData(new BitmapData(w,h,true,0)));
         var bufferG:Graphics2D = aBufferedImage.graphics;
         bufferG.fillRect(0,0,w,h,2281701376);
         return aBufferedImage;
      }
      
      public function SetLabel(newLabel:String, newStyle:int) : void
      {
         var anImage:ImageInst = null;
         this.mText.text = "";
         this.mSupplementalText.text = "";
         if(this.mText.getIsDisposable())
         {
            this.mBoard.mRenderManager.add(this.mText);
         }
         if(this.mSupplementalText.getIsDisposable())
         {
            this.mBoard.mRenderManager.add(this.mSupplementalText);
         }
         if(newLabel.length >= 3 && newLabel.charAt(0) == "[")
         {
            this.mLabel = this.app.stringManager.translateString(newLabel);
         }
         else
         {
            this.mLabel = newLabel;
         }
         this.mMessageStyle = newStyle;
         switch(this.mMessageStyle)
         {
            case MESSAGE_STYLE_HINT_LONG:
            case MESSAGE_STYLE_BIG_MIDDLE:
            case MESSAGE_STYLE_HINT_TALL_LONG:
               this.mDuration = 1500;
               break;
            case MESSAGE_STYLE_HINT_TALL_UNLOCKMESSAGE:
               this.mDuration = 500;
               break;
            case MESSAGE_STYLE_HINT_FAST:
            case MESSAGE_STYLE_HINT_TALL_FAST:
            case MESSAGE_STYLE_BIG_MIDDLE_FAST:
            case MESSAGE_STYLE_TUTORIAL_LEVEL1:
            case MESSAGE_STYLE_TUTORIAL_LEVEL2:
            case MESSAGE_STYLE_TUTORIAL_LATER:
               this.mDuration = 500;
               break;
            case MESSAGE_STYLE_HINT_STAY:
            case MESSAGE_STYLE_TUTORIAL_LEVEL1_STAY:
            case MESSAGE_STYLE_TUTORIAL_LATER_STAY:
               this.mDuration = 10000;
               break;
            case MESSAGE_STYLE_HOUSE_NAME:
               this.mDuration = 250;
               break;
            case MESSAGE_STYLE_HUGE_WAVE:
               this.mDuration = 750;
         }
         this.mDisplayTime = this.mDuration;
         this.mBounds = new Rectangle(0,0,540,405);
         switch(this.mMessageStyle)
         {
            case MESSAGE_STYLE_BIG_MIDDLE:
               this.mBounds.y = 170;
               this.mBounds.height = 100;
               this.mFont.scale = 0.8;
               this.mText.justification = StringRenderable.JUSTIFY_CENTER;
               break;
            case MESSAGE_STYLE_TUTORIAL_LEVEL1:
            case MESSAGE_STYLE_TUTORIAL_LEVEL1_STAY:
            case MESSAGE_STYLE_TUTORIAL_LEVEL2:
            case MESSAGE_STYLE_TUTORIAL_LATER:
            case MESSAGE_STYLE_TUTORIAL_LATER_STAY:
               this.mBounds.y = 270;
               this.mBounds.height = 100;
               this.mFont.scale = 0.8;
               this.mText.justification = StringRenderable.JUSTIFY_CENTER;
               break;
            case MESSAGE_STYLE_HINT_STAY:
            case MESSAGE_STYLE_HINT_FAST:
               this.mBounds.y = 350;
               this.mBounds.height = 50;
               this.mFont.scale = 0.8;
               this.mText.justification = StringRenderable.JUSTIFY_CENTER;
               break;
            case MESSAGE_STYLE_HOUSE_NAME:
               this.mBounds.y = 300;
               this.mBounds.height = 55;
               this.mFont.scale = 0.8;
               break;
            case MESSAGE_STYLE_HUGE_WAVE:
               this.mBounds.x = 0;
               this.mBounds.width = 540;
               this.mFont.scale = 0.8;
               this.mText.justification = StringRenderable.JUSTIFY_CENTER;
         }
         var aGreyBoxHeight:int = 0;
         switch(this.mMessageStyle)
         {
            case MESSAGE_STYLE_TUTORIAL_LEVEL1:
            case MESSAGE_STYLE_TUTORIAL_LEVEL1_STAY:
            case MESSAGE_STYLE_TUTORIAL_LEVEL2:
            case MESSAGE_STYLE_TUTORIAL_LATER:
            case MESSAGE_STYLE_TUTORIAL_LATER_STAY:
            case MESSAGE_STYLE_BIG_MIDDLE:
               aGreyBoxHeight = 100;
               break;
            case MESSAGE_STYLE_HINT_STAY:
            case MESSAGE_STYLE_HINT_FAST:
               aGreyBoxHeight = 50;
         }
         if(aGreyBoxHeight > 0 && this.mBoxRenderable.getIsDisposable())
         {
            anImage = this.MakeGreyBox(aGreyBoxHeight);
            anImage.x = 0;
            anImage.y = this.mBounds.y;
            this.mBoxRenderable.dead = false;
            this.mBoxRenderable = new ImageRenderable(anImage,Board.RENDER_LAYER_ABOVE_UI);
            this.mBoard.mRenderManager.add(this.mBoxRenderable);
         }
         else if(aGreyBoxHeight == 0)
         {
            this.mBoxRenderable.dead = true;
         }
         this.mText.setBounds(this.mBounds.x,this.mBounds.y,this.mBounds.width,this.mBounds.height);
         this.mSupplementalText.setBounds(this.mBounds.x,this.mBounds.y + 40,540,40);
         this.mSupplementalText.dead = false;
         this.mSupplementalText.font = this.app.fontManager.getFontInst(PVZFonts.FONT_HOUSEOFTERROR16);
         this.mText.dead = false;
         this.mText.font = this.mFont;
         this.mText.text = this.mLabel;
      }
      
      public function ClearLabel() : void
      {
         this.mDuration = 0;
         this.mText.text = "";
         this.mText.dead = true;
         this.mSupplementalText.text = "";
         this.mSupplementalText.dead = true;
         this.mBoxRenderable.dead = true;
      }
      
      public function Update() : void
      {
         if(!this.mBoard || this.mBoard.mPaused)
         {
            return;
         }
         if(this.mDuration > 0 && this.mDuration < 10000)
         {
            --this.mDuration;
            if(this.mDuration == 0)
            {
               this.mMessageStyle = MESSAGE_STYLE_OFF;
               if(this.mMessageStyleNext != MESSAGE_STYLE_OFF)
               {
                  this.SetLabel(this.mLabelNext,this.mMessageStyleNext);
                  this.mMessageStyleNext = MESSAGE_STYLE_OFF;
               }
            }
         }
      }
      
      public function Draw(g:Graphics2D) : void
      {
         var aColor:Number = NaN;
         var aFontSize:Number = NaN;
         var aSubStr:String = null;
         var aNumWavesPerFlag:int = 0;
         var aFlags:int = 0;
         var aFlagStr:String = null;
         if(this.mDuration <= 0)
         {
            this.mText.dead = true;
            this.mSupplementalText.dead = true;
            this.mBoxRenderable.dead = true;
            return;
         }
         if(this.mMessageStyle == MESSAGE_STYLE_HINT_STAY || this.mMessageStyle == MESSAGE_STYLE_HINT_FAST)
         {
            this.mSupplementalText.dead = true;
         }
         if(this.mMessageStyle == MESSAGE_STYLE_HOUSE_NAME || this.mMessageStyle == MESSAGE_STYLE_HUGE_WAVE)
         {
         }
         var aFlashing:int = 255;
         var aFadeOut:Boolean = false;
         var aGreyBoxHeight:int = 0;
         var aTextOffsetY:int = 0;
         if(this.mMessageStyle == MESSAGE_STYLE_HOUSE_NAME && this.mBoard.mGameScene == Board.SCENE_LEVEL_INTRO)
         {
            this.mBounds.x = 25 - this.mBoard.x;
            this.mText.setBounds(this.mBounds.x,this.mBounds.y,this.mBounds.width,this.mBounds.height);
            this.mSupplementalText.setBounds(this.mBounds.x,this.mBounds.y + 40,540,40);
         }
         switch(this.mMessageStyle)
         {
            case MESSAGE_STYLE_TUTORIAL_LEVEL1:
            case MESSAGE_STYLE_TUTORIAL_LEVEL1_STAY:
            case MESSAGE_STYLE_TUTORIAL_LEVEL2:
            case MESSAGE_STYLE_TUTORIAL_LATER:
            case MESSAGE_STYLE_TUTORIAL_LATER_STAY:
               aGreyBoxHeight = 100;
               aFlashing = 192;
               aColor = TodCommon.TodAnimateCurve(75,0,this.mBoard.mMainCounter % 75,aFlashing,255,TodCommon.CURVE_BOUNCE_SLOW_MIDDLE);
               this.mText.setColor(aColor / 255,253 / 255,245 / 255,123 / 255);
               break;
            case MESSAGE_STYLE_HINT_STAY:
            case MESSAGE_STYLE_HINT_FAST:
               aGreyBoxHeight = 50;
               this.mText.setColor(1,1,1,1);
               break;
            case MESSAGE_STYLE_HOUSE_NAME:
               aColor = TodCommon.ClampInt(this.mDuration * 15,0,255);
               this.mText.setColor(aColor / 255,1,1,1);
               break;
            case MESSAGE_STYLE_HUGE_WAVE:
               aFontSize = TodCommon.TodAnimateCurveFloat(0,750,this.mDuration,0,30,TodCommon.CURVE_EASE_IN);
               if(aFontSize <= 1)
               {
                  aFontSize = 1;
               }
               this.mText.setColor(1,1,0,0);
         }
         if(this.mMessageStyle == MESSAGE_STYLE_HOUSE_NAME)
         {
            aSubStr = "";
            if(this.app.IsSurvivalMode() && this.mBoard.mChallenge.mSurvivalStage > 0)
            {
               aNumWavesPerFlag = this.mBoard.GetNumWavesPerFlag();
               aFlags = this.mBoard.mChallenge.mSurvivalStage * this.mBoard.GetNumWavesPerSurvivalStage() / aNumWavesPerFlag;
               aFlagStr = this.mBoard.Pluralize(aFlags,"[ONE_FLAG]","[COUNT_FLAGS]");
               aSubStr = this.app.stringManager.translateString("[FLAGS_COMPLETED]").replace("{FLAGS}",aFlagStr);
            }
            if(aSubStr.length > 0)
            {
               this.mSupplementalText.text = aSubStr;
               this.mSupplementalText.setColor(aColor / 255,224 / 255,187 / 255,98 / 255);
            }
         }
         else
         {
            this.mSupplementalText.text = "";
         }
      }
   }
}
