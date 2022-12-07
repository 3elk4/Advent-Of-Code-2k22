import 'dart:async';
import 'dart:io';
import 'dart:convert';

class GameInput {
  String opponent_choice = '';
  String my_choice = '';
  
  GameInput(List<String> game_input) { 
    this.opponent_choice = game_input[0];
    this.my_choice = game_input[1];
  } 
}

void main() {
  var points = <String, int> { "A": 1, "B": 2, "C": 3, "X": 1, "Y": 2, "Z": 3, "lost": 0, "draw": 3, "won": 6 };

  List<GameInput> game_inputs = <GameInput>[];
  int total_score = 0;

  // get inputs
  List<String> lines = new File("input.txt").readAsLinesSync();
  for (var line in lines) {
    var game_input = line.split(" ");
    game_inputs.add(new GameInput(game_input));
  }

  //analyze - first part
  for (var game in game_inputs) {
    total_score += points[game.my_choice] as int;
    if (points[game.opponent_choice] == points[game.my_choice]) {
      total_score += points["draw"] as int;
    }
    else if (game.opponent_choice == "A") {
      if (game.my_choice == "Y") {
        total_score += points["won"] as int;
      }
    }
    else if (game.opponent_choice == "B") {
      if (game.my_choice == "Z") {
        total_score += points["won"] as int;
      }
    }
    else if (game.opponent_choice == "C") {
      if (game.my_choice == "X") {
        total_score += points["won"] as int;
      }
    }
  }

  print("Total points: $total_score");

  //analyze - second part
  total_score = 0;
  for (var game in game_inputs) {
    if (game.my_choice == "X") { // need to lose
      if (game.opponent_choice == 'A') { // rock -> me- scissors
        total_score += points["Z"] as int;
      }
      else if (game.opponent_choice == 'B'){ // paper -> me- rock
        total_score += points["X"] as int;
      }
      else if (game.opponent_choice == 'C'){ // scissors -> me-paper
        total_score += points["Y"] as int;
      }
    }
    else if(game.my_choice == "Y") { //need to draw
      total_score += points["draw"] as int;
      total_score += points[game.opponent_choice] as int;
    }
    else if(game.my_choice == "Z") { //need to win
      total_score += points["won"] as int;
      if (game.opponent_choice == 'A') { // rock -> me paper
        total_score += points["Y"] as int;
      }
      else if (game.opponent_choice == 'B'){ // paper -> me scissors
        total_score += points["Z"] as int;
      }
      else if (game.opponent_choice == 'C'){ // scissors -> me rock
        total_score += points["X"] as int;
      }
    }
  }

  print("Total points: $total_score");
}