package com.popcap.flash.framework.parsers.desc
{
   public class DescriptionParser
   {
       
      
      public function DescriptionParser()
      {
         super();
      }
      
      public function parse(descriptor:String) : Array
      {
         var crFilter:RegExp = /\r/g;
         var commentFilter:RegExp = /^ ?#.*$/gm;
         var nlFilter:RegExp = /\n/g;
         var whitespaceFilter:RegExp = /\t|[ ]+/g;
         descriptor = descriptor.replace(crFilter,"");
         descriptor = descriptor.replace(whitespaceFilter," ");
         descriptor = descriptor.replace(commentFilter,"");
         descriptor = descriptor.replace(nlFilter,"");
         var results:Array = this.parseCommands(descriptor);
         if(results == null)
         {
            return null;
         }
         return results;
      }
      
      private function parseToList(state:ParseState, list:ListDataElement, expectListEnd:Boolean) : Boolean
      {
         var addSingleChar:Boolean = false;
         var aChar:String = null;
         var isSeparator:Boolean = false;
         var childList:ListDataElement = null;
         var inSingleQuotes:* = false;
         var inDoubleQuotes:* = false;
         var isEscaped:Boolean = false;
         var wantTerminate:Boolean = false;
         var keyElement:SingleDataElement = null;
         var currentElement:SingleDataElement = null;
         var len:Number = state.line.length;
         while(state.linePosition < len)
         {
            addSingleChar = false;
            aChar = state.readChar();
            isSeparator = aChar == " " || aChar == ",";
            if(isEscaped)
            {
               addSingleChar = true;
            }
            else
            {
               if(aChar == "\'" && !inDoubleQuotes)
               {
                  inSingleQuotes = !inSingleQuotes;
                  continue;
               }
               if(aChar == "\"" && !inSingleQuotes)
               {
                  inDoubleQuotes = !inDoubleQuotes;
                  continue;
               }
               if(aChar == "\\")
               {
                  isEscaped = true;
               }
               else if(!inSingleQuotes && !inDoubleQuotes)
               {
                  if(aChar == ";")
                  {
                     return true;
                  }
                  if(aChar == ")")
                  {
                     if(expectListEnd)
                     {
                        return true;
                     }
                     throw new Error("Unexpected List End.");
                  }
                  if(aChar == "(")
                  {
                     if(wantTerminate)
                     {
                        currentElement = null;
                        wantTerminate = false;
                     }
                     if(currentElement != null)
                     {
                        throw new Error("Unexpected List Start.");
                     }
                     childList = new ListDataElement();
                     if(!this.parseToList(state,childList,true))
                     {
                        return false;
                     }
                     if(keyElement != null)
                     {
                        keyElement.mValue = childList;
                        keyElement = null;
                     }
                     else
                     {
                        list.mElements.push(childList);
                     }
                  }
                  else if(aChar == "=")
                  {
                     keyElement = currentElement;
                     wantTerminate = true;
                  }
                  else if(isSeparator)
                  {
                     if(currentElement != null && currentElement.mString.length > 0)
                     {
                        wantTerminate = true;
                     }
                  }
                  else
                  {
                     if(wantTerminate)
                     {
                        currentElement = null;
                        wantTerminate = false;
                     }
                     addSingleChar = true;
                  }
               }
               else
               {
                  if(wantTerminate)
                  {
                     currentElement = null;
                     wantTerminate = false;
                  }
                  addSingleChar = true;
               }
            }
            if(addSingleChar)
            {
               if(currentElement == null)
               {
                  currentElement = new SingleDataElement();
                  if(keyElement != null)
                  {
                     keyElement.mValue = currentElement;
                     keyElement = null;
                  }
                  else
                  {
                     list.mElements.push(currentElement);
                  }
               }
               if(isEscaped)
               {
                  currentElement.mString += "\\";
                  isEscaped = false;
               }
               currentElement.mString += aChar;
            }
         }
         if(inSingleQuotes)
         {
            throw new Error("Unterminated Single Quotes.");
         }
         if(inDoubleQuotes)
         {
            throw new Error("Unterminated Double Quotes.");
         }
         if(expectListEnd)
         {
            throw new Error("Unterminated List.");
         }
         return true;
      }
      
      private function parseCommands(line:String) : Array
      {
         var command:ListDataElement = null;
         var elem:DataElement = null;
         var state:ParseState = new ParseState();
         state.line = line;
         state.linePosition = 0;
         var commands:Array = new Array();
         while(!state.isEOF())
         {
            command = new ListDataElement();
            if(!this.parseToList(state,command,false))
            {
               return null;
            }
            commands.push(command);
         }
         var numElements:int = int(commands.length);
         for(var i:int = numElements - 1; i > -1; i += -1)
         {
            elem = commands[i];
         }
         return commands;
      }
   }
}
