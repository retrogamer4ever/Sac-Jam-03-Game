package
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxParticle;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxU;

	public class PlayState extends FlxState
	{
		[Embed(source="../data/pokeball.png")] public var rawPokeball:Class;
		[Embed(source="../data/bulba.png")]    public var rawBulba:Class;
		[Embed(source="../data/grass.png")]    public var rawGrass:Class;
		[Embed(source="../data/picka.png")]    public var rawPicka:Class;
		
		[Embed(source="../data/pokemonBackground.mp3")]  public var rawMusic:Class;
		
		public var scoreText:FlxText;
		
		
		public var pokeballs:Array;
		public var pickas:Array;
		
		public var pokeballsParticlesGroup:FlxGroup;
		public var pickasGroup:FlxGroup;
		
		
		public var bulba:FlxSprite;
		public var grass:FlxSprite;
		
		public var timer:Timer;
		
		public var emitter:FlxEmitter;
		
		public var scoreCounter:int = 0; 
		
		public var pokeballParticlesArr:Array;
		
		public function PlayState()
		{
		
		}
		
		public function onSpawn( event:TimerEvent ):void
		{
			var pickachu:FlxSprite = new FlxSprite( 700, Math.random() * 200, rawPicka );
			add( pickachu );
			
			pickasGroup.add( pickachu );
			
			pickas.push ( pickachu );
		}
		
		override public function create():void
		{
			pokeballParticlesArr = new Array();
			
			pokeballsParticlesGroup = new FlxGroup();
			pickasGroup = new FlxGroup();
			
			timer = new Timer( 1000 );
			timer.addEventListener(TimerEvent.TIMER, onSpawn );
			timer.start();
			
			
			FlxG.playMusic( rawMusic );
			
			pokeballs = new Array();
			pickas    = new Array();
			
			
			grass = new FlxSprite( 0, 0, rawGrass );
			add( grass );
			
			bulba = new FlxSprite( 300, 300, rawBulba );
			
			bulba.maxVelocity.x = 200;
			bulba.maxVelocity.y = 200;
			
			add( bulba );
			
			scoreText = new FlxText( 50, 50, 200, "Score 0" );	
			scoreText.size = 30;
			add( scoreText );
		}
		
		override public function update():void
		{
			super.update();
			
			updatePokeballs();
			
			updatePlayer();
			
			updatePickas();
			
			
			/*
			for( var i:int = 0; i < pokeballParticlesArr.length; i++ )
			{	
				if( FlxG.collide( pokeballsParticlesGroup, bulba  ) )
				{	
					pokeballParticlesArr[i].kill();
					
					scoreCounter++;
					
					scoreText.text = "Score: " + scoreCounter.toString();
				}
			}
			
			*/
		}
		
		public function updatePokeballs():void
		{
			for( var i:int = 0; i < pokeballs.length; i++ )
			{	
				if( pokeballs[i].facing == FlxObject.RIGHT )
				{
					pokeballs[i].acceleration.x += pokeballs[i].maxVelocity.x;
				}
				else if(pokeballs[i].facing == FlxObject.LEFT )
				{
					pokeballs[i].acceleration.x -= pokeballs[i].maxVelocity.x;
				}
				else if( pokeballs[i].facing == FlxObject.UP )
				{
					pokeballs[i].velocity.y -=  bulba.maxVelocity.y;
				}
				else if( pokeballs[i].facing == FlxObject.DOWN )
				{
					pokeballs[i].velocity.y += 30;
				}
			}
		}
		
		public function updatePickas():void
		{
			for( var i:int = 0; i < pickas.length; i++ )
			{	
				pickas[i].acceleration.x -= 5;
				
				if( FlxG.collide( pickasGroup, pickas[i]  ) )
				{
					var pEmitter:FlxEmitter = new FlxEmitter( 0, 0, 30 );
					pEmitter.at( pickas[i] );
					
					add( pEmitter );
					
					for ( var ii:int = 0; ii < 30; ii++ )
					{
						var particle:FlxParticle = new FlxParticle();
						particle.loadGraphic( rawPokeball );
						particle.visible = false;
				
						pokeballsParticlesGroup.add( particle );
						
						pEmitter.add( particle );
						
						pokeballParticlesArr.push( particle );
						pokeballsParticlesGroup.add( particle );
					}
					
					pEmitter.start();
					
					pickas[i].kill();
					
					scoreCounter++;
					
					scoreText.text = "Score: " + scoreCounter.toString();
				}
			}
		}
		
		public function updatePlayer():void
		{	
			bulba.acceleration.x = 0;
			bulba.acceleration.y = 0;
			
			if( FlxG.keys.RIGHT )
			{
				bulba.facing = FlxObject.RIGHT;
				bulba.acceleration.x += bulba.maxVelocity.x;
			}
			else if( FlxG.keys.LEFT )
			{
				bulba.facing = FlxObject.RIGHT;
				bulba.acceleration.x -= bulba.maxVelocity.x;
			}
			else if( FlxG.keys.UP )
			{
				bulba.facing = FlxObject.RIGHT;
				bulba.velocity.y -=  bulba.maxVelocity.y;
			}
			else if( FlxG.keys.DOWN )
			{
				bulba.facing = FlxObject.RIGHT;
				bulba.velocity.y += 30;
			}
			
			if( FlxG.keys.SPACE )
			{
				createPokeball( bulba.facing );
			}
			
		}
		
		
		public function createPokeball( direction:uint):void
		{
			var pokeball:FlxSprite = new FlxSprite( bulba.x, bulba.y, rawPokeball );
			pokeball.facing = direction;
			
			pickasGroup.add( pokeball );
			
			add( pokeball );
			
			pokeballs.push( pokeball );
			
		}
		
	}
}