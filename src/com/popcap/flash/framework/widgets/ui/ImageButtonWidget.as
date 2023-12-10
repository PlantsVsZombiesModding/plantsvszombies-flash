package com.popcap.flash.framework.widgets.ui
{
   import com.popcap.flash.framework.graphics.Color;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.widgets.CWidget;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ImageButtonWidget extends CWidget
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
       
      
      private var mOverAlphaFadeInSpeed:Number;
      
      private var mDisabledRect:Rectangle;
      
      private var mOverAlphaSpeed:Number;
      
      public var mDisabledImage:ImageInst;
      
      public var mUpImage:ImageInst;
      
      public var mOverOffset:Point;
      
      public var mUpOffset:Point;
      
      public var mDownOffset:Point;
      
      private var mOverRect:Rectangle;
      
      private var mId:Number;
      
      private var mButtonListener:IButtonListener;
      
      public var mDownImage:ImageInst;
      
      public var mDisableOffset:Point;
      
      private var mDownRect:Rectangle;
      
      private var mNormalRect:Rectangle;
      
      public var mOverImage:ImageInst;
      
      private var mOverAlpha:Number;
      
      public function ImageButtonWidget(id:Number, listener:IButtonListener)
      {
         this.mUpOffset = new Point();
         this.mOverOffset = new Point();
         this.mDownOffset = new Point();
         this.mDisableOffset = new Point();
         super();
         this.mId = id;
         this.mUpImage = null;
         this.mOverImage = null;
         this.mDownImage = null;
         this.mDisabledImage = null;
         this.mButtonListener = listener;
         this.mNormalRect = new Rectangle(0,0,0,0);
         this.mOverRect = new Rectangle(0,0,0,0);
         this.mDownRect = new Rectangle(0,0,0,0);
         this.mDisabledRect = new Rectangle(0,0,0,0);
         this.mOverAlpha = 0;
         this.mOverAlphaSpeed = 0;
         this.mOverAlphaFadeInSpeed = 0;
         doFinger = true;
      }
      
      override public function setDisabled(isDisabled:Boolean) : void
      {
         super.setDisabled(isDisabled);
         if(this.haveButtonImage(this.mDisabledImage,this.mDisabledRect))
         {
            markDirty();
         }
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
      
      private function haveButtonImage(image:ImageInst, rect:Rectangle) : Boolean
      {
         return image != null || rect.width != 0;
      }
      
      override public function draw(g:Graphics2D) : void
      {
         if(width == 0 || height == 0)
         {
            return;
         }
         if(!isDown)
         {
            if(disabled)
            {
               g.drawImage(this.mDisabledImage,this.mDisableOffset.x,this.mDisableOffset.y);
            }
            else if(this.mOverAlpha > 0 && this.mOverImage != null)
            {
               if(this.mUpImage != null && this.mOverAlpha < 1)
               {
                  g.drawImage(this.mUpImage,this.mUpOffset.x,this.mUpOffset.y);
               }
               g.drawImage(this.mOverImage,this.mOverOffset.x,this.mOverOffset.y);
            }
            else if((isOver || isDown) && this.mOverImage != null)
            {
               g.drawImage(this.mOverImage,this.mOverOffset.x,this.mOverOffset.y);
            }
            else if(this.mUpImage != null)
            {
               g.drawImage(this.mUpImage,this.mUpOffset.x,this.mUpOffset.y);
            }
         }
         else if(this.mDownImage != null)
         {
            g.drawImage(this.mDownImage,this.mDownOffset.x,this.mDownOffset.y);
         }
         else if(this.mOverImage != null)
         {
            g.drawImage(this.mOverImage,this.mOverOffset.x,this.mOverOffset.y);
         }
         else
         {
            g.drawImage(this.mUpImage,this.mUpOffset.x,this.mUpOffset.y);
         }
      }
      
      override public function onMouseDown(x:Number, y:Number) : void
      {
         super.onMouseDown(x,y);
         this.mButtonListener.buttonPress(this.mId);
         markDirty();
      }
      
      override public function contains(x:Number, y:Number) : Boolean
      {
         var targetImg:ImageInst = null;
         if(isOver)
         {
            targetImg = this.mOverImage;
         }
         else if(isDown)
         {
            targetImg = this.mDownImage;
         }
         else if(disabled)
         {
            targetImg = this.mDisabledImage;
         }
         else
         {
            targetImg = this.mUpImage;
         }
         if(targetImg == null)
         {
            return false;
         }
         var localX:Number = x - this.x;
         var localY:Number = y - this.y;
         if(localX < 0)
         {
            return false;
         }
         if(localY < 0)
         {
            return false;
         }
         if(localX > targetImg.width - 1)
         {
            return false;
         }
         if(localY > targetImg.height - 1)
         {
            return false;
         }
         var color:uint = targetImg.pixels.getPixel32(localX,localY);
         var alpha:uint = uint((color & 4278190080) >> 24);
         return alpha > 0;
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
         this.mButtonListener.buttonMouseEnter(this.mId);
      }
      
      override public function onMouseMove(x:Number, y:Number) : void
      {
         super.onMouseMove(x,y);
         this.mButtonListener.buttonMouseMove(this.mId,x,y);
      }
      
      public function isButtonDown() : Boolean
      {
         return isDown && isOver && !disabled;
      }
   }
}
