// ignore_for_file: public_member_api_docs, sort_constructors_first

class HistoryItemList {
  final List<HistoryItem> histories;
  HistoryItemList({
    required this.histories,
  });

  HistoryItemList copyWith({
    List<HistoryItem>? histories,
  }) {
    return HistoryItemList(
      histories: histories ?? this.histories,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'histories': histories.map((x) => x.toMap()).toList(),
    };
  }

  factory HistoryItemList.fromMap(Map<String, dynamic> map) {
    return HistoryItemList(
      histories: List<HistoryItem>.from(
        (map['histories'] as List<dynamic>).map<HistoryItem>(
          (x) => HistoryItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  String toString() => 'HistoryItemList(histories: $histories)';
}

class HistoryItem {
  final List<String> countries;
  final String word;
  final String translation;
  HistoryItem({
    required this.countries,
    required this.word,
    required this.translation,
  });

  HistoryItem copyWith({
    List<String>? countries,
    String? word,
    String? translation,
  }) {
    return HistoryItem(
      countries: countries ?? this.countries,
      word: word ?? this.word,
      translation: translation ?? this.translation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'countries': countries,
      'word': word,
      'translation': translation,
    };
  }

  factory HistoryItem.fromMap(Map<String, dynamic> map) {
    return HistoryItem(
      countries: List<String>.from((map['countries'] as List<dynamic>)),
      word: map['word'] as String,
      translation: map['translation'] as String,
    );
  }

  @override
  String toString() =>
      'HistoryItem(countries: $countries, word: $word, translation: $translation)';
}
