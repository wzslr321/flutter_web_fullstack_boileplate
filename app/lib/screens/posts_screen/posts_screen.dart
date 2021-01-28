import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/posts_state.dart';

class PostsScreen extends ConsumerWidget {
  const PostsScreen({Key key}) : super(key: key);
  static const routeName = '/posts';

  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final photos = watch(postsStateFuture);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetching API using riverpod'),
      ),
      body: photos.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('${error.toString()}')),
        data: (value) {
          return ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(value[index].title),
              );
            },
          );
        },
      ),
    );
  }
}