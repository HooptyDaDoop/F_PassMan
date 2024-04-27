import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passman/providers/password_gen_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // MARK: Title
              const Center(
                child: Text("Password Generator"),
              ),

              // MARK: Password display
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

              // MARK: Split on 4th
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                      value: context.watch<PasswordProvider>().splitOnFourth,
                      onChanged: (_) {
                        context.read<PasswordProvider>().setSplitByThree(
                            !context
                                .read<PasswordProvider>()
                                .getSplitByThree());
                      }),
                  const Text("Split on fourth"),
                ],
              ),

              // MARK: Toggle uppercase
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

              // MARK: Toggle enclose password
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

              // MARK: Enclose character text field
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

              // MARK: Generate password button
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

              // MARK: Copy password button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Clipboard.setData(
                      ClipboardData(
                        text: context.read<PasswordProvider>().password,
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Password copied."),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: const Text("Copy Password"),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
