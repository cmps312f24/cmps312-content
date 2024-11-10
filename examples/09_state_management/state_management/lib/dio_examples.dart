
import 'package:dio/dio.dart';

Future<String> fetchUserOrder() {
  // Imagine that this function is more complex and slow.
  return Future.delayed(const Duration(seconds: 4), () => 'Large Latte');
}

void main(List<String> args) {
  fetchUserOrder().then((order) {
    print(order);
  }).catchError((error) {
    print(error);
  });
}

Future<void> displayUserOrder() async {
  try {
    String order = await fetchUserOrder();
    print(order); // User data loaded
  } catch (error) {
    print(error);
  }
}

int slowFib(int n) => n <= 1 ? 1 : slowFib(n - 1) + slowFib(n - 2);

// Compute without blocking current isolate.
void fib40() async {
  var result = await Isolate.run(() => slowFib(40));
  print('Fib(40) = $result');
}


http.get('https://example.com').then((response) {
  if (response.statusCode == 200) {
    print('Success!');
  }  
});


final dio = Dio();

void getPage() async {
  final response = await dio.get('https://dart.dev');
  print(response);
  print(response.data);
  print(response.headers);
  print(response.requestOptions);
  print(response.statusCode);
}

void request() async {
  // Performing a GET request:
  Response response = await dio.get('/test?id=12&name=dio');
  print(response.data.toString());
  // The below request is the same as above.
  response = await dio.get(
    '/test',
    queryParameters: {'id': 12, 'name': 'dio'},
  );
  print(response.data.toString());

  // Performing a POST request:
  response = await dio.post('/test', data: {'id': 12, 'name': 'dio'});

  // Performing multiple concurrent requests:
  response = await Future.wait([dio.post('/info'), dio.get('/token')]);

// Downloading a file:
  response = await dio.download(
    'https://pub.dev/',
    (await getTemporaryDirectory()).path + 'pub.html',
  );
}

void sendFormData() {
  // Sending a FormData:
  final formData = FormData.fromMap({
    'name': 'dio',
    'date': DateTime.now().toIso8601String(),
  });
  final response = await dio.post('/info', data: formData);
}

// Uploading multiple files to server by FormData:
void uploadFile() {
  final formData = FormData.fromMap({
    'name': 'dio',
    'date': DateTime.now().toIso8601String(),
    'file': await MultipartFile.fromFile('./text.txt', filename: 'upload.txt'),
    'files': [
      await MultipartFile.fromFile('./text1.txt', filename: 'text1.txt'),
      await MultipartFile.fromFile('./text2.txt', filename: 'text2.txt'),
    ]
  });
  final response = await dio.post('/info', data: formData);
}

// Listening the uploading progress:
void uploadPgress() {
  final response = await dio.post(
    'https://www.dtworkroom.com/doris/1/2.0.0/test',
    data: {'aa': 'bb' * 22},
    onSendProgress: (int sent, int total) {
      print('$sent $total');
    },
  );
}

// Creating an instance and set default configs
void configureDio() {
  // Set default configs
  dio.options.baseUrl = 'https://api.pub.dev';
  dio.options.connectTimeout = Duration(seconds: 5);
  dio.options.receiveTimeout = Duration(seconds: 3);

  // Or create `Dio` with a `BaseOptions` instance.
  final options = BaseOptions(
    baseUrl: 'https://api.pub.dev',
    connectTimeout: Duration(seconds: 5),
    receiveTimeout: Duration(seconds: 3),
  );
  final anotherDio = Dio(options);

  dio.interceptors.add(
    LogInterceptor(
      logPrint: (o) => debugPrint(o.toString()),
    ),
  );
}

void handleError() {
  try {
    // 404
    await dio.get('https://api.pub.dev/not-exist');
  } on DioException catch (e) {
    // The request was made and the server responded with a status code
    // that falls out of the range of 2xx and is also not 304.
    if (e.response != null) {
      print(e.response.data)
      print(e.response.headers)
      print(e.response.requestOptions)
    } else {
      // Something happened in setting up or sending the request that triggered an Error
      print(e.requestOptions)
      print(e.message)
    }
  }
}