package com.popcap.flash.framework.parsers.desc
{
   public class ListDataElement extends DataElement
   {
       
      
      public var mElements:Array;
      
      public function ListDataElement()
      {
         super();
         this.mElements = new Array();
      }
      
      public function toString() : String
      {
         return "[" + this.mElements + "]";
      }
   }
}
