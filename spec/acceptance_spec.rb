require 'spec_helper'

describe 'Acceptance' do
  let(:tabletop) { Tabletop.new(5) }
  let(:robot) { Robot.new(tabletop) }

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
end
