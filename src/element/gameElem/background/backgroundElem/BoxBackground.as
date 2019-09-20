package element.gameElem.background.backgroundElem {
	
	// --------------------------------------------------------------
	// Imports
	//---------------------------------------------------------------
	
	import asset.BoxLayer3GFX;
	import element.DisplayElement;
	
	//---------------------------------------------------------------
	// Public class
	//---------------------------------------------------------------
	
	/**
	 * Representerar bakgrundens boxar. Klassen ärver från
	 * DisplayElement som hanterar skapandet av grafiken, 
	 * positionering och utplacering.
	 */
	public class BoxBackground extends DisplayElement {
		
		//-----------------------------------------------------------
		// Constructor method
		//-----------------------------------------------------------
		
		/**
		 * Skapar en ny instans av BoxBackground.
		 */
		public function BoxBackground() {
			super(BoxLayer3GFX);
		}
	}
}