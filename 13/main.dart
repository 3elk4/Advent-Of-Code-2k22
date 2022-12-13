import 'dart:io';
import 'dart:convert';
import 'dart:math';

int compare(dynamic first, dynamic second){
    if(first is int && second is int){
        return first - second;
    }
    else if(first is List && second is List){
        int l = min(first.length, second.length);
        for (int i = 0; i < l; ++i){
            var result = compare(first[i], second[i]);
            if (result != 0) return result;
        }
        return first.length - second.length;
    }
    else if(first is int){
        return compare([first], second);
    } 
    else if(second is int) {
        return compare(first, [second]);
    }
    else throw ("Input is not list or int");
}

void main() {
  var lineSplitter = RegExp("\\r?\\n");
  var pairSplitter = RegExp("\\n\\n");
  
  //part1
  List<String> pairs = new File("input.txt").readAsStringSync().split(pairSplitter);
  int total = 0;
  var packets = [];

  for (int i = 0; i < pairs.length; ++i){
    var lines = pairs[i].split(lineSplitter);
    var first = json.decode(lines[0]);
    var second = json.decode(lines[1]);
    
    if(compare(first, second) < 0) total += i + 1;
    packets.add(first); packets.add(second);
  }

  print(total);

  //part 2
  final div1 = [[2]];
  final div2 = [[6]];
  packets.add(div1); packets.add(div2);
  
  packets.sort(compare);
  print((packets.indexOf(div1) + 1) * (packets.indexOf(div2) + 1));
}
