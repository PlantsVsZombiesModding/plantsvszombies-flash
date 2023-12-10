package com.popcap.flash.games.pvz.resources
{
   import com.popcap.flash.framework.resources.ResourceLibrary;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   
   public class PVZResources extends Sprite implements ResourceLibrary
   {
       
      
      private var mResources:Dictionary;
      
      public function PVZResources()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this.mResources = new Dictionary();
         PVZImageLoader.init(this.mResources);
         PVZSoundLoader.init(this.mResources);
         PVZFontLoader.init(this.mResources);
         PVZReanimLoader.init(this.mResources);
         PVZParticleLoader.init(this.mResources);
      }
      
      public function getResource(param1:String) : Object
      {
         var _loc2_:String = null;
         if(this.mResources[param1] == null)
         {
            for(_loc2_ in this.mResources)
            {
               trace(_loc2_ + "\n");
            }
         }
         return this.mResources[param1];
      }
   }
}
