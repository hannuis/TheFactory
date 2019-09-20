package state {
	
	// --------------------------------------------------------------
	// Imports
	//---------------------------------------------------------------
	
	import element.menuElem.menu.Start;
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.system.Session;
	
	//---------------------------------------------------------------
	// Public class
	//---------------------------------------------------------------
	
	/**
	 * Klass för start-statet. Tar fram en start-meny och byter efter
	 * förfrågan till nästa state.
	 */
	public class StartMenuState extends DisplayState {
		
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
		private var _menu:Start;
		
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
		 * Initering av StartMenuState
		 */
		public function StartMenuState() {
			super();
		}
		
		//-----------------------------------------------------------
		// Override public methods
		//-----------------------------------------------------------
		
		/**
		 * Initering av StartMenuState.
		 * 
		 * @return void
		 */
		override public function init():void {
			initLayers();
			initMenu();
		}
		
		/**
		 * Deallokerar objekt som allokerats av StartMenuState.
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
		 * Tar fram Start-objekt
		 * 
		 * @return void
		 */
		private function initMenu():void {
			_menu = new Start();
			_backgroundLayer.addChild(_menu);
		}
		
		/**
		 * Kontrollerar om användaren klickat på knapp 1, isåfall
		 * byt state.
		 * 
		 * @return void
		 */
		private function checkControls():void {
			if (Input.keyboard.justPressed(_menu.controls.PLAYER_BUTTON_1)) {
				if (_menu.selected == "onePlayer") Session.application.displayState = new GameState(1);
				if (_menu.selected == "twoPlayers") Session.application.displayState = new GameState(2);
			}
		}
	}
}