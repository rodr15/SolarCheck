/// A fully generic synchronizer that uses a mandatory master template (JSON)
/// as the absolute source of truth. Any changes in the master template
/// (adding/removing sections or items) are automatically reflected without code changes.
class GenericStructureSynchronizer {
  /// Synchronizes an [inspectionCatalog] structure against a [catalog].
  ///
  /// It traverses the template recursively, preserving user inputs when keys match,
  /// injecting missing keys, and initializing default values.
  static Map<String, dynamic> synchronize({
    required Map<String, dynamic> catalog,
    required Map<String, dynamic> inspectionCatalog,
  }) {
    return _synchronizeMap(catalog, inspectionCatalog);
  }

  /// Recursively synchronizes two maps based on the template's structure.
  static Map<String, dynamic> _synchronizeMap(
    Map<String, dynamic> templateNode,
    Map<String, dynamic>? dataNode,
  ) {
    final Map<String, dynamic> synchronizedMap = {};

    templateNode.forEach((key, templateValue) {
      final dynamic userValue = dataNode?[key];

      if (templateValue is Map<String, dynamic>) {
        // Case A: The value is a nested Map/Object
        synchronizedMap[key] = _synchronizeMap(
          templateValue,
          userValue is Map<String, dynamic> ? userValue : null,
        );
      } else if (templateValue is List) {
        // Case B: The value is a List (Sections or Items lists)
        synchronizedMap[key] = _synchronizeList(templateValue, userValue);
      } else {
        // Case C: Primitive values (strings, numbers, booleans)
        // Prefer user's value if it exists, otherwise fall back to template default
        synchronizedMap[key] = userValue ?? templateValue;
      }
    });

    return synchronizedMap;
  }

  /// Synchronizes lists dynamically, handling both lists of items and lists of sections.
  static List<dynamic> _synchronizeList(
      List<dynamic> templateList, dynamic userListDynamic) {
    if (templateList.isEmpty) return [];

    // Determine the primary identifier key based on the first element of the template list.
    // e.g., 'item' for items, 'seccion' for sections, or fallback to index/equality.
    final String? identifierKey = _detectIdentifierKey(templateList.first);

    // If template items are not maps (e.g., list of strings), just return user list or template fallback
    if (identifierKey == null) {
      return userListDynamic is List
          ? List.from(userListDynamic)
          : List.from(templateList);
    }

    // Index user items for O(1) lookup using the detected identifier key
    final Map<String, dynamic> userMapIndex = {};
    if (userListDynamic is List) {
      for (final element in userListDynamic) {
        if (element is Map) {
          final String keyValue = element[identifierKey]?.toString() ?? '';
          userMapIndex[keyValue] = element;
        }
      }
    }

    final List<dynamic> synchronizedList = [];

    // Iterate through the template list to maintain the exact order defined in the master JSON
    for (final templateItem in templateList) {
      if (templateItem is Map) {
        final String keyValue = templateItem[identifierKey]?.toString() ?? '';
        final dynamic existingUserItem = userMapIndex[keyValue];

        if (existingUserItem is Map<String, dynamic>) {
          // The item exists: recursively synchronize its internal properties/lists
          final Map<String, dynamic> mergedItem = _synchronizeMap(
            Map<String, dynamic>.from(templateItem),
            existingUserItem,
          );

          // Ensure new parameters/defaults from template are initialized via putIfAbsent
          _injectDefaultParameters(mergedItem);

          synchronizedList.add(mergedItem);
        } else {
          // The item is completely missing: clone template item and initialize defaults
          final Map<String, dynamic> newItem =
              Map<String, dynamic>.from(templateItem);
          _injectDefaultParameters(newItem);

          synchronizedList.add(newItem);
        }
      } else {
        // Fallback for non-map items in lists
        synchronizedList.add(templateItem);
      }
    }

    return synchronizedList;
  }

  /// Detects the unique key used to identify items/sections in the list (e.g., 'item', 'seccion', 'id', 'name').
  static String? _detectIdentifierKey(dynamic sampleItem) {
    if (sampleItem is Map) {
      if (sampleItem.containsKey('item')) return 'item';
      if (sampleItem.containsKey('seccion')) return 'seccion';
      if (sampleItem.containsKey('id')) return 'id';
      if (sampleItem.containsKey('name')) return 'name';
    }
    return null;
  }

  /// Automatically injects default extra parameters into leaf nodes if they don't exist.
  static void _injectDefaultParameters(Map<String, dynamic> itemMap) {
    // Here is where the extra parameters are added by feafult
    if (itemMap.containsKey('item')) {
      itemMap.putIfAbsent('comments', () => '');
      itemMap.putIfAbsent('status', () => 'pending');
      // itemMap.putIfAbsent('photos', () => []);
    }
  }
}
