package com.popcap.flash.games.pvz.logic
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.games.pvz.PVZApp;
   
   public class GameObject
   {
      
      public static const RENDER_LAYER_GROUND:int = 200000;
      
      public static const RENDER_LAYER_UI_TOP:int = 700000;
      
      public static const RENDER_LAYER_LAWN:int = 300000;
      
      public static const RENDER_LAYER_PARTICLE:int = RENDER_LAYER_LAWN + 7000;
      
      public static const RENDER_LAYER_PLANT:int = RENDER_LAYER_LAWN + 2000;
      
      public static const RENDER_LAYER_LAWN_MOWER:int = RENDER_LAYER_LAWN + 6000;
      
      public static const RENDER_LAYER_PROJECTILE:int = RENDER_LAYER_LAWN + 5000;
      
      public static const RENDER_LAYER_FOG:int = 500000;
      
      public static const RENDER_LAYER_ABOVE_UI:int = 800000;
      
      public static const RENDER_LAYER_COIN_BANK:int = 600000;
      
      public static const RENDER_LAYER_GRAVE_STONE:int = RENDER_LAYER_LAWN + 1000;
      
      public static const RENDER_LAYER_SCREEN_FADE:int = 900000;
      
      public static const RENDER_LAYER_ZOMBIE:int = RENDER_LAYER_LAWN + 3000;
      
      public static const RENDER_LAYER_TOP:int = 400000;
      
      public static const RENDER_LAYER_UI_BOTTOM:int = 100000;
       
      
      public var mBoard:Board;
      
      public var app:PVZApp;
      
      public var mRenderOrder:int;
      
      public var mVisible:Boolean;
      
      public var mX:int;
      
      public var mY:int;
      
      public var mRow:int;
      
      public var mHeight:int;
      
      public var mWidth:int;
      
      public function GameObject()
      {
         super();
      }
      
      public function MakeParentGraphicsFrame(g:Graphics2D) : void
      {
      }
      
      public function BeginDraw(g:Graphics2D) : Boolean
      {
         if(!this.mVisible)
         {
            return false;
         }
         g.translate(this.mX,this.mY);
         return true;
      }
      
      public function EndDraw(g:Graphics2D) : void
      {
         g.translate(-this.mX,-this.mY);
      }
   }
}
