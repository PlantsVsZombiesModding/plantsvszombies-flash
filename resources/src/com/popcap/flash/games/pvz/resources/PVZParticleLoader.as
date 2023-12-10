package com.popcap.flash.games.pvz.resources
{
   import com.popcap.flash.framework.resources.particles.ByteParticleDescriptor;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class PVZParticleLoader
   {
      
      public static const PARTICLE_ZOMBIEFLAG_CLASS:Class = PVZParticleLoader_PARTICLE_ZOMBIEFLAG_CLASS;
      
      public static const PARTICLE_SNOWPEASPLAT_CLASS:Class = PVZParticleLoader_PARTICLE_SNOWPEASPLAT_CLASS;
      
      public static const PARTICLE_DIGGERRISE_CLASS:Class = PVZParticleLoader_PARTICLE_DIGGERRISE_CLASS;
      
      public static const PARTICLE_STARBURST_CLASS:Class = PVZParticleLoader_PARTICLE_STARBURST_CLASS;
      
      public static const PARTICLE_ZOMBIEHEADLIGHT_CLASS:Class = PVZParticleLoader_PARTICLE_ZOMBIEHEADLIGHT_CLASS;
      
      public static const PARTICLE_ZOMBIENEWSPAPERHEAD_CLASS:Class = PVZParticleLoader_PARTICLE_ZOMBIENEWSPAPERHEAD_CLASS;
      
      public static const PARTICLE_ZOMBIEHEADPOOL_CLASS:Class = PVZParticleLoader_PARTICLE_ZOMBIEHEADPOOL_CLASS;
      
      public static const PARTICLE_COINPICKUPARROW_CLASS:Class = PVZParticleLoader_PARTICLE_COINPICKUPARROW_CLASS;
      
      public static const PARTICLE_VASESHATTERLEAF_CLASS:Class = PVZParticleLoader_PARTICLE_VASESHATTERLEAF_CLASS;
      
      public static const PARTICLE_VASESHATTERZOMBIE_CLASS:Class = PVZParticleLoader_PARTICLE_VASESHATTERZOMBIE_CLASS;
      
      public static const PARTICLE_GRAVEBUSTER_CLASS:Class = PVZParticleLoader_PARTICLE_GRAVEBUSTER_CLASS;
      
      public static const PARTICLE_WALLNUTEATLARGE_CLASS:Class = PVZParticleLoader_PARTICLE_WALLNUTEATLARGE_CLASS;
      
      public static const PARTICLE_PUFFSHROOMTRAIL_CLASS:Class = PVZParticleLoader_PARTICLE_PUFFSHROOMTRAIL_CLASS;
      
      public static const PARTICLE_ZOMBIENEWSPAPER_CLASS:Class = PVZParticleLoader_PARTICLE_ZOMBIENEWSPAPER_CLASS;
      
      public static const PARTICLE_PEASPLAT_CLASS:Class = PVZParticleLoader_PARTICLE_PEASPLAT_CLASS;
      
      public static const PARTICLE_ARTCHALLENGEPLANT_CLASS:Class = PVZParticleLoader_PARTICLE_ARTCHALLENGEPLANT_CLASS;
      
      public static const PARTICLE_DUST_SQUASH_CLASS:Class = PVZParticleLoader_PARTICLE_DUST_SQUASH_CLASS;
      
      public static const PARTICLE_SEEDPACKETFLASH_CLASS:Class = PVZParticleLoader_PARTICLE_SEEDPACKETFLASH_CLASS;
      
      public static const PARTICLE_JACKEXPLODE_CLASS:Class = PVZParticleLoader_PARTICLE_JACKEXPLODE_CLASS;
      
      public static const PARTICLE_MOWEREDZOMBIEARM_CLASS:Class = PVZParticleLoader_PARTICLE_MOWEREDZOMBIEARM_CLASS;
      
      public static const PARTICLE_SEEDPACKET_CLASS:Class = PVZParticleLoader_PARTICLE_SEEDPACKET_CLASS;
      
      public static const PARTICLE_POTATOMINE_CLASS:Class = PVZParticleLoader_PARTICLE_POTATOMINE_CLASS;
      
      public static const PARTICLE_ZOMBIEPAIL_CLASS:Class = PVZParticleLoader_PARTICLE_ZOMBIEPAIL_CLASS;
      
      public static const PARTICLE_POWIE_CLASS:Class = PVZParticleLoader_PARTICLE_POWIE_CLASS;
      
      public static const PARTICLE_ZOMBIEARM_CLASS:Class = PVZParticleLoader_PARTICLE_ZOMBIEARM_CLASS;
      
      public static const PARTICLE_UPSELLARROW_CLASS:Class = PVZParticleLoader_PARTICLE_UPSELLARROW_CLASS;
      
      public static const PARTICLE_PUFFSPLAT_CLASS:Class = PVZParticleLoader_PARTICLE_PUFFSPLAT_CLASS;
      
      public static const PARTICLE_ZOMBIEHEAD_CLASS:Class = PVZParticleLoader_PARTICLE_ZOMBIEHEAD_CLASS;
      
      public static const PARTICLE_ZOMBIEPOLEVALUTHEAD_CLASS:Class = PVZParticleLoader_PARTICLE_ZOMBIEPOLEVALUTHEAD_CLASS;
      
      public static const PARTICLE_SODROLL_CLASS:Class = PVZParticleLoader_PARTICLE_SODROLL_CLASS;
      
      public static const PARTICLE_ICETRAP_CLASS:Class = PVZParticleLoader_PARTICLE_ICETRAP_CLASS;
      
      public static const PARTICLE_PLANTING_CLASS:Class = PVZParticleLoader_PARTICLE_PLANTING_CLASS;
      
      public static const PARTICLE_SEEDPACKETPICKUP_CLASS:Class = PVZParticleLoader_PARTICLE_SEEDPACKETPICKUP_CLASS;
      
      public static const PARTICLE_AWARD_CLASS:Class = PVZParticleLoader_PARTICLE_AWARD_CLASS;
      
      public static const PARTICLE_ZOMBIERISE_CLASS:Class = PVZParticleLoader_PARTICLE_ZOMBIERISE_CLASS;
      
      public static const PARTICLE_MOWERCLOUD_CLASS:Class = PVZParticleLoader_PARTICLE_MOWERCLOUD_CLASS;
      
      public static const PARTICLE_MOWEREDZOMBIEHEAD_CLASS:Class = PVZParticleLoader_PARTICLE_MOWEREDZOMBIEHEAD_CLASS;
      
      public static const PARTICLE_ZOMBIEFOOTBALLARM_CLASS:Class = PVZParticleLoader_PARTICLE_ZOMBIEFOOTBALLARM_CLASS;
      
      public static const PARTICLE_DIGGERTUNNEL_CLASS:Class = PVZParticleLoader_PARTICLE_DIGGERTUNNEL_CLASS;
      
      public static const PARTICLE_ZOMBIEFOOTBALLHEAD_CLASS:Class = PVZParticleLoader_PARTICLE_ZOMBIEFOOTBALLHEAD_CLASS;
      
      public static const PARTICLE_PRESENTPICKUP_CLASS:Class = PVZParticleLoader_PARTICLE_PRESENTPICKUP_CLASS;
      
      public static const PARTICLE_VASESHATTER_CLASS:Class = PVZParticleLoader_PARTICLE_VASESHATTER_CLASS;
      
      public static const PARTICLE_ZOMBIEHELMET_CLASS:Class = PVZParticleLoader_PARTICLE_ZOMBIEHELMET_CLASS;
      
      public static const PARTICLE_ZOMBIEPOLEVAULTARM_CLASS:Class = PVZParticleLoader_PARTICLE_ZOMBIEPOLEVAULTARM_CLASS;
      
      public static const PARTICLE_AWARDPICKUPARROW_CLASS:Class = PVZParticleLoader_PARTICLE_AWARDPICKUPARROW_CLASS;
      
      public static const PARTICLE_ZOMBIEDOOR_CLASS:Class = PVZParticleLoader_PARTICLE_ZOMBIEDOOR_CLASS;
      
      public static const PARTICLE_PUFFSHROOMMUZZLE_CLASS:Class = PVZParticleLoader_PARTICLE_PUFFSHROOMMUZZLE_CLASS;
      
      public static const PARTICLE_ZOMBIETRAFFICCONE_CLASS:Class = PVZParticleLoader_PARTICLE_ZOMBIETRAFFICCONE_CLASS;
      
      public static const PARTICLE_SCREENFLASH_CLASS:Class = PVZParticleLoader_PARTICLE_SCREENFLASH_CLASS;
      
      public static const PARTICLE_GRAVEBUSTERDIE_CLASS:Class = PVZParticleLoader_PARTICLE_GRAVEBUSTERDIE_CLASS;
      
      public static const PARTICLE_SEEDPACKETPICK_CLASS:Class = PVZParticleLoader_PARTICLE_SEEDPACKETPICK_CLASS;
      
      public static const PARTICLE_CIRCLEEVENSPACING_CLASS:Class = PVZParticleLoader_PARTICLE_CIRCLEEVENSPACING_CLASS;
      
      public static const PARTICLE_ICESPARKLE_CLASS:Class = PVZParticleLoader_PARTICLE_ICESPARKLE_CLASS;
      
      public static const PARTICLE_SNOWPEAPUFF_CLASS:Class = PVZParticleLoader_PARTICLE_SNOWPEAPUFF_CLASS;
      
      public static const PARTICLE_SNOWPEATRAIL_CLASS:Class = PVZParticleLoader_PARTICLE_SNOWPEATRAIL_CLASS;
      
      public static const PARTICLE_WALLNUTEATSMALL_CLASS:Class = PVZParticleLoader_PARTICLE_WALLNUTEATSMALL_CLASS;
      
      public static const PARTICLE_FUMECLOUD_CLASS:Class = PVZParticleLoader_PARTICLE_FUMECLOUD_CLASS;
      
      public static const PARTICLE_GRAVESTONERISE_CLASS:Class = PVZParticleLoader_PARTICLE_GRAVESTONERISE_CLASS;
      
      public static const PARTICLE_POTATOMINERISE_CLASS:Class = PVZParticleLoader_PARTICLE_POTATOMINERISE_CLASS;
       
      
      public function PVZParticleLoader()
      {
         super();
      }
      
      public static function init(param1:Dictionary) : void
      {
         param1[PVZParticles.PARTICLE_ARTCHALLENGEPLANT] = new ByteParticleDescriptor(new PARTICLE_ARTCHALLENGEPLANT_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_AWARD] = new ByteParticleDescriptor(new PARTICLE_AWARD_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_AWARDPICKUPARROW] = new ByteParticleDescriptor(new PARTICLE_AWARDPICKUPARROW_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_CIRCLEEVENSPACING] = new ByteParticleDescriptor(new PARTICLE_CIRCLEEVENSPACING_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_COINPICKUPARROW] = new ByteParticleDescriptor(new PARTICLE_COINPICKUPARROW_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_DIGGERRISE] = new ByteParticleDescriptor(new PARTICLE_DIGGERRISE_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_DIGGERTUNNEL] = new ByteParticleDescriptor(new PARTICLE_DIGGERTUNNEL_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_DUST_SQUASH] = new ByteParticleDescriptor(new PARTICLE_DUST_SQUASH_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_FUMECLOUD] = new ByteParticleDescriptor(new PARTICLE_FUMECLOUD_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_GRAVEBUSTER] = new ByteParticleDescriptor(new PARTICLE_GRAVEBUSTER_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_GRAVEBUSTERDIE] = new ByteParticleDescriptor(new PARTICLE_GRAVEBUSTERDIE_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_GRAVESTONERISE] = new ByteParticleDescriptor(new PARTICLE_GRAVESTONERISE_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_ICESPARKLE] = new ByteParticleDescriptor(new PARTICLE_ICESPARKLE_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_ICETRAP] = new ByteParticleDescriptor(new PARTICLE_ICETRAP_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_JACKEXPLODE] = new ByteParticleDescriptor(new PARTICLE_JACKEXPLODE_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_MOWERCLOUD] = new ByteParticleDescriptor(new PARTICLE_MOWERCLOUD_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_MOWEREDZOMBIEARM] = new ByteParticleDescriptor(new PARTICLE_MOWEREDZOMBIEARM_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_MOWEREDZOMBIEHEAD] = new ByteParticleDescriptor(new PARTICLE_MOWEREDZOMBIEHEAD_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_PEASPLAT] = new ByteParticleDescriptor(new PARTICLE_PEASPLAT_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_PLANTING] = new ByteParticleDescriptor(new PARTICLE_PLANTING_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_POTATOMINE] = new ByteParticleDescriptor(new PARTICLE_POTATOMINE_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_POTATOMINERISE] = new ByteParticleDescriptor(new PARTICLE_POTATOMINERISE_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_POWIE] = new ByteParticleDescriptor(new PARTICLE_POWIE_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_PRESENTPICKUP] = new ByteParticleDescriptor(new PARTICLE_PRESENTPICKUP_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_PUFFSHROOMMUZZLE] = new ByteParticleDescriptor(new PARTICLE_PUFFSHROOMMUZZLE_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_PUFFSHROOMTRAIL] = new ByteParticleDescriptor(new PARTICLE_PUFFSHROOMTRAIL_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_PUFFSPLAT] = new ByteParticleDescriptor(new PARTICLE_PUFFSPLAT_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_SCREENFLASH] = new ByteParticleDescriptor(new PARTICLE_SCREENFLASH_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_SEEDPACKET] = new ByteParticleDescriptor(new PARTICLE_SEEDPACKET_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_SEEDPACKETFLASH] = new ByteParticleDescriptor(new PARTICLE_SEEDPACKETFLASH_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_SEEDPACKETPICK] = new ByteParticleDescriptor(new PARTICLE_SEEDPACKETPICK_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_SEEDPACKETPICKUP] = new ByteParticleDescriptor(new PARTICLE_SEEDPACKETPICKUP_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_SNOWPEAPUFF] = new ByteParticleDescriptor(new PARTICLE_SNOWPEAPUFF_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_SNOWPEASPLAT] = new ByteParticleDescriptor(new PARTICLE_SNOWPEASPLAT_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_SNOWPEATRAIL] = new ByteParticleDescriptor(new PARTICLE_SNOWPEATRAIL_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_SODROLL] = new ByteParticleDescriptor(new PARTICLE_SODROLL_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_STARBURST] = new ByteParticleDescriptor(new PARTICLE_STARBURST_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_UPSELLARROW] = new ByteParticleDescriptor(new PARTICLE_UPSELLARROW_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_VASESHATTER] = new ByteParticleDescriptor(new PARTICLE_VASESHATTER_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_VASESHATTERLEAF] = new ByteParticleDescriptor(new PARTICLE_VASESHATTERLEAF_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_VASESHATTERZOMBIE] = new ByteParticleDescriptor(new PARTICLE_VASESHATTERZOMBIE_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_WALLNUTEATLARGE] = new ByteParticleDescriptor(new PARTICLE_WALLNUTEATLARGE_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_WALLNUTEATSMALL] = new ByteParticleDescriptor(new PARTICLE_WALLNUTEATSMALL_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_ZOMBIEARM] = new ByteParticleDescriptor(new PARTICLE_ZOMBIEARM_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_ZOMBIEDOOR] = new ByteParticleDescriptor(new PARTICLE_ZOMBIEDOOR_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_ZOMBIEFLAG] = new ByteParticleDescriptor(new PARTICLE_ZOMBIEFLAG_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_ZOMBIEFOOTBALLARM] = new ByteParticleDescriptor(new PARTICLE_ZOMBIEFOOTBALLARM_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_ZOMBIEFOOTBALLHEAD] = new ByteParticleDescriptor(new PARTICLE_ZOMBIEFOOTBALLHEAD_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_ZOMBIEHEAD] = new ByteParticleDescriptor(new PARTICLE_ZOMBIEHEAD_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_ZOMBIEHEADLIGHT] = new ByteParticleDescriptor(new PARTICLE_ZOMBIEHEADLIGHT_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_ZOMBIEHEADPOOL] = new ByteParticleDescriptor(new PARTICLE_ZOMBIEHEADPOOL_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_ZOMBIEHELMET] = new ByteParticleDescriptor(new PARTICLE_ZOMBIEHELMET_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_ZOMBIENEWSPAPER] = new ByteParticleDescriptor(new PARTICLE_ZOMBIENEWSPAPER_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_ZOMBIENEWSPAPERHEAD] = new ByteParticleDescriptor(new PARTICLE_ZOMBIENEWSPAPERHEAD_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_ZOMBIEPAIL] = new ByteParticleDescriptor(new PARTICLE_ZOMBIEPAIL_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_ZOMBIEPOLEVALUTHEAD] = new ByteParticleDescriptor(new PARTICLE_ZOMBIEPOLEVALUTHEAD_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_ZOMBIEPOLEVAULTARM] = new ByteParticleDescriptor(new PARTICLE_ZOMBIEPOLEVAULTARM_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_ZOMBIERISE] = new ByteParticleDescriptor(new PARTICLE_ZOMBIERISE_CLASS() as ByteArray);
         param1[PVZParticles.PARTICLE_ZOMBIETRAFFICCONE] = new ByteParticleDescriptor(new PARTICLE_ZOMBIETRAFFICCONE_CLASS() as ByteArray);
      }
   }
}
