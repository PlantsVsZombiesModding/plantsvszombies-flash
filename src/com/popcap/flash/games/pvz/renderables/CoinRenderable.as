package com.popcap.flash.games.pvz.renderables
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.render.Renderable;
   import com.popcap.flash.games.pvz.logic.Coin;
   
   public class CoinRenderable implements Renderable
   {
       
      
      private var mDepth:Number;
      
      private var mCoin:Coin;
      
      public function CoinRenderable(coin:Coin, depth:Number = 0)
      {
         super();
         this.mCoin = coin;
         this.mDepth = depth;
      }
      
      public function getIsDisposable() : Boolean
      {
         return this.mCoin.mDead;
      }
      
      public function draw(g:Graphics2D) : void
      {
         this.mCoin.Draw(g);
      }
      
      public function update() : void
      {
         this.mCoin.Update();
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
         return "Coin@" + this.mDepth;
      }
   }
}
