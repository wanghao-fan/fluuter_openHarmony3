class DecisionOption {
  final String id;
  final String title;
  final List<Weight> weights;

  DecisionOption({
    required this.id,
    required this.title,
    List<Weight>? weights,
  }) : weights = weights ?? [];

  double get totalWeight {
    return weights.fold(0, (sum, weight) => sum + weight.value);
  }

  DecisionOption addWeight(Weight weight) {
    return DecisionOption(
      id: id,
      title: title,
      weights: [...weights, weight],
    );
  }

  DecisionOption removeWeight(String weightId) {
    return DecisionOption(
      id: id,
      title: title,
      weights: weights.where((w) => w.id != weightId).toList(),
    );
  }
}

class Weight {
  final String id;
  final String description;
  final double value;

  Weight({
    required this.id,
    required this.description,
    required this.value,
  });
}
