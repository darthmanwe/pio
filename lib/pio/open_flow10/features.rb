require 'forwardable'
require 'pio/open_flow'
require 'pio/open_flow10/message'

module Pio
  # OpenFlow 1.0 Features Request and Reply message.
  class Features
    # OpenFlow 1.0 Features Request message.
    class Request
      # OpenFlow 1.0 Features Request message
      class Format < BinData::Record
        extend OpenFlow::Format

        header version: 1, message_type: OpenFlow::FEATURES_REQUEST
        string :body

        def user_data
          body
        end
      end

      def self.read(raw_data)
        allocate.tap do |message|
          message.instance_variable_set(:@format, Format.read(raw_data))
        end
      rescue BinData::ValidityError
        raise Pio::ParseError, 'Invalid Features Request message.'
      end

      def initialize(user_options = {})
        header_options = OpenFlowHeader::Options.parse(user_options)
        body_options = user_options[:body] || user_options[:user_data] || ''
        @format = Format.new(header: header_options, body: body_options)
      end

      def method_missing(method, *args, &block)
        @format.__send__ method, *args, &block
      end
    end

    # OpenFlow 1.0 Features Reply message.
    class Reply
      # Message body of features reply.
      class Body < BinData::Record
        extend OpenFlow::Flags

        # enum ofp_capabilities
        flags_32bit :capabilities,
                    [:flow_stats,
                     :table_stats,
                     :port_stats,
                     :stp,
                     :reserved,
                     :ip_reasm,
                     :queue_stats,
                     :arp_match_ip]

        # enum ofp_action_type
        flags_32bit :actions_flag,
                    [:output,
                     :set_vlan_vid,
                     :set_vlan_pcp,
                     :strip_vlan,
                     :set_ether_source_address,
                     :set_ether_destination_address,
                     :set_ip_source_address,
                     :set_ip_destination_address,
                     :set_ip_tos,
                     :set_transport_source_port,
                     :set_transport_destination_port,
                     :enqueue]

        endian :big

        datapath_id :datapath_id
        uint32 :n_buffers
        uint8 :n_tables
        uint24 :padding
        hide :padding
        capabilities :capabilities
        actions_flag :actions
        array :ports, type: :phy_port, read_until: :eof

        def dpid
          datapath_id
        end

        def empty?
          false
        end

        def length
          24 + ports.to_binary_s.length
        end
      end

      # OpenFlow 1.0 Features Reply message
      class Format < BinData::Record
        extend OpenFlow::Format

        header version: 1, message_type: OpenFlow::FEATURES_REPLY
        body :body

        def ports
          body.snapshot.ports.map do |each|
            each.instance_variable_set :@datapath_id, datapath_id
            each
          end
        end

        def physical_ports
          ports.select do |each|
            each.port_no <= PortNumber::MAX
          end
        end
      end

      def self.read(raw_data)
        allocate.tap do |message|
          message.instance_variable_set(:@format, Format.read(raw_data))
        end
      rescue BinData::ValidityError
        raise Pio::ParseError, 'Invalid Features Reply message.'
      end

      # rubocop:disable MethodLength
      def initialize(user_options = {})
        header_options = OpenFlowHeader::Options.parse(user_options)
        body_options = if user_options.respond_to?(:fetch)
                         user_options.delete :transaction_id
                         user_options.delete :xid
                         dpid = user_options[:dpid]
                         user_options[:datapath_id] = dpid if dpid
                         user_options
                       else
                         ''
                       end
        @format = Format.new(header: header_options, body: body_options)
      end
      # rubocop:enable MethodLength

      def method_missing(method, *args, &block)
        @format.__send__ method, *args, &block
      end
    end
  end
end
