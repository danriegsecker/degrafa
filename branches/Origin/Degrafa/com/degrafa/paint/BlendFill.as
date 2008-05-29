////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2008 The Degrafa Team : http://www.Degrafa.com/team
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
////////////////////////////////////////////////////////////////////////////////
package com.degrafa.paint{
	
	import com.degrafa.core.DegrafaObject;
	import com.degrafa.core.IBlend;
	import com.degrafa.core.IGraphicsFill;
	
	import flash.display.Graphics;
	import flash.geom.Rectangle;
	
	
	import mx.events.PropertyChangeEvent;
	import mx.graphics.IFill;
	
	[DefaultProperty("fill")]
	[Bindable(event="propertyChange")]
	
	//--------------------------------------
	//  Other metadata
	//--------------------------------------
	
	[IconFile("BlendFill.png")]
	
	/**
	 * Used to wrap standard IFill objects for use in a ComplexFill.
	 * The blendMode is only recognized in the context of a ComplexFill.
	 */
	public class BlendFill extends DegrafaObject implements IGraphicsFill, IBlend{
		
		//*****************************************
		// Constructor
		//*****************************************
		
		public function BlendFill(fill:IFill = null, blendMode:String = "normal"){
			this.fill = fill;
			this.blendMode = blendMode;
			
		}
		
		// property backing vars
		private var _blendMode:String;
		private var _fill:IFill;
		
		
		//**************************************
		// Public Properties
		//**************************************
		
		/**
		 * The blendMode used to render this layer in a ComplexFill.
		 * You may use any constant provided in the flash.display.BlendMode class.
		 */
		public function get blendMode():String { return _blendMode; }
		public function set blendMode(value:String):void {
			if(_blendMode != value) {
				initChange("blendMode", _blendMode, _blendMode = value, this);
			}
		}
		
		/**
		 * The IFill which this BlendFill wraps.
		 */
		public function get fill():IFill { return _fill; }
		public function set fill(value:IFill):void {
			if(_fill != value) {
				if(_fill is IGraphicsFill) {
					(_fill as IGraphicsFill).removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler, false);
				}
				if(value is IGraphicsFill) {
					(value as IGraphicsFill).addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler, false, 0, true);
				}
				initChange("fill", _fill, _fill = value, this);
			}
		}
		
		
		
		
		
		//*****************************************
		// Public Methods
		//*****************************************
		
		public function begin(graphics:Graphics, rectangle:Rectangle):void {
			if(fill != null) {
				fill.begin(graphics, rectangle);
			}
		}
		
		public function end(graphics:Graphics):void {
			if(fill != null) {
				fill.end(graphics);
			}
		}
		
		
		//*************************************
		// Event Handlers
		//*************************************
		
		private function propertyChangeHandler(event:PropertyChangeEvent):void{
			dispatchEvent(event);
		}
		
	}
}