package com.popcap.flash.framework
{
   import flash.events.IEventDispatcher;
   
   public interface IAppPluginContext extends IEventDispatcher
   {
       
      
      function registerService(param1:Vector.<String>, param2:Object, param3:XML) : IAppServiceRegistration;
      
      function getServiceReferences(param1:String) : Vector.<IAppServiceReference>;
      
      function ungetService(param1:IAppServiceReference) : void;
      
      function getPlugin() : IAppPlugin;
      
      function getPlugins() : Vector.<IAppPlugin>;
      
      function getService(param1:IAppServiceReference) : Object;
   }
}
