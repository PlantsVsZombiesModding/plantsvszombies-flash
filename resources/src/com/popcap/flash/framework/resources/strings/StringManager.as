package com.popcap.flash.framework.resources.strings
{
   import com.popcap.flash.framework.AppBase;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   
   public class StringManager implements IEventDispatcher
   {
       
      
      private var mLoader:URLLoader;
      
      private var mApp:AppBase;
      
      private var mStrings:Dictionary;
      
      private var mDispatcher:EventDispatcher;
      
      public function StringManager(param1:AppBase)
      {
         super();
         this.mApp = param1;
         this.mStrings = new Dictionary();
         this.mLoader = new URLLoader();
         this.mLoader.addEventListener(Event.COMPLETE,this.handleComplete);
         this.mLoader.addEventListener(IOErrorEvent.IO_ERROR,this.handleError);
         this.mDispatcher = new EventDispatcher(this);
      }
      
      private function handleComplete(param1:Event) : void
      {
         var _loc8_:String = null;
         var _loc9_:Number = NaN;
         var _loc2_:String = this.mLoader.data;
         _loc2_ = _loc2_.replace(/\r\n/g,"\n");
         _loc2_ = _loc2_.replace(/\r/g,"\n");
         var _loc3_:Array = _loc2_.split(/\n/);
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:int = int(_loc3_.length);
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            if((_loc8_ = String(_loc3_[_loc7_])).length != 0)
            {
               if((_loc9_ = _loc8_.search(/\[[A-Z0-9_]+\]/)) == 0)
               {
                  if(_loc4_ == null)
                  {
                     _loc4_ = _loc8_;
                  }
                  else
                  {
                     this.mStrings[_loc4_] = _loc5_;
                     _loc4_ = _loc8_;
                     _loc5_ = null;
                  }
               }
               else if(_loc5_ == null)
               {
                  _loc5_ = _loc8_;
               }
               else
               {
                  _loc5_ = _loc5_ + "\n" + _loc8_;
               }
            }
            _loc7_++;
         }
         this.mStrings[_loc4_] = _loc5_;
         this.mDispatcher.dispatchEvent(new Event(Event.COMPLETE));
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this.mDispatcher.hasEventListener(param1);
      }
      
      private function handleError(param1:IOErrorEvent) : void
      {
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this.mDispatcher.willTrigger(param1);
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this.mDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this.mDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this.mDispatcher.dispatchEvent(param1);
      }
      
      public function loadStrings(param1:String) : void
      {
         var _loc2_:URLRequest = new URLRequest(param1);
         this.mLoader.load(_loc2_);
      }
      
      public function translateString(param1:String) : String
      {
         var _loc2_:String = String(this.mStrings[param1]);
         if(_loc2_ == null)
         {
            return "\'" + param1 + "\' string has not been loaded.";
         }
         return _loc2_;
      }
   }
}
