class AuthService {
  // This is a mock service. In a real app, you would make HTTP requests
  // to your Rust Actix backend here.

  static Future<void> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Simulate a successful login
    if (email == 'user@example.com' && password == 'password123') {
      print('Login successful for $email');
      // Here you would typically store tokens, user data, etc.
    } else {
      throw Exception('Invalid email or password');
    }
  }

  static Future<void> register(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Simulate a successful registration
    if (password.length >= 6) {
      print('Registration successful for $email');
      // Here you would typically send data to your backend API
    } else {
      throw Exception('Password must be at least 6 characters');
    }
  }
}