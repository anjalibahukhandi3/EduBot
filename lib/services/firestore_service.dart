import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/app_models.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ─────────────────────────────────────────────────────────────
  // Study Tasks
  // ─────────────────────────────────────────────────────────────

  Stream<List<StudyTask>> getTodayTasks(String userId) {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final end = start.add(const Duration(days: 1));

    return _db
        .collection('tasks')
        .where('userId', isEqualTo: userId)
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where('date', isLessThan: Timestamp.fromDate(end))
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => StudyTask.fromDoc(doc)).toList());
  }

  Stream<List<StudyTask>> getExamTasks(String examId) {
    return _db
        .collection('tasks')
        .where('examId', isEqualTo: examId)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => StudyTask.fromDoc(doc)).toList());
  }

  Future<void> addTask(StudyTask task) async {
    await _db.collection('tasks').add(task.toMap());
  }

  Future<void> toggleTask(String id, bool completed) async {
    await _db.collection('tasks').doc(id).update({
      'completed': completed,
    });
  }

  Future<void> deleteTask(String id) async {
    await _db.collection('tasks').doc(id).delete();
  }

  // ─────────────────────────────────────────────────────────────
  // Pomodoro Sessions
  // ─────────────────────────────────────────────────────────────

  Future<void> addPomodoroSession(String userId) async {
    await _db.collection('pomodoro_sessions').add(
      PomodoroSession(
        id: '',
        userId: userId,
        date: DateTime.now(),
      ).toMap(),
    );
  }

  Stream<int> getSessionCount(String userId) {
    return _db
        .collection('pomodoro_sessions')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  // ─────────────────────────────────────────────────────────────
  // AI Study Plan
  // ─────────────────────────────────────────────────────────────

  Future<void> saveStudyPlan(
      String examId,
      String userId,
      List<Map<String, String>> tasks,
      ) async {
    final batch = _db.batch();

    for (final task in tasks) {
      final ref = _db.collection('tasks').doc();

      batch.set(
        ref,
        StudyTask(
          id: ref.id,
          title: task['title'] ?? '',
          completed: false,
          userId: userId,
          date: DateTime.now(),
          examId: examId,
        ).toMap(),
      );
    }

    await batch.commit();
  }

  // ─────────────────────────────────────────────────────────────
  // Exams
  // ─────────────────────────────────────────────────────────────

  Stream<List<Exam>> getExams(String userId) {
    return _db
        .collection('exams')
        .where('userId', isEqualTo: userId)
        .orderBy('examDate')
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => Exam.fromDoc(doc)).toList());
  }

  Future<DocumentReference> addExam(Exam exam) async {
    return await _db.collection('exams').add(exam.toMap());
  }

  Future<void> updateExam(
      String id,
      Map<String, dynamic> data,
      ) async {
    await _db.collection('exams').doc(id).update(data);
  }

  Future<void> deleteExam(String id) async {
    await _db.collection('exams').doc(id).delete();
  }

  // ─────────────────────────────────────────────────────────────
  // Modules
  // ─────────────────────────────────────────────────────────────

  Stream<List<Module>> getModules(String userId) {
    return _db
        .collection('modules')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => Module.fromDoc(doc)).toList());
  }

  Future<void> addModule(Module module) async {
    await _db.collection('modules').add(module.toMap());
  }

  Future<void> updateModule(
      String id,
      String name,
      ) async {
    await _db.collection('modules').doc(id).update({
      'name': name,
    });
  }

  Future<void> deleteModule(String id) async {
    await _db.collection('modules').doc(id).delete();
  }

  // ─────────────────────────────────────────────────────────────
  // Dashboard Statistics
  // ─────────────────────────────────────────────────────────────

  Future<Map<String, int>> getDashboardStats(String userId) async {
    final modules = await _db
        .collection('modules')
        .where('userId', isEqualTo: userId)
        .get();

    final exams = await _db
        .collection('exams')
        .where('userId', isEqualTo: userId)
        .get();

    final tasks = await _db
        .collection('tasks')
        .where('userId', isEqualTo: userId)
        .where('completed', isEqualTo: true)
        .get();

    final sessions = await _db
        .collection('pomodoro_sessions')
        .where('userId', isEqualTo: userId)
        .get();

    return {
      'modules': modules.docs.length,
      'exams': exams.docs.length,
      'completedTasks': tasks.docs.length,
      'sessions': sessions.docs.length,
    };
  }
}