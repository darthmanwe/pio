require File.join( File.dirname( __FILE__ ), "..", "spec_helper" )
require "pio/lldp"


module Pio
  describe Lldp do
    subject { Lldp.read( data.pack( "C*" ) ) }

    context "parsing a minimal LLDP frame" do
      let( :data ) {
        [
          0x01, 0x80, 0xc2, 0x00, 0x00, 0x0e,  # Destination MAC
          0x00, 0x19, 0x2f, 0xa7, 0xb2, 0x8d,  # Source MAC
          0x88, 0xcc,  # Ethertype
          0x02, 0x07, 0x04, 0x00, 0x19, 0x2f, 0xa7, 0xb2, 0x8d,  # Chassis ID TLV
          0x04, 0x0d, 0x01, 0x55, 0x70, 0x6c, 0x69, 0x6e, 0x6b, 0x20, 0x74, 0x6f, 0x20, 0x53, 0x31,  # Port ID TLV
          0x06, 0x02, 0x00, 0x78,  # Time to live TLV
          0x00, 0x00  # End of LLDPDU TLV
        ]
      }

      its( :dpid ) { should eq 108173701773 }

      it "should successfully parse the data" do
        lambda { subject }.should_not raise_error
      end
    end


    context "parsing a detailed LLDP frame" do
      let( :data ) {
        [
          0x01, 0x80, 0xc2, 0x00, 0x00, 0x0e,  # Destination MAC
          0x00, 0x19, 0x2f, 0xa7, 0xb2, 0x8d,  # Source MAC
          0x88, 0xcc,  # Ethertype
          0x02, 0x07, 0x04, 0x00, 0x19, 0x2f, 0xa7, 0xb2, 0x8d,  # Chassis ID TLV
          0x04, 0x0d, 0x01, 0x55, 0x70, 0x6c, 0x69, 0x6e, 0x6b, 0x20, 0x74, 0x6f, 0x20, 0x53, 0x31,  # Port ID TLV
          0x06, 0x02, 0x00, 0x78,  # Time to live TLV
          0x08, 0x17, 0x53, 0x75, 0x6d, 0x6d, 0x69, 0x74, 0x33, 0x30, 0x30, 0x2d, 0x34, 0x38, 0x2d, 0x50, 0x6f, 0x72, 0x74, 0x20, 0x31, 0x30, 0x30, 0x31, 0x00,  # Port Description
          0x0a, 0x0d, 0x53, 0x75, 0x6d, 0x6d, 0x69, 0x74, 0x33, 0x30, 0x30, 0x2d, 0x34, 0x38, 0x00,  # System Name
          0x0c, 0x4c, 0x53, 0x75, 0x6d, 0x6d, 0x69, 0x74, 0x33, 0x30, 0x30, 0x2d, 0x34, 0x38, 0x20, 0x2d, 0x20, 0x56, 0x65, 0x72, 0x73, 0x69, 0x6f, 0x6e, 0x20, 0x37, 0x2e, 0x34, 0x65, 0x2e, 0x31, 0x20, 0x28, 0x42, 0x75, 0x69, 0x6c, 0x64, 0x20, 0x35, 0x29, 0x20, 0x62, 0x79, 0x20, 0x52, 0x65, 0x6c, 0x65, 0x61, 0x73, 0x65, 0x5f, 0x4d, 0x61, 0x73, 0x74, 0x65, 0x72, 0x20, 0x30, 0x35, 0x2f, 0x32, 0x37, 0x2f, 0x30, 0x35, 0x20, 0x30, 0x34, 0x3a, 0x35, 0x33, 0x3a, 0x31, 0x31, 0x00,  # System Description
          0x0e, 0x04, 0x00, 0x14, 0x00, 0x14, # System Capabilities
          0x10, 0x0e, 0x07, 0x06, 0x00, 0x01, 0x30, 0xf9, 0xad, 0xa0, 0x02, 0x00, 0x00, 0x03, 0xe9, 0x00,
          0xfe, 0x07, 0x00, 0x12, 0x0f, 0x02, 0x07, 0x01, 0x00,
          0x00, 0x00  # End of LLDPDU TLV
        ]
      }

      its( :dpid ) { should eq 108173701773 }

      it "should successfully parse the data" do
        lambda { subject }.should_not raise_error
      end
    end
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End: