import 'dart:math';

import '../card.dart';

class CardElementConfig {
  static Card? _currentCard;

  static Card? getRandomCard() {
    var rand = Random();
    Card temp = cards[rand.nextInt(cards.length)];
    if (_currentCard != null) {
      while (temp.name == _currentCard?.name) {
        temp = cards[rand.nextInt(4)];
      }
    }
    _currentCard = temp;
    return _currentCard;
  }
}
