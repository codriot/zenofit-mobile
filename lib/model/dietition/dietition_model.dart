// ID Generator için yardımcı sınıf
class _DietitionIdGenerator {
  static int _lastId = 0;
  
  static String generateId() {
    _lastId++;
    return 'DIET_${_lastId.toString().padLeft(4, '0')}';
  }
}

class DietitionModel {
  final String id;
  final String? name;
  final String? lastName;
  final String? workBranch;
  final int? patientCount;
  final String? experienceYears;
  final double? rating;
  final String? aboutDietition;
  final String? aboutJob;
  final String? calender;
  final String? comments;
  final bool? isliked;
  final bool? isAvaible;

  DietitionModel({
      String? id,
      required this.name,
      required this.lastName,
      required this.workBranch,
      this.patientCount = 0,
      required this.experienceYears,
      this.rating = 0.0,
      this.aboutDietition,
      this.aboutJob,
      this.calender,
      this.comments,
      this.isliked = false,
      this.isAvaible = true,
  }) : id = id ?? _DietitionIdGenerator.generateId();

  // Modeli kopyalama metodu
  DietitionModel copyWith({
    String? id,
    String? name,
    String? lastname,
    String? workBranch,
    int? patientCount,
    String? experienceYears,
    double? rating,
    String? aboutDietition,
    String? aboutJob,
    String? calender,
    String? comments,
    bool? isliked,
    bool? isAvaible,
  }) {
    return DietitionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastname ?? this.lastName,
      workBranch: workBranch ?? this.workBranch,
      patientCount: patientCount ?? this.patientCount,
      experienceYears: experienceYears ?? this.experienceYears,
      rating: rating ?? this.rating,
      aboutDietition: aboutDietition ?? this.aboutDietition,
      aboutJob: aboutJob ?? this.aboutJob,
      calender: calender ?? this.calender,
      comments: comments ?? this.comments,
      isliked: isliked ?? this.isliked,
      isAvaible: isAvaible ?? this.isAvaible,
    );
  }

  // JSON dönüşümleri için
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lastname': lastName,
      'workBranch': workBranch,
      'patientCount': patientCount,
      'experienceYears': experienceYears,
      'rating': rating,
      'aboutDietition': aboutDietition,
      'aboutJob': aboutJob,
      'calender': calender,
      'comments': comments,
      'isliked': isliked,
      'isAvaible': isAvaible,
    };
  }

  factory DietitionModel.fromJson(Map<String, dynamic> json) {
    return DietitionModel(
      id: json['id'],
      name: json['name'],
      lastName: json['lastname'],
      workBranch: json['workBranch'],
      patientCount: json['patientCount'],
      experienceYears: json['experienceYears'],
      rating: json['rating'],
      aboutDietition: json['aboutDietition'],
      aboutJob: json['aboutJob'],
      calender: json['calender'],
      comments: json['comments'],
      isliked: json['isliked'],
      isAvaible: json['isAvaible'],
    );
  }
}


//card modeli için abstract class alıp ondan türet ortakları ordan al!