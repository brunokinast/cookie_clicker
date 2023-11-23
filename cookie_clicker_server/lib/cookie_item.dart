List<CookieItem> get allItems => [
      CookieGrandma(),
      CookieFarm(),
      CookieMine(),
      CookieFactory(),
      CookieBank(),
      CookieTemple(),
      CookieWizardTower(),
      CookieShipment(),
      CookieAlchemyLab(),
      CookiePortal(),
      CookieTimeMachine(),
      CookieAntimatterCondenser(),
      CookiePrism(),
      CookieChancemaker(),
      CookieFractalEngine(),
    ];

abstract class CookieItem {
  final String uniqueName;
  final String name;
  final int basePrice;
  final int cookieSecond;

  int owned = 0;

  CookieItem({
    required this.uniqueName,
    required this.name,
    required this.basePrice,
    required this.cookieSecond,
  });
}

class CookieGrandma extends CookieItem {
  CookieGrandma()
      : super(
          uniqueName: 'grandma',
          name: 'Grandma',
          basePrice: 100,
          cookieSecond: 1,
        );
}

class CookieFarm extends CookieItem {
  CookieFarm()
      : super(
          uniqueName: 'farm',
          name: 'Farm',
          basePrice: 1100,
          cookieSecond: 8,
        );
}

class CookieMine extends CookieItem {
  CookieMine()
      : super(
          uniqueName: 'mine',
          name: 'Mine',
          basePrice: 12000,
          cookieSecond: 47,
        );
}

class CookieFactory extends CookieItem {
  CookieFactory()
      : super(
          uniqueName: 'factory',
          name: 'Factory',
          basePrice: 130000,
          cookieSecond: 260,
        );
}

class CookieBank extends CookieItem {
  CookieBank()
      : super(
          uniqueName: 'bank',
          name: 'Bank',
          basePrice: 1400000,
          cookieSecond: 1400,
        );
}

class CookieTemple extends CookieItem {
  CookieTemple()
      : super(
          uniqueName: 'temple',
          name: 'Temple',
          basePrice: 20000000,
          cookieSecond: 7800,
        );
}

class CookieWizardTower extends CookieItem {
  CookieWizardTower()
      : super(
          uniqueName: 'wizard-tower',
          name: 'Wizard Tower',
          basePrice: 330000000,
          cookieSecond: 44000,
        );
}

class CookieShipment extends CookieItem {
  CookieShipment()
      : super(
          uniqueName: 'shipment',
          name: 'Shipment',
          basePrice: 5100000000,
          cookieSecond: 260000,
        );
}

class CookieAlchemyLab extends CookieItem {
  CookieAlchemyLab()
      : super(
          uniqueName: 'alchemy-lab',
          name: 'Alchemy Lab',
          basePrice: 75000000000,
          cookieSecond: 1600000,
        );
}

class CookiePortal extends CookieItem {
  CookiePortal()
      : super(
          uniqueName: 'portal',
          name: 'Portal',
          basePrice: 1000000000000,
          cookieSecond: 10000000,
        );
}

class CookieTimeMachine extends CookieItem {
  CookieTimeMachine()
      : super(
          uniqueName: 'time-machine',
          name: 'Time Machine',
          basePrice: 14000000000000,
          cookieSecond: 65000000,
        );
}

class CookieAntimatterCondenser extends CookieItem {
  CookieAntimatterCondenser()
      : super(
          uniqueName: 'antimatter-condenser',
          name: 'Antimatter Condenser',
          basePrice: 170000000000000,
          cookieSecond: 430000000,
        );
}

class CookiePrism extends CookieItem {
  CookiePrism()
      : super(
          uniqueName: 'prism',
          name: 'Prism',
          basePrice: 2100000000000000,
          cookieSecond: 2900000000,
        );
}

class CookieChancemaker extends CookieItem {
  CookieChancemaker()
      : super(
          uniqueName: 'chancemaker',
          name: 'Chancemaker',
          basePrice: 26000000000000000,
          cookieSecond: 21000000000,
        );
}

class CookieFractalEngine extends CookieItem {
  CookieFractalEngine()
      : super(
          uniqueName: 'fractal-engine',
          name: 'Fractal Engine',
          basePrice: 310000000000000000,
          cookieSecond: 150000000000,
        );
}
