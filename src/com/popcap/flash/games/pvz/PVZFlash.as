package com.popcap.flash.games.pvz
{
	
	import flash.display.Stage;
	
   public class PVZFlash extends PVZApp
   {
       
	   
      public function PVZFlash()
      {
         super();
         appWidth = stage.stageWidth;
         appHeight = stage.stageHeight;
         screenWidth = 540;
         screenHeight = 405;
         init();
      }
   }
}
