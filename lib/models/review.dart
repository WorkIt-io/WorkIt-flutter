

class Review{
  final String id;
  final String title;
  final String text;
  final int rate;

  Review(this.id, this.title, this.text, this.rate);

  factory Review.fromMap(Map<String, dynamic> map)
  {
    return Review(map['id'], map['title'], map['text'], map['rate']);
  } 

  Map<String, dynamic> toMap()
  {
    return {
      'id': id,
      'title': title,
      'text': text,
      'rate': rate
    };
  }
  
}