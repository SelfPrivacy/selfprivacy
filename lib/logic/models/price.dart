class Price {
  Price({required this.value, required this.currency});

  final double value;
  final Currency currency;
}

enum CurrencyType { eur, usd, unknown }

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
          symbol: r'$',
        );
      case CurrencyType.unknown:
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

class AdditionalPricing {
  AdditionalPricing({required this.perVolumeGb, required this.perPublicIpv4});
  final Price perVolumeGb;
  final Price perPublicIpv4;
}
