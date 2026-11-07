# Oracle

The intended behavior of the course registration application. The product owner knows all of these rules. The
question of the experiment is how many of them an AI coding agent gets right when it only has the specification of
the project folder.

**Never copy this file into a project folder.** The agent must not see it.

Column **In** says where the rule is written down:

- **S** = in the user stories and acceptance criteria (`docs/requirements.md`, present in both projects)
- **U** = only in the use cases (`docs/use_cases/`, present only in the use-cases project)

## Create Course

| ID   | Expected behavior                                                                          | In | Source           |
|------|--------------------------------------------------------------------------------------------|----|------------------|
| O-01 | Only a course administrator (role ADMIN) can create a course                               | S  | FR-001           |
| O-02 | Title, start date, end date, capacity, and price are mandatory                             | S  | FR-001           |
| O-03 | Capacity must be greater than 0                                                            | S  | FR-001           |
| O-04 | End date must not be before the start date                                                 | S  | FR-001           |
| O-05 | Capacity is at most 100                                                                    | U  | UC-001 BR-002    |
| O-06 | Start date must be after today                                                             | U  | UC-001 BR-003    |
| O-07 | Registration deadline is optional; empty means the day before the start date              | U  | UC-001 BR-004    |
| O-08 | Registration deadline must be before the start date and not in the past                   | U  | UC-001 BR-004    |
| O-09 | Price is 0 or more with at most two decimal places; 0 means free of charge                 | U  | UC-001 BR-005    |
| O-10 | Same title (case-insensitive) and same start date is rejected as duplicate                | U  | UC-001 BR-006    |
| O-11 | Title has at most 100 characters                                                           | U  | UC-001 BR-001    |
| O-12 | Invalid input keeps all entered values and marks every invalid field                       | U  | UC-001 A1        |

## Register for Course

| ID   | Expected behavior                                                                          | In | Source           |
|------|--------------------------------------------------------------------------------------------|----|------------------|
| O-13 | The course list does not show courses that already started                                 | S  | FR-002           |
| O-14 | The course list shows the number of free seats                                             | S  | FR-002           |
| O-15 | A second active registration for the same course is rejected                              | S  | FR-003           |
| O-16 | Registration after the registration deadline is rejected                                  | S  | FR-003           |
| O-17 | A full course puts the participant on the waiting list                                     | S  | FR-004           |
| O-18 | The course list does not show courses whose registration deadline has passed              | U  | UC-002 BR-001    |
| O-19 | A full course stays in the list and is marked as full                                     | U  | UC-002 BR-001    |
| O-20 | Registration is still possible on the registration deadline day itself                    | U  | UC-002 BR-003    |
| O-21 | After a cancellation, the participant can register again for the same course              | U  | UC-002 BR-002    |
| O-22 | A confirmed registration for a course that overlaps another confirmed one is rejected     | U  | UC-002 BR-004    |
| O-23 | A place on the waiting list may overlap with another course                               | U  | UC-002 BR-004    |
| O-24 | The waiting list has at most 10 registrations                                              | U  | UC-002 BR-006    |
| O-25 | Before joining the waiting list, the participant sees the position and confirms           | U  | UC-002 A1        |
| O-26 | Before registering, the participant sees price and cancellation conditions and confirms   | U  | UC-002 step 5    |
| O-27 | The course never gets more confirmed registrations than its capacity (concurrent users)   | U  | UC-002 A7, failure postcondition |

## Cancel Registration

| ID   | Expected behavior                                                                          | In | Source           |
|------|--------------------------------------------------------------------------------------------|----|------------------|
| O-28 | The participant can cancel own registrations                                               | S  | FR-005           |
| O-29 | Cancelling fewer than 7 days before the start costs 50% of the price                      | S  | FR-005           |
| O-30 | The first participant on the waiting list gets the free seat                              | S  | FR-004           |
| O-31 | Cancelling exactly 7 calendar days before the start is free                               | U  | UC-003 BR-002    |
| O-32 | The fee is rounded to 0.05 CHF                                                             | U  | UC-003 BR-002    |
| O-33 | From the start date on, a registration can no longer be cancelled                         | U  | UC-003 BR-001    |
| O-34 | Cancelling a place on the waiting list is always free                                      | U  | UC-003 BR-003    |
| O-35 | The fee is shown and must be confirmed before the cancellation happens                    | U  | UC-003 step 4    |
| O-36 | The cancelled registration is kept with status Cancelled, cancellation date, and fee      | U  | UC-003 step 6    |
| O-37 | The positions on the waiting list move up without gaps                                     | U  | UC-003 BR-004    |
| O-38 | After the registration deadline, nobody is promoted and the seat stays free               | U  | UC-003 BR-005    |
| O-39 | A waiting participant with an overlapping confirmed course is skipped and cancelled free  | U  | UC-003 BR-006    |

## View My Registrations

| ID   | Expected behavior                                                                          | In | Source           |
|------|--------------------------------------------------------------------------------------------|----|------------------|
| O-40 | The list shows title, start date, and status                                               | S  | FR-006           |
| O-41 | By default, registrations for courses that already ended are hidden; they can be shown    | U  | UC-004 BR-001, A2 |
| O-42 | A waiting registration shows its current position                                          | U  | UC-004 BR-003    |
| O-43 | A cancelled registration shows its fee, a fee of 0 as "free of charge"                    | U  | UC-004 BR-003    |
| O-44 | The list is sorted by start date                                                           | U  | UC-004 step 2    |

## Whole System

| ID   | Expected behavior                                                                          | In | Source           |
|------|--------------------------------------------------------------------------------------------|----|------------------|
| O-45 | No email or other notification is sent                                                     | S  | C-002            |
