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
  final List<String> translations;
  HistoryItem({
    required this.countries,
    required this.word,
    required this.translations,
  });

  HistoryItem copyWith({
    List<String>? countries,
    String? word,
    List<String>? translations,
  }) {
    return HistoryItem(
      countries: countries ?? this.countries,
      word: word ?? this.word,
      translations: translations ?? this.translations,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'countries': countries,
      'word': word,
      'translations': translations,
    };
  }

  factory HistoryItem.fromMap(Map<String, dynamic> map) {
    return HistoryItem(
      countries: map['countries'] != null
          ? List<String>.from((map['countries'] as List<dynamic>))
          : [],
      word: map['word'] ?? '',
      translations: map['translations'] != null
          ? List<String>.from((map['translations'] as List<dynamic>))
          : [],
    );
  }

  @override
  String toString() =>
      'HistoryItem(countries: $countries, word: $word, translation: $translations)';
}
