class Machine {
  double _coffeeBeans = 0;
  double _milk = 0;
  double _water = 0;
  double _cash = 0;

  double get coffeeBeans => _coffeeBeans;
  double get milk => _milk;
  double get water => _water;
  double get cash => _cash;

  set coffeeBeans(double value) => _coffeeBeans = value;
  set milk(double value) => _milk = value;
  set water(double value) => _water = value;
  set cash(double value) => _cash = value;

  bool isAvailable() {
    return _coffeeBeans >= 50 && _water >= 100 && _cash >= 100 && _milk >= 20;
  }

  void _subtractResources() {
    if (isAvailable()) {
      _coffeeBeans -= 50;
      _water -= 100;
      _cash -= 100;
      _milk -= 20;
    }
  }

  bool makingCoffee() {
    if (isAvailable()) {
      _subtractResources();
      return true;
    }
    return false;
  }

  void resetResources() {
    _coffeeBeans = 0;
    _milk = 0;
    _water = 0;
    _cash = 0;
  }
}