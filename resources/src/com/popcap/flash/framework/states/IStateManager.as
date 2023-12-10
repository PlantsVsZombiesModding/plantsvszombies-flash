package com.popcap.flash.framework.states
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   
   public interface IStateManager
   {
       
      
      function popState() : void;
      
      function changeState(param1:String) : void;
      
      function draw(param1:Graphics2D) : void;
      
      function pushState(param1:String) : void;
      
      function update() : void;
      
      function bindState(param1:String, param2:IState) : void;
   }
}
