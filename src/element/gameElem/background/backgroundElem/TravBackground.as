package element.gameElem.background.backgroundElem {
	
	// --------------------------------------------------------------
	// Imports
	//---------------------------------------------------------------
	
	import asset.TravelatorLayer2GFX;
	import element.DisplayElement;
	
	//---------------------------------------------------------------
	// Public class
	//---------------------------------------------------------------
	
	/**
	 * Representerar bakgrundens rullband. Klassen ärver från
	 * DisplayElement som hanterar skapandet av grafiken, 
	 * positionering och utplacering.
	 */
	public class TravBackground extends DisplayElement {
		
		//-----------------------------------------------------------
		// Constructor method
		//-----------------------------------------------------------
		
		/**
		 * Skapar en ny instans av TravBackground.
		 */
		public function TravBackground() {
			super(TravelatorLayer2GFX);
		}
	}
}

