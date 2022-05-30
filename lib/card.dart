class Card {
  final String name;
  final List<String> disallowed;

  Card(this.name, this.disallowed);
}

final List<Card> cards =
    _cards.map((e) => Card(e['name'], e['disallowed'])).toList(growable: false);

final List<Map<String, dynamic>> _cards = [
  {
    "name": "Software",
    "disallowed": [
      "Computer",
      "Application",
      "Coding",
      "Programming",
      "Android"
    ]
  },
  {
    "name": "Encryption",
    "disallowed": ["RSA", "Password", "Key", "SSA", "Decryption"]
  },
  {
    "name": "Foreign Key",
    "disallowed": ["Relationship", "Table", "Tuple", "Field", "Primary"]
  },
  {
    "name": "Round Robin",
    "disallowed": ["OS", "Priority", "Queue", "Scheduling", "Job"]
  },
  {
    "name": "Stack",
    "disallowed": ["Pop", "Push", "Queue", "LIFO", "FIFO"]
  },
  {
    "name": "Quicksort",
    "disallowed": [
      "Sort",
      "Divide and Conquer",
      "Merge Sort",
      "Pivot",
      "Median"
    ]
  },
];
