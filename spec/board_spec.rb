# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/pieces/king'
require_relative '../lib/pieces/queen'
require_relative '../lib/pieces/rook'
require_relative '../lib/pieces/bishop'
require_relative '../lib/pieces/knight'
require_relative '../lib/pieces/pawn'
require_relative '../lib/pieces/piece'
require_relative '../lib/movement/movement_factory'
require_relative '../lib/movement/basic_movement'
require_relative '../lib/movement/en_passant_movement'

RSpec.describe Board do
    subject(:board) { described_class.new }

    describe '#initial_placement' do

        before do
            board.initial_placement
        end

        it 'has bottom row (1st rank) of white pieces' do
            expect(board.data[7].all? { |piece| piece.color == :white }).to be true
        end

        it 'has sixth row (2nd Rank) of white pieces' do
            expect(board.data[6].all? { |piece| piece.color == :white }).to be true
        end

        it 'has second row (7th Rank) of black pieces' do
            expect(board.data[1].all? { |piece| piece.color == :black }).to be true
        end

        it 'has top row (8th Rank) of black pieces' do
            expect(board.data[0].all? { |piece| piece.color == :black }).to be true
        end

        it 'has 1st rank queen side Rook' do
            expect(board.data[7][0].instance_of?(Rook)).to be true
        end

        it 'has 1st rank queen side Knight' do
            expect(board.data[7][1].instance_of?(Knight)).to be true
        end

        it 'has 1st rank queen side Bishop' do
            expect(board.data[7][2].instance_of?(Bishop)).to be true
        end

        it 'has 1st rank Queen' do
            expect(board.data[7][3].instance_of?(Queen)).to be true
        end

        it 'has 1st rank King' do
            expect(board.data[7][4].instance_of?(King)).to be true
        end

        it 'has 1st rank king side Bishop' do
            expect(board.data[7][5].instance_of?(Bishop)).to be true
        end

        it 'has 1st rank king side Knight' do
            expect(board.data[7][6].instance_of?(Knight)).to be true
        end

        it 'has 1st rank king side Rook' do
            expect(board.data[7][7].instance_of?(Rook)).to be true
        end

        it 'has 8th rank queen side Rook' do
            expect(board.data[0][0].instance_of?(Rook)).to be true
        end

        it 'has 8th rank queen side Knight' do
            expect(board.data[0][1].instance_of?(Knight)).to be true
        end

        it 'has 8th rank queen side Bishop' do
            expect(board.data[0][2].instance_of?(Bishop)).to be true
        end

        it 'has 8th rank Queen' do
            expect(board.data[0][3].instance_of?(Queen)).to be true
        end

        it 'has 8th rank King' do
            expect(board.data[0][4].instance_of?(King)).to be true
        end

        it 'has 8th rank king side Bishop' do
            expect(board.data[0][5].instance_of?(Bishop)).to be true
        end

        it 'has 8th rank king side Knight' do
            expect(board.data[0][6].instance_of?(Knight)).to be true
        end

        it 'has 8th rank king side Rook' do
            expect(board.data[0][7].instance_of?(Rook)).to be true
        end

        it 'has 2nd Rank of pawns' do
            expect(board.data[6].all? { |piece| piece.instance_of?(Pawn) }).to be true
        end

        it 'has 7th Rank of pawns' do
            expect(board.data[1].all? { |piece| piece.instance_of?(Pawn) }).to be true
        end
    end
end

