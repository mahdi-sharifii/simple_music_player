import 'package:flutter/material.dart';
import 'package:music_play/features/home/presentation/helper/get_permission.dart';

class FailedPer extends StatelessWidget {
  const FailedPer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("لطفا به برنامه دسترسی به فایل ها را بدهید"),
          ElevatedButton(
            onPressed: () => getPermission(context),
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor),
            child: const Text("تلاش دوباره"),
          )
        ],
      ),
    );
  }
}
