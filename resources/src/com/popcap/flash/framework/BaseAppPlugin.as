package com.popcap.flash.framework
{
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   
   public class BaseAppPlugin implements IAppPlugin
   {
       
      
      private var mContext:BaseAppPluginContext;
      
      private var mLoader:Loader;
      
      private var mProperties:XML;
      
      private var mLoaded:Boolean = false;
      
      private var mApp:AppBase;
      
      private var mActivator:IAppPluginActivator;
      
      public function BaseAppPlugin(param1:AppBase, param2:XML)
      {
         super();
         this.mApp = param1;
         this.mLoader = new Loader();
         var _loc3_:LoaderInfo = this.mLoader.contentLoaderInfo;
         _loc3_.addEventListener(IOErrorEvent.IO_ERROR,this.handleLoadFailure);
         _loc3_.addEventListener(Event.COMPLETE,this.handleLoadSuccess);
         this.mProperties = param2;
      }
      
      public function load() : void
      {
         var _loc1_:URLRequest = new URLRequest(this.mProperties.@source);
         this.mLoader.load(_loc1_);
      }
      
      public function getProperties() : XML
      {
         return this.mProperties;
      }
      
      private function handleLoadSuccess(param1:Event) : void
      {
         var _loc2_:LoaderInfo = param1.target as LoaderInfo;
         this.mContext = new BaseAppPluginContext(this.mApp,this);
         this.mActivator = _loc2_.content as IAppPluginActivator;
         this.mActivator.start(this.mContext);
         this.mLoaded = true;
      }
      
      public function isLoaded() : Boolean
      {
         return this.mLoaded;
      }
      
      private function handleLoadFailure(param1:IOErrorEvent) : void
      {
         this.mLoaded = true;
      }
   }
}
