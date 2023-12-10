package com.popcap.flash.games.pvz.logic
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.resources.fonts.FontInst;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.utils.Utils;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.PVZFoleyType;
   import com.popcap.flash.games.pvz.resources.PVZFonts;
   import flash.geom.Rectangle;
   
   public class WaveWarning
   {
      
      private static const FINAL_WAVE_GREEN:Number = 50 / 255;
      
      private static const FINAL_FADE_OUT_TIME:Number = 12;
      
      private static const HUGE_WAVE_BLUE:Number = 9 / 255;
      
      private static const HUGE_FADE_OUT_TIME:Number = 12;
      
      private static const FINAL_WAVE_BLUE:Number = 50 / 255;
      
      private static const HUGE_WAVE_GREEN:Number = 9 / 255;
      
      private static const FINAL_FADE_IN_TIME:Number = 50;
      
      private static const HUGE_FADE_IN_TIME:Number = 18;
      
      private static const FINAL_WAVE_RED:Number = 1;
      
      private static const HUGE_WAVE_RED:Number = 246 / 255;
       
      
      private var mFinalWaveTimer:Number = 0;
      
      private var mHugeWaveDuration:Number = 0;
      
      private var mFinalWaveScale:Number = 1;
      
      private var mHugeWaveAlpha:Number = 1;
      
      private var mScreenBounds:Rectangle;
      
      private var mFinalWaveDuration:Number = 0;
      
      private var mFinalWaveAlpha:Number = 1;
      
      private var mHugeWaveText:ImageInst;
      
      private var mHugeWaveBounds:Rectangle;
      
      private var mFinalWaveText:ImageInst;
      
      private var mHugeWaveTimer:Number = 0;
      
      private var mHugeWaveScale:Number = 1;
      
      private var mApp:PVZApp;
      
      private var mFinalWaveBounds:Rectangle;
      
      public function WaveWarning(app:PVZApp)
      {
         this.mHugeWaveBounds = new Rectangle();
         this.mFinalWaveBounds = new Rectangle();
         this.mScreenBounds = new Rectangle(0,0,540,405);
         super();
         this.mApp = app;
         var hugeWaveString:String = this.mApp.stringManager.translateString("[ADVICE_HUGE_WAVE]");
         var finalWaveString:String = this.mApp.stringManager.translateString("[ADVICE_FINAL_WAVE]");
         var waveFont:FontInst = this.mApp.fontManager.getFontInst(PVZFonts.FONT_HOUSEOFTERROR28);
         this.mHugeWaveText = Utils.createStringImage(hugeWaveString,waveFont,this.mScreenBounds,Utils.JUSTIFY_CENTER);
         this.mHugeWaveText.useColor = true;
         this.mFinalWaveText = Utils.createStringImage(finalWaveString,waveFont,this.mScreenBounds,Utils.JUSTIFY_CENTER);
         this.mFinalWaveText.useColor = true;
      }
      
      public function draw(g:Graphics2D) : void
      {
         if(this.mHugeWaveTimer > 0)
         {
            this.mHugeWaveBounds.x = this.mHugeWaveText.x;
            this.mHugeWaveBounds.y = this.mHugeWaveText.y;
            this.mHugeWaveBounds.width = this.mHugeWaveText.width * this.mHugeWaveScale;
            this.mHugeWaveBounds.height = this.mHugeWaveText.height * this.mHugeWaveScale;
            this.mHugeWaveText.setColor(this.mHugeWaveAlpha,HUGE_WAVE_RED,HUGE_WAVE_GREEN,HUGE_WAVE_BLUE);
            Utils.align(this.mHugeWaveBounds,this.mScreenBounds,Utils.ALIGN_CENTER,Utils.ALIGN_CENTER);
            g.pushState();
            g.scale(this.mHugeWaveScale,this.mHugeWaveScale);
            g.drawImage(this.mHugeWaveText,this.mHugeWaveBounds.x,this.mHugeWaveBounds.y);
            g.popState();
         }
         if(this.mFinalWaveTimer > 0)
         {
            this.mFinalWaveBounds.x = this.mFinalWaveText.x;
            this.mFinalWaveBounds.y = this.mFinalWaveText.y;
            this.mFinalWaveBounds.width = this.mFinalWaveText.width * this.mFinalWaveScale;
            this.mFinalWaveBounds.height = this.mFinalWaveText.height * this.mFinalWaveScale;
            Utils.align(this.mFinalWaveBounds,this.mScreenBounds,Utils.ALIGN_CENTER,Utils.ALIGN_CENTER);
            this.mFinalWaveText.setColor(this.mFinalWaveAlpha,FINAL_WAVE_RED,FINAL_WAVE_GREEN,FINAL_WAVE_BLUE);
            g.pushState();
            g.scale(this.mFinalWaveScale,this.mFinalWaveScale);
            g.drawImage(this.mFinalWaveText,this.mFinalWaveBounds.x,this.mFinalWaveBounds.y);
            g.popState();
         }
      }
      
      public function update() : void
      {
         var range:Number = 0;
         var lower:Number = 0;
         var diff:Number = 0;
         if(this.mHugeWaveTimer == this.mHugeWaveDuration - HUGE_FADE_IN_TIME)
         {
            this.mApp.foleyManager.playFoley(PVZFoleyType.HUGEWAVE);
         }
         if(this.mHugeWaveTimer > this.mHugeWaveDuration - HUGE_FADE_IN_TIME)
         {
            lower = this.mHugeWaveDuration - HUGE_FADE_IN_TIME;
            range = this.mHugeWaveDuration - lower;
            diff = this.mHugeWaveTimer - lower;
            this.mHugeWaveAlpha = 1 - diff / range;
            this.mHugeWaveScale = 2.9 * (diff / range) + 1;
         }
         else if(this.mHugeWaveTimer > this.mHugeWaveDuration - HUGE_FADE_OUT_TIME)
         {
            this.mHugeWaveAlpha = 1;
            this.mHugeWaveScale = 1;
         }
         else
         {
            lower = 0;
            range = HUGE_FADE_OUT_TIME;
            diff = this.mHugeWaveTimer;
            this.mHugeWaveAlpha = diff / range;
            this.mHugeWaveScale = 1;
         }
         if(this.mHugeWaveTimer > 0)
         {
            --this.mHugeWaveTimer;
         }
         if(this.mFinalWaveTimer == this.mFinalWaveDuration - FINAL_FADE_IN_TIME)
         {
            this.mApp.foleyManager.playFoley(PVZFoleyType.FINALWAVE);
         }
         if(this.mFinalWaveTimer > this.mFinalWaveDuration - FINAL_FADE_IN_TIME)
         {
            lower = this.mFinalWaveDuration - FINAL_FADE_IN_TIME;
            range = this.mFinalWaveDuration - lower;
            diff = this.mFinalWaveTimer - lower;
            this.mFinalWaveAlpha = 1 - diff / range;
            this.mFinalWaveScale = 2.9 * (diff / range) + 1;
         }
         else if(this.mFinalWaveTimer > this.mFinalWaveDuration - FINAL_FADE_OUT_TIME)
         {
            this.mFinalWaveAlpha = 1;
            this.mFinalWaveScale = 1;
         }
         else
         {
            lower = 0;
            range = FINAL_FADE_OUT_TIME;
            diff = this.mFinalWaveTimer;
            this.mFinalWaveAlpha = diff / range;
            this.mFinalWaveScale = 1;
         }
         if(this.mFinalWaveTimer > 0)
         {
            --this.mFinalWaveTimer;
         }
      }
      
      public function showFinalWave(duration:int) : void
      {
         this.mFinalWaveDuration = duration;
         this.mFinalWaveTimer = duration;
      }
      
      public function showHugeWave(duration:int) : void
      {
         this.mHugeWaveDuration = duration;
         this.mHugeWaveTimer = duration;
      }
   }
}
