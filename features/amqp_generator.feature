Feature: Bunny generator provides some additional infrastructure

  Scenario: Using Bunny generator when generating a new daemon
    When I run `daemon-kit vuvuzela -i bunny`
    And I cd to "vuvuzela"
    Then the following files should exist:
      | config/bunny.yml |
      | config/pre-daemonize/bunny.rb |
      | libexec/vuvuzela-daemon.rb |
    And the file "Gemfile" should contain:
    """
    gem 'bunny'
    """

  Scenario: Using Bunny generator on an existing daemon
    Given I have an existing daemon called "vuvuzela"
    And I cd to "vuvuzela"
    When I run `./script/generate bunny` interactively
    And I accept the conflicts
    Then the following files should exist:
      | config/bunny.yml |
      | config/pre-daemonize/bunny.rb |
      | libexec/vuvuzela-daemon.rb |
    And the file "Gemfile" should contain:
    """
    gem 'bunny'
    """
