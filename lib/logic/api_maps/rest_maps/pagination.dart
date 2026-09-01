typedef PageFetcher<T> = Future<PaginatedPage<T>> Function(int page);

class PaginatedPage<T> {
  const PaginatedPage({required this.items, required this.nextPage});

  final List<T> items;
  final int? nextPage;
}

Future<List<T>> getAllPages<T>(final PageFetcher<T> fetchPage) async {
  final items = <T>[];
  var page = 1;

  while (true) {
    final result = await fetchPage(page);
    items.addAll(result.items);

    final nextPage = result.nextPage;
    if (nextPage == null) {
      return items;
    }
    if (nextPage <= page) {
      throw const FormatException(
        'The next page must be greater than the current page.',
      );
    }
    page = nextPage;
  }
}
