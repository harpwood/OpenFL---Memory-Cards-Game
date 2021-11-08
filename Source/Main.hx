package;


import haxe.Timer;
import openfl.events.KeyboardEvent;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.text.TextField;
import openfl.events.Event;
import openfl.events.MouseEvent;
import objects.Card;
import openfl.display.Sprite;

class Main extends Sprite
{
	private static inline final TOTAL_CARDS:Int = 24;
	private static inline final NUMBER_OF_CARDS:Int = 24;
	private static inline final CARDS_PER_ROW:Int = 8;

	var cards:Array<Int>;
	var flippedCards:Array<Card>;
	var canFlip:Bool = true;
	var pairsFound:Int = 0;
	var statusText:TextField;
	var timers:Array<Timer>;

	public function new()
	{
		super();
		init();
		//addEventListener(Event.ADDED_TO_STAGE, onStage);
	}
	function onStage(e:Event) {
		removeEventListener(Event.ADDED_TO_STAGE, onStage);

		init();
	}

	function init() {
		cards = new Array();

		// populating deck
		for (i in 0...TOTAL_CARDS){
			cards.push(Math.floor((i) / 2) + 1);
		}

		trace("Deck of cards: " + cards);

		//shuffling deck
		var i = TOTAL_CARDS;
		var swap:Int, tmp:Int;
		while (i-- > 0){
			swap = Math.floor(Math.random() * i);
			tmp = cards[i];
			cards[i] = cards[swap];
			cards[swap] = tmp;
		}
		trace("Deck of cards shuffled: " + cards);

		// card placing loop
		for (i in 0...NUMBER_OF_CARDS){
			var card:Card = new Card(cards[i]);
			addChild(card);
			var hm:Float = (stage.stageWidth - card.width * CARDS_PER_ROW - 10 * (CARDS_PER_ROW - 1)) / 2;
			var vm:Float = (stage.stageHeight - card.height * (NUMBER_OF_CARDS / CARDS_PER_ROW) - 10 * (NUMBER_OF_CARDS / CARDS_PER_ROW)) / 2;
			card.x = hm + (card.width + 10) * (i % CARDS_PER_ROW);
			card.y = vm + (card.height + 10) * (Math.floor(i / CARDS_PER_ROW));

			card.buttonMode = true;
			trace(card.name);

			card.addEventListener(MouseEvent.CLICK, onClick);
		}

		var textFormat:TextFormat = new TextFormat("Times New Roman", 32, 0xFFFFFF, true, false, false, null, null, TextFormatAlign.CENTER);
		
		statusText = new TextField();
		statusText.defaultTextFormat = textFormat;
		statusText.x = 0; //stage.stageWidth * .5;
		statusText.y = stage.stageHeight - 64;
		statusText.width = stage.stageWidth;
		statusText.text = "Press [R] to restart!";
		

		this.addEventListener(KeyboardEvent.KEY_DOWN, onRestart);
	
		
		addChild(statusText);
		flippedCards = new Array();

		canFlip = true;

		timers = new Array();

	}

	function onRestart(e:KeyboardEvent) {
		var key:Int = e.keyCode;
		
		if (key == 82){
			
			if (timers.length > 0) {
				for (i in 0...timers.length){
					timers[i].stop();
				}
			}
			statusText.text = "Restarting...";
			haxe.Timer.delay(function(){
				
				for(i in 0...numChildren) {
					var child = getChildAt(0);

					child.removeEventListener(MouseEvent.CLICK, onClick);
				
					removeChild(child);

					child = null;
					removeEventListener(KeyboardEvent.KEY_DOWN, onRestart);
					
				}
			
				init();

			}, 250);
		}
	}

	function onClick(e:MouseEvent) {
		var card:Card = e.target;

		
		if (canFlip && !card.isFlipped && flippedCards.indexOf(card) == -1) {
			flippedCards.push(card);
			card.flip();
			card.buttonMode = false;

			trace("You picked the " + card.name + " card (id: " + card.index + ")");
			statusText.text = "You picked the " + card.name + " card (id: " + card.index + ")";
			if(flippedCards.length > 1) {
				canFlip = false;
				if(flippedCards[0].index == flippedCards[1].index){
					trace("Cards match!!!");
					if (statusText.text != "Restarting...") statusText.text = "Cards match!!!";
					flippedCards[0].removeEventListener(MouseEvent.CLICK, onClick);	
					flippedCards[1].removeEventListener(MouseEvent.CLICK, onClick);

					canFlip = true;
					
					flippedCards = new Array();

					pairsFound++;
					if (pairsFound == TOTAL_CARDS / 2) {
						var timer = Timer.delay(function(){
							trace ("You Won!");
						statusText.text = "You Won! Press [R] to restart!";
						
						}, 1000);
						timers.push(timer);
					}
				}
				else {
					var timer = Timer.delay(function() {
						trace("Not a match...");
						if (statusText.text != "Restarting...") statusText.text = "Not a match...";
						flippedCards[0].flipBack();
						flippedCards[1].flipBack();
						flippedCards[0].buttonMode = true;
						flippedCards[1].buttonMode = true;
						canFlip = true;

						flippedCards = new Array();
					}, 1000);
					timers.push(timer);
				}
			}
		}

		
	}

	
}

// card size 96x160