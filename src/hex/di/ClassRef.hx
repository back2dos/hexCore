package hex.di;

abstract ClassRef<T>(Class<T>) from Class<T> to Class<T> {
  public function getName():ClassName
    return this;
}