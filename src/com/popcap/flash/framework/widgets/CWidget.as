package com.popcap.flash.framework.widgets
{
   import com.popcap.flash.framework.graphics.Color;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.ui.Keyboard;
   
   public class CWidget extends CWidgetContainer
   {
      
      public static const LAY_Right:Number = 1024;
      
      public static const LAY_Above:Number = 256;
      
      public static const LAY_GrowToBottom:Number = 524288;
      
      public static const LAY_SameLeft:Number = 4096;
      
      public static const LAY_SetHeight:Number = 128;
      
      public static const LAY_Left:Number = 2048;
      
      public static const LAY_SetTop:Number = 32;
      
      public static const LAY_Below:Number = 512;
      
      public static const LAY_GrowToTop:Number = 262144;
      
      public static const LAY_HCenter:Number = 1048576;
      
      public static const LAY_GrowToLeft:Number = 131072;
      
      public static const LAY_Max:Number = 4194304;
      
      public static const LAY_SameWidth:Number = 1;
      
      public static const LAY_SameHeight:Number = 2;
      
      public static const LAY_SameSize:Number = LAY_SameWidth | LAY_SameHeight;
      
      public static const LAY_SetLeft:Number = 16;
      
      public static const LAY_SetPos:Number = LAY_SetLeft | LAY_SetTop;
      
      public static const LAY_VCenter:Number = 2097152;
      
      public static const LAY_SameBottom:Number = 32768;
      
      public static const LAY_SameTop:Number = 16384;
      
      public static const LAY_SameCorner:Number = LAY_SameLeft | LAY_SameTop;
      
      public static const LAY_GrowToRight:Number = 65536;
      
      public static const LAY_SameRight:Number = 8192;
      
      public static const LAY_SetWidth:Number = 64;
      
      public static const LAY_SetSize:Number = LAY_SetWidth | LAY_SetHeight;
       
      
      protected var mBounds:Rectangle;
      
      public var isOver:Boolean = false;
      
      public var tabNext:CWidget = null;
      
      public var wantsFocus:Boolean = false;
      
      public var hasTransparencies:Boolean = false;
      
      protected var mPolyShape:Vector.<Point>;
      
      public var doFinger:Boolean = false;
      
      public var hasFocus:Boolean = false;
      
      public var tabPrev:CWidget = null;
      
      public var colors:Array;
      
      public var isDown:Boolean = false;
      
      public var visible:Boolean = true;
      
      public var mUsePolyShape:Boolean = false;
      
      public var disabled:Boolean = false;
      
      public function CWidget()
      {
         this.colors = new Array();
         this.mPolyShape = new Vector.<Point>();
         this.mBounds = new Rectangle();
         super();
      }
      
      public function setColors(param1:Array) : void
      {
         this.colors = new Array();
         var _loc2_:int = int(param1.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.setColor(_loc3_,this.colors[_loc3_]);
            _loc3_++;
         }
         markDirty();
      }
      
      public function deferOverlay(param1:Number) : void
      {
         widgetManager.deferOverlay(this,param1);
      }
      
      public function isPointVisible(param1:Number, param2:Number) : Boolean
      {
         return true;
      }
      
      public function lostFocus() : void
      {
         this.hasFocus = false;
      }
      
      public function contains(param1:Number, param2:Number) : Boolean
      {
         var _loc7_:Point = null;
         var _loc8_:Point = null;
         if(this.width == 0 || this.height == 0)
         {
            return false;
         }
         if(param1 < this.x)
         {
            return false;
         }
         if(param2 < this.y)
         {
            return false;
         }
         if(param1 >= this.x + this.width)
         {
            return false;
         }
         if(param2 >= this.y + this.height)
         {
            return false;
         }
         if(!this.mUsePolyShape)
         {
            return true;
         }
         if(this.mPolyShape.length < 3)
         {
            return false;
         }
         var _loc3_:* = false;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = int(this.mPolyShape.length);
         _loc4_ = 0;
         _loc5_ = _loc6_ - 1;
         while(_loc4_ < _loc6_)
         {
            _loc7_ = this.mPolyShape[_loc4_];
            _loc8_ = this.mPolyShape[_loc5_];
            if(_loc7_.y > param2 != _loc8_.y > param2 && param1 < (_loc8_.x - _loc7_.x) * (param2 - _loc7_.y) / (_loc8_.y - _loc7_.y) + _loc7_.x)
            {
               _loc3_ = !_loc3_;
            }
            _loc5_ = _loc4_++;
         }
         return _loc3_;
      }
      
      public function setColor(param1:int, param2:Color) : void
      {
         this.colors[param1] = param2;
         markDirty();
      }
      
      public function layout(param1:Number, param2:CWidget, param3:Number, param4:Number, param5:Number, param6:Number) : void
      {
         var _loc7_:Number = param2.x;
         var _loc8_:Number = param2.y;
         if(param2 == parent)
         {
            _loc7_ = 0;
            _loc8_ = 0;
         }
         var _loc9_:Number = param2.width;
         var _loc10_:Number = param2.height;
         var _loc11_:Number = _loc7_ + _loc9_;
         var _loc12_:Number = _loc8_ + _loc10_;
         var _loc13_:Number = x;
         var _loc14_:Number = y;
         var _loc15_:Number = width;
         var _loc16_:Number = height;
         var _loc17_:Number = 1;
         for(; _loc17_ < LAY_Max; _loc17_ <<= 1)
         {
            if(!(param1 & _loc17_))
            {
               continue;
            }
            switch(_loc17_)
            {
               case LAY_SameWidth:
                  _loc15_ = _loc9_ + param5;
                  break;
               case LAY_SameHeight:
                  _loc16_ = _loc10_ + param6;
                  break;
               case LAY_Above:
                  _loc14_ = _loc8_ - _loc16_ + param4;
                  break;
               case LAY_Below:
                  _loc14_ = _loc12_ + param4;
                  break;
               case LAY_Right:
                  _loc13_ = _loc11_ + param3;
                  break;
               case LAY_Left:
                  _loc13_ = _loc7_ - _loc15_ + param3;
                  break;
               case LAY_SameLeft:
                  _loc13_ = _loc7_ + param3;
                  break;
               case LAY_SameRight:
                  _loc13_ = _loc11_ - _loc15_ + param3;
                  break;
               case LAY_SameTop:
                  _loc14_ = _loc8_ + param4;
                  break;
               case LAY_SameBottom:
                  _loc14_ = _loc12_ - _loc16_ + param4;
                  break;
               case LAY_GrowToRight:
                  _loc15_ = _loc11_ - _loc13_ + param5;
                  break;
               case LAY_GrowToLeft:
                  _loc15_ = _loc7_ - _loc13_ + param5;
                  break;
               case LAY_GrowToTop:
                  _loc16_ = _loc8_ - _loc14_ + param6;
                  break;
               case LAY_GrowToBottom:
                  _loc16_ = _loc12_ - _loc14_ + param6;
                  break;
               case LAY_SetLeft:
                  _loc13_ = param3;
                  break;
               case LAY_SetTop:
                  _loc14_ = param4;
                  break;
               case LAY_SetWidth:
                  _loc15_ = param5;
                  break;
               case LAY_SetHeight:
                  _loc16_ = param6;
                  break;
               case LAY_HCenter:
                  _loc13_ = _loc7_ + (_loc9_ - _loc15_) / 2 + param3;
                  break;
               case LAY_VCenter:
                  _loc14_ = _loc8_ + (_loc10_ - _loc16_) / 2 + param4;
                  break;
            }
         }
         this.resize(_loc13_,_loc14_,_loc15_,_loc16_);
      }
      
      public function gotFocus() : void
      {
         this.hasFocus = true;
      }
      
      public function getColor(param1:Number) : Color
      {
         if(param1 < 0 || param1 >= this.colors.length)
         {
            return null;
         }
         return this.colors[param1];
      }
      
      public function setVisible(param1:Boolean) : void
      {
         if(this.visible == param1)
         {
            return;
         }
         this.visible = param1;
         if(this.visible == true)
         {
            markDirty();
         }
         else
         {
            markDirtyFull();
         }
         if(widgetManager != null)
         {
            widgetManager.rehupMouse();
         }
      }
      
      public function resize(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         if(this.x == param1 && this.y == param2 && this.width == param3 && this.height == param4)
         {
            return;
         }
         markDirtyFull();
         this.x = param1;
         this.y = param2;
         this.width = param3;
         this.height = param4;
         this.mBounds.x = param1;
         this.mBounds.y = param2;
         this.mBounds.width = param3;
         this.mBounds.height = param4;
         markDirty();
         if(widgetManager != null)
         {
            widgetManager.rehupMouse();
         }
      }
      
      public function orderInManagerChanged() : void
      {
      }
      
      override public function onKeyUp(param1:uint) : void
      {
      }
      
      override public function onMouseUp(param1:Number, param2:Number) : void
      {
      }
      
      override public function onKeyDown(param1:uint) : void
      {
         if(param1 == Keyboard.TAB)
         {
            if(widgetManager.keyDown[Keyboard.SHIFT])
            {
               if(this.tabPrev != null)
               {
                  widgetManager.setFocus(this.tabPrev);
               }
            }
            else if(this.tabNext != null)
            {
               widgetManager.setFocus(this.tabNext);
            }
         }
      }
      
      override public function draw(param1:Graphics2D) : void
      {
      }
      
      public function showFinger(param1:Boolean) : void
      {
         if(widgetManager == null)
         {
            return;
         }
         widgetManager.showFinger(param1,this);
      }
      
      override public function update() : void
      {
         super.update();
      }
      
      public function widgetRemovedHelper() : void
      {
         var _loc5_:CWidget = null;
         var _loc6_:CPreModalInfo = null;
         if(widgetManager == null)
         {
            return;
         }
         var _loc1_:int = int(widgets.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            (_loc5_ = widgets[_loc2_]).widgetRemovedHelper();
            _loc2_++;
         }
         widgetManager.disableWidget(this);
         var _loc3_:Array = widgetManager.preModalInfoList;
         var _loc4_:int = int(_loc3_.length);
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            if((_loc6_ = _loc3_[_loc2_]).prevBaseModalWidget == this)
            {
               _loc6_.prevBaseModalWidget = null;
            }
            if(_loc6_.prevFocusWidget == this)
            {
               _loc6_.prevFocusWidget = null;
            }
            _loc2_++;
         }
         removedFromManager(widgetManager);
         markDirtyFull(this);
         widgetManager = null;
      }
      
      override public function onMouseDown(param1:Number, param2:Number) : void
      {
      }
      
      public function move(param1:Number, param2:Number) : void
      {
         this.resize(param1,param2,width,height);
      }
      
      override public function onMouseDrag(param1:Number, param2:Number) : void
      {
      }
      
      override public function onMouseLeave() : void
      {
      }
      
      public function drawOverlay(param1:Graphics2D, param2:Number = 0) : void
      {
      }
      
      override public function onMouseEnter() : void
      {
      }
      
      override public function onMouseWheel(param1:Number) : void
      {
      }
      
      override public function onMouseMove(param1:Number, param2:Number) : void
      {
      }
      
      public function setPolyShape(param1:Vector.<Point>) : void
      {
         var _loc8_:Point = null;
         this.mPolyShape = param1;
         var _loc2_:Number = Number.MAX_VALUE;
         var _loc3_:Number = Number.MIN_VALUE;
         var _loc4_:Number = Number.MAX_VALUE;
         var _loc5_:Number = Number.MIN_VALUE;
         var _loc6_:int = int(param1.length);
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            _loc8_ = param1[_loc7_];
            _loc2_ = Math.min(_loc8_.x,_loc2_);
            _loc3_ = Math.max(_loc8_.x,_loc3_);
            _loc4_ = Math.min(_loc8_.y,_loc4_);
            _loc5_ = Math.max(_loc8_.y,_loc5_);
            _loc7_++;
         }
         this.mBounds.left = _loc2_;
         this.mBounds.right = _loc3_;
         this.mBounds.top = _loc4_;
         this.mBounds.bottom = _loc5_;
         this.x = this.mBounds.x;
         this.y = this.mBounds.y;
         this.width = this.mBounds.width;
         this.height = this.mBounds.height;
         this.mUsePolyShape = true;
      }
      
      override public function onKeyChar(param1:uint) : void
      {
      }
      
      public function setDisabled(param1:Boolean) : void
      {
         if(this.disabled == param1)
         {
            return;
         }
         this.disabled = param1;
         if(param1 && widgetManager != null)
         {
            widgetManager.disableWidget(this);
         }
         markDirty();
         if(!param1 && widgetManager != null && this.contains(widgetManager.lastMouseX,widgetManager.lastMouseY))
         {
            widgetManager.setMousePosition(widgetManager.lastMouseX,widgetManager.lastMouseY);
         }
      }
   }
}
