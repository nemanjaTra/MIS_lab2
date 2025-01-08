class Joke {
  final String setup;
  final String punchline;
  bool isFavorite;

  Joke({required this.setup, required this.punchline, this.isFavorite = false});

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      setup: json['setup'] as String,
      punchline: json['punchline'] as String,
      isFavorite: false,
    );
  }
}
