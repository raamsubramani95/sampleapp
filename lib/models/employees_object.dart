class Employees{
  int id;
  String name;
  String age;
  String teamlead;
  String team;
  String city;

  Employees(
      {this.id,this.name,this.age,this.teamlead,this.team,this.city});

  factory Employees.fromJson(Map<String, dynamic> json) {
    return new Employees(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      teamlead: json['teamlead'],
      team: json['team'],
      city: json['city'],
    );
  }
}