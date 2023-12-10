package com.popcap.flash.games.pvz.resources
{
   import com.popcap.flash.framework.resources.fonts.ByteFontDescriptor;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class PVZFontLoader
   {
      
      public static const FONT_HOUSEOFTERROR16_CLASS:Class = PVZFontLoader_FONT_HOUSEOFTERROR16_CLASS;
      
      public static const FONT_DWARVENTODCRAFT18_CLASS:Class = PVZFontLoader_FONT_DWARVENTODCRAFT18_CLASS;
      
      public static const FONT_DWARVENTODCRAFT15_CLASS:Class = PVZFontLoader_FONT_DWARVENTODCRAFT15_CLASS;
      
      public static const FONT_PIX118BOLD_CLASS:Class = PVZFontLoader_FONT_PIX118BOLD_CLASS;
      
      public static const FONT_CONTINUUMBOLD14_CLASS:Class = PVZFontLoader_FONT_CONTINUUMBOLD14_CLASS;
      
      public static const FONT_BRIANNETOD16_CLASS:Class = PVZFontLoader_FONT_BRIANNETOD16_CLASS;
      
      public static const FONT_PICO129_CLASS:Class = PVZFontLoader_FONT_PICO129_CLASS;
      
      public static const FONT_HOUSEOFTERROR28_CLASS:Class = PVZFontLoader_FONT_HOUSEOFTERROR28_CLASS;
      
      public static const FONT_DWARVENTODCRAFT24_CLASS:Class = PVZFontLoader_FONT_DWARVENTODCRAFT24_CLASS;
      
      public static const FONT_DWARVENTODCRAFT18YELLOW_CLASS:Class = PVZFontLoader_FONT_DWARVENTODCRAFT18YELLOW_CLASS;
      
      public static const FONT_DWARVENTODCRAFT36BRIGHTGREENINSET_CLASS:Class = PVZFontLoader_FONT_DWARVENTODCRAFT36BRIGHTGREENINSET_CLASS;
      
      public static const FONT_DWARVENTODCRAFT36GREENINSET_CLASS:Class = PVZFontLoader_FONT_DWARVENTODCRAFT36GREENINSET_CLASS;
       
      
      public function PVZFontLoader()
      {
         super();
      }
      
      public static function init(param1:Dictionary) : void
      {
         param1[PVZFonts.FONT_BRIANNETOD16] = new ByteFontDescriptor(new FONT_BRIANNETOD16_CLASS() as ByteArray,[]);
         param1[PVZFonts.FONT_CONTINUUMBOLD14] = new ByteFontDescriptor(new FONT_CONTINUUMBOLD14_CLASS() as ByteArray,[]);
         param1[PVZFonts.FONT_DWARVENTODCRAFT15] = new ByteFontDescriptor(new FONT_DWARVENTODCRAFT15_CLASS() as ByteArray,[]);
         param1[PVZFonts.FONT_DWARVENTODCRAFT18] = new ByteFontDescriptor(new FONT_DWARVENTODCRAFT18_CLASS() as ByteArray,[]);
         param1[PVZFonts.FONT_DWARVENTODCRAFT18YELLOW] = new ByteFontDescriptor(new FONT_DWARVENTODCRAFT18YELLOW_CLASS() as ByteArray,[]);
         param1[PVZFonts.FONT_DWARVENTODCRAFT24] = new ByteFontDescriptor(new FONT_DWARVENTODCRAFT24_CLASS() as ByteArray,[]);
         param1[PVZFonts.FONT_DWARVENTODCRAFT36BRIGHTGREENINSET] = new ByteFontDescriptor(new FONT_DWARVENTODCRAFT36BRIGHTGREENINSET_CLASS() as ByteArray,[]);
         param1[PVZFonts.FONT_DWARVENTODCRAFT36GREENINSET] = new ByteFontDescriptor(new FONT_DWARVENTODCRAFT36GREENINSET_CLASS() as ByteArray,[]);
         param1[PVZFonts.FONT_HOUSEOFTERROR16] = new ByteFontDescriptor(new FONT_HOUSEOFTERROR16_CLASS() as ByteArray,[]);
         param1[PVZFonts.FONT_HOUSEOFTERROR28] = new ByteFontDescriptor(new FONT_HOUSEOFTERROR28_CLASS() as ByteArray,[]);
         param1[PVZFonts.FONT_PICO129] = new ByteFontDescriptor(new FONT_PICO129_CLASS() as ByteArray,[]);
         param1[PVZFonts.FONT_PIX118BOLD] = new ByteFontDescriptor(new FONT_PIX118BOLD_CLASS() as ByteArray,[]);
      }
   }
}
