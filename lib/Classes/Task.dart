class Task{

  String task = "";
  String details = "Details will be added soon";
  bool isDone = false;

  Task(String t) {
    task = t;
  }
  
  set setTask(String t){
    task = t;
  }

  String getTask() {
    return task;
  }

  String getDetails(){
    return details;
  }

  bool getState(){
    return isDone;
  }

  
}

