package com.popcap.flash.framework.resources.particles
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   
   public class ParticleSystem
   {
       
      
      public var mDontUpdate:Boolean;
      
      public var mDead:Boolean;
      
      public var mParticleDef:ParticleDefinition;
      
      public var mEmitterList:Array;
      
      public function ParticleSystem()
      {
         super();
         this.mEmitterList = new Array();
      }
      
      public function die() : void
      {
         var emitter:ParticleEmitter = null;
         for each(emitter in this.mEmitterList)
         {
            emitter.deleteAll();
         }
         this.mEmitterList = new Array();
         this.mDead = true;
      }
      
      public function update() : void
      {
         var aEmitter:ParticleEmitter = null;
         if(this.mDontUpdate)
         {
            return;
         }
         var aEmitterAlive:Boolean = false;
         for each(aEmitter in this.mEmitterList)
         {
            aEmitter.update();
            if(aEmitter.mEmitterDef.mCrossFadeDuration.isSet())
            {
               if(aEmitter.mParticleList.length > 0)
               {
                  aEmitterAlive = true;
               }
            }
            else if(!aEmitter.mDead)
            {
               aEmitterAlive = true;
            }
         }
         if(!aEmitterAlive)
         {
            this.mDead = true;
         }
      }
      
      public function setPosition(x:Number, y:Number) : void
      {
         var aEmitter:ParticleEmitter = null;
         for each(aEmitter in this.mEmitterList)
         {
            aEmitter.setPosition(x,y);
         }
      }
      
      public function initFromDef(def:ParticleDefinition) : void
      {
         var aEmitterDef:ParticleEmitterDefinition = null;
         var aEmitter:ParticleEmitter = null;
         this.mParticleDef = def;
         this.mEmitterList = new Array();
         var aEmitterDefCount:int = int(def.mEmitterDefs.length);
         for(var i:int = 0; i < aEmitterDefCount; i++)
         {
            aEmitterDef = def.mEmitterDefs[i];
            if(!aEmitterDef.mCrossFadeDuration.isSet())
            {
               if(aEmitterDef.mParticleFlags.hasFlags(ParticleFlags.DIE_IF_OVERLOADED) && false)
               {
                  this.die();
                  return;
               }
               aEmitter = new ParticleEmitter();
               aEmitter.initFromDef(aEmitterDef,this);
               this.mEmitterList.push(aEmitter);
            }
         }
         this.mDontUpdate = false;
         this.mDead = false;
      }
      
      public function draw(g:Graphics2D) : void
      {
         var aEmitter:ParticleEmitter = null;
         for each(aEmitter in this.mEmitterList)
         {
            aEmitter.draw(g);
         }
      }
   }
}
