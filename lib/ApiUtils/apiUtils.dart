class ApiUtils {
  static String baseUrl = 'http://isow.acutrotech.com/';
  static String apiUrl = baseUrl + 'index.php/api/';
  static String imageUrl = 'http://isow.acutrotech.com/assets/';
  static String contactApi = apiUrl + 'SearchList/searchUsers';
  static String sosCreateApi = apiUrl + 'SOS/create';
  static String sosDeleteApi = apiUrl + 'SOS/delete';
  static String sosListApi = apiUrl + 'SOS/singleList';
  static String faqApi = apiUrl + 'FAQ/list';
}

class ApifeedbackNews {
  static String feedbackCreateApi = ApiUtils.apiUrl + 'Feedback/create';
  static String feedBackListApi = ApiUtils.apiUrl + 'Feedback/singleList';
  static String feedBackDeleteApi = ApiUtils.apiUrl + 'Feedback/delete';

  static String newsListApi = ApiUtils.apiUrl + 'News/list';
  static String newsImageApi = ApiUtils.baseUrl + 'assets/images/news/';
  static String activityImageApi =
      ApiUtils.baseUrl + 'assets/images/activities/';
  static String activityListApi = ApiUtils.apiUrl + 'Activities/list';
}

class ApiJobDescription {
  static String jobFilesApi = ApiUtils.baseUrl + 'assets/files/';
  static String jobCreateApi = ApiUtils.apiUrl + 'JobIssue/create';
  static String jobIssuedListAuthApi = ApiUtils.apiUrl + 'JobIssue/singleList';
  static String jobExecuteApi = ApiUtils.apiUrl + 'JobExecute/execute';
  static String jobIssuedApi = ApiUtils.apiUrl + 'JobIssue/singleuserissueList';
  static String jobExecutedListApi =
      ApiUtils.apiUrl + 'JobExecute/userexecutedList';
  static String jobHandoverCreateApi =
      ApiUtils.apiUrl + 'JobHandover/handovercreate';
  static String jobHandoverStatusApi =
      ApiUtils.apiUrl + 'JobHandover/handoverstatus';
  static String jobHandoveredListApi =
      ApiUtils.apiUrl + 'JobHandover/userhandoveredList';
}

class ListingApi {
  static String roleListApi = ApiUtils.apiUrl + 'userRoles/rolesList';
  static String userRoleListApi = ApiUtils.apiUrl + 'UserRoles/usersList';
}
