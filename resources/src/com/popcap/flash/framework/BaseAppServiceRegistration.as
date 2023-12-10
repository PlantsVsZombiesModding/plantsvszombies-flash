package com.popcap.flash.framework
{
   public class BaseAppServiceRegistration implements IAppServiceRegistration
   {
       
      
      private var mProperties:XML;
      
      private var mApp:AppBase;
      
      private var mService:Object;
      
      private var mPlugin:BaseAppPlugin;
      
      private var mClasses:Vector.<String>;
      
      public function BaseAppServiceRegistration(param1:AppBase, param2:BaseAppPlugin, param3:Vector.<String>, param4:Object, param5:XML)
      {
         super();
         this.mApp = param1;
         this.mPlugin = param2;
         this.mClasses = param3;
         this.mService = param4;
         this.mProperties = param5;
      }
      
      public function unregister() : void
      {
         throw new Error("Unimplemented stub method.");
      }
      
      public function setProperties(param1:XML) : void
      {
         this.mProperties = param1.copy();
      }
      
      public function getProperties() : XML
      {
         return this.mProperties.copy();
      }
      
      public function getReference() : IAppServiceReference
      {
         return new BaseAppServiceReference(this.mPlugin,this);
      }
      
      public function getService() : Object
      {
         return this.mService;
      }
   }
}
