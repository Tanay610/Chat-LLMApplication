import 'package:chat_gpt/constants/constants.dart';
import 'package:chat_gpt/widgets/drop_down.dart';
import 'package:flutter/material.dart';

import '../widgets/text_widget.dart';

class Services {
  static Future<void> showModalSheet({required BuildContext context}) async {
    await showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        backgroundColor: scaffoldBGcolor,
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Flexible(
                  child: TextWidget(
                    label: "Choose Model:",
                    fontSizes: 16,
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: ModelsDropDownWidget(),),
              ],
            ),
          );
        });
  }
}
