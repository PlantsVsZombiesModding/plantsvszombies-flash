package com.popcap.flash.framework
{
   public interface IAppServiceReference
   {
       
      
      function getProperties() : XML;
      
      function getPlugin() : IAppPlugin;
      
      function getUsingPlugins() : Vector.<IAppPlugin>;
   }
}
