package element.gameElem.burner.burnerElem {
	
	// --------------------------------------------------------------
	// Imports
	//---------------------------------------------------------------
	
	import asset.BurnerFrontGFX;
	import element.DisplayElement;
	import se.lnu.stickossdk.system.Session;
	
	//---------------------------------------------------------------
	// Public class
	//---------------------------------------------------------------
	
	/**
	 * Representerar brännarens framsida. Klassen ärver från 
	 * DisplayElement som hanterar skapandet av grafiken samt 
	 * utplacering.
	 */
	public class BurnerFront extends DisplayElement {
		
		//-----------------------------------------------------------
		// Constructor method
		//-----------------------------------------------------------
		
		/**
		 * Skapar en ny instans av BurnerFront.
		 */
		public function BurnerFront() {
			super(BurnerFrontGFX);
		}
		
		//-----------------------------------------------------------
		// Override public methods
		//-----------------------------------------------------------
		
		/**
		 * Initering av BurnerFront.
		 * 
		 * @return void
		 */
		override public function init():void {
			super.init();
			initPlace();
		}
		
		//-----------------------------------------------------------
		// Private methods
		//-----------------------------------------------------------
		
		/**
		 * Positionering av BurnerFront.
		 * 
		 * @return void
		 */
		private function initPlace():void {
			this.x = 0;
			this.y = Session.application.size.y + 130;
		}
	}
}