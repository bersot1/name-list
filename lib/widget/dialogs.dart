import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:nome_na_lista/UI/recouverAccount.dart';

// ---------------------------------------
// Bstage Alerts = Dialogs
// onTap: () => showDialog(context: context, builder: (_) => BstageDialog(context: context,type: 'NetworkGif', title: 'title', subTitle: 'subtitle', image: 'image',animation: '',),);
// onTap: () => showDialog(context: context, builder: (_) => BstageDialog(context: context,type: 'AssetsGif', title: 'title', subTitle: 'subtitle', image: 'image',animation: '',),);
// onTap: () => showDialog(context: context, builder: (_) => BstageDialog(context: context,type: 'FlareGif', title: 'title', subTitle: 'subtitle', image: 'image',animation: '',),);
// ---------------------------------------

class BstageDialog extends StatelessWidget {
  final String textButtonOK;
  final String textButtonCancel;
  final Function funcButtonOk;
  final Function funcButtonCancel;
  final String title;
  final String subTitle;
  final image;
  final context;

  BstageDialog({
    @required this.textButtonOK,
    @required this.textButtonCancel,
    @required this.funcButtonOk,
    @required this.funcButtonCancel,
    @required this.title,
    @required this.subTitle,
    @required this.image,
    @required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return NetworkGiffyDialog(
      buttonOkColor: Colors.grey,
      onCancelButtonPressed: funcButtonCancel,
      buttonOkText: Text(
        textButtonOK,
        style: TextStyle(color: Colors.white),
      ),
      buttonCancelColor: Colors.grey.withOpacity(.4),
      buttonCancelText: Text(
        textButtonCancel,
        style: TextStyle(color: Colors.white),
      ),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      description: Text(
        subTitle.toString(),
        textAlign: TextAlign.center,
      ),
      entryAnimation: EntryAnimation.BOTTOM,
      onOkButtonPressed: funcButtonOk,
      image: Image.network(
        image,
        fit: BoxFit.cover,
      ),
    );
  }
}
