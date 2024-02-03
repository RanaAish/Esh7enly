// ignore_for_file: unnecessary_new, unnecessary_this, prefer_collection_literals, camel_case_types

class Datatransaction {
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? total;
  List<tranaction>? data;

  Datatransaction(
      {this.currentPage, this.lastPage, this.perPage, this.total, this.data});

  Datatransaction.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    perPage = json['per_page'];
    total = json['total'];
    if (json['data'] != null) {
      data = <tranaction>[];
      json['data'].forEach((v) {
        data!.add(new tranaction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['last_page'] = this.lastPage;
    data['per_page'] = this.perPage;
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class tranaction {
  int? id;
  Service? service;
  Provider? provider;
  int? type;
  int? status;
  int? statusCode;
  String? message;
 String ? clientNumber;
  String? amount;
  String? totalAmount;
  String? paidAmount;
  String? merchantCommission;
  String? createdAt;

  tranaction(
      {this.id,
      this.service,
      this.provider,
      this.type,
      this.status,
      this.statusCode,
      this.message,
      this.clientNumber,
      this.amount,
      this.totalAmount,
      this.paidAmount,
      this.merchantCommission,
      this.createdAt});

  tranaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
    provider = json['provider'] != null
        ? new Provider.fromJson(json['provider'])
        : null;
    type = json['type'];
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    clientNumber = json['client_number'];
    amount = json['amount'];
    totalAmount = json['total_amount'];
    paidAmount = json['paid_amount'];
    merchantCommission = json['merchant_commission'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    if (this.provider != null) {
      data['provider'] = this.provider!.toJson();
    }
    data['type'] = this.type;
    data['status'] = this.status;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    data['client_number'] = this.clientNumber;
    data['amount'] = this.amount;
    data['total_amount'] = this.totalAmount;
    data['paid_amount'] = this.paidAmount;
    data['merchant_commission'] = this.merchantCommission;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Service {
  int? id;
  String? name;
  String? icon;

  Service({this.id, this.name, this.icon});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['icon'] = this.icon;
    return data;
  }
}

class Provider {
  int? id;
  String? name;
  String? logo;

  Provider({this.id, this.name, this.logo});

  Provider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    return data;
  }
}
