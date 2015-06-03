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
    helpers.should respond_to :global_helper_method
    helpers.global_helper_method.should eql "test5"
  end

  describe "when included" do
    it "should include the class method 'better_helpers'" do
      SomeHelper.should respond_to :better_helpers
      AnotherHelper.should respond_to :better_helpers
    end
  end

  describe "::better_helpers" do
    it "includes the module 'BetterHelpers::Railties::RequestContext'" do
      expect(helpers.another.class.ancestors).to include BetterHelpers::Railties::RequestContext
    end

    describe "without arguments" do
      it "should include the helper methods into a 'namespace' with the underscore name of the module" do
        helpers.should respond_to SomeHelper.to_s.underscore
        helpers.some_helper.helper_method.should eql "test"
      end
    end

    describe "with namespace argument" do
      it "should include the helper methods into the defined 'namespace'" do
        helpers.should respond_to :another
        helpers.another.helper_method.should eql "test2"
      end
    end

    context "for helpers inside modules" do
      it "should include as cascade methods" do
        helpers.should respond_to :inside_module_helper
        helpers.inside_module_helper.should respond_to :a
        helpers.inside_module_helper.a.should respond_to :b
        helpers.inside_module_helper.a.b.helper_method.should eql "test3"
      end

      it "should allow namespace configuration" do
        helpers.should respond_to :custom_helper
        helpers.custom_helper.helper_method.should eql "test4"
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
        helpers.should respond_to :inside_module_helper
        helpers.inside_module_helper.should respond_to :a
        helpers.inside_module_helper.a.should respond_to :b
        helpers.inside_module_helper.a.should respond_to :c

        helpers.inside_module_helper.a.b.should respond_to :helper_method
        helpers.inside_module_helper.a.c.should respond_to :helper_method

        helpers.inside_module_helper.a.b.helper_method.should eql "test3"
        helpers.inside_module_helper.a.c.helper_method.should eql "test6"
      end
    end
  end

end
