package com.popcap.flash.framework.render
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   
   public interface Renderable
   {
       
      
      function getIsDisposable() : Boolean;
      
      function getIsVisible() : Boolean;
      
      function draw(param1:Graphics2D) : void;
      
      function update() : void;
      
      function getDepth() : Number;
   }
}
