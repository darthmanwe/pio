# frozen_string_literal: true

require 'pio/open_flow/error_message'
require 'pio/open_flow/hello_failed_code'
require 'pio/open_flow/message'
require 'pio/open_flow13/error/error_type13'

module Pio
  module OpenFlow13
    module Error
      # Hello Failed error message
      class HelloFailed < OpenFlow::Message
        open_flow_header version: 4,
                         type: OpenFlow::ErrorMessage.type,
                         length: -> { 12 + description.length }
        error_type13 :error_type
        hello_failed_code :error_code
        rest :description
      end
    end
  end
end
