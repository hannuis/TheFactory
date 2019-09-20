package element.menuElem.highscore {
	
	// --------------------------------------------------------------
	// Imports
	//---------------------------------------------------------------
	
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.util.URLUtils;
	
	//---------------------------------------------------------------
	// Public class
	//---------------------------------------------------------------
	
	/**
	 * Representerar en highscore-tabell. Spelet består av två high-
	 * scoretabeller, en för one player och en för two players. 
	 * Table 1 representerar one player-tabellen.
	 * Table 2 representerar two player-tabellen.
	 */
	public class HighscoreTable {
		
		//-----------------------------------------------------------
		// Public properties
		//-----------------------------------------------------------
		
		/**
		 * Vektor som består HighscoreRow's.
		 */
		public var rows:Vector.<HighscoreRow> = new Vector.<HighscoreRow>();
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		/**
		 * ID'et på tabellen som ska plockas fram
		 */
		private var _table:Number;
		
		//-----------------------------------------------------------
		// Constructor method
		//-----------------------------------------------------------
		
		/**
		 * Initering av HighscoreTable
		 * 
		 * @param table ID't på tabellen som ska hämtas
		 */
		public function HighscoreTable(table:Number) {
			_table = table;
			init();
		}
		
		//-----------------------------------------------------------
		// Public methods
		//-----------------------------------------------------------
		
		/**
		 * Deallokerar objekt som allokerats av Table.
		 * 
		 * @return void
		 */
		public function dispose():void {
			for (var i:int=0;i<rows.length;i++) {
				rows[i] = null;
				rows.splice(i,1);
			}
			rows.length = 0;
			rows = null;
		}
		
		//-----------------------------------------------------------
		// Private methods
		//-----------------------------------------------------------
		
		/**
		 * Initering av HighscoreTable.
		 * 
		 * @return void
		 */
		private function init():void {
			initData();
		}
		
		/**
		 * Skickar en förfrågan till Highscore-APIet. Hämtar 10 rader
		 * från specificerad highscore-tabell. Skickar med 
		 * addHighscoreRows som callback funktion.
		 * 
		 * @return void
		 */
		private function initData():void {
			Session.highscore.receive(_table,10,addHighscoreRows);
		}
		
		/**
		 * Skapar HighscoreRow's och lägger in namn, position och
		 * poäng utefter XML-datan som tas emot.
		 * 
		 * @param data XML-data bestående av 10 highscore rader
		 * 
		 * @return void
		 */
		private function addHighscoreRows(data:XML):void {
			for (var i:int=0;i<data.items.item.length();i++) {
				var row:HighscoreRow = new HighscoreRow();
					row.name =  URLUtils.decode(data.items.item[i].name).substr(0,10);
					row.position = i + 1;
					row.score = data.items.item[i].score;
				rows.push(row);
			}
		}
	}
}