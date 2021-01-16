class Team{
  int team_id;
  String team_name;
  String team_lead;

  Team(
      {this.team_id,this.team_name,this.team_lead});

  factory Team.fromJson(Map<String, dynamic> json) {
    return new Team(
      team_id: json['team_id'],
      team_name: json['team_name'],
      team_lead: json['team_lead'],
    );
  }
}