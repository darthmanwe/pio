Feature: Pio::Lldp.read
  Scenario: lldp.minimal.pcap
    Given a pcap file "lldp.minimal.pcap"
    When I try to parse the pcap file with "Lldp" class
    Then it should finish successfully
