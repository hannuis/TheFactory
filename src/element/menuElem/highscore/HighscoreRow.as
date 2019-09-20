package element.menuElem.highscore {
	
	//---------------------------------------------------------------
	// Public class
	//---------------------------------------------------------------
	
	/**
	 * Representerar en rad i highscore-databasen. En rad innehåller
	 * namn, position och score som fylls i i HighscoreTable-klassen.
	 */
	public class HighscoreRow {
		
		//-----------------------------------------------------------
		// Public properties
		//-----------------------------------------------------------
		
		/**
		 * Highscore-namnet
		 */
		public var name:String = "";
		
		/**
		 * Highscore-positionen
		 */
		public var position:int;
		
		/**
		 * Highscore-poängen
		 */
		public var score:int = 0;
		
		//-----------------------------------------------------------
		// Constructor method
		//-----------------------------------------------------------
		
		/**
		 * Initering av HighscoreRow
		 */
		public function HighscoreRow() {
			
		}
	}
}