require 'spec_helper'

describe 'Acceptance' do
  let(:tabletop) { Tabletop.new(5) }
  let(:robot) { Robot.new(tabletop) }

  it do
    expect(robot.execute 'REPORT').to eq('PLACE command has not been executed yet')
  end

  it do
    robot.execute 'PLACE 0,0,NORTH'
    robot.execute 'MOVE'
    expect(robot.execute 'REPORT').to eq('0,1,NORTH')
  end

  it do
    robot.execute 'PLACE 0,0,NORTH'
    robot.execute 'LEFT'
    expect(robot.execute 'REPORT').to eq('0,0,WEST')
  end

  it do
    robot.execute 'PLACE 1,2,EAST'
    robot.execute 'MOVE'
    robot.execute 'MOVE'
    robot.execute 'LEFT'
    robot.execute 'MOVE'
    expect(robot.execute 'REPORT').to eq('3,3,NORTH')
  end

  it do
    robot.execute 'PLACE 2,2,EAST'
    robot.execute 'LEFT'
    robot.execute 'MOVE'
    robot.execute 'LEFT'
    robot.execute 'MOVE'
    expect(robot.execute 'REPORT').to eq('1,3,WEST')
    robot.execute 'RIGHT'
    robot.execute 'MOVE'
    robot.execute 'RIGHT'
    robot.execute 'MOVE'
    robot.execute 'MOVE'
    robot.execute 'REPORT'
    expect(robot.execute 'REPORT').to eq('3,4,EAST')
  end

  it do
    robot.execute 'PLACE 0,0,SOUTH'
    robot.execute 'MOVE'
    robot.execute 'MOVE'
    robot.execute 'MOVE'
    expect(robot.execute 'REPORT').to eq('0,0,SOUTH')
    robot.execute 'LEFT'
    robot.execute 'MOVE'
    robot.execute 'RIGHT'
    robot.execute 'MOVE'
    expect(robot.execute 'REPORT').to eq('1,0,SOUTH')
    robot.execute 'LEFT'
    robot.execute 'LEFT'
    expect(robot.execute 'REPORT').to eq('1,0,NORTH')
    robot.execute 'MOVE'
    robot.execute 'MOVE'
    expect(robot.execute 'REPORT').to eq('1,2,NORTH')
    robot.execute 'PLACE 0,0,SOUTH'
    expect(robot.execute 'REPORT').to eq('0,0,SOUTH')
  end

  it do
    robot.execute 'PLACE 0,0,NORTH'
    expect(robot.execute 'REPORT').to eq('0,0,NORTH')
    robot.execute 'PLACE 9,9,NORTH'
    expect(robot.execute 'REPORT').to eq('0,0,NORTH')
    robot.execute 'PLACE 0,9,NORTH'
    expect(robot.execute 'REPORT').to eq('0,0,NORTH')
    robot.execute 'PLACE 9,0,NORTH'
    expect(robot.execute 'REPORT').to eq('0,0,NORTH')
  end
end
