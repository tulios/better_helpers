require "spec_helper"

describe BetterHelpers::Railties::RequestContext do

  let :instance do
    klass = Class.new
    klass.class_eval do
      include BetterHelpers::Railties::RequestContext
    end

    klass.new
  end

  let :view_context do
    double("view context")
  end

  let :controller do
    double("controller instance", view_context: view_context)
  end

  let :namespace do
    BetterHelpers::Railties::RequestContext::NAME
  end

  before do
    Thread.current[namespace] = controller
  end

  describe "#controller" do
    it "returns the context of 'Thread.current'" do
      expect(instance.controller).to eql Thread.current[namespace]
    end
  end

  describe "#view_context" do
    it "returns the controller view_context" do
      expect(instance.view_context).to eql instance.controller.view_context
    end

    describe "when controller is nil" do
      before do
        expect(instance).to receive(:controller).and_return(nil)
      end

      it "returns nil" do
        expect(instance.view_context).to eql nil
      end
    end
  end

  describe "#method_missing" do
    it "forwards the call to view_context" do
      expect(view_context).to receive(:global_helper)
      instance.global_helper
    end

    it "caches the method" do
      expect(view_context).to receive(:global_helper)
      expect(instance).to_not respond_to :global_helper
      instance.global_helper
      expect(instance).to respond_to :global_helper
    end

    describe "when view_context doesn't has the method" do
      it "uses the default behavior" do
        expect { instance.wrong_helper }.to raise_error
      end
    end
  end

end
