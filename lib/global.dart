const SERVER_NAME="10.0.2.2";
const URL_COUNTRY = "http://$SERVER_NAME:500/Country";
const URL_PROJECT = "http://$SERVER_NAME:500/Project";
const URL_PROJECT_FROM_COUNTRY ="http://$SERVER_NAME:500/Project/Countryid";


class URL {
  static const SERVER_NAME = "10.0.2.2";
  static const SERVER_PORT = 5000;
  static const baseUri = "http://$SERVER_NAME:$SERVER_PORT/api";
  static const URL_COUNTRY = "$baseUri/Country/";
  static const URL_PROJECT = "$baseUri/Project/";
  static const URL_INSPECTION = "$baseUri/Inspection/";
}

