Feature: Grade homeworks

  Scenario: Grade a homework
    Given a Grader
    When Grader get the path of the zip file "fixtures/20120227.zip"
    Then Grader should get valid_zip_filename? "true"
    And Grader should get yourid "20120227"
    And Grader should get pyfilename "20120227.py"
    And Grader should get wldfilename "20120227.wld"
    And Grader should get docfilename "20120227.docx"
