package com.popcap.flash.framework.resources.reanimator
{
   import com.popcap.flash.framework.AppBase;
   import flash.utils.ByteArray;
   
   public class XMLReanimDescriptor implements ReanimDescriptor
   {
       
      
      private var mLastTrans:ReanimTransform;
      
      private var mXML:XML;
      
      private var mApp:AppBase;
      
      private var mBytes:ByteArray;
      
      public function XMLReanimDescriptor(bytes:ByteArray)
      {
         super();
         this.mBytes = bytes;
      }
      
      private function parseTransform(xml:XML) : ReanimTransform
      {
         var transform:ReanimTransform = new ReanimTransform();
         var xStr:String = String(xml.x);
         if(xStr.length > 0)
         {
            transform.tX = Number(xStr);
         }
         var yStr:String = String(xml.y);
         if(yStr.length > 0)
         {
            transform.tY = Number(yStr);
         }
         var kxStr:String = String(xml.kx);
         if(kxStr.length > 0)
         {
            transform.kX = -2 * Math.PI * Number(kxStr) / 360;
         }
         var kyStr:String = String(xml.ky);
         if(kyStr.length > 0)
         {
            transform.kY = -2 * Math.PI * Number(kyStr) / 360;
         }
         var sxStr:String = String(xml.sx);
         if(sxStr.length > 0)
         {
            transform.sX = Number(sxStr);
         }
         var syStr:String = String(xml.sy);
         if(syStr.length > 0)
         {
            transform.sY = Number(syStr);
         }
         var fStr:String = String(xml.f);
         if(fStr.length > 0)
         {
            transform.frame = Number(fStr);
         }
         var aStr:String = String(xml.a);
         if(aStr.length > 0)
         {
            transform.alpha = Number(aStr);
         }
         var imageStr:String = String(xml.i);
         if(imageStr.length > 0)
         {
            transform.image = this.mApp.imageManager.getImageInst(imageStr);
         }
         transform.fillInFrom(this.mLastTrans);
         return transform;
      }
      
      private function parseDefinition(xml:XML) : ReanimDefinition
      {
         var aTrack:ReanimTrack = null;
         var def:ReanimDefinition = new ReanimDefinition();
         def.fps = Number(xml.fps);
         var len:int = xml.track.length();
         for(var i:int = 0; i < len; i++)
         {
            aTrack = this.parseTrack(xml.track[i]);
            def.tracks.push(aTrack);
            def.trackNameMap[aTrack.name] = aTrack;
            ++def.numTracks;
         }
         return def;
      }
      
      private function parseTrack(xml:XML) : ReanimTrack
      {
         var aTrans:ReanimTransform = null;
         var track:ReanimTrack = new ReanimTrack();
         track.name = xml.name;
         this.mLastTrans = null;
         var len:int = xml.t.length();
         for(var i:int = 0; i < len; i++)
         {
            aTrans = this.parseTransform(xml.t[i]);
            track.transforms.push(aTrans);
            ++track.numTransforms;
            this.mLastTrans = aTrans;
         }
         return track;
      }
      
      public function createReanimData(app:AppBase) : ReanimDefinition
      {
         this.mApp = app;
         this.mBytes.position = 0;
         this.mXML = new XML(this.mBytes.readUTFBytes(this.mBytes.length));
         return this.parseDefinition(this.mXML);
      }
   }
}
