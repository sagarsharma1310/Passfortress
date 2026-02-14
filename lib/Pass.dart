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

  void checkPassword(String password) {
    double score = 0;

    if (password.length >= 8) score += 0.2;
    if (password.length >= 12) score += 0.1;
    if (RegExp(r'[A-Z]').hasMatch(password)) score += 0.2;
    if (RegExp(r'[a-z]').hasMatch(password)) score += 0.1;
    if (RegExp(r'[0-9]').hasMatch(password)) score += 0.2;
    if (RegExp(r'[!@#\$&*~]').hasMatch(password)) score += 0.2;

    if (score < 0.4) {
      strengthLabel = "Easy";
      strengthColor = Colors.red;
    } else if (score < 0.7) {
      strengthLabel = "Moderate";
      strengthColor = Colors.orange;
    } else {
      strengthLabel = "Strong";
      strengthColor = Colors.green;
    }

    setState(() {
      strength = score.clamp(0.0, 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Team Rapids PassFortress",style: TextStyle(color: Colors.white,fontSize: 23,fontWeight: FontWeight.w800),),
        centerTitle: true,
        backgroundColor: Colors.black.withOpacity(0.7),

      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Create a Secure Password",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _controller,
              obscureText: isObscure,
              onChanged: checkPassword,
              decoration: InputDecoration(
                labelText: "Enter Password",
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    isObscure ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(
                    color: Colors.deepOrange,
                    width: 2,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 35),


            Stack(
              children: [
                Container(
                  height: 14,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [Colors.red, Colors.orange, Colors.green],
                    ),
                  ),
                ),

                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  left: (screenWidth - 40) * strength,
                  top: -18,
                  child: Column(
                    children: [
                      Icon(
                        Icons.arrow_drop_down,
                        size: 40,
                        color: strengthColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Easy", style: TextStyle(color: Colors.red)),
                Text("Moderate", style: TextStyle(color: Colors.orange)),
                Text("Strong", style: TextStyle(color: Colors.green)),
              ],
            ),

            const SizedBox(height: 20),

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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text("• Minimum 8 characters"),
            const Text("• Prefer 12+ characters"),
            const Text("• Uppercase & lowercase letters"),
            const Text("• At least one number"),
            const Text("• At least one special character (!@#\$&*)"),
          ],
        ),
      ),
    );
  }
}
