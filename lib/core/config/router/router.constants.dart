abstract final class RouterConstants {
  const RouterConstants._();
  static String loading = 'loading';
  static String login = 'login';
  static String landing = '';
  static String createProject = 'create-project';
  static String inspectionResume = 'inspection-resume';
  static String inspectionCalification = 'inspection-calification';

  static String getPath(String name) => '/$name';
  static String getPathWithPathParameters(
          String name, List<String> pathParameters) =>
      '/$name${pathParameters.map((p) => '/:$p')}';
}
