package com.popcap.flash.framework.resources.particles
{
   import com.popcap.flash.framework.AppBase;
   
   public class ParticleManager
   {
       
      
      private var mApp:AppBase;
      
      public function ParticleManager(app:AppBase)
      {
         super();
         this.mApp = app;
      }
      
      public function spawnParticleSystem(id:String) : ParticleSystem
      {
         var aTmp:ParticleDefinition = null;
         var aDesc:ParticleDescriptor = this.mApp.resourceManager.getResource(id) as ParticleDescriptor;
         if(aDesc != null)
         {
            aTmp = aDesc.createData(this.mApp);
            this.mApp.resourceManager.setResource(id,aTmp);
         }
         var aData:ParticleDefinition = this.mApp.resourceManager.getResource(id) as ParticleDefinition;
         if(aData == null)
         {
            throw new Error("Particle type \'" + id + "\' is not loaded!");
         }
         var particle:ParticleSystem = new ParticleSystem();
         particle.initFromDef(aData);
         return particle;
      }
   }
}
