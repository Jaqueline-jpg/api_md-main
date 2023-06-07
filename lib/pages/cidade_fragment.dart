import 'package:api_md/services/cidade_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CidadeFragment extends StatefulWidget{
  static const title = 'Cidade';

  const CidadeFragment({Key? key}) : super(key:  key);

  @override
  State<StatefulWidget> createState() => CidadeFragmentState();
}

class CidadeFragmentState extends State<CidadeFragment>{
  final _service = CidadeService();
  final List<Cidade> _cidades = [];
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initiState(){
    super .initState();
    WidgetsBinding.instance?.addPostFrameCallback((_){
      _refreshIndicatorKey.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: LayoutBuilder(
        builder: (_, constraints) {
          Widget content;
          if (_cidades.isEmpty) {
            content = SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: Center(
                  child: Text('Nenhuma cidade cadastrada!'),
                ),
              ),
            );
          } else {
            content = ListView.separated(
              itemBuilder: (_, index) {
                final cidade = _cidade[index];
                return ListTile(
                  title: Text('${cidade.nome} - ${cidade.uf}'),
                );
              },
              separatorBuilder: (_, __) => Divider(),
              itemCount: _cidades.length,
            );
          }
          return RefreshIndicator(
            key: _refreshIndicatorKey,
            child: content,
            onRefresh: _findCidades,
          );
        },
      ),
    );
  }
    Future<void> _findCidade() async{
      await Future.delayed(Duration(seconds: 3));
      final cidades = await _service.findCidades();
      setState(() {
        _cidades.clear();
        if (cidades.isNotEmpty) {
          _cidades.addAll(cidades);
        }
      });
    }
}