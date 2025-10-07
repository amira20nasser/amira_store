abstract class ApiService {
  get(String endpoint, {Map<String, dynamic>? queryParams});
  post(String endpoint, {dynamic data});
  put(String endpoint, {dynamic data});
  patch(String endpoint, {dynamic data});
  delete(String endpoint, {dynamic data});
}
