package com.popcap.flash.framework
{
   public class BaseAppServiceReference implements IAppServiceReference
   {
       
      
      private var mPlugin:BaseAppPlugin;
      
      private var mRegistration:BaseAppServiceRegistration;
      
      public function BaseAppServiceReference(param1:BaseAppPlugin, param2:BaseAppServiceRegistration)
      {
         super();
         this.mPlugin = param1;
         this.mRegistration = param2;
      }
      
      public function getProperties() : XML
      {
         return this.mRegistration.getProperties();
      }
      
      public function getUsingPlugins() : Vector.<IAppPlugin>
      {
         throw new Error("Unimplemented stub method.");
      }
      
      public function getPlugin() : IAppPlugin
      {
         return this.mPlugin;
      }
   }
}
