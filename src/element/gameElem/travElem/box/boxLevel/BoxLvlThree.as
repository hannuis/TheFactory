package element.gameElem.travElem.box.boxLevel {
	
	// --------------------------------------------------------------
	// Imports
	//---------------------------------------------------------------
	
	import asset.BoxLvlThreeGFX;
	import element.gameElem.travElem.box.Box;
	
	//---------------------------------------------------------------
	// Public class
	//---------------------------------------------------------------
	
	/**
	 * Representerar en av spelets boxar - den högsta. Klassen ärver 
	 * från Box som hanterar positionering.
	 */
	public class BoxLvlThree extends Box {
		
		//-----------------------------------------------------------
		// Constructor method
		//-----------------------------------------------------------
		
		/**
		 * Skapar en ny instans av BoxLvlThree.
		 */
		public function BoxLvlThree() {
			super(BoxLvlThreeGFX);
		}
	}
}
