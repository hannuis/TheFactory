package element.introElem {
	
	// --------------------------------------------------------------
	// Imports
	//---------------------------------------------------------------
	
	import asset.introGFX;
	import element.DisplayElement;
	
	//---------------------------------------------------------------
	// Public class
	//---------------------------------------------------------------
	
	/**
	 * Representerar introt. Klassen ärver från DisplayElement som
	 * hanterar skapandet av grafiken, positionering och utplacering.
	 */
	public class Intro extends DisplayElement {
		
		//-----------------------------------------------------------
		// Constructor method
		//-----------------------------------------------------------
		/**
		 * Skapar en ny instans av Intro.
		 */
		public function Intro() {
			super(introGFX);
		}
	}
}