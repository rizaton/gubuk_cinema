class MovieModels {
  final String idMovieDb;
  final String movieID;
      final String title;
      final String overview;
  final String rating;
  final String voteCount;
  final String popularity;
      final String releseDate;
      final String status;
  final String budget;
  final String revenue;
      final String genres;
      final String runtime;
      final String posterPath;
 
  MovieModels({
    required this.idMovieDb,
    required this.movieID,
        required this.title,  
        required this.overview,
    required this.rating,
    required this.voteCount,
    required this.popularity,
        required this.releseDate,
        required this.status,
    required this.budget,
    required this.revenue,
        required this.genres,
        required this.runtime,
        required this.posterPath,
    });

  factory MovieModels.fromJson(Map<String, dynamic> json) {
    List<String> tempGenres = [];
    json['genres'].forEach((genre) => tempGenres.add(genre['name']));
    return MovieModels(
      idMovieDb: json['_id'],
      movieID: '${json['id']}',
        title: json['title'],
        overview: json['overview'],
      rating: "${json['vote_average']}",
      voteCount: "${json['vote_count']}",
      popularity: "${json['popularity']}",
        releseDate: json['release_date'],
        status: json['status'],
      budget: "${json['budget']}",
      revenue: "${json['revenue']}",
        genres: tempGenres.join('_'),
        runtime: "${json['runtime']}",
        posterPath: json['poster_path'],
    );
  }
}