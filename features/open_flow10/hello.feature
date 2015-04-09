Feature: Hello
  Scenario: create
    When I try to create an OpenFlow message with:
      """
      Pio::Hello.new
      """
    Then it should finish successfully
    And the message have the following fields and values:
      | field          |      value |
      | class          | Pio::Hello |
      | ofp_version    |          1 |
      | message_type   |          0 |
      | message_length |          8 |
      | transaction_id |          0 |
      | xid            |          0 |
      | body           |            |

  Scenario: create (transaction_id: 123)
    When I try to create an OpenFlow message with:
      """
      Pio::Hello.new(transaction_id: 123)
      """
    Then it should finish successfully
    And the message have the following fields and values:
      | field          |      value |
      | class          | Pio::Hello |
      | ofp_version    |          1 |
      | message_type   |          0 |
      | message_length |          8 |
      | transaction_id |        123 |
      | xid            |        123 |
      | body           |            |

  Scenario: create (xid: 123)
    When I try to create an OpenFlow message with:
      """
      Pio::Hello.new(xid: 123)
      """
    Then it should finish successfully
    And the message have the following fields and values:
      | field          |      value |
      | class          | Pio::Hello |
      | ofp_version    |          1 |
      | message_type   |          0 |
      | message_length |          8 |
      | transaction_id |        123 |
      | xid            |        123 |
      | body           |            |

  Scenario: create (xid: -1) and error
    When I try to create an OpenFlow message with:
      """
      Pio::Hello.new(xid: -1)
      """
    Then it should fail with "ArgumentError", "Transaction ID should be an unsigned 32-bit integer."

  Scenario: create (xid: 2**32) and error
    When I try to create an OpenFlow message with:
      """
      Pio::Hello.new(xid: 2**32)
      """
    Then it should fail with "ArgumentError", "Transaction ID should be an unsigned 32-bit integer."

  Scenario: parse
    When I try to parse a file named "hello.raw" with "Hello" class
    Then it should finish successfully
    And the message have the following fields and values:
      | field          |      value |
      | class          | Pio::Hello |
      | ofp_version    |          1 |
      | message_type   |          0 |
      | message_length |          8 |
      | transaction_id |         23 |
      | xid            |         23 |
      | body           |            |

  Scenario: parse error
    When I try to parse a file named "features_request.raw" with "Pio::Hello" class
    Then it should fail with "Pio::ParseError", "Invalid Hello message."