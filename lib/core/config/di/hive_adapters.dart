import 'package:hive_ce/hive.dart';
import 'package:solar_check/core/user/data/models/user_model.dart';
import 'package:solar_check/features/projects/data/models/inspection.model.dart';
import 'package:solar_check/features/projects/data/models/project.model.dart';
import 'package:solar_check/features/projects/data/models/section.model.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<InspectionModel>(),
  AdapterSpec<SectionModel>(),
  AdapterSpec<SectionItemModel>(),
  AdapterSpec<UserModel>(),
  AdapterSpec<ProjectModel>(),
])
class HiveAdapters {}
