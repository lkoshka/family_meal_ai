enum Gender { female, male }

enum AgeCategory { infant, child, adolescent, adult, olderAdult }

class FamilyMember {
  final int id;
  final String name;
  final DateTime birthDate;
  final Gender gender;
  final double heightCm;
  final double weightKg;

  FamilyMember({
    required this.id,
    required this.name,
    required this.birthDate,
    required this.gender,
    required this.heightCm,
    required this.weightKg,
  });

  int get age {
    final today = DateTime.now();

    int result = today.year - birthDate.year;

    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      result--;
    }

    return result;
  }

  AgeCategory get ageCategory {
    if (age < 2) {
      return AgeCategory.infant;
    }

    if (age < 12) {
      return AgeCategory.child;
    }

    if (age < 18) {
      return AgeCategory.adolescent;
    }

    if (age < 65) {
      return AgeCategory.adult;
    }

    return AgeCategory.olderAdult;
  }

  double get bmi {
    final heightM = heightCm / 100;

    return weightKg / (heightM * heightM);
  }
}
