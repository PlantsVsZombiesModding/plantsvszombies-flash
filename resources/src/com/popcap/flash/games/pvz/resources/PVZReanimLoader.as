package com.popcap.flash.games.pvz.resources
{
   import com.popcap.flash.framework.resources.reanimator.ByteReanimDescriptor;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class PVZReanimLoader
   {
      
      private static const REANIM_ZOMBIE_FOOTBALL_CLASS:Class = PVZReanimLoader_REANIM_ZOMBIE_FOOTBALL_CLASS;
      
      private static const REANIM_ZOMBIE_PAPER_CLASS:Class = PVZReanimLoader_REANIM_ZOMBIE_PAPER_CLASS;
      
      private static const REANIM_ZOMBIE_HAND_CLASS:Class = PVZReanimLoader_REANIM_ZOMBIE_HAND_CLASS;
      
      private static const REANIM_DYNOMITE_CLASS:Class = PVZReanimLoader_REANIM_DYNOMITE_CLASS;
      
      private static const REANIM_ZOMBIE_CLASS:Class = PVZReanimLoader_REANIM_ZOMBIE_CLASS;
      
      private static const REANIM_SUNFLOWER_CLASS:Class = PVZReanimLoader_REANIM_SUNFLOWER_CLASS;
      
      private static const REANIM_PUFFSHROOM_CLASS:Class = PVZReanimLoader_REANIM_PUFFSHROOM_CLASS;
      
      private static const REANIM_LOADBAR_ZOMBIEHEAD_CLASS:Class = PVZReanimLoader_REANIM_LOADBAR_ZOMBIEHEAD_CLASS;
      
      private static const REANIM_ZOMBIE_CHARRED_CLASS:Class = PVZReanimLoader_REANIM_ZOMBIE_CHARRED_CLASS;
      
      private static const REANIM_CHOMPER_CLASS:Class = PVZReanimLoader_REANIM_CHOMPER_CLASS;
      
      private static const REANIM_SUNSHROOM_CLASS:Class = PVZReanimLoader_REANIM_SUNSHROOM_CLASS;
      
      private static const REANIM_LAWNMOWER_CLASS:Class = PVZReanimLoader_REANIM_LAWNMOWER_CLASS;
      
      private static const REANIM_SELECTORSCREEN_CLASS:Class = PVZReanimLoader_REANIM_SELECTORSCREEN_CLASS;
      
      private static const REANIM_WALLNUT_CLASS:Class = PVZReanimLoader_REANIM_WALLNUT_CLASS;
      
      private static const REANIM_SODROLL_CLASS:Class = PVZReanimLoader_REANIM_SODROLL_CLASS;
      
      private static const REANIM_HAMMER_CLASS:Class = PVZReanimLoader_REANIM_HAMMER_CLASS;
      
      private static const REANIM_SUN_CLASS:Class = PVZReanimLoader_REANIM_SUN_CLASS;
      
      private static const REANIM_FUMESHROOM_CLASS:Class = PVZReanimLoader_REANIM_FUMESHROOM_CLASS;
      
      private static const REANIM_LEFTPEATER_CLASS:Class = PVZReanimLoader_REANIM_LEFTPEATER_CLASS;
      
      private static const REANIM_LOADBAR_SPROUT_CLASS:Class = PVZReanimLoader_REANIM_LOADBAR_SPROUT_CLASS;
      
      private static const REANIM_ZOMBIE_POLEVAULTER_CLASS:Class = PVZReanimLoader_REANIM_ZOMBIE_POLEVAULTER_CLASS;
      
      private static const REANIM_GRAVEBUSTER_CLASS:Class = PVZReanimLoader_REANIM_GRAVEBUSTER_CLASS;
      
      private static const REANIM_SNOWPEA_CLASS:Class = PVZReanimLoader_REANIM_SNOWPEA_CLASS;
      
      private static const REANIM_CHERRYBOMB_CLASS:Class = PVZReanimLoader_REANIM_CHERRYBOMB_CLASS;
      
      private static const REANIM_SQUASH_CLASS:Class = PVZReanimLoader_REANIM_SQUASH_CLASS;
      
      private static const REANIM_PEASHOOTER_CLASS:Class = PVZReanimLoader_REANIM_PEASHOOTER_CLASS;
      
      private static const REANIM_LAWNMOWEREDZOMBIE_CLASS:Class = PVZReanimLoader_REANIM_LAWNMOWEREDZOMBIE_CLASS;
      
      private static const REANIM_CRAZYDAVE_CLASS:Class = PVZReanimLoader_REANIM_CRAZYDAVE_CLASS;
      
      private static const REANIM_PEASHOOTERSINGLE_CLASS:Class = PVZReanimLoader_REANIM_PEASHOOTERSINGLE_CLASS;
       
      
      public function PVZReanimLoader()
      {
         super();
      }
      
      public static function init(param1:Dictionary) : void
      {
         param1[PVZReanims.REANIM_CHERRYBOMB] = new ByteReanimDescriptor(new REANIM_CHERRYBOMB_CLASS() as ByteArray);
         param1[PVZReanims.REANIM_CHOMPER] = new ByteReanimDescriptor(new REANIM_CHOMPER_CLASS() as ByteArray);
         param1[PVZReanims.REANIM_CRAZYDAVE] = new ByteReanimDescriptor(new REANIM_CRAZYDAVE_CLASS() as ByteArray);
         param1[PVZReanims.REANIM_DYNOMITE] = new ByteReanimDescriptor(new REANIM_DYNOMITE_CLASS() as ByteArray);
         param1[PVZReanims.REANIM_FUMESHROOM] = new ByteReanimDescriptor(new REANIM_FUMESHROOM_CLASS() as ByteArray);
         param1[PVZReanims.REANIM_GRAVEBUSTER] = new ByteReanimDescriptor(new REANIM_GRAVEBUSTER_CLASS() as ByteArray);
         param1[PVZReanims.REANIM_HAMMER] = new ByteReanimDescriptor(new REANIM_HAMMER_CLASS() as ByteArray);
         param1[PVZReanims.REANIM_LAWNMOWER] = new ByteReanimDescriptor(new REANIM_LAWNMOWER_CLASS() as ByteArray);
         param1[PVZReanims.REANIM_LAWNMOWEREDZOMBIE] = new ByteReanimDescriptor(new REANIM_LAWNMOWEREDZOMBIE_CLASS() as ByteArray);
         param1[PVZReanims.REANIM_LEFTPEATER] = new ByteReanimDescriptor(new REANIM_LEFTPEATER_CLASS() as ByteArray);
         param1[PVZReanims.REANIM_LOADBAR_SPROUT] = new ByteReanimDescriptor(new REANIM_LOADBAR_SPROUT_CLASS() as ByteArray);
         param1[PVZReanims.REANIM_LOADBAR_ZOMBIEHEAD] = new ByteReanimDescriptor(new REANIM_LOADBAR_ZOMBIEHEAD_CLASS() as ByteArray);
         param1[PVZReanims.REANIM_PEASHOOTER] = new ByteReanimDescriptor(new REANIM_PEASHOOTER_CLASS() as ByteArray);
         param1[PVZReanims.REANIM_PEASHOOTERSINGLE] = new ByteReanimDescriptor(new REANIM_PEASHOOTERSINGLE_CLASS() as ByteArray);
         param1[PVZReanims.REANIM_PUFFSHROOM] = new ByteReanimDescriptor(new REANIM_PUFFSHROOM_CLASS() as ByteArray);
         param1[PVZReanims.REANIM_SELECTORSCREEN] = new ByteReanimDescriptor(new REANIM_SELECTORSCREEN_CLASS() as ByteArray);
         param1[PVZReanims.REANIM_SNOWPEA] = new ByteReanimDescriptor(new REANIM_SNOWPEA_CLASS() as ByteArray);
         param1[PVZReanims.REANIM_SODROLL] = new ByteReanimDescriptor(new REANIM_SODROLL_CLASS() as ByteArray);
         param1[PVZReanims.REANIM_SQUASH] = new ByteReanimDescriptor(new REANIM_SQUASH_CLASS() as ByteArray);
         param1[PVZReanims.REANIM_SUN] = new ByteReanimDescriptor(new REANIM_SUN_CLASS() as ByteArray);
         param1[PVZReanims.REANIM_SUNFLOWER] = new ByteReanimDescriptor(new REANIM_SUNFLOWER_CLASS() as ByteArray);
         param1[PVZReanims.REANIM_SUNSHROOM] = new ByteReanimDescriptor(new REANIM_SUNSHROOM_CLASS() as ByteArray);
         param1[PVZReanims.REANIM_WALLNUT] = new ByteReanimDescriptor(new REANIM_WALLNUT_CLASS() as ByteArray);
         param1[PVZReanims.REANIM_ZOMBIE] = new ByteReanimDescriptor(new REANIM_ZOMBIE_CLASS() as ByteArray);
         param1[PVZReanims.REANIM_ZOMBIE_CHARRED] = new ByteReanimDescriptor(new REANIM_ZOMBIE_CHARRED_CLASS() as ByteArray);
         param1[PVZReanims.REANIM_ZOMBIE_FOOTBALL] = new ByteReanimDescriptor(new REANIM_ZOMBIE_FOOTBALL_CLASS() as ByteArray);
         param1[PVZReanims.REANIM_ZOMBIE_HAND] = new ByteReanimDescriptor(new REANIM_ZOMBIE_HAND_CLASS() as ByteArray);
         param1[PVZReanims.REANIM_ZOMBIE_PAPER] = new ByteReanimDescriptor(new REANIM_ZOMBIE_PAPER_CLASS() as ByteArray);
         param1[PVZReanims.REANIM_ZOMBIE_POLEVAULTER] = new ByteReanimDescriptor(new REANIM_ZOMBIE_POLEVAULTER_CLASS() as ByteArray);
      }
   }
}
