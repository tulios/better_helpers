require "spec_helper"
require "fixtures/example_controller"

describe BetterHelpers::Railties::Filter do

  let :include_module do
    ExampleController.send :include, BetterHelpers::Railties::Filter
  end

  it "configures 'prepend_before_filter' with 'better_helpers_store_request'" do
    expect(ExampleController).to receive(:prepend_before_filter).with(:better_helpers_store_request)
    include_module
  end

  describe "#better_helpers_store_request" do
    let :instance do
      include_module
      ExampleController.new
    end

    let :namespace do
      BetterHelpers::Railties::RequestContext::NAME
    end

    before do
      instance.better_helpers_store_request
    end

    it "stores 'self' into 'Thread.current' under request context namespace" do
      expect(Thread.current[namespace]).to eql instance
    end
  end

end
