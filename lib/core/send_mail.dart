import 'package:aprender_haciendo_app/core/models/userModelDB.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

Future sendMail() async {
  String username = 'info@aprenderhaciendo.co.cr';
  String password = 'Apr3nd3rHCR2021';

  final smtpServer = gmail(username, password);
  var connection = PersistentConnection(smtpServer);

  final message = Message()
    ..from = Address(username, 'Aprender Haciendo')
    ..recipients.add('info@aprenderhaciendo.co.cr')
    ..ccRecipients.addAll(['info@aprenderhaciendo.co.cr'])
    //..bccRecipients.add(Address('aprenderhaciendoprueba@gmail.com'))
    ..subject = 'Aprender Haciendo :: Orden de compra :: ${DateTime.now()}'
    //..text = 'This is the plain text.\nThis is line 2 of the text part.';
    ..html =
        "<h1>Hola ${UserModel.NOMBRE},</h1>\n<p>Gracias por comprar en Aprender Haciendo</p>\n\n<h2>Detalles del pedido</h2>\n\n<p> ${UserModel.TOTALCARTPRICE}</p>";

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
  await connection.close();
}
