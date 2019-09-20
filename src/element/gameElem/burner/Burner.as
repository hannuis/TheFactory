package element.gameElem.burner {
	
	// --------------------------------------------------------------
	// Imports
	//---------------------------------------------------------------
	
	import element.gameElem.burner.burnerElem.BurnerBack;
	import element.gameElem.burner.burnerElem.BurnerFront;
	
	//---------------------------------------------------------------
	// Public class
	//---------------------------------------------------------------
	
	/**
	 * Klass för brännaren. Tar fram objekt som tillhör brännaren och
	 * lägger in dessa i korret Burner-lager.
	 */
	public class Burner {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		/**
		 * Referens till GameHandler
		 */
		private var _game:Object;
		
		/**
		 * Referens till BurnerBack
		 */
		private var _burnerBack:BurnerBack;
		
		/**
		 * Referens till BurnerFront
		 */
		private var _burnerFront:BurnerFront;
		
		//-----------------------------------------------------------
		// Constructor method
		//-----------------------------------------------------------
		
		/**
		 * Initering av Burner.
		 * 
		 * @param game GameHandler objektet
		 */
		public function Burner(game) {
			_game = game;
			initBurner();
		}
		
		//-----------------------------------------------------------
		// Public methods
		//-----------------------------------------------------------
		
		/**
		 * Deallokerar objekt som allokerats av Burner.
		 * 
		 * @return void
		 */
		public function dispose():void {
			_burnerBack = null;
			_burnerFront = null;
			_game = null;
		}
		
		//-----------------------------------------------------------
		// Private methods
		//-----------------------------------------------------------
		
		/**
		 * Initering av brännarens element
		 * 
		 * @return void
		 */
		private function initBurner():void {
			_burnerBack = new BurnerBack();
			_game.burnerBackLayer.addChild(_burnerBack);
			_burnerFront = new BurnerFront();
			_game.burnerFrontLayer.addChild(_burnerFront);
		}
	}
}