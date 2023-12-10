package com.popcap.flash.framework.widgets.ui
{
   import com.popcap.flash.framework.graphics.Graphics2D;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.widgets.CWidget;
   
   public class CheckboxWidget extends CWidget
   {
       
      
      private var mCheckedImage:ImageInst;
      
      private var mListener:ICheckboxListener;
      
      private var mChecked:Boolean = false;
      
      private var mId:Number;
      
      private var mUncheckedImage:ImageInst;
      
      public function CheckboxWidget(id:Number, checkedImage:ImageInst, uncheckedImage:ImageInst, listener:ICheckboxListener)
      {
         super();
         this.mId = id;
         this.mCheckedImage = checkedImage;
         this.mUncheckedImage = uncheckedImage;
         this.mListener = listener;
         doFinger = true;
      }
      
      override public function draw(g:Graphics2D) : void
      {
         super.draw(g);
         if(this.mChecked)
         {
            g.drawImage(this.mCheckedImage,0,0);
         }
         else
         {
            g.drawImage(this.mUncheckedImage,0,0);
         }
      }
      
      public function setChecked(checked:Boolean, tellListener:Boolean) : void
      {
         this.mChecked = checked;
         if(tellListener && this.mListener != null)
         {
            this.mListener.checkboxChecked(this.mId,this.mChecked);
         }
         markDirty();
      }
      
      override public function onMouseDown(x:Number, y:Number) : void
      {
         super.onMouseDown(x,y);
         this.mChecked = !this.mChecked;
         if(this.mListener != null)
         {
            this.mListener.checkboxChecked(this.mId,this.mChecked);
         }
         markDirty();
      }
      
      public function isChecked() : Boolean
      {
         return this.mChecked;
      }
   }
}
