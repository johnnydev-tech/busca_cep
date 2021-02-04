import 'package:busca_cep/controller/viaCEPController.dart';
import 'package:busca_cep/model/viaCEP.dart';
import 'package:busca_cep/view/listLocations.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  viaCEPAPI api = viaCEPAPI();

  _findCep(String cep) {
    return api.recuperarCEP(cep);
  }

  TextEditingController _cepController = TextEditingController();
  var maskcep = new MaskTextInputFormatter(
      mask: "#####-###", filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consulta ViaCEP"),
        actions: [
          IconButton(icon: Icon(Icons.history), onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ListLocations()));
          }, tooltip: "Histórico",)
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
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
                controller: _cepController,
                cursorColor: Colors.blue,
              ),
              SizedBox(
                height: 25,
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    _findCep(_cepController.text);
                  });
                },
                color: Colors.blue,
                textColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text("BUSCAR"),
              ),
              SizedBox(
                height: 25,
              ),
              _cepController.text == ""
                  ? Container()
                  : FutureBuilder(
                future: _findCep(_cepController.text),
                // ignore: missing_return
                builder: (context, snpashot) {
                  switch (snpashot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                      break;
                    case ConnectionState.active:
                    case ConnectionState.done:
                      if (snpashot.hasError) {
                        Container(
                          height: 0,
                          width: 0,
                        );
                      } else {
                        Endereco endereco = snpashot.data;

                        return Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
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
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text("CEP:"),
                                    Text(endereco.cep),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text("Logradouro:"),
                                    Expanded(
                                        child: Text(
                                          endereco.logradouro,
                                          softWrap: true,
                                          textAlign: TextAlign.end,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text("Bairro:"),
                                    Expanded(
                                        child: Text(
                                          endereco.bairro,
                                          softWrap: true,
                                          textAlign: TextAlign.end,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text("Cidade:"),
                                    Expanded(
                                      child: Text(
                                        endereco.cidade,
                                        softWrap: true,
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text("UF:"),
                                    Text(endereco.uf),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      break;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
