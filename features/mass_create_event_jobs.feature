Feature: mass create event's jobs
  As someone who has previously created an event
  I want to see a list of all the jobs which should be created
  Which can be created after I have approved and edited them
  So I don't have to create each job individually for each new event
  Scenario: Mass create event's jobs
    Given An event
    When I go to the create event jobs page
    And Change some details and submit the form
    Then All those jobs should be created with my changes
    And The event should be marked that the jobs are finalized