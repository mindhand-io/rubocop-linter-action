# frozen_string_literal: true

class Install
  DEFAULT_DEPENDENCIES = {
    "rubocop" => "latest",
    "rubocop-airbnb" => "latest"
  }.freeze

  attr_reader :config

  def initialize(config)
    @config = Hash(config)
  end

  def run
    config_graphql_pro
    return system("bundle install") if config.fetch("bundle", false)

    system("gem install #{dependencies}")
  end

  private

  def config_graphql_pro
    system("bundle config gems.graphql.pro #{ENV['GRAPHQL_NAME']}:#{ENV['GRAPHQL_PASSWORD']}") if config.fetch("bundle", false)
  end

  def dependencies
    DEFAULT_DEPENDENCIES.merge(custom_dependencies).map(&method(:version_string)).join(" ")
  end

  def custom_dependencies
    Hash[config.fetch("versions", []).map(&method(:version))]
  end

  def version(dependency)
    case dependency
    when Hash
      dependency.first
    else
      [dependency, "latest"]
    end
  end

  def version_string(dependency, version)
    version == "latest" ? dependency : "#{dependency}:#{version}"
  end
end
