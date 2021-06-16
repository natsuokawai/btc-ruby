module Bitcoin
  class Script
    def initialize(cmds: nil)
      @cmds = cmds.nil? ? [] : cmds
    end
    attr_reader :cmds

    def self.parse(stream)
      length = Helper.read_varint(stream)
      cmds = []
      count = 0
      while count < length
        current_byte = stream.read(1)
        count += 1
        if current_byte > 1 && current_byte <= 75
          n = current_byte.unpack('C')[0]
          cmds.push(stream.read(n))
          count += n
        elsif current_byte == 76
          data_length = Helper.bytes_to_int(stream.read(1), :little)
          cmds.push(stream.read(data_length))
          count += 1 + data_length
        elsif current_byte == 77
          data_length = Helper.bytes_to_int(stream.read(2), :little)
          cmds.push(stream.read(data_length))
          count += 2 + data_length
        else
          cmds.append(current_byte)
        end
      end

      raise SyntaxError, "Parsing script failed." if count != length

      Script.new(cmds: cmds)
    end

    def serialize

    end
  end
end
