Feature: Grade homeworks

  Scenario: Grade a homework
    Given a Grader
    When Grader get the path of the zip file "fixtures/20120227.zip"
    Then Grader should get valid_zip_filename? "true"
