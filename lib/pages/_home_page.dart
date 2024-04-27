import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passman/providers/password_gen_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text("Password Generator"),
          ),
          Center(
            child: Text(
              context.watch<PasswordProvider>().password,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                  value: context.watch<PasswordProvider>().splitByThree,
                  onChanged: (_) {
                    context.read<PasswordProvider>().setSplitByThree(
                        !context.read<PasswordProvider>().getSplitByThree());
                  }),
              const Text("Split By 3"),
            ],
          ),
          const SizedBox(height: 12),
          Center(
            child: ElevatedButton(
              onPressed: () =>
                  context.read<PasswordProvider>().generatePassword(
                        enclose: true,
                        surroundCharacter: "ASD",
                        length: 16,
                      ),
              child: const Text("Generate Password"),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Clipboard.setData(
                  ClipboardData(
                    text: context.read<PasswordProvider>().password,
                  ),
                );
              },
              child: const Text("Copy Password"),
            ),
          )
        ],
      ),
    );
  }
}
