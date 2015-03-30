require 'spec_helper_acceptance'

describe 'geoipcheck class' do
  it 'should work with no errors' do
    pp = <<-EOS
    class { 'geoipcheck': }
    EOS

    apply_manifest(pp, :catch_failures => true)
    apply_manifest(pp, :catch_changes => true)
  end
end
