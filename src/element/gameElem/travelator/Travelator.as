package element.gameElem.travelator {
	
	// --------------------------------------------------------------
	// Imports
	//---------------------------------------------------------------
	
	import asset.TravelatorGFX;
	import element.DisplayElement;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	
	//---------------------------------------------------------------
	// Public class
	//---------------------------------------------------------------
	
	/**
	 * Klass för spelets rullband. Hanterar ljud och positionering av
	 * Travelator. Klassen ärver från DisplayElement som hanterar
	 * skapandet av grafiken samt utplacering.
	 */
	public class Travelator extends DisplayElement {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		/**
		 * Ljudobjekt för rullbandet
		 */
		private var _travelatorSound:SoundObject;
		
		//-----------------------------------------------------------
		// Private embedded  constants
		//-----------------------------------------------------------
		
		/**
		 * Klass för rullbandets ljud
		 */
		[Embed(source = "../../../../asset/mp3/travelatorSound.mp3")]
		private const TRAVELATOR_SOUND:Class;
		
		//-----------------------------------------------------------
		// Constructor method
		//-----------------------------------------------------------
		
		/**
		 * Initering av Travelator.
		 */
		public function Travelator() {
			super(TravelatorGFX);
		}
		
		//-----------------------------------------------------------
		// Override public methods
		//-----------------------------------------------------------
		
		/**
		 * Initering av Travelator.
		 * 
		 * @return void
		 */
		override public function init():void {
			super.init();
			initPlace();
			initSound();
		}
		
		/**
		 * Deallokerar objekt som allokerats av Travelator.
		 * 
		 * @return void
		 */
		override public function dispose():void {
			super.dispose();
			_travelatorSound.dispose();
			_travelatorSound = null;
		}
		
		//-----------------------------------------------------------
		// Private methods
		//-----------------------------------------------------------
		
		/**
		 * Positionering av Travelator
		 * 
		 * @return void
		 */
		private function initPlace():void {
			this.x = Session.application.size.x;
			this.y = Session.application.size.y * 0.805; // magic number
		}
		
		/**
		 * Tar fram och startar rullbandets ljud
		 * 
		 * @return void
		 */
		private function initSound():void {
			Session.sound.soundChannel.sources.add("trav",TRAVELATOR_SOUND);
			_travelatorSound = Session.sound.soundChannel.get("trav",true,true);
			_travelatorSound.play(int.MAX_VALUE);
		}
	}
}