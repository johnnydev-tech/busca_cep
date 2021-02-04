import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _textEditingController = TextEditingController();
  var maskcep = new MaskTextInputFormatter(
      mask: "#####-###", filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              inputFormatters: [maskcep],
              //text, number, emailadress, datime
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Digite o CEP",
                labelStyle: TextStyle(
                  color: Colors.blue,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueAccent,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
              ),

              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
              onSubmitted: (String Texto) {
                print("Valor digitado: " + Texto);
              },
              controller: _textEditingController,
              cursorColor: Colors.blue,
            ),
            SizedBox(
              height: 25,
            ),
            RaisedButton(
              onPressed: () {},
              color: Colors.blue,
              textColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text("BUSCAR"),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 1.0,
                    offset: Offset(0.0, 0.1),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [Text("Dados:")],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
