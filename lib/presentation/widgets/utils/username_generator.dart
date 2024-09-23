import 'dart:math';

class UserNameGenerator {
  final Set<String> _usedUserNames = {};
  final Random _random = Random();

  String getUserName(String firstName, String lastName) {
    // Extract parts from the first and last names
    String partOfFirstName = firstName.substring(0, min(3, firstName.length)).toLowerCase();
    String partOfLastName = lastName.substring(0, min(3, lastName.length)).toLowerCase();

    // Start with a base username
    String baseUserName = "$partOfFirstName$partOfLastName";

    // Ensure the username is unique by appending a number if necessary
    String uniqueUserName = baseUserName;
    int counter = 1;
    while (_usedUserNames.contains(uniqueUserName)) {
      uniqueUserName = "$baseUserName${_random.nextInt(1000)}"; // Append a random number
      counter++;
    }

    // Add the unique username to the set to track it
    _usedUserNames.add(uniqueUserName);

    return uniqueUserName;
  }
}
