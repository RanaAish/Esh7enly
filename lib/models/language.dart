// ignore_for_file: camel_case_types

class languge {
  final int id;
  final String name;
  final String languagecode;

  languge(this.id, this.name, this.languagecode);
  static List<languge> languageslist() {
    return <languge>[languge(1, 'English', 'en'), languge(2, 'العربيه', 'ar')];
  }
}
