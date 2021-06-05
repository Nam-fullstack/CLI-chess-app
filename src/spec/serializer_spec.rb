# frozen_string_literal: true

require_relative '../lib/serializer.rb'

RSpec.describe Serializer do
  let(:dummy_class) { Class.new { extend Serializer } }
  
  describe '#select_saved_game' do
    context 'when user input is valid' do
      it 'returns valid user input' do
        input = '1'
        allow(dummy_class).to receive(:gets).and_return(input)
        result = dummy_class.select_saved_game(3)
        expect(result).to eq('1')
      end
    end

    context 'when user input is invalid' do
      it 'outputs an input error warning' do
        warning = "\e[91mInput Error!\e[0m Please enter a valid file number."
        expect(dummy_class).to receive(:puts).with(warning).once
        valid_input = '1'
        invalid_input = 'a'
        allow(dummy_class).to receive(:gets).and_return(invalid_input, valid_input)
        dummy_class.select_saved_game(3)
      end
    end

    describe '#save_game' do
      before do
        allow(dummy_class).to receive(:puts)
        allow(Marshal).to receive(:dump)
      end

      it 'opens a file' do
        expect(File).to receive(:open)
        dummy_class.save_game
      end

      it 'dumps the file' do
        expect(Marshal).to receive(:dump)
        dummy_class.save_game
      end

      it 'does not raise an error' do
        expect { dummy_class.save_game }.not_to raise_error
      end
    end

    describe '#load_game' do
      before do
        allow(dummy_class).to receive(:find_saved_file)
        allow(Marshal).to receive(:load)
      end

      it 'opens a file' do
        expect(File).to receive(:open)
        dummy_class.load_game
      end

      it 'loads the file' do
        expect(Marshal).to receive(:load)
        dummy_class.load_game
      end
    end
  end
end