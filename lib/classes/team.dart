enum Team { TEAM1, TEAM2 }

extension TeamExtension on Team {
  String get name {
    switch (this) {
      case Team.TEAM1:
        return "TEAM-1";
      case Team.TEAM2:
        return "TEAM-2";
    }
  }
}
