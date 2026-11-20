abstract final class RouterConstants {
  const RouterConstants._();
  static String loading = 'loading';
  static String login = 'login';
  static String landing = 'landing';
  static String createProject = 'createProject';
  static String inspectionResume = 'inspectionResume';
  static String inspectionCalification = 'inspectionCalification';

  static String getPath(String name) => '/$name';
  static String getPathWithPathParameters(
          String name, List<String> pathParameters) =>
      "/$name/${pathParameters.map((p) => ':$p').join('/')}";
}
