require 'spec_helper'
describe 'hive' do

  context 'with defaults for all parameters' do
    it { should contain_class('hive') }
  end
end
