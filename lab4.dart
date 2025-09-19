// lab4.dart
// Solutions: Lab 4 (4 tasks per section) — Dart console exercises
// Tested to be simple, self-contained. Run with: dart lab4.dart

import 'dart:async';
import 'dart:convert';

//
// ---------- CLASSES (Tasks 2..5) ----------
//

class Book {
  String title;
  String author;
  int numberOfPages;
  Book(this.title, this.author, this.numberOfPages);

  @override
  String toString() =>
      'Book(title: "$title", author: "$author", pages: $numberOfPages)';
}

class Student {
  String name;
  int age;
  List<double> grades;
  Student(this.name, this.age, this.grades);

  double calculateAverageGrade() {
    if (grades.isEmpty) return 0.0;
    var sum = grades.reduce((a, b) => a + b);
    return sum / grades.length;
  }

  @override
  String toString() =>
      'Student(name: $name, age: $age, avg: ${calculateAverageGrade().toStringAsFixed(2)})';
}

class BankAccount {
  String accountNumber;
  String accountHolderName;
  double balance;
  BankAccount(this.accountNumber, this.accountHolderName, [this.balance = 0.0]);

  void deposit(double amount) {
    if (amount <= 0) {
      print('Deposit amount must be positive.');
      return;
    }
    balance += amount;
    print('Deposited \$${amount.toStringAsFixed(2)}. New balance: \$${balance.toStringAsFixed(2)}');
  }

  void withdraw(double amount) {
    if (amount <= 0) {
      print('Withdraw amount must be positive.');
      return;
    }
    if (amount > balance) {
      print('Error: Insufficient funds. Current balance: \$${balance.toStringAsFixed(2)}');
      return;
    }
    balance -= amount;
    print('Withdrew \$${amount.toStringAsFixed(2)}. New balance: \$${balance.toStringAsFixed(2)}');
  }

  @override
  String toString() =>
      'BankAccount($accountNumber, holder: $accountHolderName, balance: \$${balance.toStringAsFixed(2)})';
}

class Rectangle {
  double width, height;
  Rectangle(this.width, this.height);
  double get area => width * height;
  double get perimeter => 2 * (width + height);
  @override
  String toString() => 'Rectangle(w:$width,h:$height,area:${area.toStringAsFixed(2)},perim:${perimeter.toStringAsFixed(2)})';
}

//
// ---------- ENUMS (Tasks 2..5) ----------
//

enum OrderStatus { pending, processing, shipped, delivered, cancelled }

enum TrafficLight { red, yellow, green }

extension TrafficLightDuration on TrafficLight {
  int get durationInSeconds {
    switch (this) {
      case TrafficLight.red:
        return 30;
      case TrafficLight.yellow:
        return 5;
      case TrafficLight.green:
        return 45;
    }
  }

  String get recommendedAction {
    switch (this) {
      case TrafficLight.red:
        return 'Stop';
      case TrafficLight.yellow:
        return 'Caution';
      case TrafficLight.green:
        return 'Go';
    }
  }
}

enum UserRole { admin, editor, guest }

class User {
  String name;
  UserRole role;
  User(this.name, this.role);

  bool hasEditPermission() => role == UserRole.admin || role == UserRole.editor;

  @override
  String toString() => 'User($name, role: $role)';
}

//
// ---------- INHERITANCE (Tasks 2..5) ----------
//

class Animal {
  void makeSound() {
    print('Some generic animal sound');
  }
}

class Dog extends Animal {
  @override
  void makeSound() => print('Woof!');
}

class Cat extends Animal {
  @override
  void makeSound() => print('Meow!');
}

class ShapeBase {
  String color;
  ShapeBase(this.color);
}

class Circle extends ShapeBase {
  double radius;
  Circle(this.radius, String color) : super(color);
  double get area => 3.141592653589793 * radius * radius;
}

class Square extends ShapeBase {
  double sideLength;
  Square(this.sideLength, String color) : super(color);
  double get area => sideLength * sideLength;
}

class Employee {
  String name;
  double baseSalary;
  Employee(this.name, this.baseSalary);
  double calculateSalary() => baseSalary;
  @override
  String toString() => 'Employee($name, salary: \$${calculateSalary().toStringAsFixed(2)})';
}

class Manager extends Employee {
  double bonus;
  Manager(String name, double baseSalary, this.bonus) : super(name, baseSalary);
  @override
  double calculateSalary() => baseSalary + bonus;
}

abstract class LibraryItem {
  String title;
  String id;
  LibraryItem(this.title, this.id);
  String getDetails();
}

class BookItem extends LibraryItem {
  String author;
  BookItem(String title, String id, this.author) : super(title, id);
  @override
  String getDetails() => 'Book: $title (id: $id), author: $author';
}

class DVDItem extends LibraryItem {
  String director;
  DVDItem(String title, String id, this.director) : super(title, id);
  @override
  String getDetails() => 'DVD: $title (id: $id), director: $director';
}

//
// ---------- MIXINS (Tasks 2..5) ----------
//

mixin Flyer {
  void fly() => print('Taking off!');
}

class Bird with Flyer {
  String species;
  Bird(this.species);
}

class Plane with Flyer {
  String model;
  Plane(this.model);
}

mixin Logger {
  void log(String message) => print('[LOG] $message');
}

class DataService with Logger {
  void fetchData() => log('Fetching data');
}

mixin Validator {
  bool isEmailValid(String email) {
    // very simple validation
    return email.contains('@') && email.contains('.');
  }

  bool isPasswordStrong(String password) {
    return password.length >= 8;
  }
}

class UserSignup with Validator {
  void validate(String email, String password) {
    print('Email "$email" valid: ${isEmailValid(email)}');
    print('Password strong: ${isPasswordStrong(password)}');
  }
}

mixin Performer {
  void perform() => print('Performing...');
}

mixin Musician {
  void playInstrument() => print('Playing an instrument...');
}

class Artist {
  String name;
  Artist(this.name);
}

class Dancer extends Artist with Performer {
  Dancer(String name) : super(name);
}

class Guitarist extends Artist with Performer, Musician {
  Guitarist(String name) : super(name);
}

//
// ---------- POLYMORPHISM (Tasks 2..5) ----------
//

class Weapon {
  void action() => print('Weapon used');
}

class Sword extends Weapon {
  @override
  void action() => print('Swinging!');
}

class Bow extends Weapon {
  @override
  void action() => print('Firing!');
}

class AnimalPoly {
  void eat() => print('Animal eats');
}

class Lion extends AnimalPoly {
  @override
  void eat() => print('Eating meat.');
}

class Goat extends AnimalPoly {
  @override
  void eat() => print('Eating grass.');
}

abstract class PaymentMethod {
  void pay(double amount);
}

class CreditCard implements PaymentMethod {
  @override
  void pay(double amount) => print('Paid \$${amount.toStringAsFixed(2)} with Credit Card.');
}

class PayPal implements PaymentMethod {
  @override
  void pay(double amount) => print('Paid \$${amount.toStringAsFixed(2)} via PayPal.');
}

abstract class DataFormatter {
  String format(Map<String, dynamic> data);
}

class JSONFormatter implements DataFormatter {
  @override
  String format(Map<String, dynamic> data) => jsonEncode(data);
}

class KeyValueFormatter implements DataFormatter {
  @override
  String format(Map<String, dynamic> data) {
    return data.entries.map((e) => '${e.key}: ${e.value}').join('\n');
  }
}

//
// ---------- ASYNC (Tasks 2..5) ----------
//

Future<String> reportFuture() {
  return Future.delayed(Duration(seconds: 1), () => 'Report generated!');
}

Future<String> reportAsync() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Report generated!';
}

Future<int> fetchUserId() async {
  await Future.delayed(Duration(seconds: 1));
  return 123;
}

Future<String> fetchUserDetails(int userId) async {
  await Future.delayed(Duration(seconds: 1));
  return 'User#$userId: Alice';
}

Future<Map<String, dynamic>> fetchConfiguration() async {
  await Future.delayed(Duration(seconds: 1));
  return {'config': 'ok'};
}

Future<Map<String, dynamic>> loadResources() async {
  await Future.delayed(Duration(seconds: 2));
  return {'resources': 'ready'};
}

//
// ---------- EXCEPTIONS (Tasks 2..5) ----------
//

void printAtIndex(List list, int index) {
  try {
    print('Element at $index is: ${list[index]}');
  } on RangeError {
    print('Error: Invalid index.');
  } catch (e) {
    print('Unexpected error: $e');
  }
}

void parseAge(String input) {
  try {
    var age = int.parse(input);
    print('Parsed age: $age');
  } on FormatException {
    print('FormatException: Invalid number format for age.');
  } catch (e) {
    print('Unexpected parse error: $e');
  }
}

class InvalidInputException implements Exception {
  final String message;
  InvalidInputException(this.message);
  @override
  String toString() => 'InvalidInputException: $message';
}

void processText(String text) {
  if (text.trim().isEmpty) throw InvalidInputException('Input text is empty');
  print('Processed text: ${text.trim()}');
}

void simulateDatabaseOperation(bool throwError) {
  try {
    print('Opening connection...');
    if (throwError) throw Exception('Read error');
    print('Read data successfully.');
  } catch (e) {
    print('Caught error: $e');
  } finally {
    print('Database connection closed.');
  }
}

//
// ---------- MAIN: run small demos for each selected task ----------
//

Future<void> main() async {
  print('=== Lab4: selected tasks demo ===\n');

  // CLASSES
  print('--- CLASSES ---');
  var book = Book('Dart in Action', 'John Doe', 250);
  print(book);
  var student = Student('Bob', 20, [4.0, 3.5, 5.0]);
  print(student);
  var acct = BankAccount('ACC123', 'Bob', 50.0);
  acct.deposit(25.5);
  acct.withdraw(100); // should show error due to insufficient funds
  acct.withdraw(10);
  var rect = Rectangle(3.0, 4.0);
  print(rect);
  print('');

  // ENUMS
  print('--- ENUMS ---');
  OrderStatus status = OrderStatus.processing;
  print('Order status: $status');
  for (var light in TrafficLight.values) {
    print('${light.toString().split(".").last}: ${light.recommendedAction}, duration ${light.durationInSeconds}s');
  }
  var u1 = User('Anna', UserRole.editor);
  var u2 = User('GuestGuy', UserRole.guest);
  print('${u1.name} can edit: ${u1.hasEditPermission()}');
  print('${u2.name} can edit: ${u2.hasEditPermission()}');
  print('');

  // INHERITANCE
  print('--- INHERITANCE ---');
  Animal dog = Dog();
  Animal cat = Cat();
  dog.makeSound();
  cat.makeSound();
  var circle = Circle(2.5, 'red');
  var square = Square(3.0, 'blue');
  print('Circle area: ${circle.area.toStringAsFixed(2)}, color: ${circle.color}');
  print('Square area: ${square.area.toStringAsFixed(2)}, color: ${square.color}');
  var emp = Employee('Sam', 2000);
  var mgr = Manager('Dana', 3000, 500);
  print(emp);
  print(mgr);
  var bItem = BookItem('Clean Code', 'B001', 'R. Martin');
  var dItem = DVDItem('Inception', 'D001', 'Nolan');
  print(bItem.getDetails());
  print(dItem.getDetails());
  print('');

  // MIXINS
  print('--- MIXINS ---');
  var bird = Bird('Sparrow');
  var plane = Plane('Boeing');
  bird.fly();
  plane.fly();
  var ds = DataService();
  ds.fetchData();
  var signup = UserSignup();
  signup.validate('test@example.com', '12345678');
  var dancer = Dancer('Ivy');
  var guitar = Guitarist('Leo');
  dancer.perform();
  guitar.perform();
  guitar.playInstrument();
  print('');

  // POLYMORPHISM
  print('--- POLYMORPHISM ---');
  List<Weapon> weapons = [Sword(), Bow()];
  for (var w in weapons) w.action();
  feedAnimal(Lion());
  feedAnimal(Goat());
  PaymentMethod pm1 = CreditCard();
  PaymentMethod pm2 = PayPal();
  processPayment(pm1, 49.99);
  processPayment(pm2, 19.99);
  var data = {'name': 'Alice', 'age': 30};
  List<DataFormatter> formatters = [JSONFormatter(), KeyValueFormatter()];
  for (var f in formatters) {
    print('Formatted:\n${f.format(data)}');
  }
  print('');

  // ASYNC
  print('--- ASYNC ---');
  // Task 2: .then()
  reportFuture().then((res) => print('Then: $res'));
  // Task 3: async/await
  var res = await reportAsync();
  print('Async/await: $res');
  // Task 4: chaining
  var id = await fetchUserId();
  var details = await fetchUserDetails(id);
  print('Chained: $details');
  // Task 5: concurrent futures
  var results = await Future.wait([fetchConfiguration(), loadResources()]);
  print('Concurrent results: ${results.length} items -> ${results}');
  print('');

  // EXCEPTIONS
  print('--- EXCEPTIONS ---');
  printAtIndex([1, 2, 3], 2);
  printAtIndex([1, 2, 3], 5); // RangeError
  parseAge('25');
  parseAge('abc'); // FormatException
  try {
    processText('  Hello world  ');
    processText('   '); // should throw InvalidInputException
  } catch (e) {
    print('Handled custom exception: $e');
  }
  simulateDatabaseOperation(false);
  simulateDatabaseOperation(true);

  // Wait a short moment to allow pending .then() prints (from reportFuture)
  await Future.delayed(Duration(milliseconds: 500));

  print('\n=== Demo finished ===');
}

// helper functions for polymorphism demo
void feedAnimal(AnimalPoly animal) => animal.eat();
void processPayment(PaymentMethod pm, double amount) => pm.pay(amount);
