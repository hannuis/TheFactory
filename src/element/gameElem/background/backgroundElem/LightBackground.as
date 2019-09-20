package element.gameElem.background.backgroundElem {
	
	// --------------------------------------------------------------
	// Imports
	//---------------------------------------------------------------
	
	import asset.LightLayer4GFX;
	import element.DisplayElement;
	
	//---------------------------------------------------------------
	// Public class
	//---------------------------------------------------------------
	
	/**
	 * Representerar bakgrundens ljus. Klassen ärver från
	 * DisplayElement som hanterar skapandet av grafiken, 
	 * positionering och utplacering.
	 */
	public class LightBackground extends DisplayElement {
		
		//-----------------------------------------------------------
		// Constructor method
		//-----------------------------------------------------------
		
		/**
		 * Skapar en ny instans av LightBackground.
		 */
		public function LightBackground() {
			super(LightLayer4GFX);
		}
	}
}