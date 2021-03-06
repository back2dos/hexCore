package hex.domain;

/**
 * ...
 * @author Francis Bourre
 */
class CoreDomainSuite
{
    @Suite( "Domain" )
    public var list : Array<Class<Dynamic>> = 
	[ 
		DefaultDomainTest, 
		DomainTest, 
		NoDomainTest, 
		TopLevelDomainTest 
	];
}