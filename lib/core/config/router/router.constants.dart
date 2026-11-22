abstract final class RouterConstants {
  const RouterConstants._();
  static String loading = 'Loading';
  static String login = 'Login';
  static String landing = 'Landing';
  static String createProject = 'CreateProject';
  static String inspectionResume = 'InspectionResume';
  static String inspectionCalification = 'InspectionCalification';

  static String getPath(String name) => '/${name.toLowerCase()}';
  static String getPathWithPathParameters(
          String name, List<String> pathParameters) =>
      "/${getPath(name)}/${pathParameters.map((p) => ':$p').join('/')}";
}
