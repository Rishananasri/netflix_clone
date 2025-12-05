import 'package:flutter/material.dart';
import 'package:netflix_api/controller/login_provider.dart';
import 'package:netflix_api/widgets/bottomnavbar.dart';
import 'package:netflix_api/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

  final namecontroller = TextEditingController();
    final passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leadingWidth: 120,
        leading: SizedBox(
          width: 120,
          child: Image.asset("assets/images/poster/fulllogo.png"),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 210),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomTextField(
              controller: namecontroller,
              hint: "Name",
              id: "Name",
            ),
          ),

          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.all(10),
            child: CustomTextField(
              controller: passwordcontroller,
              hint: "Password",
              id: "password",
            ),
          ),

          const SizedBox(height: 5),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Consumer<AuthProvider>(
              builder: (context, auth, child) => GestureDetector(
                onTap: () async {
                  await auth.login(
                    namecontroller.text.trim(),
                    passwordcontroller.text.trim(),
                  );

                  if (!context.mounted) return;

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => BottomNav()),
                  );
                },
                child: Container(
                  height: 55,
                  width: 387,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black,
                  ),
                  child: const Center(
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
