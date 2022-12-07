import 'dart:io';

class Stack<E> {
  final _list = <E>[];

  void push(E value) => _list.add(value);

  E? pop() => (isEmpty) ? null : _list.removeLast();

  E? get peek => (isEmpty) ? null : _list.last;

  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => _list.isNotEmpty;

  @override
  String toString() => _list.toString();
}


void main() {
  var stack1 = Stack<String>();
  stack1.push("G"); stack1.push("D"); stack1.push("V"); stack1.push("Z"); stack1.push("J"); stack1.push("S"); stack1.push("B");
  
  var stack2 = Stack<String>();
  stack2.push("Z"); stack2.push("S"); stack2.push("M"); stack2.push("G"); stack2.push("V"); stack2.push("P");
  
  var stack3 = Stack<String>();
  stack3.push("C"); stack3.push("L"); stack3.push("B"); stack3.push("S"); stack3.push("W"); stack3.push("T"); stack3.push("Q"); stack3.push("F");

  var stack4 = Stack<String>();
  stack4.push("H"); stack4.push("J"); stack4.push("G"); stack4.push("W"); stack4.push("M"); stack4.push("R"); stack4.push("V"); stack4.push("Q");
  
  var stack5 = Stack<String>();
  stack5.push("C"); stack5.push("L"); stack5.push("S"); stack5.push("N"); stack5.push("F"); stack5.push("M"); stack5.push("D");

  var stack6 = Stack<String>();
  stack6.push("R"); stack6.push("G"); stack6.push("C"); stack6.push("D");

  var stack7 = Stack<String>();
  stack7.push("H"); stack7.push("G"); stack7.push("T"); stack7.push("R"); stack7.push("J"); stack7.push("D"); stack7.push("S"); stack7.push("Q");
  
  var stack8 = Stack<String>();
  stack8.push("P"); stack8.push("F"); stack8.push("V");

  var stack9 = Stack<String>();
  stack9.push("D"); stack9.push("R"); stack9.push("S"); stack9.push("T"); stack9.push("J");

  List<Stack<String>> stacks = [stack1, stack2, stack3, stack4, stack5, stack6, stack7, stack8, stack9];

//         [F] [Q]         [Q]        
// [B]     [Q] [V] [D]     [S]        
// [S] [P] [T] [R] [M]     [D]        
// [J] [V] [W] [M] [F]     [J]     [J]
// [Z] [G] [S] [W] [N] [D] [R]     [T]
// [V] [M] [B] [G] [S] [C] [T] [V] [S]
// [D] [S] [L] [J] [L] [G] [G] [F] [R]
// [G] [Z] [C] [H] [C] [R] [H] [P] [D]
//  1   2   3   4   5   6   7   8   9 
  
	List<String> lines = new File("input.txt").readAsLinesSync();

  //part1
  // for (var line in lines) {
  //   var details = line.split(" ");
  //   var how_many = int.parse(details[1]);
  //   var from = int.parse(details[3]);
  //   var to = int.parse(details[5]);

  //   for(int i = 0; i < how_many; ++i){
  //     var str = stacks[from-1].pop() as String;
  //     stacks[to-1].push(str);
  //   }
  // }

  //part2
    for (var line in lines) {
    var details = line.split(" ");
    var how_many = int.parse(details[1]);
    var from = int.parse(details[3]);
    var to = int.parse(details[5]);

    var strs = <String>[];
    for(int i = 0; i < how_many; ++i){
      strs.add(stacks[from-1].pop() as String);
    }

    for (int i = how_many-1; i >=0; --i) {
      stacks[to-1].push(strs[i]);
    }
  }

  for (var stack in stacks) {
    print(stack.peek);
  }
}