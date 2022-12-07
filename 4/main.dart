import 'dart:io';

Set<int> range(int from, int to) => List<int>.generate(to - from + 1, (i) => i + from).toSet();

void main() {
  var data = [];
  
  List<String> lines = new File("input.txt").readAsLinesSync();
  for (var line in lines) {
    var ranges = line.split(',');
    var num1 = ranges[0].split('-');
    var num2 = ranges[1].split('-');
    var temp = [];

    temp.add(range(int.parse(num1[0]), int.parse(num1[1])));
    temp.add(range(int.parse(num2[0]), int.parse(num2[1])));

    data.add(temp);
  }

  //task 1
  int total = 0;
  for (var sample in data) {
    var res1 = sample[0].containsAll(sample[1]);
    var res2 = sample[1].containsAll(sample[0]);

    if (res1 || res2) total += 1;
  }

  print("TASK 1: $total");

  //task 2
  total = 0;
  for (var sample in data) {
    var res1 = sample[0].intersection(sample[1]).isNotEmpty;
    var res2 = sample[1].intersection(sample[0]).isNotEmpty;

    if (res1 || res2) total += 1;
  }

  print("TASK 2: $total");
}