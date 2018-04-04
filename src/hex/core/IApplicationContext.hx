package hex.core;

import hex.di.IDependencyInjector;
import hex.domain.Domain;
import hex.event.MessageType;
import hex.module.IContextModule;

/**
 * @author Francis Bourre
 */
interface IApplicationContext extends IContextModule
{
	function getName() : String;
	
	function getDomain() : Domain;
	
	function getInjector() : IDependencyInjector;
}