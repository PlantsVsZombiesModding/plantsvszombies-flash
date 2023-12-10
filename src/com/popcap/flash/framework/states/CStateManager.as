package com.popcap.flash.framework.states
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   
   public class CStateManager implements IStateManager
   {
       
      
      private var states:Object;
      
      private var stack:Array;
      
      public function CStateManager()
      {
         super();
         this.states = new Object();
         this.stack = new Array();
      }
      
      public function popState() : void
      {
         var _loc2_:IState = null;
         if(this.stack.length == 0)
         {
            return;
         }
         var _loc1_:IState = this.stack.pop() as IState;
         _loc1_.onExit();
         if(this.stack.length > 0)
         {
            _loc2_ = this.stack[this.stack.length - 1] as IState;
            _loc2_.onPop();
         }
      }
      
      public function changeState(param1:String) : void
      {
         var _loc5_:IState = null;
         var _loc2_:IState = this.states[param1] as IState;
         if(_loc2_ == null)
         {
            throw new ArgumentError("ID " + param1 + " is unbound, cannot change states.");
         }
         var _loc3_:int = int(this.stack.length);
         var _loc4_:int = _loc3_ - 1;
         while(_loc4_ >= 0)
         {
            (_loc5_ = this.stack[_loc4_] as IState).onExit();
            _loc4_--;
         }
         this.stack = new Array();
         this.stack.push(_loc2_);
         _loc2_.onEnter();
      }
      
      public function draw(param1:Graphics2D) : void
      {
         var _loc4_:IState = null;
         var _loc2_:int = int(this.stack.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            (_loc4_ = this.stack[_loc3_] as IState).draw(param1);
            _loc3_++;
         }
      }
      
      public function bindState(param1:String, param2:IState) : void
      {
         this.states[param1] = param2;
      }
      
      public function pushState(param1:String) : void
      {
         var _loc3_:IState = null;
         var _loc2_:IState = this.states[param1] as IState;
         if(_loc2_ == null)
         {
            throw new ArgumentError("ID " + param1 + " is unbound, cannot push onto stack.");
         }
         if(this.stack.length > 0)
         {
            _loc3_ = this.stack[this.stack.length - 1] as IState;
            _loc3_.onPush();
         }
         this.stack.push(_loc2_);
         _loc2_.onEnter();
      }
      
      public function update() : void
      {
         var _loc1_:int = int(this.stack.length - 1);
         if(_loc1_ < 0)
         {
            return;
         }
         var _loc2_:IState = this.stack[_loc1_] as IState;
         _loc2_.update();
      }
   }
}
