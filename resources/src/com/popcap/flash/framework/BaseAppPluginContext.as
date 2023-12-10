package com.popcap.flash.framework
{
   import flash.events.Event;
   
   public class BaseAppPluginContext implements IAppPluginContext
   {
       
      
      private var mPlugin:BaseAppPlugin;
      
      private var mApp:AppBase;
      
      public function BaseAppPluginContext(param1:AppBase, param2:BaseAppPlugin)
      {
         super();
         this.mApp = param1;
         this.mPlugin = param2;
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this.mApp.willTrigger(param1);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this.mApp.removeEventListener(param1,param2,param3);
      }
      
      public function getService(param1:IAppServiceReference) : Object
      {
         return this.mApp.getService(param1);
      }
      
      public function registerService(param1:Vector.<String>, param2:Object, param3:XML) : IAppServiceRegistration
      {
         return this.mApp.registerService(this.mPlugin,param1,param2,param3);
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this.mApp.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function ungetService(param1:IAppServiceReference) : void
      {
         this.mApp.ungetService(param1);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this.mApp.dispatchEvent(param1);
      }
      
      public function getServiceReferences(param1:String) : Vector.<IAppServiceReference>
      {
         return this.mApp.getServiceReferences(param1);
      }
      
      public function getPlugin() : IAppPlugin
      {
         return this.mPlugin;
      }
      
      public function getPlugins() : Vector.<IAppPlugin>
      {
         return this.mApp.getPlugins();
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this.mApp.hasEventListener(param1);
      }
   }
}
