require "spec_helper"

describe BetterHelpers::NamespaceToHash do

  let :namespace do
    ["a", "b", "c"]
  end

  subject do
    BetterHelpers::NamespaceToHash.new(String, namespace).perform
  end

  it "should generate a nested hash resulting in the given object" do
    subject.should be_an_instance_of Hash
    subject.keys.should eql ["a"]

    subject["a"].should be_an_instance_of Hash
    subject["a"].keys.should eql ["b"]

    subject["a"]["b"].should be_an_instance_of Hash
    subject["a"]["b"].keys.should eql ["c"]
    subject["a"]["b"]["c"].should be_an_instance_of String
  end

end
