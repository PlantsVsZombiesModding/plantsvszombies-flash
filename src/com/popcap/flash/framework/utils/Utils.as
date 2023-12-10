package com.popcap.flash.framework.utils
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.resources.fonts.FontInst;
   import com.popcap.flash.framework.resources.images.ImageData;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class Utils
   {
      
      public static const ALIGN_LEFT:Number = -1;
      
      public static const ALIGN_RIGHT:Number = 1;
      
      public static const ALIGN_BOTTOM:Number = 1;
      
      public static const JUSTIFY_RIGHT:Number = 1;
      
      public static const ALIGN_CENTER:Number = 0;
      
      public static const ALIGN_NONE:Number = -2;
      
      public static const JUSTIFY_CENTER:Number = 0;
      
      public static const ALIGN_TOP:Number = -1;
      
      public static const JUSTIFY_LEFT:Number = -1;
       
      
      public function Utils()
      {
         super();
      }
      
      private static function splitText(str:String, font:FontInst, bounds:Rectangle) : Array
      {
         var aLine:String = null;
         var aLineWidth:Number = NaN;
         var aLineFragment:String = null;
         var words:Array = null;
         var aNumWords:int = 0;
         var j:int = 0;
         var aWord:String = null;
         var aWidth:Number = NaN;
         var results:Array = new Array();
         if(bounds.width == 0 || bounds.height == 0)
         {
            return results;
         }
         if(str == null || str.length == 0)
         {
            return results;
         }
         var aSpaceWidth:Number = font.stringWidth(" ");
         var aLineNumber:int = 0;
         var lines:Array = str.split(/[\n\r]+/);
         var aNumLines:int = int(lines.length);
         for(var i:int = 0; i < aNumLines; i++)
         {
            aLine = String(lines[i]);
            aLineWidth = 0;
            aLineFragment = "";
            words = aLine.split(/[ \t]+/);
            aNumWords = int(words.length);
            for(j = 0; j < aNumWords; j++)
            {
               aWord = String(words[j]);
               aWidth = font.stringWidth(aWord);
               if(aLineWidth + aWidth < bounds.width)
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
                  results[aLineNumber] = aLineFragment;
                  aLineNumber += 1;
                  aLineFragment = aWord;
                  aLineWidth = aWidth;
               }
               aLineWidth += aSpaceWidth;
            }
            results[aLineNumber] = aLineFragment;
            aLineNumber += 1;
            aLineFragment = "";
            aLineWidth = 0;
         }
         return results;
      }
      
      public static function createStringImage(str:String, font:FontInst, bounds:Rectangle, justification:Number) : ImageInst
      {
         var aLine:String = null;
         var aLineWidth:Number = NaN;
         var x:Number = NaN;
         var y:Number = NaN;
         var lines:Array = splitText(str,font,bounds);
         if(lines.length == 0)
         {
            return null;
         }
         var aImgWidth:Number = 0;
         var aImgHeight:Number = 0;
         var i:int = 0;
         var aNumLines:int = int(lines.length);
         for(i = 0; i < aNumLines; i++)
         {
            aLine = String(lines[i]);
            aLineWidth = font.stringImageWidth(aLine);
            aImgWidth = aImgWidth < aLineWidth ? aLineWidth : aImgWidth;
         }
         if(aImgWidth == 0)
         {
            return null;
         }
         aImgHeight = font.getHeight();
         aImgHeight += (aNumLines - 1) * (font.getAscent() + font.getLineSpacing());
         if(aImgHeight == 0)
         {
            return null;
         }
         var textImage:ImageInst = new ImageInst(new ImageData(new BitmapData(aImgWidth,aImgHeight,true,0)));
         var g:Graphics2D = textImage.graphics;
         g.setFont(font);
         for(i = 0; i < aNumLines; i++)
         {
            aLine = String(lines[i]);
            x = 0;
            y = 0;
            if(justification == JUSTIFY_LEFT)
            {
               x = 0;
            }
            else if(justification == JUSTIFY_RIGHT)
            {
               x = aImgWidth - font.stringWidth(aLine);
            }
            else
            {
               x = (aImgWidth >> 1) - (font.stringWidth(aLine) >> 1);
            }
            y = i * (font.getAscent() + font.getLineSpacing());
            g.drawString(aLine,x,y);
         }
         return textImage;
      }
      
      public static function align(targetBounds:Rectangle, anchorBounds:Rectangle, hAlign:Number = 0, vAlign:Number = 0) : void
      {
         if(hAlign == ALIGN_LEFT)
         {
            targetBounds.left = anchorBounds.left;
         }
         else if(hAlign == ALIGN_RIGHT)
         {
            targetBounds.right = anchorBounds.right;
         }
         else if(hAlign == ALIGN_CENTER)
         {
            targetBounds.x = anchorBounds.x + anchorBounds.width / 2 - targetBounds.width / 2;
         }
         if(vAlign == ALIGN_TOP)
         {
            targetBounds.top = anchorBounds.top;
         }
         else if(vAlign == ALIGN_BOTTOM)
         {
            targetBounds.bottom = anchorBounds.bottom;
         }
         else if(vAlign == ALIGN_CENTER)
         {
            targetBounds.y = anchorBounds.y + anchorBounds.height / 2 - targetBounds.height / 2;
         }
      }
      
      public static function createMergedImage(images:Array, sourceRects:Array, destPoints:Array) : ImageInst
      {
         var img:ImageInst = null;
         var src:Rectangle = null;
         var dest:Point = null;
         var l:int = 0;
         var r:int = 0;
         var t:int = 0;
         var b:int = 0;
         var matrix:Matrix = new Matrix();
         var bounds:Rectangle = new Rectangle();
         var len:int = int(images.length);
         for(var i:int = 0; i < len; i++)
         {
            src = sourceRects[i];
            dest = destPoints[i];
            l = dest.x;
            r = dest.x + src.width;
            t = dest.y;
            b = dest.y + src.height;
            bounds.left = l < bounds.left ? l : bounds.left;
            bounds.right = r > bounds.right ? r : bounds.right;
            bounds.top = t < bounds.top ? t : bounds.top;
            bounds.bottom = b > bounds.bottom ? b : bounds.bottom;
         }
         var merged:BitmapData = new BitmapData(bounds.width,bounds.height,true,0);
         for(var k:int = 0; k < len; k++)
         {
            img = images[k];
            src = sourceRects[k];
            dest = destPoints[k];
            dest.x -= bounds.x;
            dest.y -= bounds.y;
            merged.copyPixels(img.pixels,src,dest);
         }
         return new ImageInst(new ImageData(merged));
      }
      
      public static function getDigits(input:int) : Vector.<int>
      {
         var str:String = input.toString();
         var digits:Vector.<int> = new Vector.<int>();
         var len:int = str.length;
         for(var i:int = len - 1; i >= 0; i--)
         {
            digits.push(int(str.charAt(i)));
         }
         return digits;
      }
   }
}
