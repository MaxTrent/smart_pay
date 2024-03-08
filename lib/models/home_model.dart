class Home {
  final bool status;
  final String message;
  final HomeData data;
  final List<dynamic> meta;
  final List<dynamic> pagination;

  Home({
    required this.status,
    required this.message,
    required this.data,
    required this.meta,
    required this.pagination,
  });

  factory Home.fromJson(Map<String, dynamic> json) {
    return Home(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: HomeData.fromJson(json['data'] ?? {}),
      meta: json['meta'] ?? [],
      pagination: json['pagination'] ?? [],
    );
  }

  @override
  String toString() {
    return 'Home(status: $status, message: $message, data: $data, meta: $meta, pagination: $pagination)';
  }
}

class HomeData {
  final String secret;

  HomeData({required this.secret});

  factory HomeData.fromJson(Map<String, dynamic> json) {
    return HomeData(
      secret: json['secret'] ?? '',
    );
  }

  @override
  String toString() {
    return 'HomeData(secret: $secret)';
  }
}
