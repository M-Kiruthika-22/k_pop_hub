class AuthService {
  Future<bool> login(String email, String password) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    return email == 'test@example.com' && password == 'password';
  }

  void logout() {
    // Handle logout logic (e.g., clear session)
  }
}
