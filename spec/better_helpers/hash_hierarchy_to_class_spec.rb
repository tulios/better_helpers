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
        expect(subject).to respond_to :a
        expect(subject).not_to respond_to :b
        expect(subject).not_to respond_to :c

        expect(subject.a).to respond_to :b
        expect(subject.a).not_to respond_to :a
        expect(subject.a).not_to respond_to :c

        expect(subject.a.b).to respond_to :c
        expect(subject.a.b).not_to respond_to :a
        expect(subject.a.b).not_to respond_to :b

        expect(subject.a.b.c).to eql 1
      end

      it "should allow new instances with the same methods" do
        apply
        instance2 = parent_class.new
        instance3 = parent_class.new

        [instance2, instance3].each do |instance|
          expect(instance).to respond_to :a
          expect(instance).not_to respond_to :b
          expect(instance).not_to respond_to :c

          expect(instance.a).to respond_to :b
          expect(instance.a).not_to respond_to :a
          expect(instance.a).not_to respond_to :c

          expect(instance.a.b).to respond_to :c
          expect(instance.a.b).not_to respond_to :a
          expect(instance.a.b).not_to respond_to :b

          expect(instance.a.b.c).to eql 1
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
        expect(subject).to respond_to :a
        expect(subject).not_to respond_to :b
        expect(subject).not_to respond_to :c
        expect(subject).not_to respond_to :d

        expect(subject.a).to respond_to :b
        expect(subject.a).to respond_to :c
        expect(subject.a).not_to respond_to :a
        expect(subject.a).not_to respond_to :d

        expect(subject.a.b).to respond_to :d
        expect(subject.a.b).not_to respond_to :a
        expect(subject.a.b).not_to respond_to :b
        expect(subject.a.b).not_to respond_to :c

        expect(subject.a.b.d).to eql 1

        expect(subject.a.c).to respond_to :d
        expect(subject.a.c).not_to respond_to :a
        expect(subject.a.c).not_to respond_to :b
        expect(subject.a.c).not_to respond_to :c

        expect(subject.a.c.d).to eql 2
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
        expect(subject).to eql 1
      end
    end

    context "when exist some hierarchy" do
      let :hash do
        {a: {b: 1}}
      end

      it "should return an instance of a callable object" do
        expect(subject).to respond_to :a
        expect(subject.a).to respond_to :b
        expect(subject.a.b).to eql 1
      end
    end
  end

end
