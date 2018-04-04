package hex.domain;

import hex.core.HashCodeFactory;
import hex.error.IllegalStateException;
import hex.module.IContextModule;

/**
 * ...
 * @author Francis Bourre
 */
@:final 
class DomainExpert
{
	var _registeredDomains 	: Map<UInt, Domain>;
	var _subscribedModules 	: Map<IContextModule, Domain>;
	var _removedModules 	: Map<String, Bool>;
	
	static var _Instance 	= new DomainExpert();
	static var _DomainIndex : UInt = 0;
	
	static public function getInstance() : DomainExpert
	{
		return DomainExpert._Instance;
	}
	
	function new() 
	{
		this._registeredDomains = new Map();
		this._subscribedModules = new Map();
		this._removedModules 	= new Map();
	}
	
	public function getDomainFor( module : IContextModule ) : Domain
	{
		if ( !this._subscribedModules.exists( module ) )
		{
			if ( this._registeredDomains.exists( DomainExpert._DomainIndex ) )
			{
				var moduleDomain : Domain = this._registeredDomains.get( DomainExpert._DomainIndex );
				this._registeredDomains.remove( DomainExpert._DomainIndex );
				DomainExpert._DomainIndex++;
				this._removedModules.set( moduleDomain.getName(), false );
				this._subscribedModules.set( module, moduleDomain );
				return moduleDomain;
			}
			else
			{
				var key : String = getKey(module);
				if ( this._removedModules.exists( key ) && this._removedModules.get( key ) )
				{
					return null;
				}
				else
				{
					var domain = Domain.getDomain( key );
					this._removedModules.set( key, false );
					this._subscribedModules.set( module, domain );
					return domain;
				}
			}
		}
		else
		{
			return this._subscribedModules.get( module );
		}
	}
	
	public function registerDomain( domain : Domain ) : Void
	{
		this._registeredDomains.set( DomainExpert._DomainIndex, domain );
	}

	function getKey(module:IContextModule)
		return HashCodeFactory.getKey( Type.getClass( module ) ) +':'+ HashCodeFactory.getKey( module );
	
	public function releaseDomain( module : IContextModule ) : Void
	{
		if ( module.isReleased )
		{
			var key : String = getKey(module);
			
			if ( this._removedModules.exists( key ) )
			{
				this._removedModules.set( key, true );
			}
			else
			{
				this._removedModules.set( module.getDomain().getName(), true );
			}
			
			this._subscribedModules.remove( module );
		}
		else
		{
			throw new IllegalStateException( "Illegal call, '" + module + "' is not released." );
		}
	}
}