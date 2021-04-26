class Subscription {
  final bool freeMonthUsed;
  final String orderId;
  final String amount;
  final String status;
  final String transactionText;
  final String timeStamp;

  Subscription({
    this.freeMonthUsed,
    this.orderId,
    this.amount,
    this.transactionText,
    this.status,
    this.timeStamp,
  });
  Subscription.fromData(Map<String, dynamic> data)
      : freeMonthUsed = data['freeMonthUsed'],
        orderId = data['orderId'],
        amount = data['amount'],
        transactionText = data['transactionText'],
        status = data['status'],
        timeStamp = data['timeStamp'];

  Map<String, dynamic> toJson() {
    return {
      'freeMonthUsed': freeMonthUsed,
      'orderId': orderId,
      'amount': amount,
      'status': status,
      'transactionText': transactionText,
      'timeStamp': timeStamp,
    };
  }
}
