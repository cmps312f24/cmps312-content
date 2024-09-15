String asciiCharType(int char) {
  const space = 32;
  const zero = 48;
  const nine = 57;

  //Switch expression
  return switch (char) {
    < space => 'control',
    == space => 'space',
    > space && < zero => 'punctuation',
    >= zero && <= nine => 'digit',
    _ => '' 
    // _ denotes Default case
  };
}