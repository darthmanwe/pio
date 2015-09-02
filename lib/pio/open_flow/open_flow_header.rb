require 'bindata'
require 'pio/open_flow/transaction_id'

module Pio
  # OpenFlow message header parser
  class OpenFlowHeaderParser < BinData::Record
    endian :big

    uint8 :ofp_version
    uint8 :message_type
    uint16 :_length
    transaction_id :transaction_id
    rest :body

    def length
      _length
    end
  end

  # OpenFlow message header.
  class OpenFlowHeader < BinData::Record
    endian :big

    uint8 :ofp_version, value: :ofp_version_value
    virtual assert: -> { ofp_version == ofp_version_value }
    uint8 :message_type, value: :message_type_value
    virtual assert: -> { message_type == message_type_value }
    uint16 :_length, initial_value: -> { 8 + body.length }
    transaction_id :transaction_id, initial_value: 0

    def length
      _length
    end
  end
end
