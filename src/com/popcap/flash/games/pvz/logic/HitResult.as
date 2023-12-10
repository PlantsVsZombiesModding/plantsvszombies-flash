package com.popcap.flash.games.pvz.logic
{
   public class HitResult
   {
      
      private static const OBJECT_TYPE_PLANT:int = 1;
      
      private static const OBJECT_TYPE_SHOVEL:int = 5;
      
      private static const OBJECT_TYPE_PROJECTILE:int = 2;
      
      private static const OBJECT_TYPE_COIN:int = 3;
      
      private static const OBJECT_TYPE_NONE:int = 0;
      
      private static const OBJECT_TYPE_SEEDPACKET:int = 4;
       
      
      public var mObject:Object;
      
      public var mObjectType:int;
      
      public function HitResult()
      {
         super();
      }
   }
}
