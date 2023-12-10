package com.popcap.flash.framework.widgets
{
   public class CModalFlags
   {
       
      
      public var overFlags:Number = 0;
      
      public var isOver:Boolean = false;
      
      public var underFlags:Number = 0;
      
      public function CModalFlags()
      {
         super();
      }
      
      public function getFlags() : Number
      {
         return this.isOver ? this.overFlags : this.underFlags;
      }
   }
}
