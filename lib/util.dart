String replaceWithKannadaNumber(String input) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const kannada = ['೦', '೧', '೨', '೩', '೪', '೫', '೬', '೭', '೮', '೯'];

  for (int i = 0; i < english.length; i++) {
    input = input.replaceAll(english[i], kannada[i]);
  }

  return input;
}
