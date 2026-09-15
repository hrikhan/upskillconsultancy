import 'package:upskill_consultancy/src/utils/typedefs.dart';
import 'package:upskill_consultancy/src/features/courses/data/models/course_model.dart';

/// Contract for Courses data operations.
/// Can be fulfilled by [CoursesRepositoryImpl] with mock data now,
/// and later swapped to Wix API Remote Data Source seamlessly.
abstract class CoursesRepository {
  FutureEither<List<CourseModel>> getCourses({String? category, String? searchQuery});
  FutureEither<List<CourseModel>> getTopCourses();
  FutureEither<List<CourseModel>> getFeaturedCourses();
  FutureEither<CourseModel> getCourseById(String id);
  FutureEither<List<String>> getCategories();
}
