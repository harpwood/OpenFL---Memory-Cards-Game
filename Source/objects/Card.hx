package objects;

import motion.Actuate;
import openfl.display.Sprite;
import openfl.display.Tile;
import openfl.display.Tilemap;
import openfl.Lib;


class Card extends Sprite
{
    public var isFlipped(default, null):Bool = false;
    public var index(default, null):Int;

    var deck:Deck;
    var tilemap:Tilemap;
    var front:Tile;
    var back:Tile;
    var isFlipping:Bool = false;
    var tweenTime:Float = .12;
   
    public function new(index:Int) {
        super();
        this.index = index;
        deck = Deck.instance;
        tilemap = new Tilemap(96, 160, deck);
        addChild(tilemap);

        back = Deck.getCard(0);
        front = Deck.getCard(index);
        
        tilemap.addTile(back);
        tilemap.addTile(front);
        
        
        front.visible = false;
        back.visible = true;

       name = getCardName(index);

    }

    public function flip() {
      
        if(!isFlipping){
            front.visible = false;
            back.visible = true;
            isFlipping = true;

            var w:Float = 96/2;
            Actuate.tween(this, tweenTime, {scaleX: 0});
            Actuate.tween(this, tweenTime, {x: this.x + w}).onComplete(flip2);
        }
    }

    public function flip2() {
        front.visible = true;
        back.visible = false;
        isFlipped = true;
        isFlipping = false;
        var w:Float = 96/2;
        Actuate.tween(this, tweenTime, {scaleX: 1});
        Actuate.tween(this, tweenTime, {x: this.x - w});
    }
    public function flipBack() {
      
        if(!isFlipping){
            front.visible = true;
            back.visible = false;
            isFlipping = true;
            var w:Float = 96/2;
            Actuate.tween(this, tweenTime, {scaleX: 0});
            Actuate.tween(this, tweenTime, {x: this.x + w}).onComplete(flipBack2);
        }
    }

    public function flipBack2() {
        front.visible = false;
        back.visible = true;
        isFlipped = false;
        isFlipping = false;
        var w:Float = 96/2;
        Actuate.tween(this, tweenTime, {scaleX: 1});
        Actuate.tween(this, tweenTime, {x: this.x - w});
    }

    function getCardName(index:Int):String {
		
		var name:String;
		switch (index)
        {
            default: name = "back";
            case 1: name = "red";
            case 2: name = "blue";
            case 3: name = "yellow";
            case 4: name = "purple";
            case 5: name = "orange";
            case 6: name = "green";
            case 7: name = "brown";
            case 8: name = "pink";
            case 9: name = "teal";
            case 10: name = "white";
            case 11: name = "gray";
            case 12: name = "black";
        }

		return name;
	}


}