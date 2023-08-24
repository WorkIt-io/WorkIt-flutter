

class Review{
  final String id;
  final String title;
  final String text;
  final int rate;

  Review({required this.id, required this.title, required this.text, required this.rate});

  factory Review.fromMap(Map<String, dynamic> map)
  {
    return Review(id: map['id'], title: map['title'],text: map['text'],rate: map['rate']);
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