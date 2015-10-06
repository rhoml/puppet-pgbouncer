require 'spec_helper'
describe 'pgbouncer' do

  context 'with defaults for all parameters' do
    it { should contain_class('pgbouncer') }
  end
end
