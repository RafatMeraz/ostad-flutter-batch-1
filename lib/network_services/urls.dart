class Urls {
  static String baseUrl = 'https://task.teamrabbil.com/api/v1';
  static String newTask = '$baseUrl/listTaskByStatus/New';

  static String changeStatus(String taskId, String status) =>
      '$baseUrl/updateTaskStatus/$taskId/$status';
}
