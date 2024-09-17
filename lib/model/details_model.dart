class DetailsModel {
  int? id;
  String? firstName;
  String? lastName;
  String? maidenName;
  int? age;
  String? gender;
  String? email;
  String? phone;
  String? username;
  String? password;
  String? birthDate;
  String? image;
  String? bloodGroup;
  double? height;
  dynamic weight;
  String? eyeColor;
  Hair? hair;
  String? ip;
  Address? address;
  String? macAddress;
  String? university;
  Bank? bank;
  Company? company;
  String? ein;
  String? ssn;
  String? userAgent;
  Crypto? crypto;
  String? role;

  DetailsModel(
      {id,
        firstName,
        lastName,
        maidenName,
        age,
        gender,
        email,
        phone,
        username,
        password,
        birthDate,
        image,
        bloodGroup,
        height,
        weight,
        eyeColor,
        hair,
        ip,
        address,
        macAddress,
        university,
        bank,
        company,
        ein,
        ssn,
        userAgent,
        crypto,
        role});

  DetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    maidenName = json['maidenName'];
    age = json['age'];
    gender = json['gender'];
    email = json['email'];
    phone = json['phone'];
    username = json['username'];
    password = json['password'];
    birthDate = json['birthDate'];
    image = json['image'];
    bloodGroup = json['bloodGroup'];
    height = json['height'];
    weight = json['weight'];
    eyeColor = json['eyeColor'];
    hair = json['hair'] != null ?  Hair.fromJson(json['hair']) : null;
    ip = json['ip'];
    address =
    json['address'] != null ?  Address.fromJson(json['address']) : null;
    macAddress = json['macAddress'];
    university = json['university'];
    bank = json['bank'] != null ?  Bank.fromJson(json['bank']) : null;
    company =
    json['company'] != null ?  Company.fromJson(json['company']) : null;
    ein = json['ein'];
    ssn = json['ssn'];
    userAgent = json['userAgent'];
    crypto =
    json['crypto'] != null ?  Crypto.fromJson(json['crypto']) : null;
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['maidenName'] = maidenName;
    data['age'] = age;
    data['gender'] = gender;
    data['email'] = email;
    data['phone'] = phone;
    data['username'] = username;
    data['password'] = password;
    data['birthDate'] = birthDate;
    data['image'] = image;
    data['bloodGroup'] = bloodGroup;
    data['height'] = height;
    data['weight'] = weight;
    data['eyeColor'] = eyeColor;
    if (hair != null) {
      data['hair'] = hair!.toJson();
    }
    data['ip'] = ip;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['macAddress'] = macAddress;
    data['university'] = university;
    if (bank != null) {
      data['bank'] = bank!.toJson();
    }
    if (company != null) {
      data['company'] = company!.toJson();
    }
    data['ein'] = ein;
    data['ssn'] = ssn;
    data['userAgent'] = userAgent;
    if (crypto != null) {
      data['crypto'] = crypto!.toJson();
    }
    data['role'] = role;
    return data;
  }
}

class Hair {
  String? color;
  String? type;

  Hair({color, type});

  Hair.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['color'] = color;
    data['type'] = type;
    return data;
  }
}

class Address {
  String? address;
  String? city;
  String? state;
  String? stateCode;
  String? postalCode;
  Coordinates? coordinates;
  String? country;

  Address(
      {address,
        city,
        state,
        stateCode,
        postalCode,
        coordinates,
        country});

  Address.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    city = json['city'];
    state = json['state'];
    stateCode = json['stateCode'];
    postalCode = json['postalCode'];
    coordinates = json['coordinates'] != null
        ?  Coordinates.fromJson(json['coordinates'])
        : null;
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['stateCode'] = stateCode;
    data['postalCode'] = postalCode;
    if (coordinates != null) {
      data['coordinates'] = coordinates!.toJson();
    }
    data['country'] = country;
    return data;
  }
}

class Coordinates {
  double? lat;
  double? lng;

  Coordinates({lat, lng});

  Coordinates.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

class Bank {
  String? cardExpire;
  String? cardNumber;
  String? cardType;
  String? currency;
  String? iban;

  Bank(
      {cardExpire,
        cardNumber,
        cardType,
        currency,
        iban});

  Bank.fromJson(Map<String, dynamic> json) {
    cardExpire = json['cardExpire'];
    cardNumber = json['cardNumber'];
    cardType = json['cardType'];
    currency = json['currency'];
    iban = json['iban'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['cardExpire'] = cardExpire;
    data['cardNumber'] = cardNumber;
    data['cardType'] = cardType;
    data['currency'] = currency;
    data['iban'] = iban;
    return data;
  }
}

class Company {
  String? department;
  String? name;
  String? title;
  Address? address;

  Company({department, name, title, address});

  Company.fromJson(Map<String, dynamic> json) {
    department = json['department'];
    name = json['name'];
    title = json['title'];
    address =
    json['address'] != null ?  Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['department'] = department;
    data['name'] = name;
    data['title'] = title;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    return data;
  }
}

class Crypto {
  String? coin;
  String? wallet;
  String? network;

  Crypto({coin, wallet, network});

  Crypto.fromJson(Map<String, dynamic> json) {
    coin = json['coin'];
    wallet = json['wallet'];
    network = json['network'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['coin'] = coin;
    data['wallet'] = wallet;
    data['network'] = network;
    return data;
  }
}
