abstract class GCalRepository {
  Future<void> processQueue();
  Future<void> signIn();
  Future<void> signOut();
  Stream<int> watchQueueDepth();
}
