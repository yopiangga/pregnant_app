import 'package:pregnant_app/models/models.dart';

CourseTypeModel getCategoryByIndex(categorys, index) {
  for (int i = 0; i < categorys.length; i++) {
    if (categorys[i].id.toString() == index.toString()) return categorys[i];
  }

  return categorys[0];
}
