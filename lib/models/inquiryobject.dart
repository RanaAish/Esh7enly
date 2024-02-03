// ignore_for_file: unnecessary_new, prefer_typing_uninitialized_variables, prefer_collection_literals, unnecessary_this

class Inquiryobject {
  bool? status;
  int? code;
  String? message;
  Data? data;
  Version? version;
  List<PosBrand>? posBrand;

  Inquiryobject(
      {this.status,
      this.code,
      this.message,
      this.data,
      this.version,
      this.posBrand});

  Inquiryobject.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    version =
        json['version'] != null ? new Version.fromJson(json['version']) : null;
    if (json['pos_brand'] != null) {
      posBrand = <PosBrand>[];
      json['pos_brand'].forEach((v) {
        posBrand!.add(new PosBrand.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.version != null) {
      data['version'] = this.version!.toJson();
    }
    if (this.posBrand != null) {
      data['pos_brand'] = this.posBrand!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  var id;
  IntegrationProvider? integrationProvider;
  Service? service;
  Merchant? merchant;
  var type;
  var inquiryTransactionId;
  var externalTransactionId;
  var status;
  var statusCode;
  var message;
  var clientNumber;
  var amount;
  var serviceCharge;
  var totalAmount;
  var paidAmount;
  var minAmount;
  var maxAmount;
  var isPaid;
  var providerTransactionId;
  var integrationProviderAmount;
  var integrationProviderBalance;
  var integrationProviderCommission;
  RequestMap? requestMap;
  var validationError;
  var request;
  var response;
  var description;
  List? extraData;
  String? ip;
  String? userAgent;
  var requestDuration;
  var imei;
  var systemCommission;
  var extraSystemCommission;
  var agentCommission;
  var merchantCommission;
  var staffId;
  var parentMerchantId;
  var firstParentMerchantId;
  var settlementType;
  var isSettled;
  var settlementWalletTransactionId;
  var createdAt;
  var canceledAt;
  var updatedAt;
  List<Parameters>? parameters;
  var balanceBefore;
  var balanceAfter;

  Data(
      {this.id,
      this.integrationProvider,
      this.service,
      this.merchant,
      this.type,
      this.inquiryTransactionId,
      this.externalTransactionId,
      this.status,
      this.statusCode,
      this.message,
      this.clientNumber,
      this.amount,
      this.serviceCharge,
      this.totalAmount,
      this.paidAmount,
      this.minAmount,
      this.maxAmount,
      this.isPaid,
      this.providerTransactionId,
      this.integrationProviderAmount,
      this.integrationProviderBalance,
      this.integrationProviderCommission,
      this.requestMap,
      this.validationError,
      this.request,
      this.response,
      this.description,
      this.extraData,
      this.ip,
      this.userAgent,
      this.requestDuration,
      this.imei,
      this.systemCommission,
      this.extraSystemCommission,
      this.agentCommission,
      this.merchantCommission,
      this.staffId,
      this.parentMerchantId,
      this.firstParentMerchantId,
      this.settlementType,
      this.isSettled,
      this.settlementWalletTransactionId,
      this.createdAt,
      this.canceledAt,
      this.updatedAt,
      this.parameters,
      this.balanceBefore,
      this.balanceAfter});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    integrationProvider = json['integration_provider'] != null
        ? new IntegrationProvider.fromJson(json['integration_provider'])
        : null;
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
    merchant = json['merchant'] != null
        ? new Merchant.fromJson(json['merchant'])
        : null;
    type = json['type'];
    inquiryTransactionId = json['inquiry_transaction_id'];
    externalTransactionId = json['external_transaction_id'];
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    clientNumber = json['client_number'];
    amount = json['amount'];
    serviceCharge = json['service_charge'];
    totalAmount = json['total_amount'];
    paidAmount = json['paid_amount'];
    minAmount = json['min_amount'];
    maxAmount = json['max_amount'];
    isPaid = json['is_paid'];
    providerTransactionId = json['provider_transaction_id'];
    integrationProviderAmount = json['integration_provider_amount'];
    integrationProviderBalance = json['integration_provider_balance'];
    integrationProviderCommission = json['integration_provider_commission'];
    requestMap = json['request_map'] != null
        ? new RequestMap.fromJson(json['request_map'])
        : null;
    validationError = json['validation_error'];
    request = json['request'];
    response = json['response'];
    description = json['description'];
    if (json['extra_data'] != null) {
      extraData = <Null>[];
      json['extra_data'].forEach((v) {
        //  extraData!.add(new Null.fromJson(v));
      });
    }
    ip = json['ip'];
    userAgent = json['user_agent'];
    requestDuration = json['request_duration'];
    imei = json['imei'];
    systemCommission = json['system_commission'];
    extraSystemCommission = json['extra_system_commission'];
    agentCommission = json['agent_commission'];
    merchantCommission = json['merchant_commission'];
    staffId = json['staff_id'];
    parentMerchantId = json['parent_merchant_id'];
    firstParentMerchantId = json['first_parent_merchant_id'];
    settlementType = json['settlement_type'];
    isSettled = json['is_settled'];
    settlementWalletTransactionId = json['settlement_wallet_transaction_id'];
    createdAt = json['created_at'];
    canceledAt = json['canceled_at'];
    updatedAt = json['updated_at'];
    if (json['parameters'] != null) {
      parameters = <Parameters>[];
      json['parameters'].forEach((v) {
        parameters!.add(new Parameters.fromJson(v));
      });
    }
    balanceBefore = json['balance_before'];
    balanceAfter = json['balance_after'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.integrationProvider != null) {
      data['integration_provider'] = this.integrationProvider!.toJson();
    }
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    if (this.merchant != null) {
      data['merchant'] = this.merchant!.toJson();
    }
    data['type'] = this.type;
    data['inquiry_transaction_id'] = this.inquiryTransactionId;
    data['external_transaction_id'] = this.externalTransactionId;
    data['status'] = this.status;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    data['client_number'] = this.clientNumber;
    data['amount'] = this.amount;
    data['service_charge'] = this.serviceCharge;
    data['total_amount'] = this.totalAmount;
    data['paid_amount'] = this.paidAmount;
    data['min_amount'] = this.minAmount;
    data['max_amount'] = this.maxAmount;
    data['is_paid'] = this.isPaid;
    data['provider_transaction_id'] = this.providerTransactionId;
    data['integration_provider_amount'] = this.integrationProviderAmount;
    data['integration_provider_balance'] = this.integrationProviderBalance;
    data['integration_provider_commission'] =
        this.integrationProviderCommission;
    if (this.requestMap != null) {
      data['request_map'] = this.requestMap!.toJson();
    }
    data['validation_error'] = this.validationError;
    data['request'] = this.request;
    data['response'] = this.response;
    data['description'] = this.description;

    data['ip'] = this.ip;
    data['user_agent'] = this.userAgent;
    data['request_duration'] = this.requestDuration;
    data['imei'] = this.imei;
    data['system_commission'] = this.systemCommission;
    data['extra_system_commission'] = this.extraSystemCommission;
    data['agent_commission'] = this.agentCommission;
    data['merchant_commission'] = this.merchantCommission;
    data['staff_id'] = this.staffId;
    data['parent_merchant_id'] = this.parentMerchantId;
    data['first_parent_merchant_id'] = this.firstParentMerchantId;
    data['settlement_type'] = this.settlementType;
    data['is_settled'] = this.isSettled;
    data['settlement_wallet_transaction_id'] =
        this.settlementWalletTransactionId;
    data['created_at'] = this.createdAt;
    data['canceled_at'] = this.canceledAt;
    data['updated_at'] = this.updatedAt;
    if (this.parameters != null) {
      data['parameters'] = this.parameters!.map((v) => v.toJson()).toList();
    }
    data['balance_before'] = this.balanceBefore;
    data['balance_after'] = this.balanceAfter;
    return data;
  }
}

class IntegrationProvider {
  int? id;
  String? name;
  var description;

  IntegrationProvider({this.id, this.name, this.description});

  IntegrationProvider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}

class Service {
  int? id;
  String? name;
  var description;
  var footerDescription;
  var poweredBy;
  int? type;
  Provider? provider;
  Category? category;

  Service(
      {this.id,
      this.name,
      this.description,
      this.footerDescription,
      this.poweredBy,
      this.type,
      this.provider,
      this.category});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    footerDescription = json['footer_description'];
    poweredBy = json['powered_by'];
    type = json['type'];
    provider = json['provider'] != null
        ? new Provider.fromJson(json['provider'])
        : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['footer_description'] = this.footerDescription;
    data['powered_by'] = this.poweredBy;
    data['type'] = this.type;
    if (this.provider != null) {
      data['provider'] = this.provider!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class Provider {
  int? id;
  String? name;
  var description;
  String? logo;

  Provider({this.id, this.name, this.description, this.logo});

  Provider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['logo'] = this.logo;
    return data;
  }
}

class Category {
  int? id;
  String? name;
  var description;
  String? icon;

  Category({this.id, this.name, this.description, this.icon});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['icon'] = this.icon;
    return data;
  }
}

class Merchant {
  int? id;
  String? storeName;
  String? name;

  Merchant({this.id, this.storeName, this.name});

  Merchant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeName = json['store_name'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_name'] = this.storeName;
    data['name'] = this.name;
    return data;
  }
}

class RequestMap {
  String? s3346;

  RequestMap({this.s3346});

  RequestMap.fromJson(Map<String, dynamic> json) {
    s3346 = json['3346'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['3346'] = this.s3346;
    return data;
  }
}

class Parameters {
  String? internalId;
  String? key;
  String? value;
  String? displayName;

  Parameters({this.internalId, this.key, this.value, this.displayName});

  Parameters.fromJson(Map<String, dynamic> json) {
    internalId = json['internal_id'];
    key = json['key'];
    value = json['value'];
    displayName = json['display_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['internal_id'] = this.internalId;
    data['key'] = this.key;
    data['value'] = this.value;
    data['display_name'] = this.displayName;
    return data;
  }
}

class Version {
  String? api;
  String? service;
  String? app;

  Version({this.api, this.service, this.app});

  Version.fromJson(Map<String, dynamic> json) {
    api = json['api'];
    service = json['service'];
    app = json['app'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api'] = this.api;
    data['service'] = this.service;
    data['app'] = this.app;
    return data;
  }
}

class PosBrand {
  int? id;
  String? appVersion;

  PosBrand({this.id, this.appVersion});

  PosBrand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appVersion = json['app_version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['app_version'] = this.appVersion;
    return data;
  }
}
