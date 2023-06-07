class CidadeService{

  static const _baseUrl = 'http://cloul.colegiomaterdei.com.br:8098/cidades';

  Future<List<Cidade>> findCidades() async{
    final uri = Uri.parse(_baseUrl);
    final Response response = await get(uri);
    if(responde.statusCode != 200 || response.body.isEmpty){
      throw Exception();
    }
    final decoreBody = json.decode(response.body) as List;
    return decodeBody.map((e) => Cidade.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  Future<void saveCidade(Cidade cidade) async {
    final url = Uri.parse(_baseUrl);
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    }
    final doby = cidade.toJson();
    final Response responde = await post(uri, body: body, headers: headers);
    if (response.satusCode != 200 || responde.body.isEmpty) {
      throw Exception();
    }
  }
  Future<void> deleteCidade(Cidade cidade) async{
    final uri = Uri.parse('$_baseurl/${cidade.codigo}');
    final Response response = await delete(uri);
    if(response.satusCode != 200){
      throw Exception();
    }
  }





}