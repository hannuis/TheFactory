package element.gameElem.burner.burnerElem {
	
	// --------------------------------------------------------------
	// Imports
	//---------------------------------------------------------------
	
	import asset.BurnerBackGFX;
	import element.DisplayElement;
	import se.lnu.stickossdk.system.Session;
	
	//---------------------------------------------------------------
	// Public class
	//---------------------------------------------------------------
	
	/**
	 * Representerar brännarens baksida. Klassen ärver från
	 * DisplayElement som henterar skapandet av grafiken samt 
	 * utplacering.
	 */
	public class BurnerBack extends DisplayElement {
		
		//-----------------------------------------------------------
		// Constructor method
		//-----------------------------------------------------------
		
		/**
		 * Skapar en ny instans av BurnerBack.
		 */
		public function BurnerBack() {
			super(BurnerBackGFX);
		}
		
		//-----------------------------------------------------------
		// Override public methods
		//-----------------------------------------------------------
		
		/**
		 * Initering av BurnerBack.
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
		 * Positionering av BurnerBack.
		 * 
		 * @return void
		 */
		private function initPlace():void {
			this.x = 0;
			this.y = Session.application.size.y - 69;
		}
	}
}