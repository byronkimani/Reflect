import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reflect/features/post/data/post_repository.dart';
import 'package:reflect/features/post/domain/post.dart';

part 'post_bloc.freezed.dart';
part 'post_bloc.g.dart';

// --- STATES ---
@freezed
abstract class PostState with _$PostState {
  const factory PostState.initial() = _Initial;
  const factory PostState.loading() = _Loading;
  const factory PostState.loaded(List<Post> posts) = _Loaded;
  const factory PostState.error(String message) = _Error;

  factory PostState.fromJson(Map<String, dynamic> json) =>
      _$PostStateFromJson(json);
}

// --- EVENTS ---
@freezed
abstract class PostEvent with _$PostEvent {
  const factory PostEvent.started() = _Started;
  const factory PostEvent.refresh() = _Refresh;
}

// --- BLOC ---
class PostBloc extends HydratedBloc<PostEvent, PostState> {
  final PostRepository _repository;

  PostBloc(this._repository) : super(const PostState.initial()) {
    on<_Started>(_onStarted);
    on<_Refresh>(_onRefresh);
  }

  Future<void> _onStarted(_Started event, Emitter<PostState> emit) async {
    state.maybeWhen(
      loaded: (_) => add(const PostEvent.refresh()),
      orElse: () => add(const PostEvent.refresh()),
    );
  }

  Future<void> _onRefresh(_Refresh event, Emitter<PostState> emit) async {
    if (state is! _Loaded) {
      emit(const PostState.loading());
    }

    final result = await _repository.getPosts();

    result.fold(
      (failure) => emit(PostState.error(failure.errorMessage)),
      (posts) => emit(PostState.loaded(posts)),
    );
  }

  @override
  PostState? fromJson(Map<String, dynamic> json) {
    try {
      return PostState.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(PostState state) {
    if (state is _Loaded) {
      return state.toJson();
    }
    return null;
  }
}
