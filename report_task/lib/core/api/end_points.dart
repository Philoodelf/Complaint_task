class EndPoints {
  static String baseUrl = "https://clericalapi.garassolutions.com";
  static String postComplaint="/api/complaint/AddAndUpdatecomplaint";
  static String categoryComplaint="/api/complaint/GetAllCatagorycomplaint";
}

class ApiKeys{
  static String status = "status";
  static String message = "message";
  static String errorMessage = "errorMessage";
  static String description = "description";

  // Complaint Submission Keys
  static String file = "file"; // For file uploads
  static String subject = "subject";
  static String category = "category";
  static String actionType = "action_type"; // Represents "keep" or "add" selection

  // Contact Information
  static String name = "name";
  static String email = "email";
  static String phone = "phone";

  // Other
  static String send = "send"; // Button action
  static String date= "date";
}

