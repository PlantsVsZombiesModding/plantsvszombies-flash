package com.popcap.flash.framework.resources.images
{
   import com.popcap.flash.framework.AppBase;
   
   public class ImageManager
   {
       
      
      private var mApp:AppBase;
      
      public function ImageManager(param1:AppBase)
      {
         super();
         this.mApp = param1;
      }
      
      public function getImageInst(param1:String) : ImageInst
      {
         var _loc2_:Object = this.mApp.resourceManager.getResource(param1);
         var _loc3_:ImageDescriptor = _loc2_ as ImageDescriptor;
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.createData();
            this.mApp.resourceManager.setResource(param1,_loc2_);
         }
         var _loc4_:ImageData;
         if((_loc4_ = _loc2_ as ImageData) == null)
         {
            throw new Error("Image \'" + param1 + "\' is not loaded.");
         }
         return new ImageInst(_loc4_);
      }
      
      public function addDescriptor(param1:String, param2:ImageDescriptor) : void
      {
         this.mApp.resourceManager.setResource(param1,param2);
      }
   }
}
