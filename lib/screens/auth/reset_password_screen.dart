import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 120,
            ),
            Image.asset(
              'assets/icons/tasky_logo.png',
              width: 80,
              height: 80,
            ),
            const SizedBox(
              height: 70,
            ),
            // const Spacer(),
            Text(
              'Forgot Password',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              'Please Enter your Registered email address we will send you a email to reset your password',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 16,
            ),

            Container(
              width: double.infinity,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: const Color.fromARGB(246, 143, 143, 143),
                ),
              ),
              child: TextFormField(
                controller: emailController,
                style: const TextStyle(
                  color: Color.fromARGB(246, 26, 25, 25),
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter email address',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                cursorColor: const Color.fromARGB(246, 143, 143, 143),
              ),
            ),
            const SizedBox(
              height: 16,
            ),

            SizedBox(
              width: 400,
              height: 45,
              child: ElevatedButton(
                onPressed: () async {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Send Email',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
