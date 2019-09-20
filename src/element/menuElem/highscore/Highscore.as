package element.menuElem.highscore {
	
	//---------------------------------------------------------------
	// Public class
	//---------------------------------------------------------------
	
	/**
	 * Klass som hämtar highscore-tabeller.
	 */
	public class Highscore {
		
		//-----------------------------------------------------------
		// Public properties
		//-----------------------------------------------------------
		
		/**
		 * Highscore-tabell med ID 1
		 */
		public var highscoreOne:HighscoreTable;
		
		/**
		 * Highscore-tabell med ID 2
		 */
		public var highscoreTwo:HighscoreTable;
		
		//-----------------------------------------------------------
		// Constructor method
		//-----------------------------------------------------------
		/**
		 * Initering av Highscore.
		 */
		public function Highscore() {
			init();
		}
		
		//-----------------------------------------------------------
		// Public methods
		//-----------------------------------------------------------
		
		/**
		 * Deallokerar objekt som allokerats av Highscore.
		 * 
		 * @return void
		 */
		public function dispose():void {
			highscoreOne.dispose();
			highscoreTwo.dispose();
			highscoreOne = null;
			highscoreTwo = null;
		}
		
		//-----------------------------------------------------------
		// Private methods
		//-----------------------------------------------------------
		
		/**
		 * Initerar hämtning av highscore-tabeller
		 * 
		 * @return void
		 */
		private function init():void {
			highscoreOne = new HighscoreTable(1);
			highscoreTwo = new HighscoreTable(2);
		}
	}
}