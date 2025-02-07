@availability @availability_gearup
Feature: Testing that activity access can be based on achievements

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
    And the following "block_gearup > achievements" exist:
      | title          | course | instructions       |
      | Achievement 1  | c1     | This is what to do |
    And the following "block_gearup > recruits" exist:
      | mission          | user   |
      | Achievement 1    | s1     |
    And the following "activities" exist:
      | activity | course | name   |
      | page     | c1     | Page 1 |
      | page     | c1     | Page 2 |
      | page     | c1     | Page 3 |
      | page     | c1     | Page 4 |
      | page     | c1     | Page 5 |
      | page     | c1     | Page 6 |

  @javascript
  Scenario: Students access restriction for achievements
    And I am on the "Page 1" "page activity editing" page logged in as "t1"
    And I expand all fieldsets
    And I press "Add restriction..."
    And I click on "Level Up Quest" "button" in the "Add restriction..." "dialogue"
    And I click on "Click to hide" "link" in the ".availability-children" "css_element"
    And I set the following fields in the "Restrict access" "fieldset" to these values:
      | Mission        | Achievement 1      |
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
      | Mission        | Achievement 1      |
      | mode           | has started        |
    And I press "Save and return to course"

    And I am on the "Page 3" "page activity editing" page logged in as "t1"
    And I expand all fieldsets
    And I press "Add restriction..."
    And I click on "Level Up Quest" "button" in the "Add restriction..." "dialogue"
    And I click on "Click to hide" "link" in the ".availability-children" "css_element"
    And I set the following fields in the "Restrict access" "fieldset" to these values:
      | Mission        | Achievement 1          |
      | mode           | has been recruited for |
    And I press "Save and return to course"

    And I am on the "Page 4" "page activity editing" page logged in as "t1"
    And I expand all fieldsets
    And I press "Add restriction..."
    And I click on "Level Up Quest" "button" in the "Add restriction..." "dialogue"
    And I click on "Click to hide" "link" in the ".availability-children" "css_element"
    And I set the following fields in the "Restrict access" "fieldset" to these values:
      | Mission        | Achievement 1 |
      | mode           | is assigned   |
    And I press "Save and return to course"

    And I am on the "Page 5" "page activity editing" page logged in as "t1"
    And I expand all fieldsets
    And I press "Add restriction..."
    And I click on "Level Up Quest" "button" in the "Add restriction..." "dialogue"
    And I click on "Click to hide" "link" in the ".availability-children" "css_element"
    And I set the following fields in the "Restrict access" "fieldset" to these values:
      | Mission        | Achievement 1 |
      | mode           | is ongoing    |
    And I press "Save and return to course"

    And I am on the "Page 6" "page activity editing" page logged in as "t1"
    And I expand all fieldsets
    And I press "Add restriction..."
    And I click on "Level Up Quest" "button" in the "Add restriction..." "dialogue"
    And I click on "Click to hide" "link" in the ".availability-children" "css_element"
    And I set the following fields in the "Restrict access" "fieldset" to these values:
      | Mission        | Achievement 1   |
      | mode           | is finished     |
    And I press "Save and return to course"

    When I am on the "c1" "course" page logged in as "s1"
    Then I should not see "Page 1"
    And I should see "Page 2"
    And I should see "Page 3"
    And I should not see "Page 4"
    And I should see "Page 5"
    And I should not see "Page 6"

    And I am on the "c1" "course" page logged in as "t1"
    And I click on "Manage" "link" in the "Level Up Quest" "block"
    And I follow "Recruits"
    And I follow "Student One"
    And I follow "Achievement 1"
    And I press "Mark complete"
    And I click on "Mark complete" "button" in the "Mark complete" "dialogue"

    And I am on the "c1" "course" page logged in as "s1"
    And I should see "Page 1"
    And I should see "Page 2"
    And I should see "Page 3"
    And I should not see "Page 4"
    And I should not see "Page 5"
    And I should see "Page 6"
