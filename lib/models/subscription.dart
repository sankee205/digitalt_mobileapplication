class Subscription {
  bool freeMonthUsed;
  final String orderId;
  final String amount;
  String status;
  final String transactionText;
  final String timeStamp;
  final String expiredDate;

  Subscription({
    this.freeMonthUsed,
    this.orderId,
    this.amount,
    this.transactionText,
    this.status,
    this.timeStamp,
    this.expiredDate,
  });
  Subscription.fromData(Map<String, dynamic> data)
      : freeMonthUsed = data['freeMonthUsed'],
        orderId = data['orderId'],
        amount = data['amount'],
        transactionText = data['transactionText'],
        status = data['status'],
        timeStamp = data['timeStamp'],
        expiredDate = data['expiredDate'];

  Map<String, dynamic> toJson() {
    return {
      'freeMonthUsed': freeMonthUsed,
      'orderId': orderId,
      'amount': amount,
      'status': status,
      'transactionText': transactionText,
      'timeStamp': timeStamp,
      'expiredDate': expiredDate
    };
  }

  setFreeMonth() {
    this.freeMonthUsed = true;
    this.status = 'nonActive';
  }
}
