class Price {
  Price({
    required this.value,
    required this.currency,
  });

  final double value;
  final Currency currency;
}

enum CurrencyType {
  eur,
  usd,
  unkown,
}

class Currency {
  Currency({
    required this.type,
    required this.shortcode,
    this.fontcode,
    this.symbol,
  });

  factory Currency.fromType(final CurrencyType type) {
    switch (type) {
      case CurrencyType.eur:
        return Currency(
          type: type,
          shortcode: 'EUR',
          fontcode: 'euro',
          symbol: '€',
        );
      case CurrencyType.usd:
        return Currency(
          type: type,
          shortcode: 'USD',
          fontcode: 'attach_money',
          symbol: '\$',
        );
      default:
        return Currency(
          type: type,
          shortcode: '?',
          fontcode: 'payments',
          symbol: '?',
        );
    }
  }

  final CurrencyType type;
  final String shortcode;
  final String? fontcode;
  final String? symbol;
}
