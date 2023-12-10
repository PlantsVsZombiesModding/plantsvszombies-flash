package com.popcap.flash.framework.parsers.desc
{
   public class SingleDataElement extends DataElement
   {
       
      
      public var mValue:DataElement;
      
      public var mString:String = "";
      
      public function SingleDataElement()
      {
         super();
      }
      
      public function toString() : String
      {
         return this.mString;
      }
   }
}
