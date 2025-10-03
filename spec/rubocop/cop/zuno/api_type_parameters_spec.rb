# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Zuno::ApiTypeParameters, :config do
  context "when checking Grape::API parameters" do
    it "does not register an offense when required parameter has type set" do
      expect_no_offenses(<<~RUBY)
        class Test < Grape::API
          params do
            requires :name, type: String
          end
        end
      RUBY
    end

    it "does not register an offense when required parameter has type set alongside other parameters" do
      expect_no_offenses(<<~RUBY)
        class Test < Grape::API
          params do
            requires :name, type: String, foo: 123
          end
        end
      RUBY
    end

    it "does not register an offense when optional parameter has type set" do
      expect_no_offenses(<<~RUBY)
        class Test < Grape::API
          params do
            optional :age, type: Integer
          end
        end
      RUBY
    end

    it "does not register an offense when optional parameter has type set alongside other parameters" do
      expect_no_offenses(<<~RUBY)
        class Test < Grape::API
          params do
            optional :age, type: Integer, foo: 123
          end
        end
      RUBY
    end

    it "registers an offense when required parameter has no type set" do
      expect_offense(<<~RUBY)
        class Test < Grape::API
          params do
            requires :name
            ^^^^^^^^^^^^^^ Ensure each parameter has a type specified, e.g., `type: String`.
          end
        end
      RUBY
    end

    it "registers an offense when optional parameter has no type set" do
      expect_offense(<<~RUBY)
        class Test < Grape::API
          params do
            optional :age
            ^^^^^^^^^^^^^ Ensure each parameter has a type specified, e.g., `type: String`.
          end
        end
      RUBY
    end
  end

  context "when checking Grape::Entity parameters" do
    it "does not register an offense when parameter has type set" do
      expect_no_offenses(<<~RUBY)
        class Test < Grape::Entity
          expose :name, documentation: { type: String }
        end
      RUBY
    end

    it "does not register an offense when parameter has type set alongside other parameters" do
      expect_no_offenses(<<~RUBY)
        class Test < Grape::Entity
          expose :name, documentation: { type: String, desc: "some description" }, foo: 123
        end
      RUBY
    end

    it "registers an offense when parameter has no type set" do
      expect_offense(<<~RUBY)
        class Test < Grape::Entity
          expose :name
          ^^^^^^^^^^^^ Ensure each parameter has a type specified, e.g., `documentation: { type: String }`.
        end
      RUBY
    end
  end

  it "does not register an offense when the class isn't a Grape API" do
    expect_no_offenses(<<~RUBY)
      class Test
        params do
          requires :name
        end
      end
    RUBY
  end
end
