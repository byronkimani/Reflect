import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reflect/core/presentation/app_error_widget.dart';
import 'package:reflect/core/presentation/app_loading_indicator.dart';
import 'package:reflect/core/presentation/common_app_bar.dart';
import 'package:reflect/features/post/data/post_bloc.dart';
import 'package:reflect/features/post/domain/post.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Latest Posts',
        showBackButton: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              context.read<PostBloc>().add(const PostEvent.refresh());
            },
          ),
        ],
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: AppLoadingIndicator()),
            loading: () => const Center(child: AppLoadingIndicator()),
            error: (message) => AppErrorWidget(
              message: message,
              onRetry: () =>
                  context.read<PostBloc>().add(const PostEvent.refresh()),
            ),
            loaded: (posts) {
              if (posts.isEmpty) {
                return const Center(child: Text("No posts found."));
              }
              return _PostsList(posts: posts);
            },
          );
        },
      ),
    );
  }
}

class _PostsList extends StatelessWidget {
  final List<Post> posts;

  const _PostsList({required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: posts.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final post = posts[index];
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            title: Text(
              post.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                post.body,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            onTap: () {
              // Navigate to details using GoRouter
              context.go('/posts/${post.id}');
            },
          ),
        );
      },
    );
  }
}
