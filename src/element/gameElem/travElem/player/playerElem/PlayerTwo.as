package element.gameElem.travElem.player.playerElem {
	
	// --------------------------------------------------------------
	// Imports
	//---------------------------------------------------------------
	
	import asset.PlayerTwoGFX;
	import element.gameElem.travElem.player.Player;
	import se.lnu.stickossdk.input.EvertronControls;
	
	//---------------------------------------------------------------
	// Public class
	//---------------------------------------------------------------
	
	/**
	 * Representerar en av spelarna - spelare två. Klassen ärver från 
	 * Player som hanterar spelarens grafik, kontroller och logik.
	 */
	public class PlayerTwo extends Player {
		
		//-----------------------------------------------------------
		// Constructor method
		//-----------------------------------------------------------
		
		/**
		 * Skapar en ny instans av PlayerTwo.
		 */
		public function PlayerTwo() {
			super(PlayerTwoGFX,EvertronControls.PLAYER_TWO);
		}
	}
}