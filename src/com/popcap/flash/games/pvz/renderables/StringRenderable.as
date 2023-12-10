package com.popcap.flash.games.pvz.renderables
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.render.Renderable;
   import com.popcap.flash.framework.resources.fonts.FontInst;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.utils.Utils;
   import flash.geom.Rectangle;
   
   public class StringRenderable implements Renderable
   {
      
      public static const JUSTIFY_CENTER:String = "center";
      
      public static const JUSTIFY_LEFT:String = "left";
      
      public static const JUSTIFY_RIGHT:String = "right";
       
      
      private var mTextImage:ImageInst;
      
      private var mImageRed:Number = 1;
      
      private var mBounds:Rectangle;
      
      private var mTextBounds:Rectangle;
      
      private var mImageAlpha:Number = 1;
      
      private var mLines:Array;
      
      private var mDepth:Number;
      
      private var mFont:FontInst;
      
      private var mJustify:String = "center";
      
      private var mImageBlue:Number = 1;
      
      private var mDead:Boolean;
      
      private var mImageGreen:Number = 1;
      
      private var mText:String;
      
      public function StringRenderable(depth:Number = 0)
      {
         super();
         this.mDepth = depth;
         this.mBounds = new Rectangle();
         this.mTextBounds = new Rectangle();
         this.mDead = false;
         this.mLines = new Array();
      }
      
      public function set dead(value:Boolean) : void
      {
         this.mDead = value;
      }
      
      public function draw(g:Graphics2D) : void
      {
         if(this.mFont == null)
         {
            return;
         }
         if(this.mTextImage == null)
         {
            return;
         }
         g.blitImage(this.mTextImage,this.mTextBounds.x,this.mTextBounds.y);
      }
      
      public function getDepth() : Number
      {
         return this.mDepth;
      }
      
      public function update() : void
      {
      }
      
      public function set text(value:String) : void
      {
         this.mText = value;
         this.redrawText();
      }
      
      public function setColor(a:Number, r:Number, g:Number, b:Number) : void
      {
         this.mImageAlpha = a;
         this.mImageRed = r;
         this.mImageGreen = g;
         this.mImageBlue = b;
         if(this.mTextImage != null)
         {
            this.mTextImage.setColor(a,r,g,b);
            this.mTextImage.useColor = true;
         }
      }
      
      public function set font(value:FontInst) : void
      {
         this.mFont = value;
         this.redrawText();
      }
      
      private function redrawText() : void
      {
         var justification:Number = Utils.JUSTIFY_CENTER;
         if(this.mJustify == JUSTIFY_LEFT)
         {
            justification = Utils.JUSTIFY_LEFT;
         }
         else if(this.mJustify == JUSTIFY_RIGHT)
         {
            justification = Utils.JUSTIFY_RIGHT;
         }
         this.mTextImage = Utils.createStringImage(this.mText,this.mFont,this.mBounds,justification);
         if(this.mTextImage == null)
         {
            return;
         }
         this.mTextBounds.x = 0;
         this.mTextBounds.y = 0;
         this.mTextBounds.width = this.mTextImage.width;
         this.mTextBounds.height = this.mTextImage.height;
         Utils.align(this.mTextBounds,this.mBounds,justification,Utils.ALIGN_CENTER);
      }
      
      public function getIsDisposable() : Boolean
      {
         return this.mDead;
      }
      
      public function set justification(value:String) : void
      {
         this.mJustify = value;
         this.redrawText();
      }
      
      public function set x(value:Number) : void
      {
         this.mBounds.x = value;
      }
      
      public function set y(value:Number) : void
      {
         this.mBounds.y = value;
      }
      
      public function setBounds(x:Number, y:Number, width:Number, height:Number) : void
      {
         this.mBounds.x = x;
         this.mBounds.y = y;
         this.mBounds.width = width;
         this.mBounds.height = height;
         this.redrawText();
      }
      
      public function getIsVisible() : Boolean
      {
         return true;
      }
      
      public function toString() : String
      {
         return "String@" + this.mDepth;
      }
   }
}
