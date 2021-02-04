import 'dart:convert';
import 'package:busca_cep/model/viaCEP.dart';
import 'package:http/http.dart' as http;

class viaCEPAPI {

  Future<Endereco> recuperarCEP(contcep) async {
    String cep = contcep.toString();
    String url = "https://viacep.com.br/ws/${cep}/json/";

    http.Response response;
    response = await http.get(url);

    var dadosJson = json.decode(response.body);
    print(dadosJson.toString());

    Endereco endereco = new Endereco(
        cep: dadosJson["cep"].toString(),
        logradouro: dadosJson["logradouro"],
        bairro: dadosJson["bairro"],
        cidade: dadosJson["localidade"],
        uf: dadosJson["uf"]);

    return endereco;
  }
}
