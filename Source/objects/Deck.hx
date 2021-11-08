package objects;


//import openfl.Lib;
//import openfl.display.Tilemap;
import openfl.display.Tile;
import openfl.geom.Rectangle;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.display.Tileset;

class Deck extends Tileset {

    public static var BACK:Int;
	public static var RED:Int;
	public static var BLUE:Int;
	public static var YELLOW:Int;
	public static var PURPLE:Int;
	public static var ORANGE:Int;
	public static var GREEN:Int;
	public static var BROWN:Int;
	public static var PINK:Int;
	public static var TEAL:Int;
	public static var WHITE:Int;
	public static var GRAY:Int;
	public static var BLACK:Int;

   // public static var tileMap:Tilemap;
    
    
    public static var instance(get, null):Deck;

    private static function get_instance():Deck {
        if(instance == null) {
            instance = new Deck(Assets.getBitmapData("assets/cards.png"));
        }
        return instance;
    }

    public function new(bitmapData:BitmapData){
        super(bitmapData);

        BACK = addRect(new Rectangle(0, 0, 96, 160));
		RED = addRect(new Rectangle(96, 0, 96, 160));
		BLUE = addRect(new Rectangle(192, 0, 96, 160));
		YELLOW = addRect(new Rectangle(288, 0, 96, 160));
		PURPLE = addRect(new Rectangle(384, 0, 96, 160));
		ORANGE = addRect(new Rectangle(480, 0, 96, 160));
		GREEN = addRect(new Rectangle(576, 0, 96, 160));
		BROWN = addRect(new Rectangle(672, 0, 96, 160));
		PINK = addRect(new Rectangle(768, 0, 96, 160));
		TEAL = addRect(new Rectangle(864, 0, 96, 160));
		WHITE = addRect(new Rectangle(960, 0, 96, 160));
		GRAY = addRect(new Rectangle(1056, 0, 96, 160));
		BLACK = addRect(new Rectangle(1152, 0, 96, 160));

       // tileMap = new Tilemap(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight, this);
        
    }

    //public function tilemap():Tilemap {
    //    return tileMap;
    //}

    public static function getCard(index:Int):Tile {

        var card:Int;// = BACK;
        
        switch (index)
        {
            case 0: card = BACK;
            case 1: card = RED;
            case 2: card = BLUE;
            case 3: card = YELLOW;
            case 4: card = PURPLE;
            case 5: card = ORANGE;
            case 6: card = GREEN;
            case 7: card = BROWN;
            case 8: card = PINK;
            case 9: card = TEAL;
            case 10: card = WHITE;
            case 11: card = GRAY;
            case 12: card = BLACK;
            default: card = BACK;
            
            
        }
        
        return new Tile(card, 0, 0);
        
    }
}