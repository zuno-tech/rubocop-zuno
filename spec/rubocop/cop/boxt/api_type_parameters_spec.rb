# frozen_string_literal: true

# rubocop:disable RSpec/ExampleLength
RSpec.describe RuboCop::Cop::Boxt::ApiTypeParameters, :config do
  it "does not register an offense when required parameter has type set" do
    expect_no_offenses(<<~RUBY)
      class Test < Grape::API
        params do
          requires :name, type: String
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
# rubocop:enable RSpec/ExampleLength
