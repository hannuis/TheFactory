package element.menuElem.menu {
	
	// --------------------------------------------------------------
	// Imports
	//---------------------------------------------------------------
	
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import asset.GameOverBTN;
	import element.menuElem.Menu;
	import element.menuElem.highscore.Highscore;
	import element.menuElem.highscore.HighscoreRow;
	import se.lnu.stickossdk.input.Input;
	
	//---------------------------------------------------------------
	// Public class
	//---------------------------------------------------------------
	
	/**
	 * Klass för game over-menyn. Tar fram highscore-listor samt 
	 * hanterar bläddrande i den grafiska meny-listan. Ärver från Menu 
	 * som tar fram ljud och klocka.
	 */
	public class GameOver extends Menu {
		
		//-----------------------------------------------------------
		// Public properties
		//-----------------------------------------------------------
		
		/** 
		 * Anger vilken rubrik i den grafiska meny-listan som är aktiv
		 */
		public var selected:String = "newGame";
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		/**
		 * Den tabell som ska tas fram. Beror på vilket spel som 
		 * spelats.
		 */
		private var _table:uint;
		
		/**
		 * Highscore-objekt
		 */
		private var _highscore:Highscore;
		
		/**
		 * Intervall-ID för att kontrollera om highscore-listan är 
		 * inladdad
		 */
		private var _highscoreLoader:uint;
		
		//-----------------------------------------------------------
		// Constructor method
		//-----------------------------------------------------------
		
		/**
		 * Initering av GameOver
		 * 
		 * @param table Den highscore-tabell som ska visas, beror på
		 * vilket spel som har spelats.
		 */
		public function GameOver(table:Number) {
			super(GameOverBTN);
			_table = table;
		}
		
		//-----------------------------------------------------------
		// Override public methods
		//-----------------------------------------------------------
		
		/**
		 * Initering av GameOver.
		 * 
		 * @return void
		 */
		override public function init():void {
			super.init();
			initSkin();
			initHighscore();
		}
		
		/**
		 * Deallokering av objekt som allokerats av Start.
		 * 
		 * @return void
		 */
		override public function dispose():void {
			super.dispose();
			clearInterval(_highscoreLoader);
			_highscore.dispose();
			_highscore = null;
		}
		
		/**
		 * Uppdateringsmetod.
		 * 
		 * @return void
		 */
		override public function update():void {
			super.update();
			checkControls();
		}
		
		//-----------------------------------------------------------
		// Private methods
		//-----------------------------------------------------------
		
		/**
		 * Bestämmer vilken rubrik i meny-listan som ska visas först.
		 * 
		 * @return void
		 */
		private function initSkin():void {
			super.skin.gotoAndStop("PlayerOne");
		}
		
		/**
		 * Initering av Highscore-objekt. Sätter ett intervall för att
		 * anropa displayHighscore-metoden som kontrollerar om highscore
		 * är inladdat.
		 * 
		 * @return void
		 */
		private function initHighscore():void {
			_highscore = new Highscore();
			_highscoreLoader = setInterval(displayHighscore,10);
		}
		
		/**
		 * Kontrollerar om kontrollerna upp eller ner har valts av
		 * spelare 1.
		 * 
		 * @return void
		 */
		private function checkControls():void {
			if (Input.keyboard.justPressed(super.controls.PLAYER_UP)) goUp();
			if (Input.keyboard.justPressed(super.controls.PLAYER_DOWN)) goDown();
		}
		
		/**
		 * Går upp i meny-listan. Beroende på vilken rubrik händer
		 * olika saker.
		 * 
		 * @return void
		 */
		private function goUp():void {
			super.makePaperSound();
			if (super.skin.currentFrame == 1) {
				super.skin.gotoAndStop(2);
				selected = "menu";
			}
			else if (super.skin.currentFrame == 2) {
				super.skin.gotoAndStop(1);
				selected = "newGame";
			}
		}
		
		/**
		 * Går ner i meny-listan. Beroende på vilken rubrik händer
		 * olika saker.
		 * 
		 * @return void
		 */
		private function goDown():void {
			super.makePaperSound();
			if (super.skin.currentFrame == 1) {
				super.skin.gotoAndStop(2);
				selected = "menu";
			}
			else if (super.skin.currentFrame == 2) {
				super.skin.gotoAndStop(1);
				selected = "newGame";
			}
		}
		
		/**
		 * Kontrollerar om highscore-listorna har fyllts på. Visar den
		 * lista som matcher _table-egenskapen.
		 * 
		 * @return void
		 */
		private function displayHighscore():void {
			if (_highscore.highscoreOne.rows.length > 0 && _highscore.highscoreTwo.rows.length > 0) {
				if (_table === 1) showHighscore(_highscore.highscoreOne.rows);
				if (_table === 2) showHighscore(_highscore.highscoreTwo.rows);
				clearInterval(_highscoreLoader);
			}
		}
		
		/**
		 * Skriver ut highscore-listan i den grafiska representationen.
		 * 
		 * @return void
		 */
		private function showHighscore(highscore:Vector.<HighscoreRow>):void {
			if (highscore.length > 1) {
				super.skin.nameTxt.text = "";
				super.skin.scoreTxt.text = "";
				for (var i:int=0;i<highscore.length;i++) {
					if (i<9) super.skin.nameTxt.text += " " + highscore[i].position + " " + highscore[i].name + "\n";
					else if (i>8) super.skin.nameTxt.text += highscore[i].position + " " + highscore[i].name + "\n";
					super.skin.scoreTxt.text += highscore[i].score + "\n";
				}
			}
		}
	}
}