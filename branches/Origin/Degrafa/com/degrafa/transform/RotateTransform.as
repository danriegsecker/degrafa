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

package com.degrafa.transform{
	
	import com.degrafa.IGeometryComposition;
	
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	
	[Bindable]
	/**
	* RotateTransform rotates an object in the two-dimensional plane by specifying an angle 
	* and a registration point defined in registration point or centerX and centerY respectivly.
	**/
	public class RotateTransform extends Transform{
		
		private var radians:Number;
		
		public function RotateTransform(){
			super();
	
		}
		
		private var _angle:Number=0;
		/**
		* The rotation angle of the transform in degrees. A value between 0 and 360.
		**/
		public function get angle():Number{
			return _angle;
		}
		public function set angle(value:Number):void{
			
			if(_angle != value){
				radians = ((_angle-value)/180)* Math.PI;
				_angle = value;
				invalidated = true;
			}
			else{
				radians = NaN;
			}
		}
		
		override public function preCalculateMatrix(value:IGeometryComposition):Matrix{
			
			if(!invalidated && !radians){return transformMatrix;}
			
			//store the previous matrix for inversion
			var previousMatrix:Matrix=transformMatrix.clone();
		
			if(radians){
			
				var trans:Point;
				if(registrationPoint){
					trans = getRegistrationPoint(value)
				}
				else{
					trans = new Point(centerX,centerY);
				}
				
				transformMatrix.translate(-trans.x,-trans.y);
				transformMatrix.rotate(radians);
				transformMatrix.translate(trans.x,trans.y);
				
				radians = NaN;
			}
					
			//invert the previous matrix and concat the results before application
			if(previousMatrix){
				previousMatrix.invert();
				transformMatrix.concat(previousMatrix);
			}
			
			return transformMatrix;	
		}	
			
		override public function apply(value:IGeometryComposition):void{
						
			preCalculateMatrix(value);
		
			super.apply(value);
		}
		
		
	}
}