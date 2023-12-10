package com.popcap.flash.framework.widgets
{
   public class CFlagsMod
   {
       
      
      public var removeFlags:Number = 0;
      
      public var addFlags:Number = 0;
      
      public function CFlagsMod()
      {
         super();
      }
      
      public static function getModFlags(param1:Number, param2:CFlagsMod) : Number
      {
         return (param1 | param2.addFlags) & ~param2.removeFlags;
      }
   }
}
