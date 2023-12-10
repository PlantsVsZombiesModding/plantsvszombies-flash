package com.popcap.flash.framework.widgets.ui
{
   import com.popcap.flash.framework.graphics.Color;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.resources.fonts.FontInst;
   import com.popcap.flash.framework.resources.images.ImageData;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.widgets.CWidget;
   import com.popcap.flash.games.pvz.renderables.StringRenderable;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   
   public class CButtonWidget extends CWidget
   {
      
      public static const BUTTON_LABEL_RIGHT:Number = 3;
      
      public static const COLOR_BKG:Number = 5;
      
      public static const BUTTON_LABEL_CENTER:Number = 2;
      
      public static const COLOR_MEDIUM_OUTLINE:Number = 4;
      
      public static const COLOR_DARK_OUTLINE:Number = 2;
      
      public static const COLOR_LABEL_HILITE:Number = 1;
      
      public static const COLOR_LABEL:Number = 0;
      
      public static const COLOR_LIGHT_OUTLINE:Number = 3;
      
      public static const BUTTON_LABEL_LEFT:Number = 1;
       
      
      private var mOverImage:ImageInst;
      
      private var mLabel:String;
      
      private var mLabelJustify:Number;
      
      private var mOverAlpha:Number;
      
      private var mDisabledRect:Rectangle;
      
      private var mInverted:Boolean;
      
      private var mBtnNoDraw:Boolean;
      
      private var mNormalRect:Rectangle;
      
      private var mDownRect:Rectangle;
      
      private var mTextImage:StringRenderable;
      
      private var mFrameNoDraw:Boolean;
      
      private var mOverAlphaFadeInSpeed:Number;
      
      private var mOverAlphaSpeed:Number;
      
      private var mDisabledImage:ImageInst;
      
      private var mUpImage:ImageInst;
      
      private var mButtonListener:IButtonListener;
      
      private var mFont:FontInst;
      
      private var mOverRect:Rectangle;
      
      private var mDownImage:ImageInst;
      
      private var mId:Number;
      
      public function CButtonWidget(id:Number, listener:IButtonListener)
      {
         super();
         this.mId = id;
         this.mFont = null;
         this.mLabelJustify = BUTTON_LABEL_CENTER;
         this.mUpImage = null;
         this.mOverImage = null;
         this.mDownImage = null;
         this.mDisabledImage = null;
         this.mInverted = false;
         this.mBtnNoDraw = false;
         this.mFrameNoDraw = false;
         this.mButtonListener = listener;
         this.mNormalRect = new Rectangle(0,0,0,0);
         this.mOverRect = new Rectangle(0,0,0,0);
         this.mDownRect = new Rectangle(0,0,0,0);
         this.mDisabledRect = new Rectangle(0,0,0,0);
         hasAlpha = true;
         this.mOverAlpha = 0;
         this.mOverAlphaSpeed = 0;
         this.mOverAlphaFadeInSpeed = 0;
         this.mTextImage = new StringRenderable();
         this.setColor(COLOR_LABEL,Color.RGB(0,0,0));
         this.setColor(COLOR_LABEL_HILITE,Color.RGB(0,0,0));
         this.setColor(COLOR_DARK_OUTLINE,Color.RGB(0,0,0));
         this.setColor(COLOR_LIGHT_OUTLINE,Color.RGB(1,1,1));
         this.setColor(COLOR_MEDIUM_OUTLINE,Color.RGB(132 / 255,132 / 255,132 / 255));
         this.setColor(COLOR_BKG,Color.RGB(212 / 255,212 / 255,212 / 255));
         doFinger = true;
      }
      
      override public function onMouseMove(x:Number, y:Number) : void
      {
         super.onMouseMove(x,y);
         this.mButtonListener.buttonMouseMove(this.mId,x,y);
      }
      
      private function drawFrameUp(g:Graphics2D) : void
      {
         g.fillRect(0,0,width,height,colors[COLOR_BKG]);
         g.fillRect(0,0,width - 1,1,colors[COLOR_LIGHT_OUTLINE]);
         g.fillRect(0,0,1,height - 1,colors[COLOR_LIGHT_OUTLINE]);
         g.fillRect(0,height - 1,width,1,colors[COLOR_DARK_OUTLINE]);
         g.fillRect(width - 1,0,1,height,colors[COLOR_DARK_OUTLINE]);
         g.fillRect(1,height - 2,width - 2,1,colors[COLOR_MEDIUM_OUTLINE]);
         g.fillRect(width - 2,1,1,height - 2,colors[COLOR_MEDIUM_OUTLINE]);
         var aColor:Color = colors[COLOR_LABEL];
         this.mTextImage.setColor(aColor.alpha,aColor.red,aColor.green,aColor.blue);
         this.mTextImage.draw(g);
      }
      
      public function set font(value:FontInst) : void
      {
         this.mFont = value;
         this.mTextImage.font = value;
         this.refreshFrameImages();
      }
      
      override public function setColor(index:int, color:Color) : void
      {
         super.setColor(index,color);
         var aColor:Color = colors[COLOR_LABEL];
         this.mTextImage.setColor(aColor.alpha,aColor.red,aColor.green,aColor.blue);
      }
      
      private function drawFrameDisabled(g:Graphics2D) : void
      {
         g.fillRect(0,0,width,height,colors[COLOR_BKG]);
         g.fillRect(0,0,width - 1,1,colors[COLOR_LIGHT_OUTLINE]);
         g.fillRect(0,0,1,height - 1,colors[COLOR_LIGHT_OUTLINE]);
         g.fillRect(0,height - 1,width,1,colors[COLOR_DARK_OUTLINE]);
         g.fillRect(width - 1,0,1,height,colors[COLOR_DARK_OUTLINE]);
         g.fillRect(1,height - 2,width - 2,1,colors[COLOR_MEDIUM_OUTLINE]);
         g.fillRect(width - 2,1,1,height - 2,colors[COLOR_MEDIUM_OUTLINE]);
         var aColor:Color = colors[COLOR_LABEL];
         this.mTextImage.setColor(aColor.alpha,aColor.red,aColor.green,aColor.blue);
         this.mTextImage.draw(g);
      }
      
      override public function resize(x:Number, y:Number, width:Number, height:Number) : void
      {
         super.resize(x,y,width,height);
         this.mTextImage.setBounds(0,0,width,height);
         this.refreshFrameImages();
      }
      
      public function isButtonDown() : Boolean
      {
         return isDown && isOver && !disabled;
      }
      
      override public function draw(g:Graphics2D) : void
      {
         if(this.mBtnNoDraw)
         {
            return;
         }
         if(width == 0 || height == 0)
         {
            return;
         }
         var down:Boolean = this.isButtonDown();
         if(this.mUpImage == null && this.mDownImage == null)
         {
            this.refreshFrameImages();
         }
         if(!isDown)
         {
            if(disabled)
            {
               g.drawImage(this.mDisabledImage,0,0);
            }
            else if(this.mOverAlpha > 0 && this.haveButtonImage(this.mOverImage,this.mOverRect))
            {
               if(this.haveButtonImage(this.mUpImage,this.mNormalRect) && this.mOverAlpha < 1)
               {
                  g.drawImage(this.mUpImage,0,0);
               }
               g.drawImage(this.mOverImage,0,0);
            }
            else if((isOver || isDown) && this.haveButtonImage(this.mOverImage,this.mOverRect))
            {
               g.drawImage(this.mOverImage,0,0);
            }
            else if(this.haveButtonImage(this.mUpImage,this.mNormalRect))
            {
               g.drawImage(this.mUpImage,0,0);
            }
         }
         else if(this.haveButtonImage(this.mDownImage,this.mDownRect))
         {
            g.drawImage(this.mDownImage,0,0);
         }
         else if(this.haveButtonImage(this.mOverImage,this.mOverRect))
         {
            g.drawImage(this.mOverImage,0,0);
         }
         else
         {
            g.drawImage(this.mUpImage,0,0);
         }
      }
      
      private function haveButtonImage(image:ImageInst, rect:Rectangle) : Boolean
      {
         return image != null || rect.width != 0;
      }
      
      private function drawFrameDown(g:Graphics2D) : void
      {
         g.fillRect(0,0,width,height,colors[COLOR_BKG]);
         g.fillRect(0,0,width - 1,1,colors[COLOR_DARK_OUTLINE]);
         g.fillRect(0,0,1,height - 1,colors[COLOR_DARK_OUTLINE]);
         g.fillRect(0,height - 1,width,1,colors[COLOR_LIGHT_OUTLINE]);
         g.fillRect(width - 1,0,1,height,colors[COLOR_LIGHT_OUTLINE]);
         g.fillRect(1,1,width - 3,1,colors[COLOR_MEDIUM_OUTLINE]);
         g.fillRect(1,1,1,height - 3,colors[COLOR_MEDIUM_OUTLINE]);
         g.translate(1,1);
         var aColor:Color = colors[COLOR_LABEL_HILITE];
         this.mTextImage.setColor(aColor.alpha,aColor.red,aColor.green,aColor.blue);
         this.mTextImage.draw(g);
      }
      
      public function get font() : FontInst
      {
         return this.mFont;
      }
      
      override public function onMouseDown(x:Number, y:Number) : void
      {
         super.onMouseDown(x,y);
         this.mButtonListener.buttonPress(this.mId);
         markDirty();
      }
      
      override public function onMouseUp(x:Number, y:Number) : void
      {
         super.onMouseUp(x,y);
         if(isOver && widgetManager.hasFocus)
         {
            this.mButtonListener.buttonRelease(this.mId);
         }
         markDirty();
      }
      
      override public function onMouseLeave() : void
      {
         super.onMouseLeave();
         if(this.mOverAlphaSpeed == 0 && this.mOverAlpha > 0)
         {
            this.mOverAlpha = 0;
         }
         else if(this.mOverAlphaSpeed > 0 && this.mOverAlpha == 0)
         {
            this.mOverAlpha = 1;
         }
         if(isDown || this.haveButtonImage(this.mOverImage,this.mOverRect) || colors[COLOR_LABEL_HILITE] != colors[COLOR_LABEL])
         {
            markDirty();
         }
         this.mButtonListener.buttonMouseLeave(this.mId);
      }
      
      override public function update() : void
      {
         super.update();
         markDirty();
         if(isDown && isOver)
         {
            this.mButtonListener.buttonDownTick(this.mId);
         }
         if(!isDown && !isOver && this.mOverAlpha > 0)
         {
            if(this.mOverAlphaSpeed > 0)
            {
               this.mOverAlpha -= this.mOverAlphaSpeed;
               if(this.mOverAlpha < 0)
               {
                  this.mOverAlpha = 0;
               }
            }
            else
            {
               this.mOverAlpha = 0;
            }
            markDirty();
         }
         else if(isOver && this.mOverAlphaFadeInSpeed > 0 && this.mOverAlpha < 1)
         {
            this.mOverAlpha += this.mOverAlphaFadeInSpeed;
            if(this.mOverAlpha > 1)
            {
               this.mOverAlpha = 1;
            }
            markDirty();
         }
      }
      
      public function set label(value:String) : void
      {
         this.mLabel = value;
         this.mTextImage.text = value;
         this.refreshFrameImages();
      }
      
      private function refreshFrameImages() : void
      {
         if(width == 0 || height == 0)
         {
            return;
         }
         this.mUpImage = new ImageInst(new ImageData(new BitmapData(width,height,true,0)));
         var gUp:Graphics2D = new Graphics2D(this.mUpImage.pixels);
         this.drawFrameUp(gUp);
         this.mOverImage = new ImageInst(new ImageData(new BitmapData(width,height,true,0)));
         var gOver:Graphics2D = new Graphics2D(this.mOverImage.pixels);
         this.drawFrameOver(gOver);
         this.mDownImage = new ImageInst(new ImageData(new BitmapData(width,height,true,0)));
         var gDown:Graphics2D = new Graphics2D(this.mDownImage.pixels);
         this.drawFrameDown(gDown);
         this.mDisabledImage = new ImageInst(new ImageData(new BitmapData(width,height,true,0)));
         var gDisabled:Graphics2D = new Graphics2D(this.mDisabledImage.pixels);
         this.drawFrameDisabled(gDisabled);
      }
      
      override public function setColors(theColors:Array) : void
      {
         super.setColors(theColors);
         var aColor:Color = colors[COLOR_LABEL];
         this.mTextImage.setColor(aColor.alpha,aColor.red,aColor.green,aColor.blue);
      }
      
      public function get label() : String
      {
         return this.mLabel;
      }
      
      override public function onMouseEnter() : void
      {
         super.onMouseEnter();
         if(this.mOverAlphaFadeInSpeed == 0 && this.mOverAlpha > 0)
         {
            this.mOverAlpha = 0;
         }
         if(isDown || this.haveButtonImage(this.mOverImage,this.mOverRect) || colors[COLOR_LABEL_HILITE] != colors[COLOR_LABEL])
         {
            markDirty();
         }
         var aColor:Color = colors[COLOR_LABEL_HILITE];
         this.mTextImage.setColor(aColor.alpha,aColor.red,aColor.green,aColor.blue);
         this.mButtonListener.buttonMouseEnter(this.mId);
      }
      
      private function drawFrameOver(g:Graphics2D) : void
      {
         g.fillRect(0,0,width,height,colors[COLOR_BKG]);
         g.fillRect(0,0,width - 1,1,colors[COLOR_LIGHT_OUTLINE]);
         g.fillRect(0,0,1,height - 1,colors[COLOR_LIGHT_OUTLINE]);
         g.fillRect(0,height - 1,width,1,colors[COLOR_DARK_OUTLINE]);
         g.fillRect(width - 1,0,1,height,colors[COLOR_DARK_OUTLINE]);
         g.fillRect(1,height - 2,width - 2,1,colors[COLOR_MEDIUM_OUTLINE]);
         g.fillRect(width - 2,1,1,height - 2,colors[COLOR_MEDIUM_OUTLINE]);
         var aColor:Color = colors[COLOR_LABEL_HILITE];
         this.mTextImage.setColor(aColor.alpha,aColor.red,aColor.green,aColor.blue);
         this.mTextImage.draw(g);
      }
      
      override public function setDisabled(isDisabled:Boolean) : void
      {
         super.setDisabled(isDisabled);
         if(this.haveButtonImage(this.mDisabledImage,this.mDisabledRect))
         {
            markDirty();
         }
      }
   }
}
