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
	
	import flash.display.Graphics;
	import flash.geom.Rectangle;
	
	[Bindable]
	
	/**
 	* The GearAutoShape element draws a gear 
 	* based on the number of points at the specified angle with a specified innerRadius. 
 	* If not specified the default x,y starting point is 0,0 on center.
 	**/
	public class GearAutoShape extends AutoShape{
		
		/**
	 	* Constructor.
	 	*  
	 	* <p>The GearAutoShape constructor accepts 7 optional 
	 	* arguments that define it's properties.</p>
	 	* 
	 	* @param centerX A number indicating the center x-axis coordinate.
	 	* @param centerY A number indicating the center y-axis coordinate.
	 	* @param points A number indicating the count of points to include.
	 	* @param angle A number indicating the start angleof the obejct value between 0° and 360°.
	 	* @param radius A number indicating the radius. 
	 	* @param innerRadius A number indicating the inner radius.
	 	* @param holeRadius A number indicating the inner cut out radius.
	 	* @param holePoints A number indicating count of points to use for the inner cut out.
	 	*  
	 	*/	
		public function GearAutoShape(centerX:Number=NaN,centerY:Number=NaN,points:Number=NaN,
		angle:Number=NaN,radius:Number=NaN,innerRadius:Number=NaN,holeRadius:Number=NaN,
		holePoints:Number=NaN){
			super();
			if (centerX) this.centerX=centerX;
			if (centerY) this.centerY=centerY;
			if (points) this.points=points;
			if (angle) this.angle=angle;
			if (radius)  this.radius=radius;
			if (innerRadius)  this.innerRadius=innerRadius;
			if (holeRadius)  this.holeRadius=holeRadius;
			if (holePoints)  this.holePoints=holePoints;
			
		}
		
		/**
		* GearAutoShape short hand data value.
		* 
		* <p>The GearAutoShape data property expects exactly 7 values a 
		* centerX, centerY, point count, angle, radius, innerRadius, holeRadius 
		* and holePoints separated by spaces.</p>
		* 
		* @see Geometry#data
		* 
		**/
		override public function set data(value:Object):void{
			if(super.data != value){

				//parse the string
				var tempArray:Array = value.split(" ");
				
				if (tempArray.length == 5)
				{	
					super.data = value;
					_centerX= tempArray[0];
					_centerY= tempArray[1];
					_points= tempArray[2];
					_angle=	tempArray[3];
					_radius = tempArray[4];
					_innerRadius = tempArray[5];
					_holeRadius = tempArray[6];
					_holePoints = tempArray[7];
				
					invalidated = true;
				}	
			}
		} 
		
		private var _centerX:Number;
		/**
		* The x-axis coordinate of the center of the GearAutoShape. If not specified 
		* a default value of 0 is used.
		**/
		public function get centerX():Number{
			if(!_centerX){return (hasLayout)? 0.5:0;}
			return _centerX;
		}
		public function set centerX(value:Number):void{
			if (_centerX != value) {
				_centerX = value;
				invalidated = true;
			}
		}
				
		private var _centerY:Number;
		/**
		* The y-axis coordinate of the center of the GearAutoShape. If not specified 
		* a default value of 0 is used.
		**/
		public function get centerY():Number{
			if(!_centerY){return (hasLayout)? 0.5:0;}
			return _centerY;
		}
		public function set centerY(value:Number):void{
			if(_centerY != value){
				_centerY = value;
				invalidated = true;
			}
			
		}		
		
		private var _points:Number;
		/**
		* The number of points to include in this GearAutoShape construction.
		* The minimum number of points is 3 the default is 5.
		**/
		public function get points():Number{
			if(!_points){return 5;}
			return _points;
		}
		public function set points(value:Number):void{
			if (_points != value) {
				if(value ==3 || value > 3){
					_points = value;
				}
				else{
					_points = 3;
				}
				
				invalidated = true;
			}
		}
		
		
		private var _angle:Number;
		/**
		* The start angle of rotation for this GearAutoShape a value 
		* between 0° and 360°.
		* 
		* User Tip :: Transforms can also be used to adjust the angle.  
		**/
		public function get angle():Number{
			if(!_angle){return 0;}
			return _angle;
		}
		public function set angle(value:Number):void{
			if (_angle != value) {
				_angle = value;
				invalidated = true;
			}
		}
		
		private var _radius:Number;
		/**
		* The radius of the GearAutoShape. If not specified a default value of 0 
		* is used.
		**/
		public function get radius():Number{
			if(!_radius){return (hasLayout)? .5:0;}
			return _radius;
		}
		public function set radius(value:Number):void{
			if(_radius != value){
				_radius = value;
				invalidated = true;
			}
		}
		
		private var _innerRadius:Number;
		/**
		* The inner radius of the GearAutoShape. If not specified a default value of 0 
		* is used. Percent values (50%) are accepted.
		**/
		[PercentProxy("innerRadiusPercent")]
		public function get innerRadius():Number{
			if(!_innerRadius){return (hasLayout)? 0:0;}
			return _innerRadius;
		}
		
		public function set innerRadius(value:Number):void{
			if(_innerRadius != value){
				_innerRadius = value;
				_innerRadiusPercent = NaN;
				invalidated = true;
			}
		}
				
		private var _innerRadiusPercent:Number;
		/**
		* The percent inner radius of the GearAutoShape. If not specified a default value of 0 
		* is used. Expects a value between 0 and 100. 
		* Note: Percent values between 0 and 1 are not yet supported.
		**/
		public function get innerRadiusPercent():Number{
			if(!_innerRadiusPercent){return NaN;}
			return _innerRadiusPercent;
		}
		
		public function set innerRadiusPercent(value:Number):void{
			if(_innerRadiusPercent != value){
				_innerRadiusPercent = value;
				invalidated = true;
			}
		}

		private var _holeRadius:Number;
		/**
		* The radius for the inside cut out of the gear.
		**/
		[PercentProxy("holeRadiusPercent")]
		public function get holeRadius():Number{
			if(!_holeRadius){return (hasLayout)? 0:0;}
			return _holeRadius;
		}
		public function set holeRadius(value:Number):void{
			if(_holeRadius != value){
				_holeRadius = value;
				_holeRadiusPercent = NaN;
				invalidated = true;
			}
		}
		
		private var _holeRadiusPercent:Number;
		/**
		* The percent radius of the GearAutoShapes cut out hole. If not specified a default 
		* value of 0 is used. Expects a value between 0 and 100. 
		* Note: Percent values between 0 and 1 are not yet supported.
		**/
		public function get holeRadiusPercent():Number{
			if(!_holeRadiusPercent){return NaN;}
			return _holeRadiusPercent;
		}
		
		public function set holeRadiusPercent(value:Number):void{
			if(_holeRadiusPercent != value){
				_holeRadiusPercent = value;
				invalidated = true;
			}
		}

		private var _holePoints:Number;
		/**
		* The number of points for the inside cut out of the gear.
		**/
		public function get holePoints():Number{
			if(!_holePoints){return 5;}
			return _holePoints;
		}
		public function set holePoints(value:Number):void{
			if (_holePoints != value) {
				if(value ==3 || value > 3){
					_holePoints = value;
				}
				else{
					_holePoints = 3;
				}
				
				invalidated = true;
			}
		}
				
		/**
		* Draw the objects part(s) based on passed parameters.
		*/
		private function preDrawPart( x:Number, y:Number, points:Number, innerRadius:Number, outerRadius:Number,angle:Number=0, holeSides:Number=0, holeRadius:Number=0):void{
	
			if (points>=2){
				
				// calculate length of sides
				var step:Number = (Math.PI*2)/points;
				var qtrStep:Number = step/4;
				
				// calculate starting angle in radians
				var start:Number = (angle/180)*Math.PI;
				commandStack.addMoveTo(x+(Math.cos(start)*outerRadius), y-(Math.sin(start)*outerRadius));
								
				// draw lines
				for (var i:int=1; i<=points; i++){
					commandStack.addLineTo(x+Math.cos(start+(step*i)-(qtrStep*3))*innerRadius, 
					y-Math.sin(start+(step*i)-(qtrStep*3))*innerRadius);
					
					commandStack.addLineTo(x+Math.cos(start+(step*i)-(qtrStep*2))*innerRadius, 
					y-Math.sin(start+(step*i)-(qtrStep*2))*innerRadius);
					
					commandStack.addLineTo(x+Math.cos(start+(step*i)-qtrStep)*outerRadius, 
					y-Math.sin(start+(step*i)-qtrStep)*outerRadius);
					
					commandStack.addLineTo(x+Math.cos(start+(step*i))*outerRadius, 
					y-Math.sin(start+(step*i))*outerRadius);
										
				}
								
				if (holeSides>=2){
					
					if(holeRadius == 0){
						holeRadius = innerRadius/3;
					}
					
					step = (Math.PI*2)/holeSides;
					commandStack.addMoveTo(x+(Math.cos(start)*holeRadius), y-(Math.sin(start)*holeRadius));
					
					for (var j:int=1; j<=holeSides; j++){
						commandStack.addLineTo(x+Math.cos(start+(step*j))*holeRadius, 
						y-Math.sin(start+(step*j))*holeRadius);
					}
					
				}
				
			}
		}	

		/**
		* @inheritDoc 
		**/
		override public function preDraw():void{
			if(invalidated){
				
				commandStack.source.length = 0;
				
				var tempInnerRadius:Number=0;
				var tempHoleRadius:Number=0;
				
				//convert percent for inner radius
				if(!isNaN(_innerRadiusPercent)){
					tempInnerRadius = (innerRadiusPercent/100)*radius;
				}
				else if(isNaN(_innerRadius) && isNaN(_innerRadiusPercent)){
					tempInnerRadius = radius/2;
				}
				else{
					tempInnerRadius = innerRadius;
				}
				
				//convert percent for hole radius
				if(!isNaN(_holeRadiusPercent)){
					tempHoleRadius = (holeRadiusPercent/100)*radius;
				}
				else if(isNaN(_holeRadius) && isNaN(_holeRadiusPercent)){
					tempHoleRadius = radius/2;
				}
				else{
					tempHoleRadius = holeRadius;
				}
				
				preDrawPart(0,0,points,tempInnerRadius,radius,angle,holePoints,tempHoleRadius);
				
				invalidated = false;
			}
			
		}
		
		
		/**
		* Performs the specific layout work required by this Geometry.
		* @param childBounds the bounds to be layed out. If not specified a rectangle
		* of (0,0,1,1) is used or the most appropriate size is calculated. 
		**/
		override public function calculateLayout(childBounds:Rectangle=null):void{
			if(_layoutConstraint){
				if (_layoutConstraint.invalidated){
					
					var tempLayoutRect:Rectangle = new Rectangle(0,0,1,1);
					
					//default to bounds if no width or height is set
					//and we have layout
					if(isNaN(_layoutConstraint.width)){
						tempLayoutRect.width = bounds.width;
					}
					 
					if(isNaN(_layoutConstraint.height)){
						tempLayoutRect.height = bounds.height;
					}
					
					if(isNaN(_layoutConstraint.x)){
			 			tempLayoutRect.x = bounds.x;
			 		}
			 		
			 		if(isNaN(_layoutConstraint.y)){
			 			tempLayoutRect.y = bounds.y;
			 		}
			 		
					super.calculateLayout(tempLayoutRect);
					_layoutRectangle = _layoutConstraint.layoutRectangle;
			 		
			 		//Dev Note: layout needs testing and verification. 
					//Seems we are getting a bunch of duplicated code for 
					//this may want to seperate this out.
			 		
			 		if (isNaN(_radius)) {
						//handle layout defined startup values:
						_radius = _layoutRectangle.width / 2;
						
						if (isNaN(_centerX)){
							_centerX = layoutRectangle.width / 2 + layoutRectangle.x;
						}
						else{
							_layoutRectangle.x -= _radius;
						} 
						
						if (isNaN(_centerY)){
							_centerY = layoutRectangle.height / 2  + layoutRectangle.y;
						} 	
						else{
							_layoutRectangle.y -= _radius;
						} 
						
						invalidated = true;
					}
				}
			}
		}
		
		/**
		* Begins the draw phase for geometry objects. All geometry objects 
		* override this to do their specific rendering.
		* 
		* @param graphics The current context to draw to.
		* @param rc A Rectangle object used for fill bounds. 
		**/
		override public function draw(graphics:Graphics,rc:Rectangle):void{				
		 
		 	//init the layout in this case done before predraw.
			if (hasLayout) calculateLayout();
			
			//re init if required
			if (invalidated) preDraw();
	
			super.draw(graphics, (rc)? rc:bounds);
	    }
	    
	    /**
		* An object to derive this objects properties from. When specified this 
		* object will derive it's unspecified properties from the passed object.
		**/
		public function set derive(value:GearAutoShape):void{
			
			if (!fill){fill=value.fill;}
			if (!stroke){stroke = value.stroke}
			if (!_points){_points = value.points}
			if (!_angle){_angle = value.angle}
			if (!_radius){_radius = value.radius}
			if (!_centerX){_centerX = value.centerX;}
			if (!_centerY){_centerY = value.centerY;}
			if (!_innerRadius){_innerRadius = value.innerRadius;}
			if (!_holeRadius){_holeRadius = value.holeRadius;}
			if (!_holePoints){_holePoints = value.holePoints;}
			
		}
	}
}