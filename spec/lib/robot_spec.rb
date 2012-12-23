require 'spec_helper'

describe Robot do
  let(:tabletop) { Tabletop.new(5) }
  subject { Robot.new(tabletop) }

  it 'creates an instance with correct tabletop' do
    expect(subject.tabletop).to eq(tabletop)
  end

  it 'creates an instance that is not ready' do
    expect(subject.ready).to be_false
  end

  describe '#execute' do
    describe 'PLACE command' do
      it 'sets the direction' do
        subject.execute('PLACE 1,2,NORTH')
        expect(subject.direction).to eq('NORTH')
      end

      context 'when move is allowed' do
        it 'sets as ready' do
          subject.execute('PLACE 1,2,NORTH')
          expect(subject.ready).to be_true
        end
      end

      context 'when move is not allowed' do
        it 'does not set as ready' do
          subject.execute('PLACE 9,9,NORTH')
          expect(subject.ready).to be_false
        end
      end
    end

    describe 'MOVE command' do
      context 'when move is allowed' do
        it 'moves the robot northward' do
          subject.execute('PLACE 1,2,NORTH')
          subject.execute('MOVE')
          expect(subject.x).to eq(1)
          expect(subject.y).to eq(3)
          expect(subject.direction).to eq('NORTH')
        end

        it 'moves the robot southward' do
          subject.execute('PLACE 3,1,SOUTH')
          subject.execute('MOVE')
          expect(subject.x).to eq(3)
          expect(subject.y).to eq(0)
          expect(subject.direction).to eq('SOUTH')
        end

        it 'moves the robot eastward' do
          subject.execute('PLACE 2,2,EAST')
          subject.execute('MOVE')
          expect(subject.x).to eq(3)
          expect(subject.y).to eq(2)
          expect(subject.direction).to eq('EAST')
        end

        it 'moves the robot westward' do
          subject.execute('PLACE 2,2,WEST')
          subject.execute('MOVE')
          expect(subject.x).to eq(1)
          expect(subject.y).to eq(2)
          expect(subject.direction).to eq('WEST')
        end
      end

      context 'when move is not allowed' do
        it 'does not move the robot' do
          subject.execute('PLACE 2,4,NORTH')
          subject.execute('MOVE')
          expect(subject.x).to eq(2)
          expect(subject.y).to eq(4)
          expect(subject.direction).to eq('NORTH')
        end
      end

      context 'when is not ready (PLACE command has not been executed yet)' do
        it 'returns nothing' do
          expect(subject.execute('MOVE')).to be_nil
        end
      end
    end

    describe 'LEFT command' do
      context 'when facing north' do
        it 'turns westward' do
          subject.execute('PLACE 0,0,NORTH')
          subject.execute('LEFT')
          expect(subject.direction).to eq('WEST')
        end
      end

      context 'when facing west' do
        it 'turns southward' do
          subject.execute('PLACE 0,0,WEST')
          subject.execute('LEFT')
          expect(subject.direction).to eq('SOUTH')
        end
      end

      context 'when facing south' do
        it 'turns eastward' do
          subject.execute('PLACE 0,0,SOUTH')
          subject.execute('LEFT')
          expect(subject.direction).to eq('EAST')
        end
      end

      context 'when facing east' do
        it 'turns northward' do
          subject.execute('PLACE 0,0,EAST')
          subject.execute('LEFT')
          expect(subject.direction).to eq('NORTH')
        end
      end

      context 'when is not ready (PLACE command has not been executed yet)' do
        it 'returns nothing' do
          expect(subject.execute('LEFT')).to be_nil
        end
      end
    end

    describe 'RIGHT command' do
      context 'when facing north' do
        it 'turns eastward' do
          subject.execute('PLACE 0,0,NORTH')
          subject.execute('RIGHT')
          expect(subject.direction).to eq('EAST')
        end
      end

      context 'when facing east' do
        it 'turns southward' do
          subject.execute('PLACE 0,0,EAST')
          subject.execute('RIGHT')
          expect(subject.direction).to eq('SOUTH')
        end
      end

      context 'when facing south' do
        it 'turns westward' do
          subject.execute('PLACE 0,0,SOUTH')
          subject.execute('RIGHT')
          expect(subject.direction).to eq('WEST')
        end
      end

      context 'when facing west' do
        it 'turns northward' do
          subject.execute('PLACE 0,0,WEST')
          subject.execute('RIGHT')
          expect(subject.direction).to eq('NORTH')
        end
      end

      context 'when is not ready (PLACE command has not been executed yet)' do
        it 'returns nothing' do
          expect(subject.execute('RIGHT')).to be_nil
        end
      end
    end

    describe 'REPORT command' do
      it 'returns x, y and direction' do
        subject.execute('PLACE 1,2,NORTH')
        expect(subject.execute('REPORT')).to eq('1,2,NORTH')
      end

      context 'when is not ready (PLACE command has not been executed yet)' do
        it 'returns an error message' do
          expect(subject.execute('REPORT')).to eq('PLACE command has not been executed yet')
        end
      end
    end

    context 'when command is wrong' do
      it 'raises an exception' do
        expect { subject.execute('WRONG') }.to raise_error(RuntimeError, 'Unknown command')
      end
    end
  end

  describe '#move' do
    it 'moves to correct position' do
      subject.move(1, 4)
      expect(subject.x).to eq(1)
      expect(subject.y).to eq(4)
    end
  end
end
