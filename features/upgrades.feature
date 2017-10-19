Feature: Upgrading an older daemon

  daemon-kit offers help during upgrades to newer versions.

  Scenario: Upgrading from 0.2.3
    Given I have a daemon generated by daemon-kit "0.2.3"
    And I cd to the old project
    When I run `rake daemon_kit:upgrade` interactively
    And I accept the conflicts
    Then the file "Gemfile" should contain "gem 'daemon-kit', :github => 'kennethkalmer/daemon-kit'"
    And the file "config/boot.rb" should not contain "VendorBoot"
