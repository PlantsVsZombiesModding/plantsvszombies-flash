package com.popcap.flash.framework.resources.reanimator
{
   import com.popcap.flash.framework.AppBase;
   import flash.events.EventDispatcher;
   
   public class Reanimator extends EventDispatcher
   {
       
      
      private var mApp:AppBase;
      
      public function Reanimator(app:AppBase)
      {
         super();
         this.mApp = app;
      }
      
      public function loadReanim(id:String, reanimDesc:ReanimDescriptor) : void
      {
         var aData:ReanimDefinition = reanimDesc.createReanimData(this.mApp);
         this.mApp.resourceManager.setResource(id,aData);
      }
      
      public function createReanimation(id:String) : Reanimation
      {
         var aTmp:ReanimDefinition = null;
         var aDesc:ReanimDescriptor = this.mApp.resourceManager.getResource(id) as ReanimDescriptor;
         if(aDesc != null)
         {
            aTmp = aDesc.createReanimData(this.mApp);
            this.mApp.resourceManager.setResource(id,aTmp);
         }
         var aData:ReanimDefinition = this.mApp.resourceManager.getResource(id) as ReanimDefinition;
         if(aData == null)
         {
            throw new Error("Reanimation type \'" + id + "\' is not loaded!");
         }
         return new Reanimation(aData);
      }
   }
}
