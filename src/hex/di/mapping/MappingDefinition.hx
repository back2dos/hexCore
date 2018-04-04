package hex.di.mapping;

/**
 * @author Francis Bourre
 */
@:structInit class MappingDefinition
{
			
	public var fromType 				: ClassName;
	@:optional public var withName 	: MappingName;
	
	@:optional public var toClass 		: Class<Dynamic>;
	@:optional public var toValue 		: Any;
	
	@:optional public var asSingleton 	: Bool;
	@:optional public var injectInto 	: Bool;

	public inline function id():String
		return (fromType|withName);

}