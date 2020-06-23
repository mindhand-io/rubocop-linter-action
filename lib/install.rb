# frozen_string_literal: true

class Install


  attr_reader :config

  def initialize(config)
    @config = Hash(config)
  end

  def run
    #return system("bundle install") if config.fetch("bundle", false)

    system("gem install rubocop -v 0.76.0 && gem install rubocop-airbnb")
  end

  private




end
