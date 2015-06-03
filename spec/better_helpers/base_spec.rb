require "spec_helper"

require "fixtures/some_helper"
require "fixtures/another_helper"
require "fixtures/inside_module_helper"
require "fixtures/inside_module_custom_helper"

describe BetterHelpers::Base do

  let :helpers do
    Module.new do
      extend SomeHelper
      extend AnotherHelper
      extend InsideModuleHelper::A::B
      extend InsideModuleCustomHelper::A::B
    end
  end

  it "should not conflict with old helpers" do
    expect(helpers).to respond_to :global_helper_method
    expect(helpers.global_helper_method).to eql "test5"
  end

  describe "when included" do
    it "should include the class method 'better_helpers'" do
      expect(SomeHelper).to respond_to :better_helpers
      expect(AnotherHelper).to respond_to :better_helpers
    end
  end

  describe "::better_helpers" do
    it "includes the module 'BetterHelpers::Railties::RequestContext'" do
      expect(helpers.another.class.ancestors).to include BetterHelpers::Railties::RequestContext
    end

    describe "without arguments" do
      it "should include the helper methods into a 'namespace' with the underscore name of the module" do
        expect(helpers).to respond_to SomeHelper.to_s.underscore
        expect(helpers.some_helper.helper_method).to eql "test"
      end
    end

    describe "with namespace argument" do
      it "should include the helper methods into the defined 'namespace'" do
        expect(helpers).to respond_to :another
        expect(helpers.another.helper_method).to eql "test2"
      end
    end

    context "for helpers inside modules" do
      it "should include as cascade methods" do
        expect(helpers).to respond_to :inside_module_helper
        expect(helpers.inside_module_helper).to respond_to :a
        expect(helpers.inside_module_helper.a).to respond_to :b
        expect(helpers.inside_module_helper.a.b.helper_method).to eql "test3"
      end

      it "should allow namespace configuration" do
        expect(helpers).to respond_to :custom_helper
        expect(helpers.custom_helper.helper_method).to eql "test4"
      end
    end

    context "for helpers sharing a module" do
      let :helpers do
        Module.new do
          extend InsideModuleHelper::A::B
          extend InsideModuleHelper::A::C
        end
      end

      it "should include both helpers in the same module" do
        expect(helpers).to respond_to :inside_module_helper
        expect(helpers.inside_module_helper).to respond_to :a
        expect(helpers.inside_module_helper.a).to respond_to :b
        expect(helpers.inside_module_helper.a).to respond_to :c

        expect(helpers.inside_module_helper.a.b).to respond_to :helper_method
        expect(helpers.inside_module_helper.a.c).to respond_to :helper_method

        expect(helpers.inside_module_helper.a.b.helper_method).to eql "test3"
        expect(helpers.inside_module_helper.a.c.helper_method).to eql "test6"
      end
    end
  end

end
