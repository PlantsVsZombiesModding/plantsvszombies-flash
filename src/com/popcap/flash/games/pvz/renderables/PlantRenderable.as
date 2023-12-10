package com.popcap.flash.games.pvz.renderables
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.render.Renderable;
   import com.popcap.flash.games.pvz.logic.Plants.CPlant;
   
   public class PlantRenderable implements Renderable
   {
       
      
      private var mDepth:Number;
      
      private var mPlant:CPlant;
      
      public function PlantRenderable(plant:CPlant, depth:Number = 0)
      {
         super();
         this.mPlant = plant;
         this.mDepth = depth;
      }
      
      public function getIsDisposable() : Boolean
      {
         return this.mPlant.getDead();
      }
      
      public function draw(g:Graphics2D) : void
      {
         this.mPlant.Draw(g);
      }
      
      public function update() : void
      {
         this.mPlant.Update();
      }
      
      public function getIsVisible() : Boolean
      {
         return true;
      }
      
      public function getDepth() : Number
      {
         return this.mDepth;
      }
      
      public function toString() : String
      {
         return "Plant@" + this.mDepth;
      }
   }
}
