package com.popcap.flash.framework.utils
{
   import flash.utils.describeType;
   
   public class CEnum
   {
       
      
      public var name:String;
      
      public function CEnum()
      {
         super();
      }
      
      public static function InitEnumConstants(param1:*) : void
      {
         var _loc3_:XML = null;
         var _loc2_:XML = describeType(param1);
         for each(_loc3_ in _loc2_.constant)
         {
            param1[_loc3_.@name].name = _loc3_.@name;
         }
      }
   }
}
