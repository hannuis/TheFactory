package element.gameElem.travElem.player {
	
	// --------------------------------------------------------------
	// Imports
	//---------------------------------------------------------------
	
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import element.gameElem.travElem.TravElement;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.system.Session;
	
	//---------------------------------------------------------------
	// Public class
	//---------------------------------------------------------------
	
	/**
	 * Klass för att hantera spelaren, bland annat metoder som springa,
	 * hoppa, falla, dö.
	 */
	public class Player extends TravElement {
		
		//-----------------------------------------------------------
		// Public properties
		//-----------------------------------------------------------
		
		/**
		 * Spelarens bonushastighet
		 */
		public var bonusSpeed:Number = 2;
		
		/**
		 * Kontroll för att spelaren får gå till vänster
		 */
		public var removeLeftMovement:Boolean = false;
		
		/**
		 * Kontroll för att spelaren får gå till höger
		 */
		public var removeRightMovement:Boolean = false;
		
		/**
		 * Kontroll för om spelaren står på en låda
		 */
		public var onBox:Boolean = false;
		
		/**
		 * Boxens y-värde som spelaren står på
		 */
		public var boxY:Number = 0;
		
		/**
		 * Spelarens kontroller
		 */
		public var controls:EvertronControls = new EvertronControls();
		
		//-----------------------------------------------------------
		// Private properties
		//-----------------------------------------------------------
		
		/**
		 * Kontroll för om spelaren lever
		 */
		private var _alive:Boolean = true;
		
		/**
		 * Kontroll för om spelaren hoppar
		 */
		private var _jumping:Boolean = false;
		
		/**
		 * Kontroll för om spelaren springer
		 */
		private var _running:Boolean = false;
		
		/**
		 * Kontroll för om spelaren står på rullbandet
		 */
		private var _onGround:Boolean = false;
		
		/**
		 * Hoppets velocity
		 */
		private var _vel:Number = 0;
		
		/**
		 * Intervalls-ID för fallande av rullbandet
		 */
		private var _fallingInterval:uint;
		
		//-----------------------------------------------------------
		// Private constants
		//-----------------------------------------------------------
		
		/**
		 * Hoppets gravity
		 */
		private const GRAV:uint = 1;
		
		//-----------------------------------------------------------
		// Constructor method
		//-----------------------------------------------------------
		
		/**
		 * Initering av Player
		 * 
		 * @param skinBuff Grafisk representation av spelaren
		 * @param controls Spelarens kontroller
		 */
		public function Player(skinBuff:Class,controls:uint) {
			super(skinBuff);
			this.controls.player = controls;
		}
		
		//-----------------------------------------------------------
		// Override public methods
		//-----------------------------------------------------------
		
		/**
		 * Initeringsmetod av Player.
		 * 
		 * @return void
		 */
		override public function init():void {
			super.init();
			initPlace();
		}
		
		/**
		 * Deallokerar objekt som allokerats av Player.
		 * 
		 * @return void
		 */
		override public function dispose():void {
			super.dispose();
			clearInterval(_fallingInterval);
			controls = null;
		}
		
		/**
		 * Uppdateringsmetod.
		 * 
		 * @return void
		 */
		override public function update():void {
			super.update();
			checkPosition();
			checkControls();
			updatePosition();
			jump();
		}
		
		//-----------------------------------------------------------
		// Public methods
		//-----------------------------------------------------------
		
		/**
		 * Metod för att visa spelarens grafiska animation för att stå
		 * stilla. Sätter _running-egenskapen till falskt.
		 * 
		 * @return void
		 */
		public function standStill():void {
			super.skin.gotoAndStop(1);
			_running = false;
		}
		
		/**
		 * Metod för när spelaren dör. Kontrollerar om spelaren lever,
		 * isåfall ändras den grafiska representationen, tar bort 
		 * möjligheterna att gå till höger och vänster samt sätter 
		 * ett fall-intervall till fall-metoden.
		 * 
		 * @return void
		 */
		public function die():void {
			if (_alive) {
				_alive = false;
				super.skin.gotoAndStop(4);
				removeRightMovement = true;
				removeLeftMovement = true;
				_fallingInterval = setInterval(fall,10);
			}
		}
		
		//-----------------------------------------------------------
		// Private methods
		//-----------------------------------------------------------
		
		/**
		 * Positionering av spelarens x- och y-värden.
		 * 
		 * @return void
		 */
		private function initPlace():void {
			this.y = 0;
			this.x = Session.application.size.x * 0.4;
		}
		
		/**
		 * Kontrollerar aktiva kontroller. Om ingen kontroll är aktiv
		 * ska spelaren stå stilla, annars anropas andra metoder
		 * beroende på knapp.
		 * 
		 * @return void
		 */
		private function checkControls():void {
			if (this.controls != null) {
				if (!Input.keyboard.anyPressed()) {
					standStill();
				} else {
					if (Input.keyboard.pressed(controls.PLAYER_LEFT)) moveLeft();
					if (Input.keyboard.pressed(controls.PLAYER_RIGHT)) moveRight();
					//if (Input.keyboard.justPressed(controls.PLAYER_UP)) jumpStatus(); // Kommentera bort vid användning av arkadmaskin
					if (Input.keyboard.justPressed(this.controls.PLAYER_BUTTON_1)) jumpStatus();  // Använd vid användning av arkadmaskin
				}
			}
		}
		
		/**
		 * Den grafiska animationen ändras till spring-animationen.
		 * _Running sätts till sant.
		 * 
		 * @return void
		 */
		private function run():void {
			super.skin.gotoAndStop(2);
			_running = true;
		}
		
		/**
		 * Förflyttar spelaren till vänster.
		 * 
		 * @return void
		 */
		private function moveLeft():void {
			super.skin.scaleX = -1;
			if (!removeLeftMovement) {
				this.x -= super.speed + bonusSpeed;
				if (!_jumping) run();
			}
		}
		
		/**
		 * Förflyttar spelaren till höger.
		 * 
		 * @return void
		 */
		private function moveRight():void {
			super.skin.scaleX = 1;
			if (!removeRightMovement) {
				this.x += super.speed + bonusSpeed;
				if (!_jumping) run();
			}
		}
		
		/**
		 * Kontrollerar spelarens position i spelet.
		 * 
		 * @return void
		 */
		private function checkPosition():void {
			if (this.y >= Session.application.size.y * 0.745) _onGround = true; // @TODO: Hårdkodat
			if (this.x > (Session.application.size.x - (this.width * 0.5))) removeRightMovement = true;
		}
		
		/**
		 * Uppdaterar spelarens position, om spelaren står på marken
		 * eller på en box sätts korrekta värde.
		 * 
		 * @return void
		 */
		private function updatePosition():void {
			if (_onGround) {
				this.y = Session.application.size.y * 0.745	// @TODO: Hårdkodat
					if (super.skin.currentFrame == 3) {
						if (!_running) standStill();
					}
			}
			if (onBox) {
				this.y = boxY;
				if (super.skin.currentFrame == 3) {
					if (!_running) standStill();
				}
			}
		}
		
		/**
		 * Kontrollerar om spelaren får hoppa, om så är fallet sätts
		 * korrekta värden.
		 * 
		 * @return void
		 */
		private function jumpStatus():void {
			if (!_jumping && (_onGround || onBox)) {
				_vel = -10;
				_jumping = true;
				_running = false;
				_onGround = false;
				onBox = false;
			}
		}
		
		/**
		 * Spelarens hopp-metod.
		 * 
		 * @return void
		 */
		private function jump():void {
			if (_onGround || onBox) {
				_jumping = false;
			}
			else {
				if (_jumping) super.skin.gotoAndStop(3);
				this.y += _vel;
				_vel += GRAV;
			}
		}
		
		/**
		 * Spelarens fall-metod.
		 * 
		 * @return void
		 */
		private function fall():void {
			super.skin.y += _vel;
		}
	}
}