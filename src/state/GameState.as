package state {
	
	// --------------------------------------------------------------
	// Imports
	//---------------------------------------------------------------
	
	import element.gameElem.background.Background;
	import element.gameElem.burner.Burner;
	import element.gameElem.scoreboard.Scoreboard;
	import element.gameElem.travElem.player.playerElem.PlayerOne;
	import element.gameElem.travElem.player.playerElem.PlayerTwo;
	import element.gameElem.travelator.Travelator;
	import handlers.BoxHandler;
	import handlers.GameHandler;
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	
	//---------------------------------------------------------------
	// Public class
	//---------------------------------------------------------------
	
	/**
	 * Klass för att ta fram spelets element, skapar lager, musik
	 * samt hanterar game over. 
	 */
	public class GameState extends DisplayState {
		
		//-----------------------------------------------------------
		// Public properties
		//-----------------------------------------------------------
		
		/**
		 * Box-lager
		 */
		public var boxLayer:DisplayStateLayer;
		
		/**
		 * Bakgrundslager
		 */
		public var backgroundLayer:DisplayStateLayer;
		
		/**
		 * Brännarens baksidelager
		 */
		public var burnerBackLayer:DisplayStateLayer;
		
		/**
		 * Brännarens framsidelager
		 */
		public var burnerFrontLayer:DisplayStateLayer;
		
		/**
		 * Scoreboard-objekt
		 */
		public var scoreboard:Scoreboard;
		
		/**
		 * Travelator-objekt
		 */
		public var travelator:Travelator;
		
		/**
		 * BoxHandler-objekt
		 */
		public var boxHandler:BoxHandler;
		
		/**
		 * Spelar-array
		 */
		public var playerArr:Vector.<Object> = new Vector.<Object>();
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		/**
		 * Antalet spelare som ska tas fram
		 */
		private var _numPlayers:uint;
		
		/**
		 * HUD-lager
		 */
		private var hudLayer:DisplayStateLayer;
		
		/**
		 * Spelar-lager
		 */
		private var playerLayer:DisplayStateLayer;
		
		/**
		 * Travelator-lager
		 */
		private var travLayer:DisplayStateLayer;
		
		/**
		 * GameHandler-objekt
		 */
		private var gameHandler:GameHandler;
		
		/**
		 * Background-objekt
		 */
		private var bg:Background;
		
		/**
		 * Burner-objekt
		 */
		private var burner:Burner;
		
		/**
		 * Ljudobjekt för bakgrundsmusik
		 */
		private var  _backgroundMusic:SoundObject;
		
		/**
		 * Ljudobjekt för ljudobjekt
		 */
		private var  _backgroundSound:SoundObject;
		
		//-----------------------------------------------------------
		// Private constants
		//-----------------------------------------------------------
		
		/**
		 * Bakgrundslager-namn
		 */
		private const LAYER_BACKGROUND:String = "background";
		
		/**
		 * HUD-lagernamn
		 */
		private const LAYER_HUD:String = "HUD";
		
		/**
		 * Travelator-lagernamn
		 */
		private const LAYER_TRAVELATOR:String = "travelator";
		
		/**
		 * Brännarens baksidas lagernamn
		 */
		private const LAYER_BURNER_BACK:String = "burnerBack";
		
		/**
		 * Spelarlagernamn
		 */
		private const LAYER_PLAYER:String = "player";
		
		/**
		 * Boxlagernamn
		 */
		private const LAYER_BOX:String = "box";
		
		/**
		 * Brännarens framsidas lagernamn
		 */
		private const LAYER_BURNER_FRONT:String = "burnerFront";
		
		//-----------------------------------------------------------
		// Private embedded constants
		//-----------------------------------------------------------
		
		/**
		 * Ljudobjekt för bakgrundsljud
		 */
		[Embed(source = "../../asset/mp3/backgroundSound.mp3")]
		private const BACKGROUND_SOUND:Class;
		
		/**
		 * Ljudobjekt för bakgrundsmusik
		 */
		[Embed(source = "../../asset/mp3/inGame.mp3")]
		private const BACKGROUND_MUSIC:Class;
		
		//-----------------------------------------------------------
		// Constructor method
		//-----------------------------------------------------------
		
		/**
		 * Initering av GameState
		 * 
		 * @param numPlayers Antalet spelare som ska spela
		 */
		public function GameState(numPlayers:uint) {
			super();
			_numPlayers = numPlayers;
		}
		
		//-----------------------------------------------------------
		// Override public methods
		//-----------------------------------------------------------
		
		/**
		 * Initering av GameState
		 * 
		 * @return void
		 */
		override public function init():void {
			initLayers();
			initSound();
			initElems();
			initHandlers();
		}
		
		/**
		 * Anropar olika deallokeringsmetoder
		 * 
		 * @return void
		 */
		override public function dispose():void {
			gameHandler.dispose();
			boxHandler.dispose();
			bg.dispose();
			burner.dispose();
			disposeSound();
			disposeObjects();
			disposeLayers();
		}
		
		//-----------------------------------------------------------
		// Public methods
		//-----------------------------------------------------------
		
		/**
		 * Stoppar poängräknaren, kontrollerar om poängen var ska
		 * sättas in i highscore-listan samt anropar spelarens die-
		 * metod.
		 * 
		 * @return void
		 */
		public function onGameOver(player):void {
			scoreboard.stopScoreCounter();
			Session.highscore.smartSend(_numPlayers,scoreboard.points,10,gameOver);
			player.die();
		}
		
		
		//-----------------------------------------------------------
		// Private methods
		//-----------------------------------------------------------
		
		/**
		 * Skapar lager som ska finnas i GameState.
		 * 
		 * @return void
		 */
		private function initLayers():void {
			backgroundLayer = layers.add(LAYER_BACKGROUND);
			hudLayer = layers.add(LAYER_HUD);
			travLayer = layers.add(LAYER_TRAVELATOR);
			burnerBackLayer = layers.add(LAYER_BURNER_BACK);
			boxLayer = layers.add(LAYER_BOX);
			playerLayer = layers.add(LAYER_PLAYER);
			burnerFrontLayer = layers.add(LAYER_BURNER_FRONT)
		}
		
		/**
		 * Initering av ljud.
		 * 
		 * @return void
		 */
		private function initSound():void {
			getMusic();
			getSound();
		}
		
		/**
		 * Initering av element.
		 * 
		 * @return void
		 */
		private function initElems():void {
			getBackground();
			getHud();
			getBurner();
			getTravelator();
			getPlayer();
		}
		
		/**
		 * Initering av hanterare.
		 * 
		 * @return void
		 */
		private function initHandlers():void {
			getBoxHandler();
			getGameHandler();
		}
		
		/**
		 * Tar fram bakgrundsmusik.
		 * 
		 * @return void
		 */
		private function getMusic():void {
			Session.sound.musicChannel.sources.add("bgSoundIn",BACKGROUND_MUSIC);
			_backgroundSound = Session.sound.musicChannel.get("bgSoundIn",true,true)
			_backgroundSound.play(int.MAX_VALUE);
		}
		
		/**
		 * Tar fram bakgrundsljud.
		 * 
		 * @return void
		 */
		private function getSound():void {
			Session.sound.soundChannel.sources.add("bgMusicIn",BACKGROUND_SOUND);
			_backgroundMusic = Session.sound.soundChannel.get("bgMusicIn",true,true);
			_backgroundMusic.play(int.MAX_VALUE);
		}
		
		/**
		 * Tar fram Background-objekt.
		 * 
		 * @return void
		 */
		private function getBackground():void {
			bg = new Background(this);
		}
		
		/**
		 * Tar fram Scoreboard-objekt, lägger ut i DisplayObject-
		 * Container samt startar poängräknaren.
		 * 
		 * @return void
		 */
		private function getHud():void {
			scoreboard = new Scoreboard();
			hudLayer.addChild(scoreboard);
			scoreboard.startScoreCounter();
		}
		
		/**
		 * Tar fram Burner-objekt.
		 * 
		 * @return void
		 */
		private function getBurner():void {
			burner = new Burner(this);
		}
		
		/**
		 * Tar fram Travelator-objekt samt lägger ut i Display-
		 * ObjectContainer.
		 * 
		 * @return void
		 */
		private function getTravelator():void {
			travelator = new Travelator();
			travLayer.addChild(travelator);
		}
		
		/**
		 * Tar fram Player-objekt, lägger ut i DisplayObjectContainer
		 * samt lägger in dessa i spelar-arrayen.
		 * 
		 * @return void
		 */
		private function getPlayer():void {
			var playerOne:PlayerOne = new PlayerOne();
			playerLayer.addChild(playerOne);
			playerArr.push(playerOne);
			
			if (_numPlayers == 2) {
				var playerTwo:PlayerTwo = new PlayerTwo();
				playerLayer.addChild(playerTwo);
				playerArr.push(playerTwo);
			}
		}
		
		/**
		 * Tar fram Boxhandler-objektet.
		 * 
		 * @return void
		 */
		private function getBoxHandler():void {
			boxHandler = new BoxHandler(this);
		}
		
		/**
		 * Tar fram GameHandler-objektet.
		 * 
		 * @return void
		 */
		private function getGameHandler():void {
			gameHandler = new GameHandler(this);
		}
		
		/**
		 * Byter state.
		 * 
		 * @return void
		 */
		private function gameOver(data:XML):void {
			Session.application.displayState = new GameOverState(_numPlayers,scoreboard.points);
		}
		
		/**
		 * Deallokerar allokerade ljudobjekt.
		 * 
		 * @return void
		 */
		private function disposeSound():void {
			_backgroundMusic.dispose();
			_backgroundMusic = null;
			_backgroundSound.dispose();
			_backgroundSound = null;
		}
		
		/**
		 * Deallokerar allokerade objekt.
		 * 
		 * @return void
		 */
		private function disposeObjects():void {
			gameHandler = null;
			boxHandler = null;
			bg = null;
			burner = null;
			scoreboard = null;
			travelator = null;
			for (var i:int=0;i<playerArr.length;i++) {
				playerArr[i] = null;
			}
		}
		
		/**
		 * Deallokerar allokerade lager.
		 * 
		 * @return void
		 */
		private function disposeLayers():void {
			layers.removeAndDispose(LAYER_BACKGROUND);
			layers.removeAndDispose(LAYER_HUD);
			layers.removeAndDispose(LAYER_TRAVELATOR);
			layers.removeAndDispose(LAYER_PLAYER);
			layers.removeAndDispose(LAYER_BOX);
			layers.removeAndDispose(LAYER_BURNER_BACK);
			layers.removeAndDispose(LAYER_BURNER_FRONT);
		}
	}
}