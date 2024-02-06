String clearPhoneNumber(String text) {
  text = text.trim().replaceAll(" ", "");

  if (text.contains("+39")) {
    text = text.replaceAll("+39", "");
  }
  if (text.startsWith("4146")) {
    text = text.substring(4);
  }
  return text.length < 10
      ? text
      : "${text.substring(0, 3)} ${text.substring(3, 6)} ${text.substring(6)}";
}
