import 'package:get/get.dart';

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
  final String description;
  final int basePrice;
  final int cookieSecond;

  final RxInt owned = RxInt(0);

  CookieItem({
    required this.uniqueName,
    required this.name,
    required this.description,
    required this.basePrice,
    required this.cookieSecond,
  });
}

class CookieGrandma extends CookieItem {
  CookieGrandma()
      : super(
          uniqueName: 'grandma',
          name: 'Grandma',
          description: 'A nice grandma to bake more cookies.',
          basePrice: 100,
          cookieSecond: 1,
        );
}

class CookieFarm extends CookieItem {
  CookieFarm()
      : super(
          uniqueName: 'farm',
          name: 'Farm',
          description: 'Grows cookie plants from cookie seeds.',
          basePrice: 1100,
          cookieSecond: 8,
        );
}

class CookieMine extends CookieItem {
  CookieMine()
      : super(
          uniqueName: 'mine',
          name: 'Mine',
          description: 'Mines out cookie dough and chocolate chips.',
          basePrice: 12000,
          cookieSecond: 47,
        );
}

class CookieFactory extends CookieItem {
  CookieFactory()
      : super(
          uniqueName: 'factory',
          name: 'Factory',
          description: 'Produces large quantities of cookies.',
          basePrice: 130000,
          cookieSecond: 260,
        );
}

class CookieBank extends CookieItem {
  CookieBank()
      : super(
          uniqueName: 'bank',
          name: 'Bank',
          description: 'Generates cookies from interest.',
          basePrice: 1400000,
          cookieSecond: 1400,
        );
}

class CookieTemple extends CookieItem {
  CookieTemple()
      : super(
          uniqueName: 'temple',
          name: 'Temple',
          description: 'Full of precious, ancient chocolate.',
          basePrice: 20000000,
          cookieSecond: 7800,
        );
}

class CookieWizardTower extends CookieItem {
  CookieWizardTower()
      : super(
          uniqueName: 'wizard-tower',
          name: 'Wizard Tower',
          description: 'Summons cookies with magic spells.',
          basePrice: 330000000,
          cookieSecond: 44000,
        );
}

class CookieShipment extends CookieItem {
  CookieShipment()
      : super(
          uniqueName: 'shipment',
          name: 'Shipment',
          description: 'Brings in fresh cookies from the cookie planet.',
          basePrice: 5100000000,
          cookieSecond: 260000,
        );
}

class CookieAlchemyLab extends CookieItem {
  CookieAlchemyLab()
      : super(
          uniqueName: 'alchemy-lab',
          name: 'Alchemy Lab',
          description: 'Turns gold into cookies!',
          basePrice: 75000000000,
          cookieSecond: 1600000,
        );
}

class CookiePortal extends CookieItem {
  CookiePortal()
      : super(
          uniqueName: 'portal',
          name: 'Portal',
          description: 'Opens a door to the cookieverse.',
          basePrice: 1000000000000,
          cookieSecond: 10000000,
        );
}

class CookieTimeMachine extends CookieItem {
  CookieTimeMachine()
      : super(
          uniqueName: 'time-machine',
          name: 'Time Machine',
          description:
              'Brings cookies from the past, before they were even eaten.',
          basePrice: 14000000000000,
          cookieSecond: 65000000,
        );
}

class CookieAntimatterCondenser extends CookieItem {
  CookieAntimatterCondenser()
      : super(
          uniqueName: 'antimatter-condenser',
          name: 'Antimatter Condenser',
          description: 'Condenses the antimatter in the universe into cookies.',
          basePrice: 170000000000000,
          cookieSecond: 430000000,
        );
}

class CookiePrism extends CookieItem {
  CookiePrism()
      : super(
          uniqueName: 'prism',
          name: 'Prism',
          description: 'Converts light itself into cookies.',
          basePrice: 2100000000000000,
          cookieSecond: 2900000000,
        );
}

class CookieChancemaker extends CookieItem {
  CookieChancemaker()
      : super(
          uniqueName: 'chancemaker',
          name: 'Chancemaker',
          description: 'Generates cookies out of thin air through sheer luck.',
          basePrice: 26000000000000000,
          cookieSecond: 21000000000,
        );
}

class CookieFractalEngine extends CookieItem {
  CookieFractalEngine()
      : super(
          uniqueName: 'fractal-engine',
          name: 'Fractal Engine',
          description: 'Harnesses the power of the Cookieverse itself.',
          basePrice: 310000000000000000,
          cookieSecond: 150000000000,
        );
}
