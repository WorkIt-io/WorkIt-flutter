

class LoginPageHelper
{
  static String? validateEmail(String? input)
  {
    if (input == null || input.trim().isEmpty || !input.contains('@'))
    {
      return 'Please enter a valid email address';
    }
    
    return null;
  }

  static String? validatePassword(String? input)
  {
    if (input == null || input.trim().length < 6)
    {
      return 'Password must be at least 6 characters long';
    }

    return null;
  }
}