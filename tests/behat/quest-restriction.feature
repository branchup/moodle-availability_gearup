@availability @availability_gearup
Feature: Testing that activity access can be based on quests

  Background:
    Given I activate Level Up Quest
    And the following "courses" exist:
      | fullname  | shortname |
      | Course 1  | c1        |
    And the following "users" exist:
      | username | firstname | lastname |
      | t1       | Teacher   | One      |
      | s1       | Student   | One      |
    And the following "course enrolments" exist:
      | user     | course | role           |
      | t1       | c1     | editingteacher |
      | s1       | c1     | student      |
    And the following "blocks" exist:
      | blockname | contextlevel | reference |
      | gearup    | Course       | c1        |
    And the following "block_gearup > quests" exist:
      | title          | course | instructions       | startmode |
      | Quest 1        | c1     | This is what to do | 1         |
    And the following "block_gearup > recruits" exist:
      | mission          | user   |
      | Quest 1          | s1     |
    And the following "activities" exist:
      | activity | course | name   |
      | page     | c1     | Page 1 |
      | page     | c1     | Page 2 |
      | page     | c1     | Page 3 |
      | page     | c1     | Page 4 |
      | page     | c1     | Page 5 |
      | page     | c1     | Page 6 |

  @javascript
  Scenario: Students access restriction for quests
    Given I am on the "Page 1" "page activity editing" page logged in as "t1"
    And I expand all fieldsets
    And I press "Add restriction..."
    And I click on "Level Up Quest" "button" in the "Add restriction..." "dialogue"
    And I click on "Click to hide" "link" in the ".availability-children" "css_element"
    And I set the following fields in the "Restrict access" "fieldset" to these values:
      | Mission        | Quest 1            |
      | mode           | has been completed |
    And I press "Save and return to course"
    And I am on the "c1" "course" page logged in as "s1"
    And I should not see "Page 1"

    And I am on the "Page 2" "page activity editing" page logged in as "t1"
    And I expand all fieldsets
    And I press "Add restriction..."
    And I click on "Level Up Quest" "button" in the "Add restriction..." "dialogue"
    And I click on "Click to hide" "link" in the ".availability-children" "css_element"
    And I set the following fields in the "Restrict access" "fieldset" to these values:
      | Mission        | Quest 1            |
      | mode           | has started        |
    And I press "Save and return to course"

    And I am on the "Page 3" "page activity editing" page logged in as "t1"
    And I expand all fieldsets
    And I press "Add restriction..."
    And I click on "Level Up Quest" "button" in the "Add restriction..." "dialogue"
    And I click on "Click to hide" "link" in the ".availability-children" "css_element"
    And I set the following fields in the "Restrict access" "fieldset" to these values:
      | Mission        | Quest 1                |
      | mode           | has been recruited for |
    And I press "Save and return to course"

    And I am on the "Page 4" "page activity editing" page logged in as "t1"
    And I expand all fieldsets
    And I press "Add restriction..."
    And I click on "Level Up Quest" "button" in the "Add restriction..." "dialogue"
    And I click on "Click to hide" "link" in the ".availability-children" "css_element"
    And I set the following fields in the "Restrict access" "fieldset" to these values:
      | Mission        | Quest 1       |
      | mode           | is assigned   |
    And I press "Save and return to course"

    And I am on the "Page 5" "page activity editing" page logged in as "t1"
    And I expand all fieldsets
    And I press "Add restriction..."
    And I click on "Level Up Quest" "button" in the "Add restriction..." "dialogue"
    And I click on "Click to hide" "link" in the ".availability-children" "css_element"
    And I set the following fields in the "Restrict access" "fieldset" to these values:
      | Mission        | Quest 1       |
      | mode           | is ongoing    |
    And I press "Save and return to course"

    And I am on the "Page 6" "page activity editing" page logged in as "t1"
    And I expand all fieldsets
    And I press "Add restriction..."
    And I click on "Level Up Quest" "button" in the "Add restriction..." "dialogue"
    And I click on "Click to hide" "link" in the ".availability-children" "css_element"
    And I set the following fields in the "Restrict access" "fieldset" to these values:
      | Mission        | Quest 1         |
      | mode           | is finished     |
    And I press "Save and return to course"

    When I am on the "c1" "course" page logged in as "s1"
    Then I should not see "Page 1"
    And I should not see "Page 2"
    And I should see "Page 3"
    And I should see "Page 4"
    And I should not see "Page 5"
    And I should not see "Page 6"
    # Recruit accepts the quest.
    And I click on "Quest 1" "link"
    And I click on "Accept" "button" in the "You've got a quest!" "dialogue"
    And I click on "OK" "button" in the "You've got a quest!" "dialogue"
    And I should not see "Page 1"
    And I should see "Page 2"
    And I should see "Page 3"
    And I should not see "Page 4"
    And I should see "Page 5"
    And I should not see "Page 6"
    # Teacher completes the quest
    And I am on the "c1" "course" page logged in as "t1"
    And I click on "Manage" "link" in the "Level Up Quest" "block"
    And I follow "Recruits"
    And I follow "Student One"
    And I follow "Quest 1"
    And I press "Mark complete"
    And I click on "Mark complete" "button" in the "Mark complete" "dialogue"
    # Quest is completed
    And I am on the "c1" "course" page logged in as "s1"
    And I should see "Page 1"
    And I should see "Page 2"
    And I should see "Page 3"
    And I should not see "Page 4"
    And I should not see "Page 5"
    And I should not see "Page 6"
    # Recruits finished the quest.
    And I click on "Quest 1" "link"
    And I click on "Thank you" "button" in the "Quest 1" "dialogue"
    And I should see "Page 1"
    And I should see "Page 2"
    And I should see "Page 3"
    And I should not see "Page 4"
    And I should not see "Page 5"
    And I should see "Page 6"
