abstract class MealApiInterface {
  void getMeals(
    Function callback,
    Function onError,
  );
  void getProgram(
    Function callback,
    Function onError,
  );
  void getSpecial(
    Function callback,
    Function onError,
  );
}
