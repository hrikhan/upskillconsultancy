import 'package:upskill_consultancy/src/utils/typedefs.dart';
import 'package:upskill_consultancy/src/features/services/data/models/service_model.dart';

abstract class ServicesRepository {
  FutureEither<List<ServiceModel>> getServices();
  FutureEither<ServiceModel> getServiceById(String id);
}
