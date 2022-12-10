import java.io.File
import kotlin.math.abs

fun checkAndAdd(stopCycles : List<Int>, cycleCounter : Int, total : Int, X : Int) : Int  {
  var t = total;
  if(cycleCounter in stopCycles) {
    var result = X * cycleCounter;
    t += result;
    println("Cycle Counter: ${cycleCounter}, result: ${result}");
  }
  return t;
}

fun checkAndPrint(message : String, cycleCounter : Int,  X : Int ) : String {
  var message = message;
  message += if (abs(X - ((cycleCounter-1) % 40)) <= 1) "##" else "..";
  
  if(cycleCounter % 40 == 0){
    println(message);
    message = "";
  }
  
  return message;
}

fun main(args: Array<String>) {
  // val lines : List<String> = File("input.txt").useLines { it.toList() }

  // val stopCycles = listOf<Int>(20, 60, 100, 140, 180, 220);
  // var cycleCounter = 0;
  // var X = 1;
  // var total = 0;
  
  // for(line in lines) {
  //   var params = line.split(' ');
  //   if (params[0] == "noop") {
  //     cycleCounter++;
  //     total = checkAndAdd(stopCycles, cycleCounter, total, X);
  //   }
  //   else if (params[0] == "addx") {
  //     // first circle
  //     cycleCounter++;
  //     total = checkAndAdd(stopCycles, cycleCounter, total, X);

  //     //second circle
  //     cycleCounter++;
  //     total = checkAndAdd(stopCycles, cycleCounter, total, X);
      
  //     X += params[1].toInt();
  //   }
  //   else {
  //     throw UnsupportedOperationException();
  //   }
  // }

  // println(total);

  // part 2

  val lines : List<String> = File("input.txt").useLines { it.toList() }

  var cycleCounter = 0;
  var message = "";
  var X = 1;
  
  for(line in lines) {
    var params = line.split(' ');
    if (params[0] == "noop") {
      cycleCounter++;
      message = checkAndPrint(message, cycleCounter, X);
    }
    else if (params[0] == "addx") {
      cycleCounter++;
      message = checkAndPrint(message, cycleCounter, X);
     
      cycleCounter++;
      message = checkAndPrint(message, cycleCounter, X);
      
      X += params[1].toInt();
    }
    else {
      throw UnsupportedOperationException();
    }
  }
}