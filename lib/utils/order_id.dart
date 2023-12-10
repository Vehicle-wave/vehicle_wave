class OrderIDGenerator {
  int _currentSequence = 0; // Initial sequence number

  String generateOrderID() {
    String prefix = "DW";
    String paddedSequence = _currentSequence.toString().padLeft(4, '0');
    String orderID = "$prefix$paddedSequence";

    // Increment the sequence for the next order
    _currentSequence++;

    return orderID;
  }
}
