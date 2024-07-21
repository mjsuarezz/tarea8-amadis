import 'package:hive/hive.dart';

part 'incidence.g.dart';

@HiveType(typeId: 0)
class Incidence extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late DateTime date;

  @HiveField(2)
  late String description;

  @HiveField(3)
  late String photoPath;

  @HiveField(4)
  late String audioPath;
}