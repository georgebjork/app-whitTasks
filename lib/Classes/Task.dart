class Task{

  String task = "";
  String date = "";
  String details = "Details will be added soon";
  bool isDone = false;

  Task(String t, String d) {
    task = t;
    date = d;
  }
  
  set setTask(String t){
    task = t;
  }

  String getTask() {
    return task;
  }

  String getDate(){
    return date;
  }

  String getDetails(){
    return details;
  }

  bool getState(){
    return isDone;
  }

  bool isToday(){
    if(date == "Today")
      return true;
    
    return false; 
  }

  void changeState(){
    isDone = !isDone;
  }

  
}

