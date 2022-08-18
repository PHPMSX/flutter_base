# flutter_base

A new Flutter project.

## Getting Started
# Set up cơ bản
* Flutter version: 3.0 
* Cài đặt plugin Flutter và Dart trên Android Studio (Visual Studio - hiện tại chỉ mới sử dụng AS nên chưa xem qua cách set up)
* Thiết lập đường dẫn đến flutter SDK

### MacOS
* Set up [Flutter cho máy Mac chip M1](https://www.youtube.com/watch?v=9xfRTp6tN5E)
* Set up [Homebrew](https://brew.sh/index_vi)
* Set up [Cocoapods](https://formulae.brew.sh/formula/cocoapods)
* Set up pub global từ dart bằng cách thêm PATH của dart-sdk (từ thư mục flutter) vào file .zshrc
* Set up [Get CLI](https://pub.dev/packages/get_cli)
* Set up [flutter_gen](https://pub.dev/packages/flutter_gen) - chỉ cần set up pub global để chạy được lên ```flutter_gen```

### Windows
* Set up [biến môi trường cho flutter](https://flutter.dev/docs/get-started/install/windows#update-your-path)
* Set up pub global từ dart bằng cách thêm đường dẫn của dart-sdk vào biến môi trường

# Cấu trúc một màn hình
Project sử dụng GetX Pattern, cấu trúc một màn hình bao gồm: Bindings, Controller và View
### Bindings
Extend Bindings., khởi tạo dependency injection (Controller, Service...) cho màn hình hiện tại.

[GetX Bindings](https://github.com/jonataslaw/getx/blob/master/documentation/en_US/dependency_management.md#bindings)

### Controller
Extends BaseController, chứa các class, field, hàm chịu trách nhiệm xử lý logic cho màn hình hiện tại.
Có thể tạo các _workers_ và _StateMixin_ để xử lý việc load các biến react và xử lý loading của màn hình

[StateMixin](https://pub.dev/packages/get#statemixin)

### View
Extends GetView - cần có một Controller. Là phần xử lý UI của màn hình. Không cần sử dụng StatelessWidget hay StatefulWidget cho UI nữa

### Sử dụng Obx
Khi một widget cần có sự thay đổi về content, VD: Widget Text cần thay đổi text hiển thị khi gọi xong API:
- Tạo một biến ```.obs``` ở Controller của view VD: ```final name = 'Nhan Soi'.obs; ```
- Sử dụng Widget builder Obx khi dùng biến _name_: ```Obx(() => Text("${controller.name}"));```

=> Không cần phải setState (StatefulWidget) hoặc build lại widget tree (StatelessWidget)

# Service kiểm tra internet connection
Project mẫu đã có set up sẵn một service kiểm tra internet connection. Thay đổi cách hiển thị khi bị mất kết nối mạng trong class **ConnectivityService**

```
        Connectivity().onConnectivityChanged.listen((event) {
         if (event == ConnectivityResult.none) {
           ///No internet
           isShowingDialog = true;
           LoggerService.log.i('No connection');
           showDialog(); <-- Thay đổi cách hiển thị khi không có kết nối mạng
         } else {
           LoggerService.log.i('Connected...');
           if (isShowingDialog) {
             ///If dialog/screen is showing => pop back
             LoggerService.log.i('Handle back to current screen');
             Get.back();
             isShowingDialog = false;
           }
         }
       });
```

# build 
flutter run --flavor staging --release -t lib/main_staging.dart

# config flavor
https://github.com/vanle57/flutter-flavor/blob/main/README.md
# flutter_base
