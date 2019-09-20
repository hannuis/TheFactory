package element.gameElem.scoreboard {
	
	// --------------------------------------------------------------
	// Imports
	//---------------------------------------------------------------
	
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import asset.PointTxtGFX;
	import element.DisplayElement;
	import se.lnu.stickossdk.system.Session;
	
	//---------------------------------------------------------------
	// Public class
	//---------------------------------------------------------------
	
	/**
	 * Klass för spelets HUD/poängräknaren. Hanterar poänguppräkning
	 * och  positionering av Scoreboard. Klassen ärver från 
	 * DisplayElement som hanterar skapandet av grafiken samt 
	 * utplacering.
	 */
	public class Scoreboard extends DisplayElement {
		
		//-----------------------------------------------------------
		// Public properties
		//-----------------------------------------------------------
		
		/**
		 * Antalet poäng som spelaren samlat ihop
		 */
		public var points:uint = 0;
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		/**
		 * Intervall för hur ofta poäng läggs till i points
		 */
		private var _addScoreInterval:uint;
		
		/**
		 * Poäng med korrekt antal 0:or framför poängsumman
		 */
		private var _num:String;
		
		//-----------------------------------------------------------
		// Private constants
		//-----------------------------------------------------------
		
		/**
		 * Antalet poäng som läggs till efter bestämt intervall
		 */
		private const ADD:uint = 3;
		
		//-----------------------------------------------------------
		// Constructor method
		//-----------------------------------------------------------
		
		/**
		 * Initiering av Scoreboard.
		 */
		public function Scoreboard() {
			super(PointTxtGFX);
		}
		
		//-----------------------------------------------------------
		// Override public methods
		//-----------------------------------------------------------
		
		/**
		 * Initering av Scoreboard.
		 * 
		 * @return void
		 */
		override public function init():void {
			super.init();
			initPlace();
		}
		
		//-----------------------------------------------------------
		// Public methods
		//-----------------------------------------------------------
		
		/**
		 * Startar _addScoreInterval. Lägger till poäng efter 
		 * inställd intervalltid.
		 * 
		 * @return void
		 */
		public function startScoreCounter():void {
			_addScoreInterval = setInterval(addScore,175);
		}
		
		/**
		 * Stoppar _addScoreInterval. Inga mer poäng läggs till.
		 * 
		 * @return void
		 */
		public function stopScoreCounter():void {
			clearInterval(_addScoreInterval);
		}
		
		/**
		 * Gör om poängen till en sträng för att få korrekt antal
		 * 0:or. Lägger in strängen i det grafiska elementet.
		 * 
		 * @param points Nuvarande poängen
		 * 
		 * @return void
		 */
		public function updateScore(points):void {
			_num = ("000000" + points).slice(-6);
			super.skin.PointsTxt.text = _num;
		}
		
		//-----------------------------------------------------------
		// Private methods
		//-----------------------------------------------------------
		
		/**
		 * Positionering av Scoreboard.
		 * 
		 * @return void
		 */
		private function initPlace():void {
			this.y = this.height;
			this.x = Session.application.size.x - (this.width * 0.5) - 50;
		}
		
		/**
		 * Lägger till poäng. Anropas efter tidsinställt intervall.
		 * 
		 * @return void
		 */
		private function addScore():void {
			points += ADD;
			updateScore(points);
		}
	}
}