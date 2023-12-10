package com.popcap.flash.framework
{
   public interface IAppServiceRegistration
   {
       
      
      function unregister() : void;
      
      function setProperties(param1:XML) : void;
      
      function getReference() : IAppServiceReference;
   }
}
