import '../enums/Player.dart';

class TeamSetup {
  static int team1 = 0;
  static int team2 = 0;

  static void teamPointsChanged(int val, Player player) {
    if (player == Player.PLAYER1) {
      team1 += val;
    } else {
      team2 += val;
    }
  }
}
