import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:reflect/core/presentation/app_error_widget.dart';
import 'package:reflect/core/presentation/app_loading_indicator.dart';
import 'package:reflect/core/presentation/common_app_bar.dart';
import 'package:reflect/features/post/data/post_bloc.dart';
import 'package:reflect/features/post/domain/post.dart';

class PostDetailScreen extends StatelessWidget {
  final String postId;

  const PostDetailScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: 'Post Details'),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          // Since our logic assumes the list is loaded, we try to find the post locally.
          // In a real app, you might trigger a `GetPostById` event if it's not found.
          return state.maybeWhen(
            loaded: (posts) {
              final post = posts.firstWhereOrNull(
                (p) => p.id.toString() == postId,
              );

              if (post == null) {
                return const AppErrorWidget(message: "Post not found.");
              }

              return _PostContent(post: post);
            },
            loading: () => const Center(child: AppLoadingIndicator()),
            error: (msg) => AppErrorWidget(message: msg),
            orElse: () {
              // If state is initial (empty), we might want to trigger a refresh
              // or show a generic loading until the list arrives.
              return const Center(child: AppLoadingIndicator());
            },
          );
        },
      ),
    );
  }
}

class _PostContent extends StatelessWidget {
  final Post post;

  const _PostContent({required this.post});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: post.isRead ? Colors.green.shade100 : Colors.blue.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              post.isRead ? 'Read' : 'Unread',
              style: TextStyle(
                color: post.isRead
                    ? Colors.green.shade800
                    : Colors.blue.shade800,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            post.body,
            style: theme.textTheme.bodyLarge?.copyWith(
              height: 1.6,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}
