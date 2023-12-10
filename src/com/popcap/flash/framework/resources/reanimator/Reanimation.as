package com.popcap.flash.framework.resources.reanimator
{
   import com.popcap.flash.framework.AppBase;
   import com.popcap.flash.framework.graphics.Color;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.resources.images.ImageData;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.resources.reanimator.looptypes.ReanimLoopAlways;
   import com.popcap.flash.framework.resources.reanimator.looptypes.ReanimLoopOnceAndDie;
   import com.popcap.flash.framework.resources.reanimator.looptypes.ReanimLoopOnceAndHold;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class Reanimation
   {
      
      public static const LOOP_TYPE_ONCE_AND_DIE:ReanimLoopType = new ReanimLoopOnceAndDie();
      
      public static const LOOP_TYPE_ONCE_AND_HOLD:ReanimLoopType = new ReanimLoopOnceAndHold();
      
      public static const SECONDS_PER_UPDATE:Number = 1 / 100;
      
      public static const LOOP_TYPE_ALWAYS:ReanimLoopType = new ReanimLoopAlways();
      
      private static var scratchMatrix:Matrix = new Matrix();
      
      private static const identityMatrix:Matrix = new Matrix();
       
      
      private var locatorY:Number;
      
      private var locatorX:Number;
      
      private var mX:Number = 0;
      
      private var mY:Number = 0;
      
      private var childTrack:String;
      
      private var mAnimTime:Number = 0;
      
      public var overrideColor:Color;
      
      private var mLoopType:ReanimLoopType;
      
      public var useColor:Boolean = false;
      
      private var mAnimRate:Number = 0;
      
      private var mDefinition:ReanimDefinition = null;
      
      private var child:Reanimation;
      
      public var additiveColor:Color;
      
      private var mLastAnimTime:Number = 0;
      
      private var mVisibleMap:Dictionary;
      
      private var mCurrentTrack:String = null;
      
      private var mFrameTime:ReanimFrameTime;
      
      private var mFrameCount:Number = 0;
      
      private var mChildOffsetX:Number = 0;
      
      private var mChildOffsetY:Number = 0;
      
      private var mStartFrame:Number = 0;
      
      public var mIsDead:Boolean = false;
      
      public function Reanimation(definition:ReanimDefinition)
      {
         this.mFrameTime = new ReanimFrameTime();
         this.mLoopType = LOOP_TYPE_ALWAYS;
         this.mVisibleMap = new Dictionary();
         super();
         this.mDefinition = definition;
         this.overrideColor = Color.ARGB(1,1,1,1);
         this.additiveColor = Color.ARGB(1,0,0,0);
         this.useColor = false;
      }
      
      public function get loopType() : ReanimLoopType
      {
         return this.mLoopType;
      }
      
      public function overrideImage(trackName:String, image:ImageInst) : void
      {
         var aTrans:ReanimTransform = null;
         var aTrack:ReanimTrack = this.getTrack(trackName);
         var aNumTransforms:int = aTrack.numTransforms;
         for(var i:int = 0; i < aNumTransforms; i++)
         {
            aTrans = aTrack.transforms[i];
            if(aTrans.image != null)
            {
               aTrans.image = image;
            }
         }
      }
      
      public function shouldTriggerTimedEvent(time:Number) : Boolean
      {
         if(this.mFrameCount == 0)
         {
            return false;
         }
         if(this.mLastAnimTime < 0)
         {
            return false;
         }
         if(this.mAnimRate <= 0)
         {
            return false;
         }
         if(this.mAnimTime >= this.mLastAnimTime)
         {
            if(time >= this.mLastAnimTime && time < this.mAnimTime)
            {
               return true;
            }
         }
         else if(time >= this.mLastAnimTime || time < this.mAnimTime)
         {
            return true;
         }
         return false;
      }
      
      private function drawTrackLerp(g:Graphics2D, track:ReanimTrack, alpha:Number) : void
      {
         var init:Matrix = null;
         if(this.mVisibleMap[track.name] == false)
         {
            return;
         }
         var a:ReanimTransform = track.transforms[this.mFrameTime.mFrameBefore];
         var b:ReanimTransform = track.transforms[this.mFrameTime.mFrameAfter];
         var t:Number = this.mFrameTime.mFraction;
         if(a.frame < 0)
         {
            return;
         }
         if(b.frame < 0)
         {
            b = a;
         }
         var kX:Number = this.lerp(a.kX,b.kX,t);
         var kY:Number = this.lerp(a.kY,b.kY,t);
         var sX:Number = this.lerp(a.sX,b.sX,t);
         var sY:Number = this.lerp(a.sY,b.sY,t);
         var tX:Number = this.lerp(a.tX,b.tX,t);
         var tY:Number = this.lerp(a.tY,b.tY,t);
         var tA:Number = this.lerp(a.alpha,b.alpha,t);
         var matrix:Matrix = scratchMatrix;
         matrix.a = Math.cos(kX) * sX;
         matrix.b = -Math.sin(kX) * sX;
         matrix.c = Math.sin(kY) * sY;
         matrix.d = Math.cos(kY) * sY;
         matrix.tx = tX;
         matrix.ty = tY;
         if(track.name == this.childTrack)
         {
            init = track.transforms[this.mStartFrame].matrix;
            this.locatorX = this.mX + (matrix.tx - init.tx);
            this.locatorY = this.mY + (matrix.ty - init.ty);
         }
         var img:ImageInst = a.image;
         if(img == null)
         {
            return;
         }
         img.useColor = true;
         img.setColor(alpha * tA,this.overrideColor.red + this.additiveColor.red,this.overrideColor.green + this.additiveColor.green,this.overrideColor.blue + this.additiveColor.blue);
         g.pushState();
         g.transform(matrix);
         g.drawImage(img,this.mX,this.mY);
         g.popState();
      }
      
      public function get animRate() : Number
      {
         return this.mAnimRate;
      }
      
      public function set loopType(value:ReanimLoopType) : void
      {
         this.mLoopType = value;
      }
      
      private function getTrack(trackName:String) : ReanimTrack
      {
         var aTrack:ReanimTrack = this.mDefinition.trackNameMap[trackName];
         if(aTrack == null)
         {
            throw new Error("Track \'" + trackName + "\' does not exist!");
         }
         return aTrack;
      }
      
      public function getTrackVelocity(trackName:String, allFrames:Boolean = false) : Number
      {
         var aTransBefore:ReanimTransform = null;
         var aTransAfter:ReanimTransform = null;
         var velo:Number = NaN;
         var aTrack:ReanimTrack = this.getTrack(trackName);
         var aList:Array = aTrack.transforms;
         if(!allFrames)
         {
            aTransBefore = aList[this.mFrameTime.mFrameBefore];
            aTransAfter = aList[this.mFrameTime.mFrameAfter];
         }
         else
         {
            aTransBefore = aList[this.mStartFrame];
            aTransAfter = aList[this.mStartFrame + this.mFrameCount - 1];
         }
         if(aTransAfter == null)
         {
            aTransAfter = aTransBefore;
         }
         var aMatrixBefore:Matrix = aTransBefore.matrix;
         var aMatrixAfter:Matrix = aTransAfter.matrix;
         var aXBefore:Number = aMatrixBefore.tx;
         var aXAfter:Number = aMatrixAfter.tx;
         if(!allFrames)
         {
            velo = (aXAfter - aXBefore) * SECONDS_PER_UPDATE * this.mAnimRate;
         }
         else
         {
            velo = aXAfter - aXBefore;
         }
         return velo;
      }
      
      public function get frameCount() : Number
      {
         return this.mFrameCount;
      }
      
      public function getBoundsForFrame() : Rectangle
      {
         var track:ReanimTrack = null;
         var numTransforms:int = 0;
         var j:int = 0;
         var transform:ReanimTransform = null;
         var matrix:Matrix = null;
         var img:ImageInst = null;
         var src:BitmapData = null;
         var p0:Point = null;
         var p1:Point = null;
         var p2:Point = null;
         var p3:Point = null;
         var aBounds:Rectangle = new Rectangle();
         var left:Number = Number.MAX_VALUE;
         var right:Number = Number.MIN_VALUE;
         var top:Number = Number.MAX_VALUE;
         var bottom:Number = Number.MIN_VALUE;
         var tracks:Array = this.mDefinition.tracks;
         var aNumTracks:int = int(tracks.length);
         for(var i:int = 0; i < aNumTracks; i++)
         {
            track = tracks[i];
            numTransforms = track.numTransforms;
            for(j = 0; j < numTransforms; j++)
            {
               transform = track.transforms[j];
               matrix = transform.matrix;
               img = transform.image;
               if(img != null)
               {
                  src = img.pixels;
                  p0 = new Point(0,0);
                  p1 = new Point(src.width,0);
                  p2 = new Point(src.width,src.height);
                  p3 = new Point(0,src.height);
                  p0 = matrix.transformPoint(p0);
                  p1 = matrix.transformPoint(p1);
                  p2 = matrix.transformPoint(p2);
                  p3 = matrix.transformPoint(p3);
                  left = Math.min(left,Math.floor(Math.min(Math.min(p0.x,p1.x),Math.min(p2.x,p3.x))));
                  right = Math.max(right,Math.ceil(Math.max(Math.max(p0.x,p1.x),Math.max(p2.x,p3.x))));
                  top = Math.min(top,Math.floor(Math.min(Math.min(p0.y,p1.y),Math.min(p2.y,p3.y))));
                  bottom = Math.max(bottom,Math.ceil(Math.max(Math.max(p0.y,p1.y),Math.max(p2.y,p3.y))));
               }
            }
         }
         aBounds.left = left;
         aBounds.right = right;
         aBounds.top = top;
         aBounds.bottom = bottom;
         return aBounds;
      }
      
      public function set animRate(value:Number) : void
      {
         this.mAnimRate = value;
      }
      
      public function set currentTrack(value:String) : void
      {
         this.playTrack(value);
         this.mCurrentTrack = value;
      }
      
      public function attachReanimation(child:Reanimation, trackName:String, offsetX:Number = 0, offsetY:Number = 0) : void
      {
         this.child = child;
         this.child.x = this.mX;
         this.child.y = this.mY;
         this.mChildOffsetX = offsetX;
         this.mChildOffsetY = offsetY;
         this.childTrack = trackName;
      }
      
      public function setTrackVisible(trackName:String, isVisible:Boolean) : void
      {
         this.mVisibleMap[trackName] = isVisible;
      }
      
      private function playTrack(trackName:String) : void
      {
         var trans:ReanimTransform = null;
         var anim:ReanimTrack = this.mDefinition.trackNameMap[trackName];
         if(anim == null)
         {
            throw new Error("Track \'" + trackName + "\' does not exist!");
         }
         this.mCurrentTrack = trackName;
         this.mAnimTime = 0;
         var i:int = 0;
         var startFrame:Number = -1;
         var endFrame:Number = -1;
         var transforms:Array = anim.transforms;
         var numTransforms:int = int(transforms.length);
         for(i = 0; i < numTransforms; i++)
         {
            trans = transforms[i];
            if(trans.frame >= 0)
            {
               startFrame = i;
               break;
            }
         }
         while(i < numTransforms)
         {
            trans = transforms[i];
            if(trans.frame >= 0)
            {
               endFrame = i;
            }
            i++;
         }
         this.mStartFrame = startFrame;
         this.mFrameCount = endFrame - startFrame;
      }
      
      public function draw(g:Graphics2D) : void
      {
         var track:ReanimTrack = null;
         if(this.mIsDead)
         {
            return;
         }
         if(!AppBase.LOW_QUALITY)
         {
            this.drawLerp(g,identityMatrix);
            return;
         }
         var tracks:Array = this.mDefinition.tracks;
         var aNumTracks:int = int(tracks.length);
         for(var i:int = 0; i < aNumTracks; i++)
         {
            track = tracks[i];
            this.drawTrack(g,track);
         }
         if(this.child != null)
         {
            this.child.useColor = this.useColor;
            this.child.additiveColor.copy(this.additiveColor);
            this.child.overrideColor.copy(this.overrideColor);
            this.child.x = this.locatorX + this.mChildOffsetX;
            this.child.y = this.locatorY + this.mChildOffsetY;
            this.child.draw(g);
         }
      }
      
      public function update() : void
      {
         if(this.mCurrentTrack == null)
         {
            return;
         }
         if(this.mFrameCount == 0)
         {
            return;
         }
         if(this.mIsDead)
         {
            return;
         }
         this.mLastAnimTime = this.mAnimTime;
         this.mAnimTime += SECONDS_PER_UPDATE * this.mAnimRate / this.mFrameCount;
         if(this.mAnimRate > 0)
         {
            this.mLoopType.updatePositive(this);
         }
         else
         {
            this.mLoopType.updateNegative(this);
         }
         this.mFrameTime.update(this.mAnimTime,this.mStartFrame,this.mFrameCount,this.mLoopType.doHold());
         if(this.child != null)
         {
            this.child.update();
         }
      }
      
      private function lerp(zero:Number, one:Number, time:Number) : Number
      {
         return zero + (one - zero) * time;
      }
      
      public function get currentTrack() : String
      {
         return this.mCurrentTrack;
      }
      
      public function get definition() : ReanimDefinition
      {
         return this.mDefinition;
      }
      
      public function drawLerp(g:Graphics2D, transform:Matrix = null, alpha:Number = 1) : void
      {
         var track:ReanimTrack = null;
         if(this.mIsDead)
         {
            return;
         }
         g.pushState();
         if(transform != null)
         {
            g.transform(transform);
         }
         var tracks:Array = this.mDefinition.tracks;
         var aNumTracks:int = int(tracks.length);
         for(var i:int = 0; i < aNumTracks; i++)
         {
            track = tracks[i];
            this.drawTrackLerp(g,track,alpha);
            if(track.name == this.childTrack && this.child != null)
            {
               this.child.useColor = this.useColor;
               this.child.additiveColor.copy(this.additiveColor);
               this.child.overrideColor.copy(this.overrideColor);
               this.child.x = this.locatorX + this.mChildOffsetX;
               this.child.y = this.locatorY + this.mChildOffsetY;
               this.child.drawLerp(g,transform,alpha);
            }
         }
         g.popState();
      }
      
      public function getTrackPosition(trackName:String) : Point
      {
         var aTrack:ReanimTrack = this.getTrack(trackName);
         var aTrans:ReanimTransform = aTrack.transforms[this.mFrameTime.mFrameBefore];
         return new Point(aTrans.kX,aTrans.kY);
      }
      
      private function drawTrack(g:Graphics2D, track:ReanimTrack) : void
      {
         var init:Matrix = null;
         if(this.mVisibleMap[track.name] == false)
         {
            return;
         }
         var transform:ReanimTransform = track.transforms[this.mFrameTime.mFrameBefore];
         if(transform.frame < 0)
         {
            return;
         }
         var matrix:Matrix = transform.matrix;
         if(track.name == this.childTrack)
         {
            init = track.transforms[this.mStartFrame].matrix;
            this.locatorX = this.mX + (matrix.tx - init.tx);
            this.locatorY = this.mY + (matrix.ty - init.ty) + 1;
         }
         var cache:ImageInst = transform.cache;
         if(cache != null)
         {
            cache.useColor = this.useColor;
            if(cache.useColor)
            {
               cache.setColor(this.overrideColor.alpha + this.additiveColor.alpha,this.overrideColor.red + this.additiveColor.red,this.overrideColor.green + this.additiveColor.green,this.overrideColor.blue + this.additiveColor.blue);
            }
            g.blitImage(cache,this.mX,this.mY);
            return;
         }
         var img:ImageInst = transform.image;
         if(img == null)
         {
            return;
         }
         var src:BitmapData = img.pixels;
         var p0:Point = new Point(0,0);
         var p1:Point = new Point(src.width,0);
         var p2:Point = new Point(src.width,src.height);
         var p3:Point = new Point(0,src.height);
         p0 = matrix.transformPoint(p0);
         p1 = matrix.transformPoint(p1);
         p2 = matrix.transformPoint(p2);
         p3 = matrix.transformPoint(p3);
         var left:Number = Math.floor(Math.min(Math.min(p0.x,p1.x),Math.min(p2.x,p3.x)));
         var right:Number = Math.ceil(Math.max(Math.max(p0.x,p1.x),Math.max(p2.x,p3.x)));
         var top:Number = Math.floor(Math.min(Math.min(p0.y,p1.y),Math.min(p2.y,p3.y)));
         var bottom:Number = Math.ceil(Math.max(Math.max(p0.y,p1.y),Math.max(p2.y,p3.y)));
         matrix.translate(-left,-top);
         var aData:BitmapData = new BitmapData(right - left,bottom - top,true,0);
         var aCache:ImageInst = new ImageInst(new ImageData(aData));
         aCache.destPt.x = left;
         aCache.destPt.y = top;
         aData.draw(src,matrix,null,null,null,true);
         transform.cache = aCache;
         this.drawTrack(g,track);
      }
      
      public function set y(value:Number) : void
      {
         this.mY = value;
      }
      
      public function set animTime(value:Number) : void
      {
         this.mAnimTime = value;
      }
      
      public function get animTime() : Number
      {
         return this.mAnimTime;
      }
      
      public function set x(value:Number) : void
      {
         this.mX = value;
      }
   }
}
