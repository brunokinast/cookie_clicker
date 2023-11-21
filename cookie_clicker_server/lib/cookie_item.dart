List<CookieItem> get allItems => [
      CookieGrandma(),
    ];

abstract class CookieItem {
  final String name;
  final String description;
  final String uniqueName;
  final int basePrice;
  final int cookieSecond;

  int owned = 0;

  CookieItem({
    required this.name,
    required this.description,
    required this.uniqueName,
    required this.basePrice,
    required this.cookieSecond,
  });
}

class CookieGrandma extends CookieItem {
  CookieGrandma()
      : super(
          name: 'Grandma',
          description: 'A nice grandma to bake more cookies.',
          uniqueName: 'grandma',
          basePrice: 10,
          cookieSecond: 1,
        );
}
