package com.popcap.flash.games.pvz.renderables
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.render.Renderable;
   import com.popcap.flash.games.pvz.logic.GridItem;
   
   public class GridItemRenderable implements Renderable
   {
       
      
      private var mGridItem:GridItem;
      
      private var mDepth:Number;
      
      public function GridItemRenderable(gridItem:GridItem, depth:Number = 0)
      {
         super();
         this.mGridItem = gridItem;
         this.mDepth = depth;
      }
      
      public function getIsDisposable() : Boolean
      {
         return this.mGridItem.mDead;
      }
      
      public function draw(g:Graphics2D) : void
      {
         this.mGridItem.Draw(g);
      }
      
      public function getDepth() : Number
      {
         return this.mDepth;
      }
      
      public function toString() : String
      {
         return "GridItem@" + this.mDepth;
      }
      
      public function update() : void
      {
         this.mGridItem.Update();
      }
      
      public function getIsVisible() : Boolean
      {
         return true;
      }
   }
}
