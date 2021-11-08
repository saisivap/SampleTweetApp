class TweetModel {
  String userName;
  String userImageUrl;
  String tweet;
  DateTime tweetDate;
  TweetModel({
    required this.userName,
    required this.userImageUrl,
    required this.tweet,
    required this.tweetDate,
  });
}

List<TweetModel> listOfTweets = [
  TweetModel(
    userName: "Sai Mahesh",
    userImageUrl:
        "https://learnenglish.britishcouncil.org/sites/podcasts/files/styles/max_325x325/public/2021-10/RS8003_GettyImages-994576028-hig.jpg?itok=m0rIP3zI",
    tweet:
        "Rama was born to Kaushalya and Dasharatha in Ayodhya, the ruler of the Kingdom of Kosala.",
    tweetDate: DateTime(2021, 11, 07, 0, 40),
  ),
  TweetModel(
    userName: "Paruchuri",
    userImageUrl:
        "https://learnenglish.britishcouncil.org/sites/podcasts/files/styles/max_325x325/public/2021-10/RS8003_GettyImages-994576028-hig.jpg?itok=m0rIP3zI",
    tweet:
        "Rama was born to Kaushalya and Dasharatha in Ayodhya, the ruler of the Kingdom of Kosala. His siblings included Lakshmana, Bharata, and Shatrughna. He married Sita. Though born in a royal family, their life is described in the Hindu texts as one challenged by unexpected changes such as an exile into impoverished and difficult circumstances, ethical questions and moral dilemmas.",
    tweetDate: DateTime(2021, 11, 07, 0, 20),
  ),
];
