package com.popcap.flash.framework.widgets.ui
{
   public interface IButtonListener
   {
       
      
      function buttonPress(param1:Number) : void;
      
      function buttonMouseMove(param1:Number, param2:Number, param3:Number) : void;
      
      function buttonMouseEnter(param1:Number) : void;
      
      function buttonDownTick(param1:Number) : void;
      
      function buttonMouseLeave(param1:Number) : void;
      
      function buttonRelease(param1:Number) : void;
   }
}
