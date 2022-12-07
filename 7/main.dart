import 'dart:io';

enum TreeNodeType {
  none,
  file,
  dir
}

class TreeNode {
  TreeNode? parent = null;
  List<TreeNode> children = <TreeNode>[];
  String name = '';
  int size = 0;
  TreeNodeType type = TreeNodeType.none;
  
  TreeNode(){}

  TreeNode.forDir(TreeNode? parent, String name){
    this.parent = parent;
    this.name = name;
    this.type = TreeNodeType.dir;
  }

  TreeNode.forFile(TreeNode? parent, String name, int size){
    this.parent = parent;
    this.name = name;
    this.size = size;
    this.type = TreeNodeType.file;
  }

  int sumSize(){
    if (children.isEmpty) return size; // probably file
    
    for (var child in this.children){
      this.size += child.sumSize();
    }

    return size;
  }

  @override
  String toString() {
    return "Name: " + this.name + ", Size: " + this.size.toString();
  }
}

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
  TreeNode? currentTreeNode = null;
  List<String> lines = new File("input.txt").readAsLinesSync();

  //make tree
  for (var line in lines) {
    var params = line.split(' ');
    if(params[1] == 'cd'){
      if(params[2] == '..'){
        currentTreeNode = currentTreeNode?.parent;
      }
      else{
        if (currentTreeNode == null){
          currentTreeNode = TreeNode.forDir(currentTreeNode, params[2]);
        }
        else {
          currentTreeNode = currentTreeNode.children.firstWhere((ch)=>ch.name==params[2]);
        }
      }
    }
    else if(params[1] == 'ls') continue;
    else{
      if(params[0] == 'dir'){
        currentTreeNode?.children.add(TreeNode.forDir(currentTreeNode, params[1]));
      }
      else{
        currentTreeNode?.children.add(TreeNode.forFile(currentTreeNode, params[1], int.parse(params[0])));
      }
    }
  }

  //do glownego rodzica
  while (currentTreeNode?.parent != null){
    currentTreeNode = currentTreeNode?.parent;
  }

  //podliczenie size - rekurencyjnie
  currentTreeNode?.sumSize();
  
  //task 1

  int total = 0;

  var stack = new Stack();
  stack.push(currentTreeNode);

  while (stack.isNotEmpty) {
      TreeNode obj = stack.pop();
  
      if (obj.size <= 100000) total += obj.size;
    
      for(var child in obj.children) {
        if(child.type == TreeNodeType.dir) stack.push(child);
      }
  }

  print(total);

  // task 2

  int freeSpace = 70000000 - currentTreeNode!.size;
  int spaceNeeded = 30000000 - freeSpace;
  var lst = [];

  var stack2 = new Stack();
  stack2.push(currentTreeNode);

  while (stack2.isNotEmpty) {
      TreeNode obj = stack2.pop();
  
      for(var child in obj.children) {
        if(child.type == TreeNodeType.dir && child.size >= spaceNeeded) {
          lst.add(child);
          stack2.push(child);
        }
      }
  }

  lst.sort((a, b) => a.size.compareTo(b.size));
  print(lst.first);
}
