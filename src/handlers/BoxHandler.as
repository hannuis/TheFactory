package handlers {
	
	// --------------------------------------------------------------
	// Imports
	//---------------------------------------------------------------
	
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import element.gameElem.travElem.box.boxLevel.BoxLvlOne;
	import element.gameElem.travElem.box.boxLevel.BoxLvlThree;
	import element.gameElem.travElem.box.boxLevel.BoxLvlTwo;
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.util.MathUtils;
	
	//---------------------------------------------------------------
	// Public class
	//---------------------------------------------------------------
	
	/**
	 * Klass för att hantera boxarna: plockar fram boxar och lägger ut
	 * i DisplayObjectContainer utefter det regelverk som bestäms i
	 * klassen.
	 */
	public class BoxHandler {
		
		//-----------------------------------------------------------
		// Public properties
		//-----------------------------------------------------------
		
		/**
		 * Vector med boxar
		 */
		public var boxArr:Vector.<Object> = new Vector.<Object>();
		
		/**
		 * Hastighet
		 */
		public var speed:Number = 2;
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		/**
		 * GameState-objekt
		 */
		private var _game:Object;
		
		/**
		 * Uppdateringsintervalls-ID
		 */
		private var updateInterval:uint;
		
		/**
		 * Slumpat x värde
		 */
		private var placeX:uint;
		
		//-----------------------------------------------------------
		// Constructor method
		//-----------------------------------------------------------
		/**
		 * Initering av BoxHandler
		 * 
		 * @param game Referens till GameState-objektet
		 */
		public function BoxHandler(game:Object) {
			_game = game;
			init();
		}
		
		//-----------------------------------------------------------
		// Public methods
		//-----------------------------------------------------------
		
		/**
		 * Deallokerar objekt som allokerats av BoxHandler.
		 * 
		 * @return void
		 */
		public function dispose():void {
			clearInterval(updateInterval);
			_game = null;
		}
		
		//-----------------------------------------------------------
		// Private methods
		//-----------------------------------------------------------
		
		/**
		 * Initering av BoxHandler.
		 * 
		 * @return void
		 */
		private function init():void {
			updateInterval = setInterval(update,60);
		}
		
		/**
		 * Uppdateringsmetod.
		 * 
		 * @return void
		 */
		private function update():void {
			controlBoxes();
			getBoxes();
		}
		
		/**
		 * Kontrollerar om boxarna är förbi Travelators slut.
		 * 
		 * @return void
		 */
		private function controlBoxes():void {
			if (boxArr.length > 0) {
				for (var i:int=0;i<boxArr.length;i++) {
					if ((boxArr[i].x - (boxArr[i].width * 0.5)) < (_game.travelator.x - (_game.travelator.width))) {
						boxArr[i].fall();
						boxArr.splice(i,1);
					}
				}
			}
		}
		
		/**
		 * Kontrollerar om en ny box ska skapas samt sätter regelverk för
		 * vilken box som ska efterfrågas.
		 * 
		 * @return void
		 */
		private function getBoxes():void {
			if (boxArr.length < 1) {
				getBox(1);
				return;
			}
			
			for (var i:uint=0;i<boxArr.length;i++) {
				if (boxArr[boxArr.length - 1].x < (Session.application.size.x)) {
					if (boxArr[boxArr.length - 1].name === "lvlOne") {
						if (MathUtils.chance(80)) getBox(2);
						else getBox(1);
						break;
					}
					if (boxArr[boxArr.length - 1].name === "lvlTwo") {
						if (MathUtils.chance(20)) getBox(1);
						else if (MathUtils.chance(30)) getBox(2);
						else getBox(3);
						break;
					}
					if (boxArr[boxArr.length - 1].name === "lvlThree") {
						if (MathUtils.chance(33)) getBox(1);
						else if (MathUtils.chance(50)) getBox(2);
						else getBox(3);
						break;
					}
				}
			}
		}
		
		/**
		 * Tar fram den efterfrågade boxen.
		 * 
		 * @param lvl Nummer på den box som ska tas fram
		 * 
		 * @return void
		 */
		private function getBox(lvl:Number):void {
			var box:Object;
			
			if (lvl == 1) {
				box = new BoxLvlOne();
				box.name = "lvlOne";
			}
			else if (lvl == 2) {
				box = new BoxLvlTwo();
				box.name = "lvlTwo";
			}
			else if (lvl == 3) {
				box = new BoxLvlThree();
				box.name = "lvlThree";
			}
			
			handleBox(box);
		}
		
		/**
		 * Sätter hastighet på boxen, lägger in den i box-arrayen, lägger
		 * ut den i DisplayObjectContainer samt sätter ett slumpat x-värde.
		 * 
		 * @param box Box-objekt
		 * 
		 * @return void
		 */
		private function handleBox(box:Object):void {
			box.speed = speed;
			boxArr.push(box);
			_game.boxLayer.addChild(box);
			box.x = Session.application.size.x + box.width + getRange();
		}
		
		/**
		 * Sätter ett regelverk på hur långt avstånd boxens x-värde ska få. 
		 * Beroende på tidigare placeX värde samt vilken speed spelet har tas
		 * olika längder fram.
		 * 
		 * @return En slumpad placering
		 */
		private function getRange():uint {
			if (speed <= 2.5) {
				if (placeX < 60) placeX = Math.round(MathUtils.randomRange(60,80));
				else placeX = Math.round(MathUtils.randomRange(50,80));
			} 
			else if (speed > 2.5 && speed < 5) {
				if (placeX < 70) placeX = Math.round(MathUtils.randomRange(70,90));
				else placeX = Math.round(MathUtils.randomRange(50,90));
			}
			else if (speed >= 5 && speed < 6) {
				if (placeX < 80) placeX = Math.round(MathUtils.randomRange(80,105));
				else placeX = Math.round(MathUtils.randomRange(60,105));
			}
			else if (speed >= 6) {
				if (placeX < 90) placeX = Math.round(MathUtils.randomRange(90,115));
				else placeX = Math.round(MathUtils.randomRange(60,115));
			}
			return placeX;
		}
	}
}