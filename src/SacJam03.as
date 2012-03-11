package
{
	import flash.display.Sprite;
	
	import org.flixel.FlxGame;
	import org.flixel.FlxG;
	
	
	[SWF(width="600", height="600", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]
	
	public class SacJam03 extends FlxGame
	{
		public function SacJam03()
		{
			super( 600, 600, PlayState );
		}
	}
}