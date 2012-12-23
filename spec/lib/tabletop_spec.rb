require 'spec_helper'

describe Tabletop do
  it 'creates an instance with correct placements' do
    tabletop = Tabletop.new(2)
    expect(tabletop.placements).to eq([[:empty, :empty], [:empty, :empty]])
  end

  describe '#move' do
    let(:tabletop) { Tabletop.new(5) }
    let(:robot) { Robot.new(tabletop) }

    context 'when there is no robot in this position' do
      it 'moves the robot' do
        tabletop.placements[4][3] = :empty
        tabletop.move(robot, 4, 3)
        expect(tabletop.placements[4][3]).to eq(robot)
      end

      it 'returns true' do
        tabletop.placements[4][3] = :empty
        expect(tabletop.move(robot, 4, 3)).to be_true
      end

      context 'when robot already has a position' do
        it 'cleans the previous robot position' do
          tabletop.placements[4][3] = :empty
          robot.move(4, 2)

          tabletop.move(robot, 4, 3)
          expect(tabletop.placements[4][2]).to eq(:empty)
        end
      end
    end

    context 'when there is already a robot in this position' do
      it 'returns false' do
        other_robot = Robot.new(tabletop)
        tabletop.placements[4][3] = other_robot

        expect(tabletop.move(robot, 4, 3)).to be_false
      end
    end

    context 'when the position is out of tabletop' do
      it 'returns false' do
        expect(tabletop.move(robot, 9, 9)).to be_false
      end
    end

    context 'when the x position is negative' do
      it 'returns false' do
        expect(tabletop.move(robot, -1, 0)).to be_false
      end
    end

    context 'when the y position is negative' do
      it 'returns false' do
        expect(tabletop.move(robot, 0, -1)).to be_false
      end
    end
  end
end
