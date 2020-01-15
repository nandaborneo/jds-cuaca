class LinkHelper {
  static final _apiEndpoint = "http://api.openweathermap.org/data/2.5/";
  
  static final forecastGet = _apiEndpoint+"forecast";
  static final weatherGet = _apiEndpoint+"weather";
  static final listCityIndoGet = 'https://jds-cuaca.firebaseio.com/.json?print=pretty&orderBy="postal_code"&limitToFirst=1';
  static final iconUrl = 'http://openweathermap.org/img/wn/';
}