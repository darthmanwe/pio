[
  0x01, # version
  0x0a, # type
  0x00, 0x12, # _length
  0x00, 0x00, 0x00, 0x00, # transaction_id
  0xff, 0xff, 0xff, 0x00, # buffer_id
  0x00, 0x00, # total_length
  0x00, 0x01, # in_port
  0x00, # reason
  0x00, # padding
].pack('C18')