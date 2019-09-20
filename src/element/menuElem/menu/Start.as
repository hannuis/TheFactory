package element.menuElem.menu {
	
	// --------------------------------------------------------------
	// Imports
	//---------------------------------------------------------------
	
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import asset.MenuBTN;
	import element.menuElem.Menu;
	import element.menuElem.highscore.Highscore;
	import element.menuElem.highscore.HighscoreRow;
	import se.lnu.stickossdk.input.Input;
	
	//---------------------------------------------------------------
	// Public class
	//---------------------------------------------------------------
	
	/**
	 * Klass för start-menyn. Tar fram highscore-listor samt hanterar
	 * bläddrande i den grafiska meny-listan. Ärver från Menu som tar
	 * fram ljud och klocka.
	 */
	public class Start extends Menu {
		
		//-----------------------------------------------------------
		// Public properties
		//-----------------------------------------------------------
		
		/** 
		 * Anger vilken rubrik i den grafiska meny-listan som är aktiv
		 */
		public var selected:String = "onePlayer";
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
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
		 * Initering av Start
		 */
		public function Start() {
			super(MenuBTN);
		}
		
		//-----------------------------------------------------------
		// Override public methods
		//-----------------------------------------------------------
		
		/**
		 * Initering av Start.
		 * 
		 * @return void
		 */
		override public function init():void {
			super.init();
			initHighscore();
			initSkin();
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
			checkControls();
		}
		
		//-----------------------------------------------------------
		// Private methods
		//-----------------------------------------------------------
		
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
		 * Bestämmer vilken rubrik i meny-listan som ska visas först.
		 * 
		 * @return void
		 */
		private function initSkin():void {
			super.skin.gotoAndStop("PlayerOne");
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
			if (super.skin.currentFrameLabel == "PlayerOne") {
				super.skin.gotoAndStop(4);
				selected = "credits";
			}
			else if (super.skin.currentFrame == 4) {
				super.skin.gotoAndStop("HowTo");
				selected = "howTo";
			}
			else if (super.skin.currentFrameLabel == "HowTo") {
				super.skin.gotoAndStop("PlayerTwo");
				selected = "twoPlayers";
				showHighscore(_highscore.highscoreTwo.rows);
			}
			else if (super.skin.currentFrameLabel == "PlayerTwo") {
				super.skin.gotoAndStop("PlayerOne");
				selected = "onePlayer";
				showHighscore(_highscore.highscoreOne.rows);
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
			if (super.skin.currentFrameLabel == "PlayerOne") {
				super.skin.gotoAndStop("PlayerTwo");
				selected = "twoPlayers";
				showHighscore(_highscore.highscoreTwo.rows);
			}
			else if (super.skin.currentFrameLabel == "PlayerTwo") {
				super.skin.gotoAndStop("HowTo");
				selected = "howTo";
			}
			else if (super.skin.currentFrameLabel == "HowTo") {
				super.skin.gotoAndStop(4);
				selected = "credits";
			}
			else if (super.skin.currentFrame == 4) {
				super.skin.gotoAndStop("PlayerOne");
				selected = "onePlayer";
				showHighscore(_highscore.highscoreOne.rows);
			}
		}
		
		
		/**
		 * Kontrollerar om highscore-listorna har fyllts på, isåfall
		 * visas den highscore-lista som är vald.
		 * 
		 * @return void
		 */
		private function displayHighscore():void {
			if (_highscore.highscoreOne.rows.length > 0 && _highscore.highscoreTwo.rows.length > 0) {
				if (selected == "onePlayer") showHighscore(_highscore.highscoreOne.rows);
				else if (selected == "twoPlayers") showHighscore(_highscore.highscoreTwo.rows);
				clearInterval(_highscoreLoader);
			}
			
		}
		
		/**
		 * Skriver ut highscore-listan i den grafiska representationen.
		 * 
		 * @return void
		 */
		private function showHighscore(highscore:Vector.<HighscoreRow>):void {
			if (highscore.length > 0) {
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