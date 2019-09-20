package {
	
	// --------------------------------------------------------------
	// Imports
	//---------------------------------------------------------------
	
	import se.lnu.stickossdk.system.Engine;
	import state.IntroState;
	
	
	// --------------------------------------------------------------
	// SWF-information
	//---------------------------------------------------------------
	
	/**
	 * Information till SWF header 
	 */
	[SWF(width="800",height="600",frameRate="60",backgroundColor="#FFFFFF")]
	
	//---------------------------------------------------------------
	// Public class
	//---------------------------------------------------------------
	
	/**
	 * Klass för att specificera inställningar till SDK'n.
	 */
	public class TheFactory extends Engine {
		
		//-----------------------------------------------------------
		// Private constant properties
		//-----------------------------------------------------------
		
		/**
		 * Spelets ID
		 */
		private const GAME_ID:uint = 33;
		
		//-----------------------------------------------------------
		// Constructor method
		//-----------------------------------------------------------
		/**
		 * Initering av TheFactory
		 */
		public function TheFactory() {
			
		}
		
		//-----------------------------------------------------------
		// Override public methods
		//-----------------------------------------------------------
		
		/**
		 * Inställningar till spelmotorn.
		 * 
		 * @return void
		 */
		override public function setup():void {
			initId = GAME_ID;
			initDisplayState = IntroState;
			initDebugger = false;
		}
	}
}