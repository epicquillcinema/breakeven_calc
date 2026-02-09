class CalcEngine {
  // Input map: key -> value
  static Map<String, double> calculate(Map<String, double> inputs) {
    final fixedCosts = inputs['fixedCosts'] ?? 0;
    final price = inputs['price'] ?? 0;
    final variableCost = inputs['variableCost'] ?? 0;

    if (price <= variableCost || price == 0) {
      return {
        'breakEvenUnits': 0,
        'breakEvenRevenue': 0,
      };
    }

    final units = fixedCosts / (price - variableCost);
    return {
      'breakEvenUnits': units,
      'breakEvenRevenue': units * price,
    };
  }
}
