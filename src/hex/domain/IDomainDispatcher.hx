package hex.domain;

import hex.domain.Domain;
import hex.event.IDispatcher;
import hex.event.MessageType;

/**
 * @author Francis Bourre
 */
interface IDomainDispatcher<ListenerType:{}> 
{
	
	function setDispatcherClass( ?dispatcherClass : Class<IDispatcher<ListenerType>> ) : Void;

    function getDefaultDispatcher() : IDispatcher<ListenerType>;

    function getDefaultDomain() : Domain;

    function setDefaultDomain( domain : Domain = null ) : Void;

    function clear() : Void;

    function isRegistered( listener : ListenerType, messageType : MessageType, domain : Domain ) : Bool;

    function hasChannelDispatcher( ?domain : Domain ) : Bool;

    function getDomainDispatcher( ?domain : Domain ) : IDispatcher<ListenerType>;

    function releaseDomainDispatcher( domain : Domain ) : Bool;

    function addListener( listener : ListenerType, ?domain : Domain ) : Bool;

    function removeListener( listener : ListenerType, ?domain : Domain ) : Bool;

    function addHandler( messageType : MessageType, scope : Dynamic, callback : haxe.Constraints.Function, domain : Domain ) : Bool;

    function removeHandler( messageType : MessageType, scope : Dynamic, callback : haxe.Constraints.Function, domain : Domain ) : Bool;

    function dispatch( messageType : MessageType, ?domain : Domain, ?data : Array<Dynamic> ) : Void;

    function removeAllListeners() : Void;
	
}