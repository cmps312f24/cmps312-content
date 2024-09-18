void main() {
  // A list of participants, each represented as a record with 
  // a name and score
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
    The list pattern [first, second, third, ...rest, last]
    is used to destructuring the list to extract the top 3 winners
    and the last participant. Others are assigned to the rest variable
  */
  var [first, second, third, ...rest, last] = participants;
  print('Top 3 winners:');
  print('1st: ${first.name} with score ${first.score}');
  print('2nd: ${second.name} with score ${second.score}');
  print('3rd: ${third.name} with score ${third.score}');

  print('\nRemaining participants:');
  for (var participant in rest) {
    print('${participant.name} with score ${participant.score}');
  }

  print('\nLast participant:');
  print('${last.name} with score ${last.score}');
}
