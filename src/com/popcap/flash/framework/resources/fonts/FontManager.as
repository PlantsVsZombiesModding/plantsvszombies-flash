package com.popcap.flash.framework.resources.fonts
{
   import com.popcap.flash.framework.AppBase;
   import flash.utils.Dictionary;
   
   public class FontManager
   {
       
      
      private var mApp:AppBase;
      
      private var mFontDataMap:Dictionary;
      
      private var mFontTypeMap:Dictionary;
      
      public function FontManager(param1:AppBase)
      {
         super();
         this.mApp = param1;
         this.mFontTypeMap = new Dictionary();
         this.mFontDataMap = new Dictionary();
      }
      
      public function addDescriptor(param1:String, param2:FontDescriptor) : void
      {
         this.mApp.resourceManager.setResource(param1,param2);
      }
      
      public function getFontInst(param1:String) : FontInst
      {
         var _loc2_:Object = this.mApp.resourceManager.getResource(param1);
         var _loc3_:FontDescriptor = _loc2_ as FontDescriptor;
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.createFontData(this.mApp);
            this.mApp.resourceManager.setResource(param1,_loc2_);
         }
         var _loc4_:FontData;
         if((_loc4_ = _loc2_ as FontData) == null)
         {
            throw new Error("Font \'" + param1 + "\' is not loaded.");
         }
         return new FontInst(_loc4_);
      }
   }
}
