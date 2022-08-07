class GameSettings {
  static const niveis = [6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 28, 30];

  static const cardOpcoes = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19
  ];

  static gameBoardAxisCount(int nivel) {
    if (nivel < 10) {
      return 2;
    } else if (nivel == 10 ||
        nivel == 12 ||
        nivel == 14 ||
        nivel == 16 ||
        nivel == 18) {
      return 3;
    } else if (nivel == 20 || nivel == 22 || nivel == 24) {
      return 4;
    } else {
      return 5;
    }
  }
}
