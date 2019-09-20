package element.gameElem.travElem.box.boxLevel {
	
	// --------------------------------------------------------------
	// Imports
	//---------------------------------------------------------------
	
	import asset.BoxLvlTwoGFX;
	import element.gameElem.travElem.box.Box;
	
	//---------------------------------------------------------------
	// Public class
	//---------------------------------------------------------------
	
	/**
	 * Representerar en av spelets boxar - mellanboxen. Klassen ärver 
	 * från Box som hanterar positionering.
	 */
	public class BoxLvlTwo extends Box {
		
		//-----------------------------------------------------------
		// Constructor method
		//-----------------------------------------------------------
		
		/**
		 * Skapar en ny instans av BoxLvlTwo.
		 */
		public function BoxLvlTwo() {
			super(BoxLvlTwoGFX);
		}
	}
}

