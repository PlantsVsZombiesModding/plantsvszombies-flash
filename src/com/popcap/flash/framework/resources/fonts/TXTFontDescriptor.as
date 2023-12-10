package com.popcap.flash.framework.resources.fonts
{
   import com.popcap.flash.framework.AppBase;
   import com.popcap.flash.framework.parsers.desc.DataElement;
   import com.popcap.flash.framework.parsers.desc.DescriptionParser;
   import com.popcap.flash.framework.parsers.desc.ListDataElement;
   import com.popcap.flash.framework.parsers.desc.SingleDataElement;
   import com.popcap.flash.framework.resources.images.ImageData;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BitmapDataChannel;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class TXTFontDescriptor implements FontDescriptor
   {
       
      
      private var mImageClazzes:Array;
      
      private var mFontClazz:Class;
      
      private var mDefines:Dictionary;
      
      private var mData:FontData;
      
      public function TXTFontDescriptor(fontClazz:Class, imageClazzes:Array)
      {
         super();
         this.mFontClazz = fontClazz;
         this.mImageClazzes = imageClazzes;
      }
      
      private function cmdLayerSetPointSize(args:ListDataElement) : void
      {
         var aLayerName:String = String(args.mElements[1].mString);
         var aLayer:FontLayer = this.mData.layerMap[aLayerName];
         var aPointSize:Number = Number(args.mElements[2].mString);
         aLayer.mPointSize = aPointSize;
      }
      
      private function cmdLayerSetColorMult(args:ListDataElement) : void
      {
         var aLayerName:String = String(args.mElements[1].mString);
         var aLayer:FontLayer = this.mData.layerMap[aLayerName];
         var aColor:Number = Number(args.mElements[2].mString);
         aLayer.mColorMult = aColor / 255 << 24 | aColor / 255 << 16 | aColor / 255 << 8 | aColor / 255;
      }
      
      private function cmdLayerSetImageMap(args:ListDataElement) : void
      {
         var aCharCode:Number = NaN;
         var aRectDesc:ListDataElement = null;
         var aData:CharData = null;
         var aLayerName:String = String(args.mElements[1].mString);
         var aLayer:FontLayer = this.mData.layerMap[aLayerName];
         var aCharList:ListDataElement = this.lookup(args.mElements[2]);
         var aRectList:ListDataElement = this.lookup(args.mElements[3]);
         var len:int = int(aCharList.mElements.length);
         for(var i:int = 0; i < len; i++)
         {
            aCharCode = Number(aCharList.mElements[i].mString.charCodeAt(0));
            aRectDesc = aRectList.mElements[i];
            aData = aLayer.getCharData(aCharCode);
            aData.mImageRect = new Rectangle();
            aData.mImageRect.x = Number(aRectDesc.mElements[0]);
            aData.mImageRect.y = Number(aRectDesc.mElements[1]);
            aData.mImageRect.width = Number(aRectDesc.mElements[2]);
            aData.mImageRect.height = Number(aRectDesc.mElements[3]);
         }
      }
      
      private function cmdLayerSetLineSpacingOffset(args:ListDataElement) : void
      {
         var aLayerName:String = String(args.mElements[1].mString);
         var aLayer:FontLayer = this.mData.layerMap[aLayerName];
         var anOffset:Number = Number(args.mElements[2].mString);
         aLayer.mLineSpacingOffset = anOffset;
      }
      
      private function setLayerImage(layer:FontLayer, imgClazz:Class) : void
      {
         var data:CharData = null;
         var w:Number = NaN;
         var h:Number = NaN;
         var bd:BitmapData = null;
         var src:Rectangle = null;
         var bitmap:Bitmap = new imgClazz() as Bitmap;
         var destPt:Point = new Point();
         var aStartIndex:Number = layer.mImageId.lastIndexOf("/") + 1;
         var imageName:String = layer.mImageId;
         var underIndex:Number = imageName.indexOf("_");
         var area:Rectangle = new Rectangle(0,0,bitmap.bitmapData.width,bitmap.bitmapData.height);
         var aFontBD:BitmapData = new BitmapData(area.width,area.height,true,4294967295);
         if(underIndex == 0 || underIndex == imageName.length - 1)
         {
            aFontBD.copyChannel(bitmap.bitmapData,area,destPt,BitmapDataChannel.RED,BitmapDataChannel.ALPHA);
         }
         else
         {
            aFontBD.copyPixels(bitmap.bitmapData,area,destPt);
         }
         var image:ImageInst = new ImageInst(new ImageData(aFontBD));
         var numChars:int = int(layer.mCharData.length);
         for(var i:int = 0; i < numChars; i++)
         {
            data = layer.getCharData(i);
            if(!(data.mImageRect == null || data.mImageRect.width == 0 || data.mImageRect.height == 0))
            {
               w = data.mImageRect.width;
               h = data.mImageRect.height;
               bd = new BitmapData(w,h,true,4294967295);
               src = data.mImageRect;
               bd.copyPixels(aFontBD,src,destPt);
               data.mImage = new ImageInst(new ImageData(bd));
            }
         }
         layer.mHeight = image.height;
      }
      
      private function cmdDefine(args:ListDataElement) : void
      {
         var aKey:String = String(args.mElements[1].mString);
         this.mDefines[aKey] = args.mElements[2];
      }
      
      private function cmdSetDefaultPointSize(args:ListDataElement) : void
      {
         var aPointSize:Number = Number(args.mElements[1].mString);
         this.mData.mPointSize = aPointSize;
      }
      
      private function cmdCreateLayer(args:ListDataElement) : void
      {
         var aLayerName:String = String(args.mElements[1].mString);
         var aLayer:FontLayer = new FontLayer();
         aLayer.mLayerName = aLayerName;
         this.mData.layerList.push(aLayer);
         this.mData.layerMap[aLayerName] = aLayer;
      }
      
      private function cmdLayerSetCharOffsets(args:ListDataElement) : void
      {
         var aCharCode:Number = NaN;
         var aOffsetDesc:ListDataElement = null;
         var aData:CharData = null;
         var aLayerName:String = String(args.mElements[1].mString);
         var aLayer:FontLayer = this.mData.layerMap[aLayerName];
         var aCharList:ListDataElement = this.lookup(args.mElements[2]);
         var aOffsetList:ListDataElement = this.lookup(args.mElements[3]);
         var len:int = int(aCharList.mElements.length);
         for(var i:int = 0; i < len; i++)
         {
            aCharCode = Number(aCharList.mElements[i].mString.charCodeAt(0));
            aOffsetDesc = aOffsetList.mElements[i];
            aData = aLayer.getCharData(aCharCode);
            aData.mOffset.x = Number(aOffsetDesc.mElements[0]);
            aData.mOffset.y = Number(aOffsetDesc.mElements[1]);
         }
      }
      
      private function cmdLayerSetAscent(args:ListDataElement) : void
      {
         var aLayerName:String = String(args.mElements[1].mString);
         var aLayer:FontLayer = this.mData.layerMap[aLayerName];
         var anAscent:Number = Number(args.mElements[2].mString);
         aLayer.mAscent = anAscent;
      }
      
      private function cmdLayerSetAscentPadding(args:ListDataElement) : void
      {
         var aLayerName:String = String(args.mElements[1].mString);
         var aLayer:FontLayer = this.mData.layerMap[aLayerName];
         var anAscent:Number = Number(args.mElements[2].mString);
         aLayer.mAscentPadding = anAscent;
      }
      
      private function cmdLayerSetImage(args:ListDataElement) : void
      {
         var aLayerName:String = String(args.mElements[1].mString);
         var aFilename:String = String(args.mElements[2].mString);
         var aLayer:FontLayer = this.mData.layerMap[aLayerName];
         aLayer.mImageId = aFilename;
      }
      
      private function lookup(elem:DataElement) : ListDataElement
      {
         var list:ListDataElement = null;
         if(elem is SingleDataElement)
         {
            list = this.mDefines[(elem as SingleDataElement).mString];
         }
         else
         {
            if(!(elem is ListDataElement))
            {
               throw new Error("Unable to lookup list using element " + elem);
            }
            list = elem as ListDataElement;
         }
         return list;
      }
      
      public function createFontData(app:AppBase) : FontData
      {
         var command:ListDataElement = null;
         var cmdName:String = null;
         var cmdFunc:Function = null;
         var imgClazz:Class = null;
         var aLayer:FontLayer = null;
         this.mDefines = new Dictionary();
         this.mData = new FontData();
         var aByteArray:ByteArray = new this.mFontClazz();
         var aFile:String = aByteArray.readUTFBytes(aByteArray.length);
         var parser:DescriptionParser = new DescriptionParser();
         var commands:Array = parser.parse(aFile);
         var aNumCommands:int = int(commands.length);
         for(var i:int = 0; i < aNumCommands; i++)
         {
            command = commands[i];
            cmdName = String(command.mElements[0].mString);
            cmdFunc = this["cmd" + cmdName];
            if(cmdFunc == null)
            {
               throw new Error("No command mapped to \'" + cmdName + "\'");
            }
            cmdFunc(command);
         }
         var aNumLayers:int = int(this.mData.layerList.length);
         for(var j:int = 0; j < aNumLayers; j++)
         {
            imgClazz = this.mImageClazzes[j];
            aLayer = this.mData.layerList[j];
            this.setLayerImage(aLayer,imgClazz);
         }
         return this.mData;
      }
      
      private function cmdLayerSetCharWidths(args:ListDataElement) : void
      {
         var aCharCode:Number = NaN;
         var aWidth:Number = NaN;
         var aData:CharData = null;
         var aLayerName:String = String(args.mElements[1].mString);
         var aLayer:FontLayer = this.mData.layerMap[aLayerName];
         var aCharList:ListDataElement = this.lookup(args.mElements[2]);
         var aWidthList:ListDataElement = this.lookup(args.mElements[3]);
         var len:int = int(aCharList.mElements.length);
         for(var i:int = 0; i < len; i++)
         {
            aCharCode = Number(aCharList.mElements[i].mString.charCodeAt(0));
            aWidth = Number(aWidthList.mElements[i].mString);
            aData = aLayer.getCharData(aCharCode);
            aData.mWidth = aWidth;
         }
      }
      
      private function cmdLayerSetKerningPairs(args:ListDataElement) : void
      {
         var pair:SingleDataElement = null;
         var left:String = null;
         var right:String = null;
         var anOffset:Number = NaN;
         var aCharData:CharData = null;
         var aLayerName:String = String(args.mElements[1].mString);
         var aLayer:FontLayer = this.mData.layerMap[aLayerName];
         var aPairsList:ListDataElement = this.lookup(args.mElements[2]);
         var anOffsetList:ListDataElement = this.lookup(args.mElements[3]);
         var aNumPairs:int = int(aPairsList.mElements.length);
         for(var i:int = 0; i < aNumPairs; i++)
         {
            pair = aPairsList.mElements[i];
            left = pair.mString.charAt(0);
            right = pair.mString.charAt(1);
            anOffset = Number(anOffsetList.mElements[i].toString());
            aCharData = aLayer.getCharData(left.charCodeAt(0));
            aCharData.mKerningOffsets[right] = anOffset;
         }
      }
   }
}
