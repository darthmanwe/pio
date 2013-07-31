require File.join( File.dirname( __FILE__ ), "..", "..", "spec_helper" )
require "pio/lldp/optional-tlv"


module Pio
  class Lldp
    describe OptionalTlv do
      subject { OptionalTlv.read( data ) }


      context "when parsing End Of LLDPDU TLV" do
        let( :data ) { [ 0x00, 0x00 ].pack( "C*" ) }

        its( :tlv_type ) { should eq 0 }
        its( :tlv_info_length ) { should eq 0 }
        its( :tlv_value ) { should eq "tlv_info_string" => "" }
      end


      context "when parsing Port Description TLV" do
        let( :data ) { [ 0x08, 0x17, 0x53, 0x75, 0x6d, 0x6d, 0x69, 0x74, 0x33, 0x30, 0x30, 0x2d, 0x34, 0x38, 0x2d, 0x50, 0x6f, 0x72, 0x74, 0x20, 0x31, 0x30, 0x30, 0x31, 0x00 ].pack( "C*" ) }

        its( :tlv_type ) { should eq 4 }
        its( :tlv_info_length ) { should eq 23 }
        its( :tlv_value ) { should eq( { "port_description" => "Summit300-48-Port 1001" } ) }
      end


      context "when parsing System Name TLV" do
        let( :data ) { [ 0x0a, 0x0d, 0x53, 0x75, 0x6d, 0x6d, 0x69, 0x74, 0x33, 0x30, 0x30, 0x2d, 0x34, 0x38, 0x00 ].pack( "C*" ) }

        its( :tlv_type ) { should eq 5 }
        its( :tlv_info_length ) { should eq 13 }
        its( :tlv_value ) { should eq( { "system_name" => "Summit300-48" } ) }
      end


      context "when parsing System Description TLV" do
        let( :data ) { [ 0x0c, 0x4c, 0x53, 0x75, 0x6d, 0x6d, 0x69, 0x74, 0x33, 0x30, 0x30, 0x2d, 0x34, 0x38, 0x20, 0x2d, 0x20, 0x56, 0x65, 0x72, 0x73, 0x69, 0x6f, 0x6e, 0x20, 0x37, 0x2e, 0x34, 0x65, 0x2e, 0x31, 0x20, 0x28, 0x42, 0x75, 0x69, 0x6c, 0x64, 0x20, 0x35, 0x29, 0x20, 0x62, 0x79, 0x20, 0x52, 0x65, 0x6c, 0x65, 0x61, 0x73, 0x65, 0x5f, 0x4d, 0x61, 0x73, 0x74, 0x65, 0x72, 0x20, 0x30, 0x35, 0x2f, 0x32, 0x37, 0x2f, 0x30, 0x35, 0x20, 0x30, 0x34, 0x3a, 0x35, 0x33, 0x3a, 0x31, 0x31, 0x00 ].pack( "C*" ) }

        its( :tlv_type ) { should eq 6 }
        its( :tlv_info_length ) { should eq 76 }
        its( :tlv_value ) { should eq( { "system_description"=>"Summit300-48 - Version 7.4e.1 (Build 5) by Release_Master 05/27/05 04:53:11" } ) }
      end


      context "when parsing System Capabilities TLV" do
        let( :data ) { [ 0x0e, 0x04, 0x00, 0x14, 0x00, 0x14 ].pack( "C*" ) }

        its( :tlv_type ) { should eq 7 }
        its( :tlv_info_length ) { should eq 4 }
        its( :tlv_value ) { should eq( { "system_capabilities" => 20, "enabled_capabilities" => 20 } ) }
      end


      context "when parsing Management Address TLV" do
        let( :data ) { [ 0x10, 0x0e, 0x07, 0x06, 0x00, 0x01, 0x30, 0xf9, 0xad, 0xa0, 0x02, 0x00, 0x00, 0x03, 0xe9, 0x00 ].pack( "C*" ) }

        its( :tlv_type ) { should eq 8 }
        its( :tlv_info_length ) { should eq 14 }
        its( :tlv_value ) { should eq( { "management_address" => "\a\006" } ) }  # FIXME
      end


      context "when parsing Organizationally Specific TLV" do
        let( :data ) { [ 0xfe, 0x07, 0x00, 0x12, 0x0f, 0x02, 0x07, 0x01, 0x00 ].pack( "C*" ) }

        its( :tlv_type ) { should eq 127 }
        its( :tlv_info_length ) { should eq 7 }
        its( :tlv_value ) { should eq "" }  # FIXME
      end
    end
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
