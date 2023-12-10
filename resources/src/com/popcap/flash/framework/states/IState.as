package com.popcap.flash.framework.states
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   
   public interface IState
   {
       
      
      function update() : void;
      
      function onPop() : void;
      
      function draw(param1:Graphics2D) : void;
      
      function onPush() : void;
      
      function onEnter() : void;
      
      function onExit() : void;
   }
}
