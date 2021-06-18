require 'spec_helper'
require 'stringio'

module Bitcoin
  describe Script do
    describe '#self.parse' do
      let(:script_hex) { 0x6b483045022100ed81ff192e75a3fd2304004dcadb746fa5e24c5031ccfcf21320b0277457c98f02207a986d955c6e0cb35d446a89d3f56100f4d7f67801c31967743a9c8e10615bed01210349fc4e631e3624a545de3f89f5d8684c7b8138bd94bdd531d2e213bf016b278a }
      let(:script_bin) { Helper.int_to_bytes(script_hex, script_hex.to_s(16).size / 2, :big) }
      let(:expected_cmds) {["0E\x02!\x00\xED\x81\xFF\x19.u\xA3\xFD#\x04\x00M\xCA\xDBto\xA5\xE2LP1\xCC\xFC\xF2\x13 \xB0'tW\xC9\x8F\x02 z\x98m\x95\\n\f\xB3]Dj\x89\xD3\xF5a\x00\xF4\xD7\xF6x\x01\xC3\x19gt:\x9C\x8E\x10a[\xED\x01".b, "\x03I\xFCNc\x1E6$\xA5E\xDE?\x89\xF5\xD8hL{\x818\xBD\x94\xBD\xD51\xD2\xE2\x13\xBF\x01k'\x8A".b] }

      it { expect(Script.parse(StringIO.new(script_bin)).cmds).to eq expected_cmds }
      it { expect(Script.parse(StringIO.new(script_bin)).serialize).to eq script_bin }
    end
  end
end
