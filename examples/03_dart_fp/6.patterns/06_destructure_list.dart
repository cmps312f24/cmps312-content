void main() {
  // A list of participants, each represented as a record with a name and score
  List<({String name, int score})> participants = [
    (name: 'Mr Perfect', score: 9),
    (name: 'Mujtahid', score: 8),
    (name: 'Mujtahida', score: 10),
    (name: 'Kasul', score: 3),
    (name: 'Gamer', score: 5),
    (name: 'Movie Lover', score: 6),
    ];

  participants.sort((p1, p2) => p2.score.compareTo(p1.score));

  /*
    The list pattern[var winner1, var winner2, var winner3, ... var rest]
    is used to destructuring the list to extract the top 3 winners
    This can be useful when you need specific parts of a list.
  */
  if (participants case [var winner1, var winner2, var winner3, ... var rest, var last]) {
    print('Top 3 winners:');
    print('1st: ${winner1.name} with score ${winner1.score}');
    print('2nd: ${winner2.name} with score ${winner2.score}');
    print('3rd: ${winner3.name} with score ${winner3.score}');
    
    print('\nRemaining participants:');
    for (var participant in rest) {
      print('${participant.name} with score ${participant.score}');
    }

    print('\nLast participant:');
    print('${last.name} with score ${last.score}');
  } else {
    print('Not enough participants to determine top 3 winners.');
  }
}