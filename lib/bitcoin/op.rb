module Bitcoin
  class Op
    def initialize
      @stack = []
    end
    attr_reader :stack

    def op_dup
      return false if stack.size < 1

      stack.push(stack[-1])
      true
    end

    def op_hash256
      return false if stack.size < 1

      elem = stack.pop
      stack.push(Helper.hash256(elem))
      true
    end

    OP_CODE_FUNCTIONS = {
      0x76 => :op_dup,
      0xaa => :op_hash256,
    }
  end
end
