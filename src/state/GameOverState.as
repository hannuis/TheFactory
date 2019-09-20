package state {
	
	// --------------------------------------------------------------
	// Imports
	//---------------------------------------------------------------
	
	import element.menuElem.menu.GameOver;
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.system.Session;
	
	//---------------------------------------------------------------
	// Public class
	//---------------------------------------------------------------
	
	/**
	 * Klass för Game over-statet. Tar fram en game over-meny och byter efter
	 * förfrågan till nästa state.
	 */
	public class GameOverState extends DisplayState {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		/**
		 * Bakgrundslager
		 */
		private var _backgroundLayer:DisplayStateLayer;
		
		/**
		 * Meny-objekt
		 */
		private var _menu:GameOver;
		
		/**
		 * Antalet spelare som spelat
		 */
		private var _numPlayers:uint;
		
		/**
		 * Poängen från föregående spel
		 */
		private var _score:uint;
		
		//-----------------------------------------------------------
		// Private constants
		//-----------------------------------------------------------
		
		/**
		 * Bakgrundslager-namn
		 */
		private const LAYER_BACKGROUND:String = "background";
		
		//-----------------------------------------------------------
		// Constructor method
		//-----------------------------------------------------------
		/**
		 * Initering av GameOverState
		 * 
		 * @param numPlayers Antalet spelare som spelade föregående
		 * spel
		 * 
		 * @param score Poäng som sparades undan från föregående spel
		 */
		public function GameOverState(numPlayers:uint,score:uint) {
			super();
			_numPlayers = numPlayers;
			_score = score;
		}
		
		//-----------------------------------------------------------
		// Override public methods
		//-----------------------------------------------------------
		
		/**
		 * Initering av GameOverState.
		 * 
		 * @return void
		 */
		override public function init():void {
			initLayers();
			initMenu();
			initScore();
		}
		
		/**
		 * Deallokerar objekt som allokerats av GameOverState.
		 * 
		 * @return void
		 */
		override public function dispose():void {
			_menu.dispose();
			_backgroundLayer.removeChild(_menu);
			layers.removeAndDispose(LAYER_BACKGROUND);
			_backgroundLayer = null;
			_menu = null;
		}
		
		/**
		 * Uppdateringsmetod.
		 * 
		 * @return void
		 */
		override public function update():void {
			checkControls();
		}
		
		//-----------------------------------------------------------
		// Private methods
		//-----------------------------------------------------------
		
		/**
		 * Skapar bakgrundslager.
		 * 
		 * @return void
		 */
		private function initLayers():void {
			_backgroundLayer = layers.add(LAYER_BACKGROUND);
		}
		
		/**
		 * Tar fram GameOver-objekt
		 * 
		 * @return void
		 */
		private function initMenu():void {
			_menu = new GameOver(_numPlayers);
			_backgroundLayer.addChild(_menu);
		}
		
		/**
		 * Lägger in poängsumman i menyns poängfält
		 * 
		 * @return void
		 */
		private function initScore():void {
			var num:String = ("000000" + _score).slice(-6);
			_menu.skin.PointsTxt.text = num;
		}
		
		/**
		 * Kontrollerar om användaren klickat på knapp 1, isåfall
		 * byt state.
		 * 
		 * @return void
		 */
		private function checkControls():void {
			if (Input.keyboard.justPressed(_menu.controls.PLAYER_BUTTON_1)) {
				if (_menu.selected == "newGame") Session.application.displayState = new GameState(_numPlayers)
				if (_menu.selected == "menu") Session.application.displayState = new StartMenuState();
			}
		}
	}
}