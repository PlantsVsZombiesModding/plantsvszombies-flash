package com.popcap.flash.framework.widgets
{
   import com.popcap.flash.framework.AppBase;
   import com.popcap.flash.framework.graphics.Graphics2D;
   import flash.geom.Point;
   import flash.ui.Keyboard;
   
   public class CWidgetManager extends CWidgetContainer
   {
      
      public static const WIDGETFLAGS_DRAW:Number = 4;
      
      public static const WIDGETFLAGS_UPDATE:Number = 1;
      
      public static const WIDGETFLAGS_CLIP:Number = 8;
      
      public static const WIDGETFLAGS_ALLOW_FOCUS:Number = 32;
      
      public static const WIDGETFLAGS_ALLOW_MOUSE:Number = 16;
      
      public static const WIDGETFLAGS_MARK_DIRTY:Number = 2;
       
      
      public var minDeferredOverlayPriority:Number = 0;
      
      public var deferredOverlayWidgets:Array;
      
      public var lastMouseX:Number = 0;
      
      public var lastMouseY:Number = 0;
      
      public var mShowFinger:Boolean = false;
      
      public var belowModalFlagsMod:CFlagsMod;
      
      public var defaultTab:CWidget = null;
      
      public var keyDown:Array;
      
      public var popupCommandWidget:CWidget;
      
      public var app:AppBase;
      
      public var mouseIn:Boolean = true;
      
      public var lostFocusFlagsMod:CFlagsMod;
      
      public var widgetFlags:Number = 0;
      
      public var overWidget:CWidget;
      
      public var lastDownWidget:CWidget;
      
      public var defaultBelowModalFlagsMod:CFlagsMod;
      
      public var baseModalWidget:CWidget;
      
      public var focusWidget:CWidget;
      
      public var lastInputUpdateCount:Number = 0;
      
      public var preModalInfoList:Array;
      
      private var modalFlags:CModalFlags;
      
      public var hasFocus:Boolean = true;
      
      public var downButtons:Number = 0;
      
      public function CWidgetManager(param1:AppBase)
      {
         this.modalFlags = new CModalFlags();
         this.keyDown = new Array();
         this.deferredOverlayWidgets = new Array();
         this.preModalInfoList = new Array();
         this.lostFocusFlagsMod = new CFlagsMod();
         this.belowModalFlagsMod = new CFlagsMod();
         this.defaultBelowModalFlagsMod = new CFlagsMod();
         super();
         this.app = param1;
         widgetManager = this;
         this.widgetFlags = WIDGETFLAGS_UPDATE | WIDGETFLAGS_DRAW | WIDGETFLAGS_CLIP | WIDGETFLAGS_ALLOW_MOUSE | WIDGETFLAGS_ALLOW_FOCUS;
         var _loc2_:int = 0;
         while(_loc2_ < 255)
         {
            this.keyDown[_loc2_] = false;
            _loc2_++;
         }
      }
      
      public function getWidgetAt(param1:Number, param2:Number, param3:Point) : CWidget
      {
         var _loc4_:CWidget;
         if((_loc4_ = this.getAnyWidgetAt(param1,param2,param3)) != null && _loc4_.disabled)
         {
            _loc4_ = null;
         }
         return _loc4_;
      }
      
      public function doKeyUp(param1:uint) : void
      {
         this.lastInputUpdateCount = updateCount;
         this.keyDown[param1] = false;
         if(param1 == Keyboard.TAB && Boolean(this.keyDown[Keyboard.CONTROL]))
         {
            return;
         }
         if(this.focusWidget != null)
         {
            this.focusWidget.onKeyUp(param1);
         }
      }
      
      public function initModalFlags(param1:CModalFlags) : void
      {
         param1.isOver = this.baseModalWidget == null;
         param1.overFlags = this.getWidgetFlags();
         param1.underFlags = CFlagsMod.getModFlags(param1.overFlags,this.belowModalFlagsMod);
      }
      
      public function rehupMouse() : void
      {
         var _loc1_:CWidget = null;
         var _loc2_:CWidget = null;
         if(this.lastDownWidget != null)
         {
            if(this.overWidget != null)
            {
               _loc1_ = this.getWidgetAt(this.lastMouseX,this.lastMouseY,new Point());
               if(_loc1_ != this.lastDownWidget)
               {
                  _loc2_ = this.overWidget;
                  this.overWidget = null;
                  this.doMouseLeave(_loc2_);
               }
            }
         }
         else if(this.mouseIn)
         {
            this.setMousePosition(this.lastMouseX,this.lastMouseY);
         }
      }
      
      public function doMouseUps(param1:CWidget = null, param2:Number = 0) : void
      {
         if(param1 == null)
         {
            if(this.lastDownWidget != null && this.downButtons != 0)
            {
               this.doMouseUps(this.lastDownWidget,this.downButtons);
               this.downButtons = 0;
               this.lastDownWidget = null;
            }
            return;
         }
         param1.isDown = false;
         param1.onMouseUp(this.lastMouseX - param1.x,this.lastMouseY - param1.y);
      }
      
      public function doMouseExit(param1:Number, param2:Number) : void
      {
         this.lastInputUpdateCount = updateCount;
         this.mouseIn = false;
         if(this.overWidget != null)
         {
            this.doMouseLeave(this.overWidget);
            this.overWidget = null;
         }
      }
      
      public function setBaseModal(param1:CWidget, param2:CFlagsMod) : void
      {
         var _loc4_:Number = NaN;
         this.baseModalWidget = param1;
         this.belowModalFlagsMod = param2;
         var _loc3_:CWidget = null;
         if(this.overWidget != null && this.belowModalFlagsMod.removeFlags & WIDGETFLAGS_ALLOW_MOUSE && isBelow(this.overWidget,this.baseModalWidget))
         {
            _loc3_ = this.overWidget;
            this.overWidget = null;
            this.doMouseLeave(_loc3_);
         }
         if(this.lastDownWidget != null && this.belowModalFlagsMod.removeFlags & WIDGETFLAGS_ALLOW_MOUSE && isBelow(this.lastDownWidget,this.baseModalWidget))
         {
            _loc3_ = this.lastDownWidget;
            _loc4_ = this.downButtons;
            this.downButtons = 0;
            this.lastDownWidget = null;
            this.doMouseUps(_loc3_,_loc4_);
         }
         if(this.focusWidget != null && this.belowModalFlagsMod.removeFlags & WIDGETFLAGS_ALLOW_FOCUS && isBelow(this.focusWidget,this.baseModalWidget))
         {
            _loc3_ = this.focusWidget;
            this.focusWidget = null;
            _loc3_.lostFocus();
         }
      }
      
      public function doMouseUp(param1:Number, param2:Number) : void
      {
         var _loc3_:CWidget = null;
         this.lastInputUpdateCount = updateCount;
         if(this.lastDownWidget != null && this.downButtons != 0)
         {
            _loc3_ = this.lastDownWidget;
            this.downButtons = 0;
            this.lastDownWidget = null;
            _loc3_.isDown = false;
            _loc3_.onMouseUp(param1 - _loc3_.x,param2 - _loc3_.y);
         }
         this.setMousePosition(param1,param2);
      }
      
      override public function setFocus(param1:CWidget) : void
      {
         if(param1 == this.focusWidget)
         {
            return;
         }
         if(this.focusWidget != null)
         {
            this.focusWidget.lostFocus();
         }
         if(param1 != null && param1.widgetManager == this)
         {
            this.focusWidget = param1;
            if(this.hasFocus && this.focusWidget != null)
            {
               this.focusWidget.gotFocus();
            }
         }
         else
         {
            this.focusWidget = null;
         }
      }
      
      public function doMouseEnter(param1:CWidget) : void
      {
         param1.isOver = true;
         param1.onMouseEnter();
         if(param1.doFinger)
         {
            param1.showFinger(true);
         }
      }
      
      public function deferOverlay(param1:CWidget, param2:Number) : void
      {
         var _loc3_:Object = new Object();
         _loc3_.widget = param1;
         _loc3_.priority = param2;
         this.deferredOverlayWidgets.push(_loc3_);
         if(param2 < this.minDeferredOverlayPriority)
         {
            this.minDeferredOverlayPriority = param2;
         }
      }
      
      public function flushDeferredOverlayWidgets(param1:Graphics2D, param2:Number) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Object = null;
         var _loc7_:CWidget = null;
         var _loc8_:Number = NaN;
         do
         {
            _loc3_ = Number.MAX_VALUE;
            _loc4_ = int(this.deferredOverlayWidgets.length);
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc7_ = (_loc6_ = this.deferredOverlayWidgets[_loc5_]).widget;
               if(_loc6_.widget != null)
               {
                  if((_loc8_ = Number(_loc6_.priority)) == this.minDeferredOverlayPriority)
                  {
                     param1.pushState();
                     param1.translate(_loc7_.x,_loc7_.y);
                     _loc7_.drawOverlay(param1,_loc8_);
                     param1.popState();
                     _loc6_.widget = null;
                  }
                  else if(_loc8_ < _loc3_)
                  {
                     _loc3_ = _loc8_;
                  }
               }
               _loc5_++;
            }
            this.minDeferredOverlayPriority = _loc3_;
            if(_loc3_ == Number.MAX_VALUE)
            {
               this.deferredOverlayWidgets = new Array();
               break;
            }
         }
         while(_loc3_ < param2);
         
      }
      
      public function setPopupCommandWidget(param1:CWidget) : void
      {
         this.popupCommandWidget = param1;
         addWidget(this.popupCommandWidget);
      }
      
      public function updateFrame() : Boolean
      {
         this.initModalFlags(this.modalFlags);
         ++updateCount;
         lastWMUpdateCount = updateCount;
         updateAll(this.modalFlags);
         return dirty;
      }
      
      public function doMouseWheel(param1:Number) : void
      {
         this.lastInputUpdateCount = updateCount;
         if(this.focusWidget != null)
         {
            this.focusWidget.onMouseWheel(param1);
         }
      }
      
      public function doMouseDrag(param1:Number, param2:Number) : void
      {
         var _loc3_:CWidget = null;
         var _loc4_:Point = null;
         var _loc5_:Point = null;
         this.lastInputUpdateCount = updateCount;
         this.mouseIn = true;
         this.lastMouseX = param1;
         this.lastMouseY = param2;
         if(this.overWidget != null && this.overWidget != this.lastDownWidget)
         {
            _loc3_ = this.overWidget;
            this.overWidget = null;
            this.doMouseLeave(_loc3_);
         }
         if(this.lastDownWidget != null)
         {
            _loc4_ = this.lastDownWidget.getAbsPos();
            _loc5_ = new Point(param1 - _loc4_.x,param2 - _loc4_.y);
            this.lastDownWidget.onMouseDrag(_loc5_.x,_loc5_.y);
            _loc3_ = this.getWidgetAt(param1,param2,new Point());
            if(_loc3_ == this.lastDownWidget && _loc3_ != null)
            {
               if(this.overWidget == null)
               {
                  this.overWidget = this.lastDownWidget;
                  this.doMouseEnter(this.overWidget);
               }
            }
            else if(this.overWidget != null)
            {
               _loc3_ = this.overWidget;
               this.overWidget = null;
               this.doMouseLeave(_loc3_);
            }
         }
      }
      
      public function lostFocus() : void
      {
         var _loc1_:Number = NaN;
         if(this.hasFocus)
         {
            this.downButtons = 0;
            _loc1_ = 0;
            while(_loc1_ < this.keyDown.length)
            {
               if(this.keyDown[_loc1_])
               {
                  onKeyUp(_loc1_);
               }
               this.hasFocus = false;
               if(this.focusWidget != null)
               {
                  this.focusWidget.lostFocus();
               }
               _loc1_++;
            }
         }
      }
      
      public function addBaseModal(param1:CWidget, param2:CFlagsMod) : void
      {
         var _loc3_:CPreModalInfo = new CPreModalInfo();
         _loc3_.baseModalWidget = param1;
         _loc3_.prevBaseModalWidget = this.baseModalWidget;
         _loc3_.prevFocusWidget = this.focusWidget;
         _loc3_.prevBelowModalFlagsMod = this.belowModalFlagsMod;
         this.preModalInfoList.push(_loc3_);
         this.setBaseModal(param1,param2);
      }
      
      public function doMouseDown(param1:Number, param2:Number) : void
      {
         this.lastInputUpdateCount = updateCount;
         this.downButtons = 1;
         this.setMousePosition(param1,param2);
         var _loc3_:Point = new Point();
         var _loc4_:CWidget = this.getWidgetAt(param1,param2,_loc3_);
         if(this.lastDownWidget != null)
         {
            _loc4_ = this.lastDownWidget;
         }
         this.lastDownWidget = _loc4_;
         if(_loc4_ != null)
         {
            if(_loc4_.wantsFocus)
            {
               this.setFocus(_loc4_);
            }
            _loc4_.isDown = true;
            _loc4_.onMouseDown(_loc3_.x,_loc3_.y);
         }
      }
      
      public function gotFocus() : void
      {
         if(!this.hasFocus)
         {
            this.hasFocus = true;
            if(this.focusWidget != null)
            {
               this.focusWidget.gotFocus();
            }
         }
      }
      
      public function showFinger(param1:Boolean, param2:CWidget) : void
      {
         if(this.overWidget == param2 || this.overWidget == null)
         {
            this.mShowFinger = param1;
         }
      }
      
      public function removeBaseModal(param1:CWidget) : void
      {
         var _loc3_:CPreModalInfo = null;
         var _loc4_:Boolean = false;
         if(this.preModalInfoList.length == 0)
         {
            throw new Error("Empty modal list.");
         }
         var _loc2_:Boolean = true;
         while(this.preModalInfoList.length > 0)
         {
            _loc3_ = this.preModalInfoList[this.preModalInfoList.length - 1];
            if(_loc2_ && _loc3_.baseModalWidget != param1)
            {
               return;
            }
            _loc4_ = _loc3_.prevBaseModalWidget != null || this.preModalInfoList.length == 1;
            this.setBaseModal(_loc3_.prevBaseModalWidget,_loc3_.prevBelowModalFlagsMod);
            if(this.focusWidget == null)
            {
               this.focusWidget = _loc3_.prevFocusWidget;
               if(this.focusWidget != null)
               {
                  this.focusWidget.gotFocus();
               }
            }
            this.preModalInfoList.pop();
            if(_loc4_)
            {
               break;
            }
            _loc2_ = false;
         }
      }
      
      public function doKeyChar(param1:uint) : void
      {
         this.lastInputUpdateCount = updateCount;
         if(param1 == Keyboard.TAB)
         {
            if(this.keyDown[Keyboard.CONTROL])
            {
               if(this.defaultTab != null)
               {
                  this.defaultTab.onKeyChar(param1);
               }
               return;
            }
         }
         if(this.focusWidget != null)
         {
            this.focusWidget.onKeyChar(param1);
         }
      }
      
      override public function disableWidget(param1:CWidget) : void
      {
         var _loc2_:CWidget = null;
         if(this.overWidget == param1)
         {
            _loc2_ = this.overWidget;
            this.overWidget = null;
            this.doMouseLeave(_loc2_);
         }
         if(this.lastDownWidget == param1)
         {
            _loc2_ = this.lastDownWidget;
            this.lastDownWidget = null;
            this.doMouseUps(_loc2_,this.downButtons);
            this.downButtons = 0;
         }
         if(this.focusWidget == param1)
         {
            _loc2_ = this.focusWidget;
            this.focusWidget = null;
            _loc2_.lostFocus();
         }
         if(this.baseModalWidget == param1)
         {
            this.baseModalWidget = null;
         }
      }
      
      public function removePopupCommandWidget() : void
      {
         var _loc1_:CWidget = null;
         if(this.popupCommandWidget != null)
         {
            _loc1_ = this.popupCommandWidget;
            this.popupCommandWidget = null;
            removeWidget(_loc1_);
         }
      }
      
      public function doKeyDown(param1:uint) : void
      {
         this.lastInputUpdateCount = updateCount;
         this.keyDown[param1] = true;
         if(this.focusWidget != null)
         {
            this.focusWidget.onKeyDown(param1);
         }
      }
      
      public function drawScreen(param1:Graphics2D) : void
      {
         this.initModalFlags(this.modalFlags);
         var _loc2_:Boolean = false;
         var _loc3_:Number = 0;
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         var _loc6_:Number = 0;
         var _loc7_:CWidget = null;
         var _loc8_:int = int(widgets.length);
         _loc6_ = 0;
         while(_loc6_ < _loc8_)
         {
            if((_loc7_ = widgets[_loc6_]).dirty)
            {
               _loc3_++;
            }
            _loc6_++;
         }
         this.minDeferredOverlayPriority = Number.MAX_VALUE;
         this.deferredOverlayWidgets = new Array();
         if(_loc3_ > 0)
         {
            param1.pushState();
            _loc8_ = int(widgets.length);
            _loc6_ = 0;
            while(_loc6_ < _loc8_)
            {
               if((_loc7_ = widgets[_loc6_]) == widgetManager.baseModalWidget)
               {
                  this.modalFlags.isOver = true;
               }
               if(_loc7_.dirty && _loc7_.visible)
               {
                  param1.pushState();
                  param1.translate(_loc7_.x,_loc7_.y);
                  _loc7_.drawAll(this.modalFlags,param1);
                  param1.popState();
                  _loc3_++;
                  _loc2_ = true;
               }
               _loc6_++;
            }
            param1.popState();
         }
         this.flushDeferredOverlayWidgets(param1,Number.MAX_VALUE);
      }
      
      public function setMousePosition(param1:Number, param2:Number) : void
      {
         var _loc7_:CWidget = null;
         var _loc3_:Number = this.lastMouseX;
         var _loc4_:Number = this.lastMouseY;
         this.lastMouseX = param1;
         this.lastMouseY = param2;
         var _loc5_:Point = new Point(0,0);
         var _loc6_:CWidget;
         if((_loc6_ = this.getWidgetAt(param1,param2,_loc5_)) != this.overWidget)
         {
            _loc7_ = this.overWidget;
            this.overWidget = null;
            if(_loc7_ != null)
            {
               this.doMouseLeave(_loc7_);
            }
            this.overWidget = _loc6_;
            if(_loc6_ != null)
            {
               this.doMouseEnter(_loc6_);
               _loc6_.onMouseMove(_loc5_.x,_loc5_.y);
            }
         }
         else if(_loc3_ != param1 || _loc4_ != param2)
         {
            if(_loc6_ != null)
            {
               _loc6_.onMouseMove(_loc5_.x,_loc5_.y);
            }
         }
      }
      
      public function remapMouse(param1:Number, param2:Number) : void
      {
      }
      
      public function doMouseMove(param1:Number, param2:Number) : void
      {
         this.lastInputUpdateCount = updateCount;
         if(this.downButtons != 0)
         {
            this.doMouseDrag(param1,param2);
         }
         this.mouseIn = true;
         this.setMousePosition(param1,param2);
      }
      
      public function getAnyWidgetAt(param1:Number, param2:Number, param3:Point) : CWidget
      {
         return getWidgetAtHelper(param1,param2,this.getWidgetFlags(),param3);
      }
      
      public function getWidgetFlags() : Number
      {
         return this.hasFocus ? this.widgetFlags : CFlagsMod.getModFlags(this.widgetFlags,this.lostFocusFlagsMod);
      }
      
      public function doMouseLeave(param1:CWidget) : void
      {
         param1.isOver = false;
         param1.onMouseLeave();
         if(param1.doFinger)
         {
            param1.showFinger(false);
         }
      }
   }
}
