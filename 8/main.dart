import 'dart:io';
import 'dart:math';

void main() {
    List<String> lines = new File("input.txt").readAsLinesSync();
    var input = [];

    for (var line in lines){
        input.add(line.split('').map((x) => int.parse(x)).toList());
    }

    // part 1
    int total = 0;
    int rows = input.length;
    int cols = input[0].length;

    for (int i = 0; i < rows; ++i){
        for(int j = 0 ; j < cols; ++j) {
        int currentTree = input[i][j];

        bool right = [for (int idx = j+1; idx < cols; ++idx) input[i][idx]].every((v) => v < currentTree);
        bool left = [for (int idx = 0; idx < j; ++idx) input[i][idx]].every((v) => v < currentTree);
        bool up = [for (int idx = 0; idx < i; ++idx) input[idx][j]].every((v) => v < currentTree);
        bool down = [for (int idx = i+1; idx < rows; ++idx) input[idx][j]].every((v) => v < currentTree);
        
        if (up || down || left || right) total += 1; 
        }
    }

    print(total);

    //part 2
    total = 0;

    for (int i = 0; i < rows; ++i){
        for(int j = 0 ; j < cols; ++j) {
        int currentTree = input[i][j];
        var right = 0;
        var left = 0;
        var up = 0;
        var down = 0;

        for (int idx = j-1; idx >=0; --idx){
            left++;
            if(input[i][idx] >= currentTree) break;
        }

        for(int idx = j+1; idx < cols; ++idx) {
            right++;
            if(input[i][idx] >= currentTree) break;
        }

        for(int idx = i-1; idx >= 0; --idx) {
            up++;
            if(input[idx][j] >= currentTree) break;
        }

        for(int idx = i+1; idx < rows; ++idx) {
            down++;
            if(input[idx][j] >= currentTree) break;
        }

        total = max(total, up * down * left * right);
        }
    }

    print(total);
}