package com.popcap.flash.framework.render
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   
   public class RenderManager
   {
       
      
      private var mItems:Array;
      
      public function RenderManager()
      {
         super();
         this.mItems = new Array();
      }
      
      public function add(renderable:Renderable) : void
      {
         var item:Renderable = null;
         var len:int = int(this.mItems.length);
         var depth:Number = renderable.getDepth();
         for(var i:int = 0; i < len; i++)
         {
            item = this.mItems[i];
            if(item.getDepth() > depth)
            {
               this.mItems.splice(i,0,renderable);
               return;
            }
         }
         this.mItems.push(renderable);
      }
      
      private function depthCompare(a:Renderable, b:Renderable) : Number
      {
         return a.getDepth() - b.getDepth();
      }
      
      public function draw(g:Graphics2D) : void
      {
         var anItem:Renderable = null;
         var aNumItems:int = int(this.mItems.length);
         for(var i:int = 0; i < aNumItems; i++)
         {
            anItem = this.mItems[i];
            if(!anItem.getIsDisposable())
            {
               if(anItem.getIsVisible())
               {
                  anItem.draw(g);
               }
            }
         }
      }
      
      public function update() : void
      {
         var anItem:Renderable = null;
         var aNumItems:int = int(this.mItems.length);
         for(var i:int = 0; i < aNumItems; i++)
         {
            anItem = this.mItems[i];
            if(!anItem.getIsDisposable())
            {
               anItem.update();
            }
         }
         this.mItems = this.mItems.filter(this.isAliveFilter);
      }
      
      private function isAliveFilter(item:*, index:int, array:Array) : Boolean
      {
         var aRenderable:Renderable = item as Renderable;
         return !aRenderable.getIsDisposable();
      }
   }
}
