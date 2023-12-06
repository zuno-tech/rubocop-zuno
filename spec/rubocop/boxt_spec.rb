# frozen_string_literal: true

RSpec.describe RuboCop::Boxt do
  let(:current_version) { File.read("VERSION").split("\n").first }

  it "has a version number" do
    expect(RuboCop::Boxt::VERSION).not_to be_nil
  end

  it "is set from the VERSION file" do
    expect(RuboCop::Boxt::VERSION).to eq(current_version)
  end
end
