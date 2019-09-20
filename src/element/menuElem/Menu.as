package element.menuElem {
	
	// --------------------------------------------------------------
	// Imports
	//---------------------------------------------------------------
	
	import element.DisplayElement;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	
	//---------------------------------------------------------------
	// Public class
	//---------------------------------------------------------------
	
	/**
	 * Klass för Meny-element. Tar fram ljud och klocka för menyn.
	 * Ärver från DisplayElement som hanterar skapandet av grafiken
	 * samt utplacering.
	 */
	public class Menu extends DisplayElement {
		
		//-----------------------------------------------------------
		// Public properties
		//-----------------------------------------------------------
		
		/**
		 * Evertron kontroll
		 */
		public var controls:EvertronControls;
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		/**
		 * Datumobjekt
		 */
		private var _time:Date;
		
		/**
		 * Ljudobjekt för bakgrundsmusik
		 */
		private var _backgroundMusic:SoundObject;
		
		/**
		 * Ljudobjekt för byte av rubrik
		 */
		private var _paperSound:SoundObject;
		//-----------------------------------------------------------
		// Private embedded constants
		//-----------------------------------------------------------
		
		/**
		 * Bakgrundsmusik
		 */
		[Embed(source = "../../../asset/mp3/offGame.mp3")]
		private static const BACKGROUND_MUSIC:Class;
		
		/**
		 * Pappersljud
		 */
		[Embed(source = "../../../asset/mp3/paper.mp3")]
		private static const PAPER_SOUND:Class;
		
		//-----------------------------------------------------------
		// Constructor method
		//-----------------------------------------------------------
		
		/**
		 * Initering av Menu
		 * 
		 * @param skinBuff Grafisk representation av boxen
		 */
		public function Menu(skinBuff:Class) {
			super(skinBuff);
		}
		
		//-----------------------------------------------------------
		// Override public methods
		//-----------------------------------------------------------
		
		/**
		 * Initering av Menu.
		 * 
		 * @return void
		 */
		override public function init():void {
			super.init();
			initControls();
			initClock();
			initSound();
		}
		
		/**
		 * Deallokering av objekt som allokerats av Menu.
		 * 
		 * @return void
		 */
		override public function dispose():void {
			super.dispose();
			_backgroundMusic.dispose();
			_paperSound.dispose();
			_backgroundMusic = null;
			_paperSound = null;
			_time = null;
			controls = null;
		}
		
		//-----------------------------------------------------------
		// Private methods
		//-----------------------------------------------------------
		
		/**
		 * Tar fram kontroll-objekt som sätts till spelare 1's 
		 * kontroller.
		 * 
		 * @return void
		 */
		private function initControls():void {
			controls = new EvertronControls();
			controls.player = EvertronControls.PLAYER_ONE;
		}
		
		/**
		 * Tar fram datorns aktuella tid.
		 * 
		 * @return void
		 */
		private function initClock():void {
			_time = new Date();
			var min:String = ("00" + _time.minutes).slice(-2);
			var hour:String = ("00" + _time.hours).slice(-2);
			super.skin.time.text = hour + ":" + min;
		}
		
		/**
		 * Initering av ljud.
		 * 
		 * @return void
		 */
		private function initSound():void {
			getBackgroundMusic();
			getPaperSound();
		}
		
		/**
		 * Tar fram bakgrundsmusik.
		 * 
		 * @return void
		 */
		private function getBackgroundMusic():void {
			Session.sound.musicChannel.sources.add("bgMusicOff",BACKGROUND_MUSIC);
			_backgroundMusic = Session.sound.musicChannel.get("bgMusicOff", true, true);
			_backgroundMusic.play(int.MAX_VALUE);
		}
		
		/**
		 * Tar fram pappersljud.
		 * 
		 * @return void
		 */
		private function getPaperSound():void {
			Session.sound.soundChannel.sources.add("paperSound",PAPER_SOUND);
			_paperSound = Session.sound.soundChannel.get("paperSound", true, true);
		}
		
		//-----------------------------------------------------------
		// Protected methods
		//-----------------------------------------------------------
		
		/**
		 * Spelar upp pappersljud.
		 * 
		 * @return void
		 */
		protected function makePaperSound():void {
			_paperSound.play(1);
		}
	}
}