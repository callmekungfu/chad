library constants;

const String API = "https://us-central1-chaddb-a0502.cloudfunctions.net/api/v1";
const String DEV_API = 'https://us-central1-this-is-a-firebase-project.cloudfunctions.net/api/v1';

const Map<String, dynamic> ERROR_RESPONSE = {
  "status": "failed",
  "isSuccess": false,
  "msg": "An exception occured. Please try again later."
};
