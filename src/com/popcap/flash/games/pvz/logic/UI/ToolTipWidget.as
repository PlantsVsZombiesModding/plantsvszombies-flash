package com.popcap.flash.games.pvz.logic.UI
{
   import com.popcap.flash.framework.graphics.Color;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.resources.fonts.FontInst;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.games.pvz.PVZApp;
   import com.popcap.flash.games.pvz.logic.Board;
   import com.popcap.flash.games.pvz.resources.PVZFonts;
   
   public class ToolTipWidget
   {
      
      public static const TOOLTIP_LINE_SPACING:int = 2;
      
      public static const TOOLTIP_SIDE_SPACING:int = 5;
      
      public static const TOOLTIP_TOP_SPACING:int = 3;
       
      
      public var mFontBold:FontInst;
      
      public var mMaxBottom:int;
      
      public var mVisible:Boolean;
      
      public var mLabel:String;
      
      public var mY:int;
      
      public var mGetsLinesWidth:int;
      
      public var mX:int;
      
      public var mMinLeft:int;
      
      public var mToolTipImage:ImageInst;
      
      public var mWidth:int;
      
      public var mFont:FontInst;
      
      public var app:PVZApp;
      
      public var mCenter:Boolean;
      
      public var mTitle:String;
      
      public var mHeight:int;
      
      public var mBoard:Board;
      
      public var mWarningFlashCounter:int;
      
      public var mWarningText:String;
      
      public function ToolTipWidget(app:PVZApp, theBoard:Board)
      {
         super();
         this.app = app;
         this.mBoard = theBoard;
         this.mX = 0;
         this.mY = 0;
         this.mWidth = 0;
         this.mHeight = 0;
         this.mVisible = true;
         this.mCenter = false;
         this.mMinLeft = 0;
         this.mMaxBottom = Board.BOARD_HEIGHT;
         this.mGetsLinesWidth = 0;
         this.mWarningFlashCounter = 0;
         this.mFont = app.fontManager.getFontInst(PVZFonts.FONT_PICO129);
         this.mFont.setColor(1,0,0,0);
         this.mFontBold = app.fontManager.getFontInst(PVZFonts.FONT_PIX118BOLD);
         this.mFontBold.setColor(1,0,0,0);
         this.mLabel = "";
         this.mTitle = "";
         this.mWarningText = "";
      }
      
      public function SetWarningText(theWarningText:String) : void
      {
         if(theWarningText == "")
         {
            this.mWarningText = "";
         }
         else
         {
            this.mWarningText = this.app.stringManager.translateString(theWarningText);
         }
         this.CalculateSize();
      }
      
      public function Draw(g:Graphics2D) : void
      {
         var x:int = 0;
         var y:int = 0;
         var aFontWidth:int = 0;
         var aWarningColor:Color = null;
         var aLine:String = null;
         if(!this.mVisible)
         {
            return;
         }
         var aPosX:int = this.mX;
         if(this.mCenter)
         {
            aPosX -= this.mWidth / 2;
         }
         if(aPosX < this.mMinLeft - g.state.affineMatrix.tx)
         {
            aPosX = this.mMinLeft - int(g.state.affineMatrix.tx);
         }
         else if(aPosX + this.mWidth + g.state.affineMatrix.tx > Board.BOARD_WIDTH)
         {
            aPosX = Board.BOARD_WIDTH - this.mWidth - int(g.state.affineMatrix.tx);
         }
         var aPosY:int = this.mY;
         if(aPosY < -g.state.affineMatrix.ty)
         {
            aPosY = int(-g.state.affineMatrix.ty);
         }
         else if(aPosY + this.mHeight + g.state.affineMatrix.ty > this.mMaxBottom)
         {
            aPosY = this.mMaxBottom - this.mHeight - int(g.state.affineMatrix.ty);
         }
         if(this.mX > 540)
         {
            aPosX += this.mBoard.x;
         }
         g.fillRect(aPosX - 1,aPosY - 1,this.mWidth + 2,this.mHeight + 2,4278190080);
         g.fillRect(aPosX,aPosY,this.mWidth,this.mHeight,4294967240);
         if(this.mX > 540)
         {
            aPosX -= this.mBoard.x;
         }
         aPosY += TOOLTIP_TOP_SPACING - 2;
         if(this.mTitle.length > 0)
         {
            g.setFont(this.mFontBold);
            aFontWidth = this.mFontBold.stringWidth(this.mTitle);
            x = aPosX + (this.mWidth - aFontWidth) / 2;
            y = aPosY;
            g.drawString(this.mTitle,x,y);
            aPosY += this.mFontBold.getAscent() + TOOLTIP_LINE_SPACING;
         }
         if(this.mWarningText.length > 0)
         {
            g.setFont(this.mFont);
            aFontWidth = this.mFont.stringWidth(this.mWarningText);
            x = aPosX + (this.mWidth - aFontWidth) / 2;
            y = aPosY;
            aWarningColor = Color.RGB(1,0,0);
            if(this.mWarningFlashCounter > 0)
            {
               if(this.mWarningFlashCounter % 20 < 10)
               {
                  aWarningColor = Color.RGB(0,0,0);
               }
            }
            this.mFont.setColor(aWarningColor.alpha,aWarningColor.red,aWarningColor.green,aWarningColor.blue);
            g.drawString(this.mWarningText,x,y);
            this.mFont.setColor(1,0,0,0);
            aPosY += this.mFont.getAscent() + TOOLTIP_LINE_SPACING;
         }
         var aLines:Array = new Array();
         this.GetLines(aLines);
         g.setFont(this.mFont);
         for(var i:int = 0; i < aLines.length; i++)
         {
            aLine = String(aLines[i]);
            aFontWidth = this.mFont.stringWidth(aLine);
            x = aPosX + (this.mWidth - aFontWidth) / 2;
            y = aPosY;
            g.drawString(aLine,x,y);
            aPosY += this.mFont.getAscent() + TOOLTIP_LINE_SPACING;
         }
      }
      
      public function FlashWarning() : void
      {
         this.mWarningFlashCounter = 70;
      }
      
      public function CalculateSize() : void
      {
         var aWidth:int = 0;
         var aLines:Array = new Array();
         var aMaxWidth:int = this.mFontBold.stringWidth(this.mTitle);
         var aWarningWidth:int = this.mFont.stringWidth(this.mWarningText);
         aMaxWidth = Math.max(aWarningWidth,aMaxWidth);
         this.mGetsLinesWidth = Math.max(130,aMaxWidth - 30);
         this.GetLines(aLines);
         for(var i:int = 0; i < aLines.length; i++)
         {
            aWidth = this.mFont.stringWidth(aLines[i]);
            aMaxWidth = Math.max(aMaxWidth,aWidth);
         }
         var aHeight:int = TOOLTIP_TOP_SPACING * 2;
         if(this.mTitle.length > 0)
         {
            aHeight += this.mFont.getAscent() + TOOLTIP_LINE_SPACING;
         }
         if(this.mWarningText.length > 0)
         {
            aHeight += this.mFont.getAscent() + TOOLTIP_LINE_SPACING;
         }
         aHeight += this.mFont.getAscent() * aLines.length;
         aHeight += TOOLTIP_LINE_SPACING * (aLines.length - 1);
         aMaxWidth += TOOLTIP_SIDE_SPACING * 2;
         this.mWidth = aMaxWidth;
         this.mHeight = aHeight;
      }
      
      public function SetLabel(theLabel:String) : void
      {
         if(theLabel == "")
         {
            this.mLabel = "";
         }
         else
         {
            this.mLabel = this.app.stringManager.translateString(theLabel);
         }
         this.CalculateSize();
      }
      
      public function Update() : void
      {
         if(this.mWarningFlashCounter > 0)
         {
            --this.mWarningFlashCounter;
         }
      }
      
      public function GetLines(theLines:Array) : void
      {
         var aWord:String = null;
         var aWidth:Number = NaN;
         if(this.mLabel == "")
         {
            return;
         }
         var aIndexStart:int = 0;
         var aIndexCur:int = 0;
         var aCurWidth:int = 0;
         var theWords:Array = this.mLabel.split(" ");
         var numWords:int = int(theWords.length);
         var aSpaceWidth:Number = this.mFont.stringWidth(" ");
         var aLineNumber:int = 0;
         var aLineWidth:Number = 0;
         var aLineFragment:String = "";
         for(var i:int = 0; i < numWords; i++)
         {
            aWord = String(theWords[i]);
            aWidth = this.mFont.stringWidth(aWord);
            if(aLineWidth + aWidth < this.mGetsLinesWidth)
            {
               if(aLineFragment.length == 0)
               {
                  aLineFragment = aWord;
               }
               else
               {
                  aLineFragment = aLineFragment + " " + aWord;
               }
               aLineWidth += aWidth;
            }
            else
            {
               theLines[aLineNumber] = aLineFragment;
               aLineNumber += 1;
               aLineFragment = aWord;
               aLineWidth = aWidth;
            }
            aLineWidth += aSpaceWidth;
         }
         theLines[aLineNumber] = aLineFragment;
      }
      
      public function SetTitle(theTitle:String) : void
      {
         if(theTitle == "")
         {
            this.mTitle = "";
         }
         else
         {
            this.mTitle = this.app.stringManager.translateString(theTitle);
         }
         this.CalculateSize();
      }
   }
}
