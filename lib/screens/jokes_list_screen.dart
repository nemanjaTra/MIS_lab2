import 'package:flutter/material.dart';
import '../models/joke_model.dart';
import '../services/api_services.dart';

class JokesListScreen extends StatefulWidget {
  final String type;

  const JokesListScreen({super.key, required this.type});

  @override
  _JokesListScreenState createState() => _JokesListScreenState();
}

class _JokesListScreenState extends State<JokesListScreen> {
  late Future<List<Joke>> jokesFuture;
  late List<Joke> jokes;

  @override
  void initState() {
    super.initState();
    jokesFuture = ApiService.fetchJokesByType(widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.type} Jokes'),
      ),
      body: FutureBuilder<List<Joke>>(
        future: jokesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            jokes = snapshot.data!;
            return ListView.builder(
              itemCount: jokes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(jokes[index].setup),
                  subtitle: Text(jokes[index].punchline),
                  trailing: IconButton(
                    icon: Icon(
                      jokes[index].isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: jokes[index].isFavorite ? Colors.red : null,
                    ),
                    onPressed: () {
                      setState(() {
                        jokes[index].isFavorite = !jokes[index].isFavorite;
                      });
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
