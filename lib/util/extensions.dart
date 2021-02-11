extension NullCheck<K, V> on Map<K, V> {
  bool putIfNotNull(K key, V value) {
    if (value == null) {
      return false;
    }
    putIfAbsent(key, () => value);
    return true;
  }
}