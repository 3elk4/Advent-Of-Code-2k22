import 'dart:io';

List<List<String>> splitStringByLength(String str, int length) =>
    [str.substring(0, length).split(''), str.substring(length).split('')];

List<List<String>> getListOfChunks(List<String> l, int chunkSize) {
  var chunks = [];
  for (var i = 0; i < l.length; i += chunkSize) {
    var end = (i+chunkSize<l.length)?i+chunkSize:l.length;
    chunks.add(l.sublist(i,end));
  }
  return List<List<String>>.from(chunks);
}

int task1(List<String> backpacks, String letters){
  int total = 0; 
  for(String backpack in backpacks) {
    var parts = splitStringByLength(backpack, (backpack.length / 2).toInt());
    var common = parts[0].toSet().intersection(parts[1].toSet()).first;
    total += letters.indexOf(common) + 1;
  }

  return total;
}

int task2(List<String> backpacks, String letters) {
  int total = 0; 
  var groupBackpacks = getListOfChunks(backpacks, 3);

  for (var groupBackpack in groupBackpacks) {
    var firstSet = groupBackpack[0].split('').toSet();
    var secondSet = groupBackpack[1].split('').toSet();
    var thirdSet = groupBackpack[2].split('').toSet();
    
    var common = (firstSet.intersection(secondSet)).intersection(thirdSet).first;
    total += letters.indexOf(common) + 1;
  }
  
  return total;
}

void main() {
  var letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
  var backpacks = <String>[];
  
  List<String> lines = new File("input.txt").readAsLinesSync();
  for (var line in lines) {
    backpacks.add(line);
  }
  
  int total1 = task1(backpacks, letters);
  print("TOTAL: $total1");

  int total2 = task2(backpacks, letters);
  print("TOTAL: $total2");
}