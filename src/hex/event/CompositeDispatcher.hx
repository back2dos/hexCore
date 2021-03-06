package hex.event;

import hex.error.UnsupportedOperationException;

/**
 * ...
 * @author Francis Bourre
 */
class CompositeDispatcher
{
	var _dispatchers 		: Array<DispatcherDef>;
	var _isSealed 			: Bool;
	var _cachedMethodCalls 	: Array<Void->Void>;
	
	public function new() 
	{
		this._isSealed 				= false;
		this._cachedMethodCalls 	= [];
		this._dispatchers 			= [];
	}
	
	public function dispatch( messageType : MessageType, ?data : Array<Dynamic> ) : Void 
	{
		this._seal( true );
		
		for ( dispatcher in this._dispatchers )
		{
			dispatcher.dispatch( messageType, data );
		}
		
		this._seal( false );
	}
	
	/*public function addHandler( messageType : MessageType, callback : Dynamic ) : Bool
	{
		if ( !this._isSealed )
		{
			var b : Bool = false;
			for ( dispatcher in this._dispatchers )
			{
				b = dispatcher.addHandler( messageType, callback ) || b;
			}

			return b;
		}
		else
		{
			this._cachedMethodCalls.push( this.addHandler.bind( messageType, callback ) );
			return false;
		}
	}
	
	/*public function removeHandler( messageType : MessageType, callback : Dynamic ) : Bool
	{
		if ( !this._isSealed )
		{
			var b : Bool = false;
			for ( dispatcher in this._dispatchers )
			{
				b = dispatcher.removeHandler( messageType, callback ) || b;
			}
			
			return b;
		}
		else
		{
			this._cachedMethodCalls.push( this.removeHandler.bind( messageType, callback ) );
			return false;
		}
	}*/
	
	public function addListener( listener : {} ) : Bool 
	{
		throw ( new UnsupportedOperationException( "'addListener' is not supported" ) );
	}
	
	public function removeListener( listener : {} ) : Bool 
	{
		throw ( new UnsupportedOperationException( "'removeListener' is not supported" ) );
	}
	
	public function removeAllListeners() : Void 
	{
		if ( !this._isSealed )
		{
			for ( dispatcher in this._dispatchers )
			{
				dispatcher.removeAllListeners();
			}
		}
		else
		{
			this._cachedMethodCalls.push( this.removeAllListeners.bind() );
		}
	}
	
	public function isEmpty() : Bool 
	{
		for ( dispatcher in this._dispatchers )
		{
			if ( !dispatcher.isEmpty() )
			{
				return false;
			}
		}
		return true;
	}
	
	public function isRegistered( listener : {}, ?messageType : MessageType ) : Bool 
	{
		throw ( new UnsupportedOperationException( "'isRegistered' is not supported" ) );
	}
	
	public function hasHandler( messageType : MessageType, ?scope : Dynamic ) : Bool
	{
		var b : Bool = false;
		for ( dispatcher in this._dispatchers )
		{
			b = dispatcher.hasHandler( messageType, scope ) || b;
		}
		return b;
	}
	
	public function add( dispatcher : DispatcherDef ) : Bool
	{
		if ( !this._isSealed )
		{
			if ( this._dispatchers.indexOf( dispatcher ) == -1 )
			{
				this._dispatchers.push( dispatcher );
				return true;
			}
			else
			{
				return false;
			}
		}
		else
		{
			this._cachedMethodCalls.push( this.add.bind( dispatcher ) );
			return false;
		}
	}
	
	public function remove( dispatcher : DispatcherDef ) : Bool
	{
		if ( !this._isSealed )
		{
			var index : Int = this._dispatchers.indexOf( dispatcher );
			if ( index != -1 )
			{
				this._dispatchers.splice( index, 1 );
				return true;
			}
			else
			{
				return false;
			}
		}
		else
		{
			this._cachedMethodCalls.push( this.remove.bind( dispatcher ) );
			return false;
		}
	}
	
	function _seal( isSealed : Bool ) : Void
	{
		if ( isSealed != this._isSealed )
		{
			this._isSealed = isSealed;
			if ( !this._isSealed && this._cachedMethodCalls.length > 0 )
			{
				for ( cachedMethodCall in this._cachedMethodCalls )
				{
					cachedMethodCall();
				}
				
				this._cachedMethodCalls = [];
			}
		}
	}
}