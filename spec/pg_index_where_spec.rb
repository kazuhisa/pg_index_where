require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "hoge" do
  before do
    p ActiveRecord::ConnectionAdapters::SchemaStatements::AAA
  end
  it{1.should == 1}
end