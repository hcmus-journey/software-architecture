import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventProviderData with ChangeNotifier {
  int currentIndex = 0;

  final List<Map<String, String>> AllEvents = [
  {
    'id': '001',
    'title': 'Giảm 50% cho mọi đơn',
    'image': 'assets/images/highlands.png',
    'avatar': 'assets/images/logo_high.png',
    'store': 'Highlands Coffee',
    'detail': 'Ưu đãi giảm 50% cho mọi đơn hàng khi sử dụng ứng dụng.',
    'voucherCount': '100',
    'voucherUsed': '50',
    'startDate': '01/02/2025',
    'endDate': '31/02/2025',
  },
  {
    'id': '002',
    'title': 'Ưu đãi đặc biệt cuối tuần',
    'image': 'assets/images/toco.png',
    'avatar': 'assets/images/logo_toco.png',
    'store': 'TocoToco',
    'detail': 'Giảm giá đặc biệt vào cuối tuần khi mua từ 2 sản phẩm trở lên.',
    'voucherCount': '50',
    'voucherUsed': '20',
    'startDate': '06/02/2025',
    'endDate': '16/02/2025',
  },
  {
    'id': '003',
    'title': 'Ưu đãi giờ vàng',
    'image': 'assets/images/katinat.png',
    'avatar': 'assets/images/logo_katinat.png',
    'store': 'KATINAT',
    'detail': 'Giảm 30% cho tất cả đơn hàng trong khung giờ vàng 16:00 - 18:00.',
    'voucherCount': '300',
    'voucherUsed': '110',
    'startDate': '10/03/2025',
    'endDate': '10/04/2025',
  },
  {
    'id': '004',
    'title': 'Khuyến mãi 1 tặng 1',
    'image': 'assets/images/warrio.png',
    'avatar': 'assets/images/logo_warrio.png',
    'store': 'WARRIOR',
    'detail': 'Mua 1 tặng 1 khi sử dụng voucher tại cửa hàng WARRIOR.',
    'voucherCount': '150',
    'voucherUsed': '50',
    'startDate': '12/12/2024',
    'endDate': '15/01/2025',
  },
  {
    'id': '005',
    'title': 'Đồng giá 20K',
    'image': 'assets/images/trasuadodo.png',
    'avatar': 'assets/images/logo_trasuadodo.png',
    'store': 'Trà Sữa Đô Đô',
    'detail': 'Mọi sản phẩm đồng giá 20K khi thanh toán bằng ví điện tử.',
    'voucherCount': '250',
    'voucherUsed': '0',
    'startDate': '01/01/2025',
    'endDate': '31/01/2025',
  },

  {
    'id': '006',
    'title': 'Giảm 10% trên mọi hóa đơn',
    'image': 'assets/images/highlands.png',
    'avatar': 'assets/images/logo_high.png',
    'store': 'Highlands Coffee',
    'detail': 'Ưu đãi giảm giá 10% cho mọi hóa đơn trên toàn quốc.',
    'voucherCount': '80',
    'voucherUsed': '0',
    'startDate': '05/01/2025',
    'endDate': '20/01/2025',
  },
  {
    'id': '007',
    'title': 'Quà tặng sinh nhật',
    'image': 'assets/images/toco.png',
    'avatar': 'assets/images/logo_toco.png',
    'store': 'TocoToco',
    'detail': 'Nhận quà tặng miễn phí nhân dịp sinh nhật của bạn.',
    'voucherCount': '100',
    'voucherUsed': '0',
    'startDate': '10/01/2025',
    'endDate': '30/01/2025',
  },
  {
    'id': '008',
    'title': 'Miễn phí giao hàng',
    'image': 'assets/images/fashion.png',
    'avatar': 'assets/images/logo_fashion.png',
    'store': 'Fashion',
    'detail': 'Miễn phí giao hàng cho các đơn hàng từ 150K trở lên.',
    'voucherCount': '200',
    'voucherUsed': '50',
    'startDate': '01/02/2025',
    'endDate': '31/03/2025',
  },
  {
    'id': '009',
    'title': 'Giảm giá cuối tháng',
    'image': 'assets/images/katinat.png',
    'avatar': 'assets/images/logo_katinat.png',
    'store': 'KATINAT',
    'detail': 'Giảm giá 25% cho tất cả sản phẩm trong dịp cuối tháng.',
    'voucherCount': '300',
    'voucherUsed': '0',
    'startDate': '15/01/2025',
    'endDate': '15/02/2025',
  },
  {
    'id': '010',
    'title': 'Ưu đãi khách hàng mới',
    'image': 'assets/images/warrio.png',
    'avatar': 'assets/images/logo_warrio.png',
    'store': 'WARRIOR',
    'detail': 'Ưu đãi đặc biệt dành cho khách hàng lần đầu mua sắm.',
    'voucherCount': '120',
    'voucherUsed': '0',
    'startDate': '01/01/2025',
    'endDate': '31/01/2025',
  },
  {
    'title': 'Tặng thêm topping miễn phí',
    'image': 'assets/images/trasuadodo.png',
    'avatar': 'assets/images/logo_trasuadodo.png',
    'store': 'Trà Sữa Đô Đô',
    'detail': 'Thêm topping miễn phí cho tất cả đơn hàng từ 50K.',
    'voucherCount': '150',
    'voucherUsed': '50',
    'startDate': '05/12/2024',
    'endDate': '25/12/2024',
  },

  {
    'id': '011',
    'title': 'Ngày hội giảm giá',
    'image': 'assets/images/highlands.png',
    'avatar': 'assets/images/logo_high.png',
    'store': 'Highlands Coffee',
    'detail': 'Ngày hội giảm giá cực lớn, lên đến 70% trên toàn quốc.',
    'voucherCount': '500',
    'voucherUsed': '440',
    'startDate': '10/12/2024',
    'endDate': '10/03/2025',
  },
  {
    'id': '012',
    'title': 'Tặng voucher 50K',
    'image': 'assets/images/toco.png',
    'avatar': 'assets/images/logo_toco.png',
    'store': 'TocoToco',
    'detail': 'Nhận ngay voucher 50K khi mua hàng trực tuyến.',
    'voucherCount': '300',
    'voucherUsed': '210',
    'startDate': '20/01/2025',
    'endDate': '20/02/2025',
  },
  {
    'id': '013',
    'title': 'Ưu đãi hội viên VIP',
    'image': 'assets/images/fashion.png',
    'avatar': 'assets/images/logo_fashion.png',
    'store': 'Fashion',
    'detail': 'Dành riêng cho khách hàng VIP với ưu đãi hấp dẫn.',
    'voucherCount': '400',
    'voucherUsed': '230',
    'startDate': '01/12/2024',
    'endDate': '12/12/2024',
  },
  {
    'id': '014',
    'title': 'Khuyến mãi lễ hội mùa xuân',
    'image': 'assets/images/katinat.png',
    'avatar': 'assets/images/logo_katinat.png',
    'store': 'KATINAT',
    'detail': 'Giảm 40% cho toàn bộ sản phẩm dịp lễ hội mùa xuân.',
    'voucherCount': '400',
    'voucherUsed': '350',
    'startDate': '01/12/2024',
    'endDate': '13/12/2024',
  },
  {
    'id': '015',
    'title': 'Tích điểm đổi quà',
    'image': 'assets/images/warrio.png',
    'avatar': 'assets/images/logo_warrio.png',
    'store': 'WARRIOR',
    'detail': 'Tích điểm ngay hôm nay để nhận quà tặng hấp dẫn.',
    'voucherCount': '400',
    'voucherUsed': '330',
    'startDate': '01/02/2025',
    'endDate': '22/02/2025',
  },
  {
    'id': '016',
    'title': 'Ưu đãi độc quyền',
    'image': 'assets/images/trasuadodo.png',
    'avatar': 'assets/images/logo_trasuadodo.png',
    'store': 'Trà Sữa Đô Đô',
    'detail': 'Ưu đãi độc quyền chỉ có tại cửa hàng Đô Đô.',
    'voucherCount': '400',
    'voucherUsed': '230',
    'startDate': '01/04/2025',
    'endDate': '25/05/2024',
  },

  {
    'id': '017',
    'title': 'Giảm giá cuối tuần',
    'image': 'assets/images/highlands.png',
    'avatar': 'assets/images/logo_high.png',
    'store': 'Highlands Coffee',
    'detail': 'Sự kiện giảm giá cực hot, kết thúc cuối tuần vừa qua.',
    'voucherCount': '150',
    'voucherUsed': '50',
    'startDate': '15/11/2024',
    'endDate': '25/11/2024',
  },
  {
    'id': '018',
    'title': 'Ưu đãi Black Friday',
    'image': 'assets/images/toco.png',
    'avatar': 'assets/images/logo_toco.png',
    'store': 'TocoToco',
    'detail': 'Khuyến mãi Black Friday đã kết thúc, hẹn gặp lại năm sau.',
    'voucherCount': '200',
    'voucherUsed': '50',
    'startDate': '20/11/2024',
    'endDate': '30/11/2024',
  },
];

void updateIndex(int newIndex) {
    currentIndex = newIndex;
    notifyListeners();
  }

  List<Map<String, String>> wishlist = [
    {
    'id': '019',  
    'title': 'Tặng voucher 50K',
    'image': 'assets/images/toco.png',
    'avatar': 'assets/images/logo_toco.png',
    'store': 'TocoToco',
    'detail': 'Nhận ngay voucher 50K khi mua hàng trực tuyến.',
    'voucherCount': '300',
    'voucherUsed': '210',
    'startDate': '12/12/2024',
    'endDate': '20/01/2025',
  },
  {
    'id': '020',
    'title': 'Ưu đãi hội viên VIP',
    'image': 'assets/images/fashion.png',
    'avatar': 'assets/images/logo_fashion.png',
    'store': 'Fashion',
    'detail': 'Dành riêng cho khách hàng VIP với ưu đãi hấp dẫn.',
    'voucherCount': '400',
    'voucherUsed': '230',
    'startDate': '01/12/2024',
    'endDate': '31/12/2024',
  },
  {
    'id': '021',
    'title': 'Khuyến mãi lễ hội mùa xuân',
    'image': 'assets/images/katinat.png',
    'avatar': 'assets/images/logo_katinat.png',
    'store': 'KATINAT',
    'detail': 'Giảm 40% cho toàn bộ sản phẩm dịp lễ hội mùa xuân.',
    'voucherCount': '400',
    'voucherUsed': '350',
    'startDate': '01/12/2024',
    'endDate': '28/12/2024',
  },
  {
    'id': '022',
    'title': 'Tặng 1 nước khi mua 2 ly',
    'image': 'assets/images/fashion.png',
    'avatar': 'assets/images/logo_fashion.png',
    'store': 'Fashion',
    'detail': 'Mua 2 ly bất kỳ tặng thêm 1 ly miễn phí chỉ trong tuần này.',
    'voucherCount': '200',
    'voucherUsed': '50',
    'startDate': '01/12/2024',
    'endDate': '20/12/2024',
  },
  {
    'id': '023',
    'title': 'Ưu đãi giờ vàng',
    'image': 'assets/images/katinat.png',
    'avatar': 'assets/images/logo_katinat.png',
    'store': 'KATINAT',
    'detail': 'Giảm 30% cho tất cả đơn hàng trong khung giờ vàng 16:00 - 18:00.',
    'voucherCount': '300',
    'voucherUsed': '110',
    'startDate': '10/12/2024',
    'endDate': '10/01/2025',
  },
  {
    'id': '024',
    'title': 'Khuyến mãi 1 tặng 1',
    'image': 'assets/images/warrio.png',
    'avatar': 'assets/images/logo_warrio.png',
    'store': 'WARRIOR',
    'detail': 'Mua 1 tặng 1 khi sử dụng voucher tại cửa hàng WARRIOR.',
    'voucherCount': '150',
    'voucherUsed': '50',
    'startDate': '02/12/2024',
    'endDate': '15/01/2024',
  },
  {
    'id': '025',
    'title': 'Đồng giá 20K',
    'image': 'assets/images/trasuadodo.png',
    'avatar': 'assets/images/logo_trasuadodo.png',
    'store': 'Trà Sữa Đô Đô',
    'detail': 'Mọi sản phẩm đồng giá 20K khi thanh toán bằng ví điện tử.',
    'voucherCount': '250',
    'voucherUsed': '150',
    'startDate': '01/12/2024',
    'endDate': '15/01/2025',
  },
  ];


  List<Map<String, String>> getOngoingEvents() {
    DateTime now = DateTime.now();
    return AllEvents.where((event) {
      DateTime startDate = DateFormat('dd/MM/yyyy').parse(event['startDate']!);
      DateTime endDate = DateFormat('dd/MM/yyyy').parse(event['endDate']!);
     
      return (now.isAfter(startDate) || now.isAtSameMomentAs(startDate)) &&
             (now.isBefore(endDate) || now.isAtSameMomentAs(endDate));
    }).toList();
  }


  List<Map<String, String>> getUpcomingEvents() {
    DateTime now = DateTime.now();
    return AllEvents.where((event) {
      DateTime startDate = DateFormat('dd/MM/yyyy').parse(event['startDate']!);
      return now.isBefore(startDate);
    }).toList();
  }

  List<Map<String, String>> getEndedEvents() {
    DateTime now = DateTime.now();
    return AllEvents.where((event) {
      DateTime endDate = DateFormat('dd/MM/yyyy').parse(event['endDate']!);
      return now.isAfter(endDate);
    }).toList();
  }

  List<Map<String, String>> getEventsByStore(String storeName) {
  DateTime now = DateTime.now();
  return AllEvents.where((event) {
    DateTime endDate = DateFormat('dd/MM/yyyy').parse(event['endDate']!);
    return event['store'] == storeName && now.isBefore(endDate);
  }).toList();
}


  
}
