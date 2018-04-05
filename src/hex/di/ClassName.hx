package hex.di;

abstract ClassName(String) from String to String {
  @:from static function ofClassRef<T>(c:ClassRef<T>):ClassName
    return Type.getClassName(c);
}