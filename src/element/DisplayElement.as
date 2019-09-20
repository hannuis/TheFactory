package element {
	
	// --------------------------------------------------------------
	// Imports
	//---------------------------------------------------------------
	
	import flash.display.MovieClip;
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	
	//---------------------------------------------------------------
	// Public class
	//---------------------------------------------------------------
	
	/**
	 * Klass för grafiskt objekt som ska läggas in i DisplayObject-
	 * Container. Skapar ett nytt objekt utifrån skickad parameter,
	 * lägger till i DisplayObjectContainer samt hanterar borttagandet
	 * av objektet.
	 */
	public class DisplayElement extends DisplayStateLayerSprite {
		
		//-----------------------------------------------------------
		// Public properties
		//-----------------------------------------------------------
		
		/**
		 * Grafiskt objekt
		 */
		public var skin:MovieClip;
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		/**
		 * Klass för grafiskt objekt
		 */
		private var _skinBuff:Class;
		
		//-----------------------------------------------------------
		// Constructor method
		//-----------------------------------------------------------
		
		/**
		 * Initering av DisplayElement.
		 * 
		 * @param skinBuff Klass till det grafiska objektet
		 */
		public function DisplayElement(skinBuff:Class){
			super();
			_skinBuff = skinBuff;
		}
		
		//-----------------------------------------------------------
		// Override public methods
		//-----------------------------------------------------------
		
		/**
		 * Initering av DisplayElement.
		 * 
		 * @return void
		 */
		override public function init():void {
			initSkin();
		}
		
		/**
		 * Deallokerar objekt som allokerats av TravElement.
		 * 
		 * @return void
		 */
		override public function dispose():void {
			removeChild(skin);
			skin = null;
			_skinBuff = null;
		}
		
		//-----------------------------------------------------------
		// Private methods
		//-----------------------------------------------------------
		
		/**
		 * Skapar ett nytt objekt utifrån klassen som skickats med.
		 * 
		 * @return void
		 */
		private function initSkin():void {
			skin = new _skinBuff();
			skin.cacheAsBitmap = true;
			addChild(skin);
		}
	}
}