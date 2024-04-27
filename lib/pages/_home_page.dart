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
              const Text("Split on fourth"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                  value: context.watch<PasswordProvider>().useUpper,
                  onChanged: (_) {
                    context.read<PasswordProvider>().setUseUpper(
                        !context.read<PasswordProvider>().getUseUpper());
                  }),
              const Text("Toggle uppercase"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                  value: context.watch<PasswordProvider>().enclose,
                  onChanged: (_) {
                    context.read<PasswordProvider>().setEnclosement(
                        !context.read<PasswordProvider>().getEnclosement());
                  }),
              const Text("Enclose with character"),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Surrounding character(s)",
              ),
              textAlign: TextAlign.center,
              onChanged: (value) => {
                context.read<PasswordProvider>().setSurroundCharacter(value)
              },
              maxLength: 1,
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: ElevatedButton(
              onPressed: () =>
                  context.read<PasswordProvider>().generatePassword(
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
