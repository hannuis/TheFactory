package element.gameElem.background {
	
	// --------------------------------------------------------------
	// Imports
	//---------------------------------------------------------------
	
	import flash.display.Bitmap;
	import element.gameElem.background.backgroundElem.BoxBackground;
	import element.gameElem.background.backgroundElem.LightBackground;
	import element.gameElem.background.backgroundElem.TravBackground;
	
	//---------------------------------------------------------------
	// Public class
	//---------------------------------------------------------------
	
	/**
	 * Klass för spelets bakgrund. Tar fram objekt som tillhör
	 * bakgrunden och lägger in dessa i Background-lagret i korrekt
	 * ordning.
	 */
	public class Background {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		/**
		 * Referens till GameHandler
		 */
		private var _game:Object;
		
		/**
		 * Referens till bakgrundsbilden
		 */
		private var _background:Bitmap;
		
		/**
		 * Referens till TravelatorBackground-objektet
		 */
		private var _travBg:TravBackground;
		
		/**
		 * Referens till BoxBackground-objektet
		 */
		private var _boxBg:BoxBackground;
		
		/**
		 * Referens till LightBackground-objektet
		 */
		private var _lightBg:LightBackground;
		
		//-----------------------------------------------------------
		// Private embedded constants
		//-----------------------------------------------------------
		
		/**
		 * Bakgrundsbild
		 */
		[Embed(source="../../../../asset/jpg/BackgroundLayer1GFX.jpg")]
		private const BACKGROUND:Class;
		
		//-----------------------------------------------------------
		// Constructor method
		//-----------------------------------------------------------
		
		/**
		 * Initiering av Background.
		 * 
		 * @param game GameHandler objektet
		 */
		public function Background(game:Object) {
			_game = game;
			initBackground();
		}
		
		//-----------------------------------------------------------
		// Public methods
		//-----------------------------------------------------------
		
		/**
		 * Deallokerar objekt som allokerats av Background.
		 * 
		 * @return void
		 */
		public function dispose():void {
			_game = null;
			_background = null;
			_travBg = null;
			_boxBg = null;
			_lightBg = null;
		}
		
		//-----------------------------------------------------------
		// Private methods
		//-----------------------------------------------------------
		
		/**
		 * Initering av bakgrundselement.
		 * 
		 * @return void
		 */
		private function initBackground():void {
			getBackground();
			getTravelator();
			getBox();
			getLight();
		}
		
		/**
		 * Tar fram bakgrundens JPG-bild.
		 * 
		 * @return void
		 */
		private function getBackground():void {
			_background = new BACKGROUND();
			_game.backgroundLayer.addChild(_background);
		}
		
		/**
		 * Tar fram bakgrundens rullband.
		 * 
		 * @return void
		 */
		private function getTravelator():void {
			_travBg = new TravBackground();
			_game.backgroundLayer.addChild(_travBg);
		}
		
		/**
		 * Tar fram bakgrundens boxar.
		 * 
		 * @return void
		 */
		private function getBox():void {
			_boxBg = new BoxBackground();
			_game.backgroundLayer.addChild(_boxBg);
		}
		
		/**
		 * Tar fram bakgrundens ljus.
		 * 
		 * @return void
		 */
		private function getLight():void {
			_lightBg = new LightBackground();
			_game.backgroundLayer.addChild(_lightBg);
		}
	}
}