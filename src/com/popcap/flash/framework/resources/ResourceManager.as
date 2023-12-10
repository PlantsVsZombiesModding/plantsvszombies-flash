package com.popcap.flash.framework.resources
{
   import com.popcap.flash.framework.AppBase;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   import com.popcap.flash.games.pvz.resources.PVZResources;
   
   public class ResourceManager
   {
       
      
      private var mIsLoading:Boolean;
      
	  //[Embed(source = "../../../../../../bin/resources.swf")]
	  //private var mResourceClass:Class;
	  
	 
      private var mLoader:Loader;
      
      private var mLibrary:ResourceLibrary;
      
      private var mApp:AppBase;
      
      private var mResources:Dictionary;
      
      public function ResourceManager(param1:AppBase)
      {
         super();
         this.mApp = param1;
         this.init();
      }
      
      public function getResource(param1:String) : Object
      {
         if(this.mLibrary == null)
         {
            return this.mResources[param1];
         }
         if(this.mResources[param1] != null)
         {
            return this.mResources[param1];
         }
         return this.mLibrary.getResource(param1);
      }
      
      public function isLoading() : Boolean
      {
         return this.mIsLoading;
      }
      
      public function getPercentageLoaded() : Number
      {
         if(!this.mIsLoading)
         {
            return 1;
         }
         var _loc1_:Number = this.mLoader.contentLoaderInfo.bytesLoaded;
         var _loc2_:Number = this.mLoader.contentLoaderInfo.bytesTotal + 1;
         var _loc3_:Number = _loc1_ / _loc2_;
         if(isNaN(_loc3_))
         {
            return 0;
         }
         return _loc3_;
      }
      
      public function loadResourceLibrary(param1:String) : void
      {
         if(this.mIsLoading)
         {
            throw new Error("Only one library may be loaded at a time.");
         }
         this.mIsLoading = true;
         var _loc2_:URLRequest = new URLRequest(param1);
         this.mLoader.load(_loc2_);
		  var _loc1_:LoaderInfo = this.mLoader.contentLoaderInfo;
         _loc1_.addEventListener(Event.COMPLETE, this.handleLibrary);
		 _loc1_.addEventListener(IOErrorEvent.IO_ERROR, this.handleLoadFailure);
      }
      
      private function init() : void
      {
         this.mResources = new Dictionary();
         this.mIsLoading = false;
         this.mLoader = new Loader();
		 //this.mLibrary = new mResourceClass();
		 this.mLibrary = this.mLoader.content as ResourceLibrary;
		 //var a = 1;
         //var _loc1_:LoaderInfo = this.mLoader.contentLoaderInfo;
         //_loc1_.addEventListener(Event.COMPLETE,this.handleLibrary);
      }
            
	  private function handleLoadFailure(param1:IOErrorEvent) : void
      {
         throw new Error(param1.text);;
      }
	  
      private function handleLibrary(param1:Event) : void
      {
         this.mLibrary = this.mLoader.content as ResourceLibrary;
         this.mIsLoading = false;
      }
      
      public function setResource(param1:String, param2:Object) : void
      {
         this.mResources[param1] = param2;
      }
   }
}
