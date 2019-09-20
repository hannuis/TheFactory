package state {
	
	// --------------------------------------------------------------
	// Imports
	//---------------------------------------------------------------
	
	import flash.utils.setTimeout;
	import element.introElem.Intro;
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.system.Session;
	
	//---------------------------------------------------------------
	// Public class
	//---------------------------------------------------------------
	
	public class IntroState extends DisplayState {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		/**
		 * Lager för introts grafiska representation
		 */
		private var _introLayer:DisplayStateLayer;
		
		/**
		 * Intro-objekt
		 */
		private var _intro:Intro;
		
		//-----------------------------------------------------------
		// Private constants
		//-----------------------------------------------------------
		
		/**
		 * Lager-namn
		 */
		private const LAYER_INTRO:String = "intro";
		
		/**
		 * Tiden introt ska visas
		 */
		private const INTRO_TIMEOUT:Number = 3500;
		
		//-----------------------------------------------------------
		// Constructor method
		//-----------------------------------------------------------
		
		/**
		 * Initering av IntroState.
		 */
		public function IntroState() {
			super();
		}
		
		//-----------------------------------------------------------
		// Override public methods
		//-----------------------------------------------------------
		
		/**
		 * Initering av IntroState.
		 * 
		 * @return void
		 */
		override public function init():void {
			initLayers();
			initIntro();
		}
		
		/**
		 * Deallokerar objekt som allokerats av IntroState.
		 * 
		 * @return void
		 */
		override public function dispose():void {
			_intro.dispose();
			_introLayer.removeChild(_intro);
			layers.removeAndDispose(LAYER_INTRO);
			_introLayer = null;
			_intro = null;
		}
		
		//-----------------------------------------------------------
		// Private methods
		//-----------------------------------------------------------
		
		/**
		 * Tar fram lager.
		 * 
		 * @return void
		 */
		private function initLayers():void {
			_introLayer = layers.add(LAYER_INTRO);
		}
		
		/**
		 * Tar fram Intro-objektet och lägger in i DisplayObject-
		 * Container. Startar tiden för att gå vidare till nästa 
		 * state.
		 * 
		 * @return void
		 */
		private function initIntro():void {
			_intro = new Intro();
			_introLayer.addChild(_intro);
			setTimeout(changeState,INTRO_TIMEOUT);
		}
		
		/**
		 * Byter state.
		 * 
		 * @return void
		 */
		private function changeState():void {
			Session.application.displayState = new StartMenuState();
		}
	}
}