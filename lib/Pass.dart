import 'package:flutter/material.dart';

class Pass extends StatefulWidget {
  const Pass({super.key});

  @override
  State<Pass> createState() => _PassState();
}

class _PassState extends State<Pass> {
  final TextEditingController _controller = TextEditingController();

  double strength = 0.0;
  String strengthLabel = "Enter password";
  Color strengthColor = Colors.grey;
  bool isObscure = true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void checkPassword(String password) {
    double score = 0;

    if (password.length >= 8) score += 0.2;
    if (password.length >= 12) score += 0.1;
    if (RegExp(r'[A-Z]').hasMatch(password)) score += 0.2;
    if (RegExp(r'[a-z]').hasMatch(password)) score += 0.1;
    if (RegExp(r'[0-9]').hasMatch(password)) score += 0.2;
    if (RegExp(r'[!@#\$&*~]').hasMatch(password)) score += 0.2;

    if (score < 0.4) {
      strengthLabel = "Weak";
      strengthColor = Colors.redAccent;
    } else if (score < 0.7) {
      strengthLabel = "Moderate";
      strengthColor = Colors.orangeAccent;
    } else {
      strengthLabel = "Strong";
      strengthColor = Colors.greenAccent;
    }

    setState(() {
      strength = score.clamp(0.0, 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double barWidth = MediaQuery.of(context).size.width - 40;

    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              Icons.lock_outline,
              color: Colors.white,
              size: 22,
            ),
            SizedBox(width: 8),
            Text(
              "PassFortress",
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Create a Secure Password",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 24),

            TextField(
              controller: _controller,
              obscureText: isObscure,
              onChanged: checkPassword,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                suffixIcon: IconButton(
                  icon: Icon(
                    isObscure ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: strengthColor,
                    width: 2,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 35),

            // Strength Bar
            Stack(
              children: [
                Container(
                  height: 12,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade800,
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  height: 12,
                  width: barWidth * strength,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [
                        Colors.redAccent,
                        Colors.orangeAccent,
                        Colors.greenAccent,
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            Center(
              child: Text(
                "Strength: $strengthLabel",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: strengthColor,
                ),
              ),
            ),

            const SizedBox(height: 30),





            const Text(
              "Password Guidelines",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 10),
            const Text("• Minimum 8 characters", style: TextStyle(color: Colors.grey)),
            const Text("• Prefer 12+ characters", style: TextStyle(color: Colors.grey)),
            const Text("• Uppercase & lowercase letters", style: TextStyle(color: Colors.grey)),
            const Text("• At least one number", style: TextStyle(color: Colors.grey)),
            const Text("• At least one special character (!@#\$&*)",
                style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
