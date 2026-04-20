# frozen_string_literal: true

require "fileutils"
require "stringio"
require "tmpdir"

RSpec.describe RuboCop::Zuno do
  def current_version
    File.read("VERSION").split("\n").first
  end

  def example_file_contents
    "# frozen_string_literal: true\n"
  end

  def base_config
    <<~YAML
      plugins:
        - rubocop-zuno
    YAML
  end

  def base_files
    { "example.rb" => example_file_contents }
  end

  def rails_config
    <<~YAML
      #{base_config}
      inherit_gem:
        rubocop-zuno:
          - rails.yml
    YAML
  end

  def rspec_config
    <<~YAML
      #{base_config}
      inherit_gem:
        rubocop-zuno:
          - rspec.yml
    YAML
  end

  def todo_config
    <<~YAML
      #{base_config}
      inherit_from:
        - .rubocop_todo.yml
    YAML
  end

  def todo_files
    base_files.merge(
      ".rubocop_todo.yml" => <<~YAML
        Performance/CollectionLiteralInLoop:
          Exclude:
            - example.rb
      YAML
    )
  end

  it "has a version number" do
    expect(RuboCop::Zuno::VERSION).not_to be_nil
  end

  it "is set from the VERSION file" do
    expect(RuboCop::Zuno::VERSION).to eq(current_version)
  end

  describe "plugin integration" do
    def write_files(dir, files)
      files.each do |relative_path, contents|
        path = File.join(dir, relative_path)
        FileUtils.mkdir_p(File.dirname(path))
        File.write(path, contents)
      end
    end

    def capture_output
      stdout = StringIO.new
      stderr = StringIO.new
      original_stdout = $stdout
      original_stderr = $stderr
      $stdout = stdout
      $stderr = stderr

      [yield, stdout.string, stderr.string]
    ensure
      $stdout = original_stdout
      $stderr = original_stderr
    end

    def rubocop_status(config_path, target_path)
      RuboCop::CLI.new.run(["--config", config_path, target_path])
    end

    def run_rubocop_with(config:, files: {})
      Dir.mktmpdir do |dir|
        write_files(dir, files)

        config_path = File.join(dir, ".rubocop.yml")
        File.write(config_path, config)
        target_path = File.join(dir, "example.rb")

        capture_output { rubocop_status(config_path, target_path) }
      end
    end

    def expect_rubocop_to_succeed(config:, files: {})
      status, stdout, stderr = run_rubocop_with(config:, files:)

      expect(status).to eq(0), "Expected RuboCop to succeed, got stdout: #{stdout}\nstderr: #{stderr}"
    end

    it "loads the base plugin config" do
      expect_rubocop_to_succeed(config: base_config, files: base_files)
    end

    it "parses Rails cops when inheriting rails.yml" do
      expect_rubocop_to_succeed(config: rails_config, files: base_files)
    end

    it "parses RSpec cops when inheriting rspec.yml" do
      expect_rubocop_to_succeed(config: rspec_config, files: base_files)
    end

    it "parses Performance cops from inherited todo config" do
      expect_rubocop_to_succeed(config: todo_config, files: todo_files)
    end
  end
end
