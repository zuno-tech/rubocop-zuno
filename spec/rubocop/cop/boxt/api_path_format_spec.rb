# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Boxt::ApiPathFormat, :config do
  it "does not register an offense when using get with a path in kebab-case format" do
    expect_no_offenses(<<~RUBY)
      class Test < Grape::API
        get "path/kebab-case"
      end
    RUBY
  end

  it "does not register an offense when using post with a path in kebab-case format" do
    expect_no_offenses(<<~RUBY)
      class Test < Grape::API
        post "path/kebab-case"
      end
    RUBY
  end

  it "does not register an offense when using namespace with a path in kebab-case format" do
    expect_no_offenses(<<~RUBY)
      class Test < Grape::API
        namespace "path/kebab-case"
      end
    RUBY
  end

  it "does not register an offense when using a symbol namespace without any underscores" do
    expect_no_offenses(<<~RUBY)
      class Test < Grape::API
        namespace :path
      end
    RUBY
  end

  it "registers an offense when using get with a path that contains underscores" do
    expect_offense(<<~RUBY)
      class Test < Grape::API
        get "path/snake_case"
        ^^^^^^^^^^^^^^^^^^^^^ Use kebab-case for the API path
      end
    RUBY
  end

  it "registers an offense when using post with a path that contains underscores" do
    expect_offense(<<~RUBY)
      class Test < Grape::API
        post "path/snake_case"
        ^^^^^^^^^^^^^^^^^^^^^^ Use kebab-case for the API path
      end
    RUBY
  end

  it "registers an offense when using put with a path that contains underscores" do
    expect_offense(<<~RUBY)
      class Test < Grape::API
        put "path/snake_case"
        ^^^^^^^^^^^^^^^^^^^^^ Use kebab-case for the API path
      end
    RUBY
  end

  it "registers an offense when using patch with a path that contains underscores" do
    expect_offense(<<~RUBY)
      class Test < Grape::API
        patch "path/snake_case"
        ^^^^^^^^^^^^^^^^^^^^^^^ Use kebab-case for the API path
      end
    RUBY
  end

  it "registers an offense when using delete with a path that contains underscores" do
    expect_offense(<<~RUBY)
      class Test < Grape::API
        delete "path/snake_case"
        ^^^^^^^^^^^^^^^^^^^^^^^^ Use kebab-case for the API path
      end
    RUBY
  end

  it "registers an offense when using namespace with a path that contains underscores" do
    expect_offense(<<~RUBY)
      class Test < Grape::API
        namespace "path/snake_case"
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use kebab-case for the API path
      end
    RUBY
  end

  it "registers an offense when using namespace with a symbol path that contains underscores" do
    expect_offense(<<~RUBY)
      class Test < Grape::API
        namespace :snake_case
        ^^^^^^^^^^^^^^^^^^^^^ Use kebab-case for the API path
      end
    RUBY
  end

  it "does not register an offense when there is an underscore in the path parameter" do
    expect_no_offenses(<<~RUBY)
      class Test < Grape::API
        get "/test/:snake_case_id/kebab-case"
      end
    RUBY
  end
end
