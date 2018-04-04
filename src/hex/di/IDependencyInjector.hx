package hex.di;

import hex.di.provider.IDependencyProvider;

/**
 * @author Francis Bourre
 */
interface IDependencyInjector extends IBasicInjector
{
    function injectInto<T>( target : T ) : Void;

    function destroyInstance<T>( instance : T ) : Void;
}