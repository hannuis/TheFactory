package element.gameElem.travElem.player.playerElem {
	
	// --------------------------------------------------------------
	// Imports
	//---------------------------------------------------------------
	
	import asset.PlayerOneGFX;
	import element.gameElem.travElem.player.Player;
	import se.lnu.stickossdk.input.EvertronControls;
	
	//---------------------------------------------------------------
	// Public class
	//---------------------------------------------------------------
	
	/**
	 * Representerar en av spelarna - spelare ett. Klassen ärver från 
	 * Player som hanterar spelarens grafik, kontroller och logik.
	 */
	public class PlayerOne extends Player {
		
		//-----------------------------------------------------------
		// Constructor method
		//-----------------------------------------------------------
		
		/**
		 * Skapar en ny instans av PlayerOne.
		 */
		public function PlayerOne() {
			super(PlayerOneGFX,EvertronControls.PLAYER_ONE);
		}
	}
}