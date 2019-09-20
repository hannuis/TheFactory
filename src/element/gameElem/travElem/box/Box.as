package element.gameElem.travElem.box {
	
	// --------------------------------------------------------------
	// Imports
	//---------------------------------------------------------------
	
	import element.gameElem.travElem.TravElement;
	import se.lnu.stickossdk.system.Session;
	
	//---------------------------------------------------------------
	// Public class
	//---------------------------------------------------------------
	
	/**
	 * Klass för boxar. Hanterar utplacering och fall-metod. Ärver
	 * från TravElement som hanterar boxens hastighet i x-led samt
	 * positionering.
	 */
	public class Box extends TravElement {
		
		//-----------------------------------------------------------
		// Constructor method
		//-----------------------------------------------------------
		
		/**
		 * Initiering av Box.
		 * 
		 * @param skinBuff Grafisk representation av boxen
		 */
		public function Box(skinBuff:Class) {
			super(skinBuff);
		}
		
		//-----------------------------------------------------------
		// Override public methods
		//-----------------------------------------------------------
		
		/**
		 * Initering av Box.
		 * 
		 * @return void
		 */
		override public function init():void {
			super.init();
			initPlace();
		}
		
		//-----------------------------------------------------------
		// Public methods
		//-----------------------------------------------------------
		
		/**
		 * Metod för att få boxen att falla.
		 * 
		 * @return void
		 */
		public function fall():void {
			super.skin.gotoAndStop(2);
		}
		
		//-----------------------------------------------------------
		// Private methods
		//-----------------------------------------------------------
		
		/**
		 * Startpositionering av boxens x-värde.
		 * 
		 * @return void
		 */
		private function initPlace():void {
			this.x = Session.application.size.x + this.width;
			super.skin.gotoAndStop(1);
		}
	}
}