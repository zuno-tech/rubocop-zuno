# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Zuno::ApiTypeParameters, :config do
  def expect_no_offenses_in_class(parent_class, class_body)
    expect_no_offenses(<<~RUBY)
      class Test < #{parent_class}
        #{class_body}
      end
    RUBY
  end

  def expect_offense_in_class(parent_class, class_body, marker_line, message)
    expect_offense(<<~RUBY)
      class Test < #{parent_class}
        #{class_body}
        #{marker_line} #{message}
      end
    RUBY
  end

  def grape_api_params(body)
    <<~RUBY
      params do
        #{body}
      end
    RUBY
  end

  def missing_type_message
    "Ensure each parameter has a type specified, e.g., `type: String`."
  end

  def missing_entity_type_message
    "Ensure each parameter has a type specified, e.g., `documentation: { type: String }`."
  end

  def expect_missing_api_type_offense(param_call, marker_line)
    expect_offense_in_class("Grape::API", grape_api_params(param_call), marker_line, missing_type_message)
  end

  def expect_missing_entity_type_offense
    expect_offense_in_class("Grape::Entity", "expose :name", "^^^^^^^^^^^^", missing_entity_type_message)
  end

  context "when checking Grape::API parameters" do
    it "does not register an offense when required parameter has type set" do
      expect_no_offenses_in_class("Grape::API", grape_api_params("requires :name, type: String"))
    end

    it "does not register an offense when required parameter has type set alongside other parameters" do
      expect_no_offenses_in_class("Grape::API", grape_api_params("requires :name, type: String, foo: 123"))
    end

    it "does not register an offense when optional parameter has type set" do
      expect_no_offenses_in_class("Grape::API", grape_api_params("optional :age, type: Integer"))
    end

    it "does not register an offense when optional parameter has type set alongside other parameters" do
      expect_no_offenses_in_class("Grape::API", grape_api_params("optional :age, type: Integer, foo: 123"))
    end

    it "registers an offense when required parameter has no type set" do
      expect_missing_api_type_offense("requires :name", "^^^^^^^^^^^^^^")
    end

    it "registers an offense when optional parameter has no type set" do
      expect_missing_api_type_offense("optional :age", "^^^^^^^^^^^^^")
    end
  end

  context "when checking Grape::Entity parameters" do
    it "does not register an offense when parameter has type set" do
      expect_no_offenses_in_class("Grape::Entity", "expose :name, documentation: { type: String }")
    end

    it "does not register an offense when parameter has type set alongside other parameters" do
      expect_no_offenses_in_class(
        "Grape::Entity",
        "expose :name, documentation: { type: String, desc: \"some description\" }, foo: 123"
      )
    end

    it "registers an offense when parameter has no type set" do
      expect_missing_entity_type_offense
    end
  end

  it "does not register an offense when the class isn't a Grape API" do
    expect_no_offenses_in_class("Object", grape_api_params("requires :name"))
  end
end
