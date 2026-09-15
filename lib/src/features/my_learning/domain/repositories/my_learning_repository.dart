import 'package:upskill_consultancy/src/utils/typedefs.dart';
import 'package:upskill_consultancy/src/features/my_learning/data/models/enrollment_model.dart';

abstract class MyLearningRepository {
  FutureEither<List<EnrollmentModel>> getEnrolledCourses();
  FutureEither<List<EnrollmentModel>> getCompletedCourses();
  FutureEither<EnrollmentModel?> getContinueLearningCourse();
  FutureEither<int> getCertificatesCount();
}
