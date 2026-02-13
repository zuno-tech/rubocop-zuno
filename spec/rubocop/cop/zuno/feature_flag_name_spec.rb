# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Zuno::FeatureFlagName, :config do
  let(:rollout_file) { "lib/tasks/seed/rollout.rake" }

  context "when in rollout.rake inside task rollout" do
    it "registers an offense for flag names with hyphens" do
      expect_offense(<<~RUBY, rollout_file)
        task rollout: :environment do
          %w[
            dash-flag
            ^^^^^^^^^ Use only lowercase letters, numbers, and underscores for feature flag names (e.g., feature_flag instead of feature-flag)
          ]
        end
      RUBY
    end

    it "registers an offense for flag names with uppercase letters" do
      expect_offense(<<~RUBY, rollout_file)
        task rollout: :environment do
          %w[
            Upper_Flag
            ^^^^^^^^^^ Use only lowercase letters, numbers, and underscores for feature flag names (e.g., feature_flag instead of feature-flag)
          ]
        end
      RUBY
    end

    it "registers offenses for multiple invalid flags" do
      expect_offense(<<~RUBY, rollout_file)
        task rollout: :environment do
          %w[
            valid_flag
            dash-flag
            ^^^^^^^^^ Use only lowercase letters, numbers, and underscores for feature flag names (e.g., feature_flag instead of feature-flag)
            Upper_Flag
            ^^^^^^^^^^ Use only lowercase letters, numbers, and underscores for feature flag names (e.g., feature_flag instead of feature-flag)
          ]
        end
      RUBY
    end

    it "does not register an offense for single-word flag names" do
      expect_no_offenses(<<~RUBY, rollout_file)
        task rollout: :environment do
          %w[feature_flag]
        end
      RUBY
    end

    it "does not register an offense for multiple valid snake_case flag names" do
      expect_no_offenses(<<~RUBY, rollout_file)
        task rollout: :environment do
          %w[
            feature_flag
            another_feature_flag
          ]
        end
      RUBY
    end

    it "does not register an offense for flag names with numbers" do
      expect_no_offenses(<<~RUBY, rollout_file)
        task rollout: :environment do
          %w[feature_flag_2]
        end
      RUBY
    end
  end

  context "when in rollout.rake but not inside task rollout" do
    it "does not register an offense for arrays in a different task" do
      expect_no_offenses(<<~RUBY, rollout_file)
        task other_task: :environment do
          %w[dash-flag]
        end
      RUBY
    end

    it "does not register an offense for arrays outside any task" do
      expect_no_offenses(<<~RUBY, rollout_file)
        %w[dash-flag]
      RUBY
    end
  end

  context "when not in rollout.rake" do
    it "does not register an offense in other files" do
      expect_no_offenses(<<~RUBY)
        task rollout: :environment do
          %w[dash-flag]
        end
      RUBY
    end
  end
end
