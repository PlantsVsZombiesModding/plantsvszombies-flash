package com.popcap.flash.framework.parsers.desc
{
   public class ParseState
   {
       
      
      public var line:String = "";
      
      public var linePosition:Number = 0;
      
      public function ParseState()
      {
         super();
      }
      
      public function isEOF() : Boolean
      {
         return this.linePosition >= this.line.length;
      }
      
      public function readChar() : String
      {
         return this.line.charAt(this.linePosition++);
      }
   }
}
