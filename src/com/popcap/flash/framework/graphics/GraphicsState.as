package com.popcap.flash.framework.graphics
{
   import com.popcap.flash.framework.resources.fonts.FontInst;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class GraphicsState
   {
       
      
      public var clipRect:Rectangle;
      
      public var affineMatrix:Matrix;
      
      public var font:FontInst = null;
      
      public function GraphicsState()
      {
         super();
         this.clipRect = new Rectangle();
         this.affineMatrix = new Matrix();
         this.font = null;
      }
   }
}
