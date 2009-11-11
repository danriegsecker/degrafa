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
package com.degrafa.geometry.autoshapes{
		
	//only need one offset here so need to exclude
	[Exclude(name="offset2", kind="property")]
	[Exclude(name="offset2Percent", kind="property")]
	
	[Exclude(name="offset3", kind="property")]
	[Exclude(name="offset3Percent", kind="property")]
	
	[Exclude(name="offset4", kind="property")]
	[Exclude(name="offset4Percent", kind="property")]
		
	/**
 	* The BoxArrowBasicAutoShape element draws a box with a pointy type call out.
 	**/
	public class BoxArrowBasicAutoShape extends AutoShapeTypeOffsets{
		
		/**
	 	* Constructor.
	 	*  
	 	* <p>The BoxArrowBasicAutoShape constructor accepts 1 optional 
	 	* argument that defines it's properties.</p>
	 	* 
	 	* @param offset A number indicating the offset.
	 	*/	
		public function BoxArrowBasicAutoShape(offset1:Number=NaN){
			super();
			if (offset1) this.offset1=offset1;
		}
		
		/**
		* BoxArrowBasicAutoShape short hand data value.
		* 
		* <p>The BoxArrowBasicAutoShape data property expects exactly 1 value an offset1</p>
		* 
		* @see Geometry#data
		* 
		**/
		override public function set data(value:Object):void{
			if(super.data != value){

				//parse the string
				var tempArray:Array = value.split(" ");
				
				if (tempArray.length == 1)
				{	
					super.data = value;
					_offset1=	tempArray[0];
					invalidated = true;
				}	
			}
		} 
				
		/**
		* Draw the BoxArrowBasicAutoShape part(s) based on the parameters.
		*/
		override protected function preDrawPart():void{
			
			//store local to calculate
			var _Offset1:Number=_offset1;
			
			//calc desired final offset 1
			if (isNaN(_Offset1) && hasLayout && isNaN(_offset1Percent)){
				if(_layoutRectangle.width){
						_Offset1 = _layoutRectangle.width/4;		
				}
				else{
					_Offset1 = 0;
				}
			}
			else if (!isNaN(_offset1Percent) && hasLayout){
				if(_offset1Percent >= 1){
					_Offset1 = (_offset1Percent/100)*_layoutRectangle.width;
				}
				else{
					_Offset1 = _offset1Percent*_layoutRectangle.width;
				}		
			}
			else{
				if(isNaN(_Offset1)){
					_Offset1 = 0;	
				}
			}
						
			
			//begin drawing
			commandStack.addMoveTo(0,0);
			commandStack.addLineTo(_layoutRectangle.width-_Offset1,0);
			commandStack.addLineTo(_layoutRectangle.width-_Offset1,_layoutRectangle.height/2-_Offset1);
			commandStack.addLineTo(_layoutRectangle.width,_layoutRectangle.height/2);
			commandStack.addLineTo(_layoutRectangle.width-_Offset1,_layoutRectangle.height/2+_Offset1);
			commandStack.addLineTo(_layoutRectangle.width-_Offset1,_layoutRectangle.height);
			commandStack.addLineTo(0,_layoutRectangle.height);
			commandStack.addLineTo(0,0);

			
		}
	    
	    /**
		* An object to derive this objects properties from. When specified this 
		* object will derive it's unspecified properties from the passed object.
		**/
		public function set derive(value:BoxArrowBasicAutoShape):void{
			if (!fill){fill=value.fill;}
			if (!stroke){stroke = value.stroke}
			if (!_offset1){_offset1 = value.offset1}
			if (!_offset1Percent){_offset1Percent = value.offset1Percent}
		}
	}
}