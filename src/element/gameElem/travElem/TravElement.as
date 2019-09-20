package element.gameElem.travElem {
	
	// --------------------------------------------------------------
	// Imports
	//---------------------------------------------------------------
	
	import element.DisplayElement;
	import se.lnu.stickossdk.system.Session;
	
	//---------------------------------------------------------------
	// Public class
	//---------------------------------------------------------------
	
	/**
	 * Klass för de element som befinner sig på rullbandet. Hanterar
	 * elementens hastighet i x-led samt y-positionering. Ärver från
	 * DisplayElement som hanterar skapandet av grafiken samt
	 * utplacering.
	 */
	public class TravElement extends DisplayElement {
		
		//-----------------------------------------------------------
		// Public properties
		//-----------------------------------------------------------
		
		/**
		 * Hastigheten elementen ska röra sig i
		 */
		public var speed:Number = 2;
		
		//-----------------------------------------------------------
		// Constructor method
		//-----------------------------------------------------------
		
		/**
		 * Initering av TravElement
		 * 
		 * @param skinBuff Grafisk representation av boxen
		 */
		public function TravElement(skinBuff:Class) {
			super(skinBuff);
		}
		
		//-----------------------------------------------------------
		// Override public methods
		//-----------------------------------------------------------
		
		/**
		 * Initering av TravElement.
		 * 
		 * @return void
		 */
		override public function init():void {
			super.init();
			initPlace();
		}
		
		/**
		 * Uppdateringsmetod.
		 * 
		 * @return void
		 */
		override public function update():void {
			moveObject();
		}
		
		//-----------------------------------------------------------
		// Private methods
		//-----------------------------------------------------------
		
		/**
		 * Positionering av boxens y-värde.
		 * 
		 * @return void
		 */
		private function initPlace():void {
			this.y = Session.application.size.y * 0.745;
		}
		
		/**
		 * Förflyttar objektet efter bestämd hastighet.
		 * 
		 * @return void
		 */
		private function moveObject():void {
			this.x -= speed;
		}
	}
}