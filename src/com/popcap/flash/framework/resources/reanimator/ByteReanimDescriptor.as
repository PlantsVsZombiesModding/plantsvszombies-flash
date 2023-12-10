package com.popcap.flash.framework.resources.reanimator
{
   import com.popcap.flash.framework.AppBase;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.utils.ByteArray;
   
   public class ByteReanimDescriptor implements ReanimDescriptor
   {
       
      
      private var mBytes:ByteArray;
      
      public function ByteReanimDescriptor(param1:ByteArray)
      {
         super();
         this.mBytes = param1;
      }
      
      public function createReanimData(param1:AppBase) : ReanimDefinition
      {
         var _loc6_:String = null;
         var _loc7_:ReanimTrack = null;
         var _loc8_:int = 0;
         var _loc9_:Number = NaN;
         var _loc10_:ReanimTransform = null;
         var _loc11_:int = 0;
         var _loc12_:String = null;
         var _loc2_:Point = new Point();
         var _loc3_:ReanimDefinition = new ReanimDefinition();
         this.mBytes.position = 0;
         _loc3_.fps = this.mBytes.readInt();
         var _loc4_:int = this.mBytes.readInt();
         _loc3_.numTracks = _loc4_;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = null;
            (_loc7_ = new ReanimTrack()).name = this.mBytes.readUTF();
            _loc8_ = this.mBytes.readInt();
            _loc7_.numTransforms = _loc8_;
            _loc9_ = 0;
            while(_loc9_ < _loc8_)
            {
               _loc10_ = new ReanimTransform();
               _loc7_.transforms[_loc9_] = _loc10_;
               if((_loc11_ = this.mBytes.readInt()) == -1)
               {
                  _loc10_.frame = -1;
                  _loc10_.alpha = 0;
                  _loc10_.kX = 0;
                  _loc10_.kY = 0;
                  _loc10_.sX = 1;
                  _loc10_.sY = 1;
                  _loc10_.tX = 0;
                  _loc10_.tY = 0;
                  _loc10_.matrix = new Matrix();
               }
               else
               {
                  _loc10_.frame = 0;
                  _loc10_.alpha = this.mBytes.readFloat();
                  _loc10_.kX = this.mBytes.readDouble();
                  _loc10_.kY = this.mBytes.readDouble();
                  _loc10_.sX = this.mBytes.readDouble();
                  _loc10_.sY = this.mBytes.readDouble();
                  _loc10_.tX = this.mBytes.readDouble();
                  _loc10_.tY = this.mBytes.readDouble();
                  _loc10_.calcMatrix();
                  if((_loc12_ = this.mBytes.readUTF()).length > 0)
                  {
                     _loc10_.image = param1.imageManager.getImageInst(_loc12_);
                     _loc6_ = _loc12_;
                  }
                  else if(_loc6_ != null)
                  {
                     _loc10_.image = param1.imageManager.getImageInst(_loc6_);
                  }
               }
               _loc9_++;
            }
            _loc3_.tracks[_loc5_] = _loc7_;
            _loc3_.trackNameMap[_loc7_.name] = _loc7_;
            _loc5_++;
         }
         return _loc3_;
      }
   }
}
