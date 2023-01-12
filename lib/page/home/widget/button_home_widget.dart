import 'package:flutter/material.dart';
import 'package:notes_app_sqflite/design/color_style.dart';
import 'package:notes_app_sqflite/widgets/dialog_custom.dart';

class WidgetButtonHome extends StatelessWidget {
  WidgetButtonHome({Key? key}) : super(key: key);
  final TextEditingController _controllerTitle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // add category
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                minimumSize: const Size(double.infinity, 45),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 2, color: primaryColor),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Buat Kategori',
                style: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(color: primaryColor),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // add note
                // Navigation.pushPage(route: DetailNotePage.routeNamed);
                DialogCustom.dialogCreateNote(title: _controllerTitle);
              },
              child: Text(
                'Buat Catatan',
                style: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
