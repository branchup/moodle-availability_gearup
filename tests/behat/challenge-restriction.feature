@availability @availability_gearup @javascript
Feature: Testing that activity access can be based on challenges

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
    And the following "block_gearup > challenges" exist:
      | title          | course | instructions       | repeatmode |
      | Challenge 1    | c1     | This is what to do | 0          |
    And the following "activities" exist:
      | activity | course | name   |
      | page     | c1     | Page 1 |
      | page     | c1     | Page 2 |
      | page     | c1     | Page 3 |
      | page     | c1     | Page 4 |
      | page     | c1     | Page 5 |
      | page     | c1     | Page 6 |

    And I am on the "Page 1" "page activity editing" page logged in as "t1"
    And I expand all fieldsets
    And I press "Add restriction..."
    And I click on "Level Up Quest" "button" in the "Add restriction..." "dialogue"
    And I click on "Click to hide" "link" in the ".availability-children" "css_element"
    And I set the following fields in the "Restrict access" "fieldset" to these values:
      | Mission        | Challenge 1        |
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
      | Mission        | Challenge 1        |
      | mode           | has started        |
    And I press "Save and return to course"

    And I am on the "Page 3" "page activity editing" page logged in as "t1"
    And I expand all fieldsets
    And I press "Add restriction..."
    And I click on "Level Up Quest" "button" in the "Add restriction..." "dialogue"
    And I click on "Click to hide" "link" in the ".availability-children" "css_element"
    And I set the following fields in the "Restrict access" "fieldset" to these values:
      | Mission        | Challenge 1            |
      | mode           | has been recruited for |
    And I press "Save and return to course"

    And I am on the "Page 4" "page activity editing" page logged in as "t1"
    And I expand all fieldsets
    And I press "Add restriction..."
    And I click on "Level Up Quest" "button" in the "Add restriction..." "dialogue"
    And I click on "Click to hide" "link" in the ".availability-children" "css_element"
    And I set the following fields in the "Restrict access" "fieldset" to these values:
      | Mission        | Challenge 1   |
      | mode           | is assigned   |
    And I press "Save and return to course"

    And I am on the "Page 5" "page activity editing" page logged in as "t1"
    And I expand all fieldsets
    And I press "Add restriction..."
    And I click on "Level Up Quest" "button" in the "Add restriction..." "dialogue"
    And I click on "Click to hide" "link" in the ".availability-children" "css_element"
    And I set the following fields in the "Restrict access" "fieldset" to these values:
      | Mission        | Challenge 1   |
      | mode           | is ongoing    |
    And I press "Save and return to course"

    And I am on the "Page 6" "page activity editing" page logged in as "t1"
    And I expand all fieldsets
    And I press "Add restriction..."
    And I click on "Level Up Quest" "button" in the "Add restriction..." "dialogue"
    And I click on "Click to hide" "link" in the ".availability-children" "css_element"
    And I set the following fields in the "Restrict access" "fieldset" to these values:
      | Mission        | Challenge 1     |
      | mode           | is finished     |
    And I press "Save and return to course"

  Scenario: Students access restriction for non-repeating challenges
    Given I am on the "Challenge 1" "block_gearup > challenge recruits" page logged in as "t1"
    And I press "Recruit users"
    And I set the field "Users to recruit" to "Student One"
    And I press "Save changes"

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
    And I follow "Challenge 1"
    And I choose the "View" item in the "Menu" action menu
    And I press "Increment"
    And I press "Confirm"
    And I press "Finalise"
    And I click on "Finalise" "button" in the "Finalise mission" "dialogue"

    And I am on the "c1" "course" page logged in as "s1"
    And I should see "Page 1"
    And I should see "Page 2"
    And I should see "Page 3"
    And I should not see "Page 4"
    And I should not see "Page 5"
    And I should see "Page 6"

  Scenario: Students access restriction for repeating challenges
    Given I am on the "Challenge 1" "block_gearup > challenge" page logged in as "t1"
    And I click on "[data-form-class*=\"timing\"]" "css_element"
    And I set the field "Time to complete" to "1 day"
    And I click on "Repeat indefinitely" "radio"
    And I press "Save changes"
    And I follow "Recruits"
    And I press "Recruit users"
    And I set the field "Users to recruit" to "Student One"
    And I press "Save changes"

    When I am on the "c1" "course" page logged in as "s1"
    Then I should not see "Page 1"
    And I should see "Page 2"
    And I should see "Page 3"
    And I should not see "Page 4"
    And I should see "Page 5"
    And I should not see "Page 6"

    And I am on the "Challenge 1" "block_gearup > challenge recruits" page logged in as "t1"
    And I follow "Student One"
    And I choose the "View" item in the "Menu" action menu
    And I press "Increment"
    And I press "Confirm"

    And I am on the "c1" "course" page logged in as "s1"
    And I should see "Page 1"
    And I should see "Page 2"
    And I should see "Page 3"
    And I should not see "Page 4"
    And I should not see "Page 5"
    And I should not see "Page 6"

    And I am on the "Challenge 1" "block_gearup > challenge recruits" page logged in as "t1"
    And I follow "Student One"
    And I choose the "View" item in the "Menu" action menu
    And I press "Finalise"
    And I click on "Finalise" "button" in the "Finalise mission" "dialogue"

    And I am on the "c1" "course" page logged in as "s1"
    And I should see "Page 1"
    And I should see "Page 2"
    And I should see "Page 3"
    And I should not see "Page 4"
    And I should not see "Page 5"
    And I should see "Page 6"

    And I click on "Challenge 1" "link"
    And I should not see "Completed" in the "Challenge" "dialogue"
