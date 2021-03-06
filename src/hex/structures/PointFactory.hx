package hex.structures;

import hex.error.PrivateConstructorException;

/**
 * ...
 * @author Francis Bourre
 */
class PointFactory
{
	/** @private */
	function new() 
	{
		throw new PrivateConstructorException();
	}
	
	inline static public function build( x : Int = 0, y : Int = 0 ) : Point
	{
		return new Point( x, y );
	}
}