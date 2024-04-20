// regex.dart

class Regex {
  static final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static final passwordRegExp = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$');
  static final mobileRegExp = RegExp(r'^[0-9]{10}$'); // Regex for a 10-digit number
}
