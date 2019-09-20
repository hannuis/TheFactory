package element.gameElem.travElem.box.boxLevel {
	
	// --------------------------------------------------------------
	// Imports
	//---------------------------------------------------------------
	
	import asset.BoxLvlOneGFX;
	import element.gameElem.travElem.box.Box;
	
	//---------------------------------------------------------------
	// Public class
	//---------------------------------------------------------------
	
	/**
	 * Representerar en av spelets boxar - den lägsta. Klassen ärver 
	 * från Box som hanterar positionering.
	 */
	public class BoxLvlOne extends Box {
		
		//-----------------------------------------------------------
		// Constructor method
		//-----------------------------------------------------------
		
		/**
		 * Skapar en ny instans av BoxLvlOne.
		 */
		public function BoxLvlOne() {
			super(BoxLvlOneGFX);
		}
	}
}