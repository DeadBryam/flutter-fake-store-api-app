class ParseUtil {
  static Iterable<T> parseList<T>({
    required dynamic list,
    T Function(Map<String, dynamic> json)? fromJson,
  }) {
    if (list is List) {
      if (fromJson == null) return list.cast<T>();
      return list.cast<Map<String, dynamic>>().map(fromJson);
    }

    return [];
  }

  static T? parse<T>({
    required dynamic json,
    T Function(Map<String, dynamic> json)? fromJson,
  }) {
    if (fromJson == null) return json as T?;
    if (json is Map<String, dynamic>) return fromJson(json);
    return null;
  }
}
