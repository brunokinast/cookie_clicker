import 'dart:async';

List<CookieItem> get allItems => [
      CookieGrandma(),
    ];

abstract class CookieItem {
  final String name;
  final String description;
  final String uniqueName;
  final int basePrice;
  final StreamController<int> ownedController;

  Stream<int> get owned => ownedController.stream;

  CookieItem({
    required this.name,
    required this.description,
    required this.uniqueName,
    required this.basePrice,
  }) : ownedController = StreamController.broadcast();
}

class CookieGrandma extends CookieItem {
  CookieGrandma()
      : super(
          name: 'Grandma',
          description: 'A nice grandma to bake more cookies.',
          uniqueName: 'grandma',
          basePrice: 10,
        );
}
