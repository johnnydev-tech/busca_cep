import 'dart:convert';
import 'package:busca_cep/model/viaCEP.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class viaCEPAPI {
  Future<Endereco> recuperarCEP(contcep) async {
    FirebaseFirestore _db = FirebaseFirestore.instance;
    String cep = contcep.toString();
    String url = "https://viacep.com.br/ws/${cep}/json/";
    http.Response response;
    response = await http.get(url);
    var data = new DateTime.now();


    var dadosJson = json.decode(response.body);
    print(dadosJson.toString());

    Endereco endereco = new Endereco(
        cep: dadosJson["cep"].toString(),
        logradouro: dadosJson["logradouro"],
        bairro: dadosJson["bairro"],
        cidade: dadosJson["localidade"],
        uf: dadosJson["uf"]);

    if (dadosJson != "null") {
      Map<String, dynamic> location = Map();
      location["cep"] = dadosJson["cep"];
      location["logradouro"] = dadosJson["logradouro"];
      location["bairro"] = dadosJson["bairro"];
      location["localidade"] = dadosJson["localidade"];
      location["uf"] = dadosJson["uf"];
      location["data"] = data;

      _db.collection("locations").add(location);
    }

    return endereco;
  }
}
