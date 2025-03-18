import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ✅ White background
      body: Column(
        children: [
          // ✅ Expanded ensures the text stays centered
          Expanded(
            child: Center(
              child: Text(
                "Submit Successfully",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center, // ✅ Ensures proper centering
              ).tr(),
            ),
          ),

          // ✅ Row is aligned to the bottom
          Padding(
            padding:
                const EdgeInsets.only(bottom: 40), // ✅ Adjust bottom padding
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly, // ✅ Space buttons evenly
              children: [
                // First Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue[500],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 30),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'New Complaint',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ).tr(),
                ),

                // Second Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue[500],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 30),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Exit',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ).tr(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
