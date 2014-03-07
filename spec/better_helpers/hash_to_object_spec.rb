require "spec_helper"

describe BetterHelpers::HashToObject do

  let :hash do
    {
      a: {
        b: {
          c: 1
        }
      }
    }
  end

  subject do
    BetterHelpers::HashToObject.new(hash).perform
  end

  it "should generate nested objects following the hash structure" do
    subject.should respond_to :a
    subject.a.should respond_to :b
    subject.a.b.should respond_to :c
    subject.a.b.c.should eql 1
  end

  describe "when key is nil" do
    let :hash do
      {nil => 1}
    end

    it "should return the value" do
      subject.should eql 1
    end
  end

end
