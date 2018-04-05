package hex.di;

abstract MappingName(String) from String {
  @:to inline function toString()
    return if (this == null) '' else this;

  @:op(a | b) static function makeId(typeId:ClassName, name:MappingName) {
    return (typeId:String) + '|' + (name:String);
  }
}