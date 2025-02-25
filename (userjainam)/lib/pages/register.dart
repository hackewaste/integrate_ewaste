import 'package:ewaste/services/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  String _role = "User"; // Default role
  bool _isLoading = false; // Add this at the top of the State

void _register() async {
  if (_isLoading) return; // Prevents duplicate clicks
  setState(() {
    _isLoading = true; // Disable button
  });

  try {
    String email = _emailController.text.trim();
    String password = _pwController.text.trim();

    // Call the sign-up function
    await _auth.signUpWithEmailPassword(email, password, _role);

    // Notify user of success
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Registered as $_role!")),
    );

    // Navigate to login page
    Navigator.pop(context);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Registration Failed: ${e.toString()}")),
    );
  } finally {
    setState(() {
      _isLoading = false; // Re-enable button
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Create an Account",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Join us in recycling waste responsibly!",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 30),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Enter your email (with domain)",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _pwController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Enter your password",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _role = "User";
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: _role == "User" ? Colors.blue : Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Sign up as User",
                      style: TextStyle(
                        color: _role == "User" ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _role = "Volunteer";
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color:
                          _role == "Volunteer" ? Colors.blue : Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Sign up as Volunteer",
                      style: TextStyle(
                        color:
                            _role == "Volunteer" ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
  onPressed: _isLoading ? null : _register, // Disable during loading
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
  ),
  child: _isLoading
      ? CircularProgressIndicator(color: Colors.white)
      : Text("Sign Up", style: TextStyle(fontSize: 16)),
),
          ],
        ),
      ),
    );
  }
}
