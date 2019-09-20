package handlers {
	
	// --------------------------------------------------------------
	// Imports
	//---------------------------------------------------------------
	
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	//---------------------------------------------------------------
	// Public class
	//---------------------------------------------------------------
	
	public class GameHandler {
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		/**
		 * Referens till GameState-objektet
		 */
		private var _game:Object;
		
		/**
		 * IntervallsID för att anropa hitTest-metoderna
		 */
		private var _updateHitboxInterval:uint;
		
		/**
		 * IntervallsID för att kontrollera spelarens position
		 */
		private var _updatePositionCheckInterval:uint;
		
		/**
		 * IntervallsID för att kontrollera hastigheten
		 */
		private var _speedUpInterval:uint;
		
		/**
		 * Hastigheten som rullbandet ökar med
		 */
		private var _upSpeed:Number = 0.5;
		
		/**
		 * Boolean för att kontrollera om spelaren har förlorat
		 */
		private var _lose:Boolean;
		
		//-----------------------------------------------------------
		// Private constants
		//-----------------------------------------------------------
		
		/**
		 * Max-hastigheten
		 */
		private const MAX_SPEED:Number = 6;
		
		//-----------------------------------------------------------
		// Constructor method
		//-----------------------------------------------------------
		
		/**
		 * Initering av GameHandler
		 * 
		 * @param game Referens till GameState-objektet
		 */
		public function GameHandler(game:Object) {
			_game = game;
			init();
		}
		
		//-----------------------------------------------------------
		// Public methods
		//-----------------------------------------------------------
		
		/**
		 * Deallokerar objekt som allokerats av GameHandler.
		 * 
		 * @return void
		 */
		public function dispose():void {
			clearInterval(_updatePositionCheckInterval);
			_game = null;
		}
		
		//-----------------------------------------------------------
		// Private methods
		//-----------------------------------------------------------
		
		/**
		 * Initering av GameHandler.
		 * 
		 * @return void
		 */
		private function init():void {
			update();
		}
		
		/**
		 * Uppdateringsmetod.
		 * 
		 * @return void
		 */
		private function update():void {
			_updateHitboxInterval = setInterval(updateHitboxCheck,10);
			_updatePositionCheckInterval = setInterval(updatePlayerPositionCheck,10);
			_speedUpInterval = setInterval(speedUp,5000); // var 10:e sekund ökar hastigheten/svårighetsgraden
		}
		
		/**
		 * Uppdateringsmetod för hitTest-metoderna
		 * 
		 * @return void
		 */
		private function updateHitboxCheck():void {
			controlHitboxTop();
			controlHitboxLeft();
			controlHitboxRight();
		}
		
		/**
		 * Uppdateringsmetod för att kontrollera spelarens position
		 * 
		 * @return void
		 */
		private function updatePlayerPositionCheck():void {
			checkPlayerPosition();
		}
		
		/**
		 * Uppdateringsmetod som ökar tempot på spelarna, boxarna samt
		 * minskar spelarens bonus-speed efter regelverk.
		 * 
		 * @return void
		 */
		private function speedUp():void {
			if (_game.boxHandler.speed < MAX_SPEED) {
				for (var y:uint=0;y<_game.playerArr.length;y++) {
					_game.playerArr[y].speed += _upSpeed;
					if (_game.boxHandler.speed > 3 && _game.playerArr[y].bonusSpeed > 1) {
						_game.playerArr[y].bonusSpeed -= 0.5;
					}
				}
				for (var i:uint=0;i<_game.boxHandler.boxArr.length;i++) {
					_game.boxHandler.boxArr[i].speed += _upSpeed;
				}
				_game.boxHandler.speed += _upSpeed;
			}
		}
		
		/**
		 * Kontrollerar om spelarens inbyggda objekt bottomSide nuddar
		 * boxarnas inbyggda objekt topSide.
		 * 
		 * @return void
		 */
		private function controlHitboxTop():void {
			if (_game.boxHandler.boxArr.length > 0) {
				for (var y:uint=0;y<_game.playerArr.length;y++) {
					for (var i:uint=0;i<_game.boxHandler.boxArr.length;i++) {
						if (_game.playerArr[y].skin.bottomSide.hitTestObject(_game.boxHandler.boxArr[i].skin.topSide)) {
							_game.playerArr[y].onBox = true;
							_game.playerArr[y].boxY = _game.boxHandler.boxArr[i].y - _game.boxHandler.boxArr[i].height + 5;
							break;
						}
						else _game.playerArr[y].onBox = false;
					}
				}
			}
		}
		
		/**
		 * Kontrollerar om spelaren nuddar boxarnas leftSide.
		 * 
		 * @return void
		 */
		private function controlHitboxLeft():void {
			if (_game.boxHandler.boxArr.length > 0) {
				for (var y:uint=0;y<_game.playerArr.length;y++) {
					for (var i:uint=0;i<_game.boxHandler.boxArr.length;i++) {
						if (_game.playerArr[y].skin.hitTestObject(_game.boxHandler.boxArr[i].skin.leftSide)) {
							_game.playerArr[y].removeRightMovement = true;
							break;
						} 
						else _game.playerArr[y].removeRightMovement = false;
					}
				}
			}
		}
		
		/**
		 * Kontrollerar om spelaren nuddar boxarnas rightSide.
		 * 
		 * @return void
		 */
		private function controlHitboxRight():void {
			if (_game.boxHandler.boxArr.length > 0) {
				for (var y:uint=0;y<_game.playerArr.length;y++) {
					for (var i:uint=0;i<_game.boxHandler.boxArr.length;i++) {
						if (_game.playerArr[y].skin.hitTestObject(_game.boxHandler.boxArr[i].skin.rightSide)) {
							_game.playerArr[y].removeLeftMovement = true;
							break;
						} 
						else _game.playerArr[y].removeLeftMovement = false;
					}	
				}
			}
		}
		
		/**
		 * Kontrollerar om spelaren är utanför rullbandet, isåfall ska uppdaterings-
		 * metoder stoppas, spelarens die-funktion anropas, spelarnas kontroller tas
		 * bort och GameHandlers onGameOver anropas.
		 * 
		 * @return void
		 */
		private function checkPlayerPosition():void {
			for (var y:uint=0;y<_game.playerArr.length;y++) {
				if (_game.playerArr[y].x < (_game.travelator.x - _game.travelator.width)) {
					if (!_lose) {
						clearInterval(_updateHitboxInterval);
						clearInterval(_speedUpInterval);
						_lose = true;
						_game.onGameOver(_game.playerArr[y]);
						_upSpeed = 0;
						removePlayerControls();
					} else _game.playerArr[y].die();
				}
			}
		}
		
		/**
		 * Tar bort spelarnas kontroller.
		 * 
		 * @return void
		 */
		private function removePlayerControls():void {
			for (var i:int=0;i<_game.playerArr.length;i++) {
				_game.playerArr[i].controls = null;
				_game.playerArr[i].standStill();
			}
		}
	}
}