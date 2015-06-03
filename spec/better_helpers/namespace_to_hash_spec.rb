require "spec_helper"

describe BetterHelpers::NamespaceToHash do

  let :namespace do
    ["a", "b", "c"]
  end

  subject do
    BetterHelpers::NamespaceToHash.new(String, namespace).perform
  end

  it "should generate a nested hash resulting in the given object" do
    expect(subject).to be_an_instance_of Hash
    expect(subject.keys).to eql ["a"]

    expect(subject["a"]).to be_an_instance_of Hash
    expect(subject["a"].keys).to eql ["b"]

    expect(subject["a"]["b"]).to be_an_instance_of Hash
    expect(subject["a"]["b"].keys).to eql ["c"]
    expect(subject["a"]["b"]["c"]).to be_an_instance_of String
  end

end
