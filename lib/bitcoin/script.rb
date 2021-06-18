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
        current_byte = stream.read(1).unpack('C')[0]
        count += 1
        if current_byte > 1 && current_byte <= 75
          cmds.push(stream.read(current_byte))
          count += current_byte
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

      raise SyntaxError, 'Parsing script failed.' if count != length

      Script.new(cmds: cmds)
    end

    def serialize
      result = raw_serialize
      total = result.size

      Helper.encode_varint(total) + result
    end

    private
      def raw_serialize
        result = ''.b
        cmds.each do |cmd|
          if cmd.is_a? Integer
            result += Helper.int_to_bytes(cmd, 1, :little)
          else
            length = cmd.size
            if length <= 75
              result += Helper.int_to_bytes(length, 1, :little)
            elsif length > 76 && length < 256
              result += Helper.int_to_bytes(76, 1, :little)
              result += Helper.int_to_bytes(length, 1, :little)
            elsif length >= 0x100 && length <= 520
              result += Helper.int_to_bytes(77, 1, :little)
              result += Helper.int_to_bytes(length, 2, :little)
            else
              raise "cmd is too long: #{length}"
            end
            result += cmd
          end
        end

        result
      end
  end
end
