require "spec_helper"

describe BetterHelpers::HashHierarchyToClass do

  let :parent_class do
    Class.new
  end

  let :hash do
    {a: {b: {c: 1}}}
  end

  let :apply do
    BetterHelpers::HashHierarchyToClass.new(hash, parent_class).apply
  end

  describe "when modifying the class" do
    subject { parent_class.new }

    context "for unique modules" do
      before { apply }

      it "should include the methods into the parent class" do
        apply
        subject.should respond_to :a
        subject.should_not respond_to :b
        subject.should_not respond_to :c

        subject.a.should respond_to :b
        subject.a.should_not respond_to :a
        subject.a.should_not respond_to :c

        subject.a.b.should respond_to :c
        subject.a.b.should_not respond_to :a
        subject.a.b.should_not respond_to :b

        subject.a.b.c.should eql 1
      end

      it "should allow new instances with the same methods" do
        apply
        instance2 = parent_class.new
        instance3 = parent_class.new

        [instance2, instance3].each do |instance|
          instance.should respond_to :a
          instance.should_not respond_to :b
          instance.should_not respond_to :c

          instance.a.should respond_to :b
          instance.a.should_not respond_to :a
          instance.a.should_not respond_to :c

          instance.a.b.should respond_to :c
          instance.a.b.should_not respond_to :a
          instance.a.b.should_not respond_to :b

          instance.a.b.c.should eql 1
        end
      end
    end

    context "for different modules with the same parent" do
      let :hash1 do
        {a: {b: {d: 1}}}
      end

      let :hash2 do
        {a: {c: {d: 2}}}
      end

      before do
        BetterHelpers::HashHierarchyToClass.new(hash1, parent_class).apply
        BetterHelpers::HashHierarchyToClass.new(hash2, parent_class).apply
      end

      it "should define the method in the parent class" do
        subject.should respond_to :a
        subject.should_not respond_to :b
        subject.should_not respond_to :c
        subject.should_not respond_to :d

        subject.a.should respond_to :b
        subject.a.should respond_to :c
        subject.a.should_not respond_to :a
        subject.a.should_not respond_to :d

        subject.a.b.should respond_to :d
        subject.a.b.should_not respond_to :a
        subject.a.b.should_not respond_to :b
        subject.a.b.should_not respond_to :c

        subject.a.b.d.should eql 1

        subject.a.c.should respond_to :d
        subject.a.c.should_not respond_to :a
        subject.a.c.should_not respond_to :b
        subject.a.c.should_not respond_to :c

        subject.a.c.d.should eql 2
      end
    end
  end

  describe "when returning value" do
    subject { apply }

    context "when key is nil" do
      let :hash do
        {nil => 1}
      end

      it "should return the value" do
        subject.should eql 1
      end
    end

    context "when exist some hierarchy" do
      let :hash do
        {a: {b: 1}}
      end

      it "should return an instance of a callable object" do
        subject.should respond_to :a
        subject.a.should respond_to :b
        subject.a.b.should eql 1
      end
    end
  end

end
