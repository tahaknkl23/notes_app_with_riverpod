import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:todo_app_state/models/cat_fact_model.dart';

final HttpClientProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(baseUrl: 'https://catfact.ninja/'));
});

final catFactProvider = FutureProvider<List<CatFactModel>>((ref) async {
  final dio = ref.watch(HttpClientProvider);
  final result = await dio.get('/fact');
  if (result.data != null && result.data['data'] != null) {
    List<Map<String, dynamic>> mapData = List.from(result.data['data']);
    List<CatFactModel> catFactList = mapData.map((e) => CatFactModel.fromMap(e)).toList();
    return catFactList;
  } else {
    // Handle null data or error case
    return []; // veya başka bir hata yönetimi
  }
});

class FutureProviderExample extends ConsumerWidget {
  const FutureProviderExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var liste = ref.watch(catFactProvider);
    return Scaffold(
      body: SafeArea(
          child: liste.when(
        data: (liste) {
          return ListView.builder(
            itemCount: liste.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(liste[index].fact),
                subtitle: Text(liste[index].length),
              );
            },
          );
        },
        error: (error, stack) {
          return Center(
            child: Text('Error: ${error.toString()}'),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      )),
    );
  }
}
