# Requirements: Course Registration

## Vision

A course provider offers courses (for example, "Spring Boot Fundamentals" or "jOOQ Deep Dive"). Today, people
register by email and an employee keeps the list of participants in a spreadsheet. The new web application lets
course administrators publish courses and lets participants register for a course, see their registrations, and
cancel them.

## Functional Requirements (FR)

| ID     | Title                 | User Story                                                                                                           | Status   |
|--------|-----------------------|----------------------------------------------------------------------------------------------------------------------|----------|
| FR-001 | Create Course         | As a course administrator, I want to create a course so that participants can register for it.                       | Approved |
| FR-002 | Browse Courses        | As a participant, I want to see the courses that are open for registration so that I can choose one.                | Approved |
| FR-003 | Register for Course   | As a participant, I want to register for a course so that I have a seat.                                             | Approved |
| FR-004 | Waiting List          | As a participant, I want to be put on the waiting list when a course is full so that I can still get a seat later.   | Approved |
| FR-005 | Cancel Registration   | As a participant, I want to cancel my registration so that my seat is free for somebody else.                        | Approved |
| FR-006 | View My Registrations | As a participant, I want to see my registrations so that I know which courses I attend.                              | Approved |

### Acceptance Criteria

In the acceptance criteria, "I" is the role of the user story: the course administrator in FR-001, the participant in
FR-002 to FR-006. Other participants are named in the third person.

#### FR-001 Create Course

**Scenarios**

- Given I choose to create a course, then the system displays an empty course form.
- Given a valid course, when I save, then the course is stored with all its attributes, with free seats equal to its
  capacity and an empty waiting list, and it is shown in the course list.
- Given the registration deadline is empty, when I save, then the registration deadline is the day before the start
  date, and all other rules are still checked.
- Given one or more fields are invalid, when I save, then the system marks every invalid field with a message that
  names the violated rule, keeps all entered values, stores nothing, and I can correct the input.
- Given a course with the same title (ignoring upper and lower case) and the same start date exists, when I save,
  then the system displays a message that this course already exists, stores nothing, and I can correct the input.
- Given I leave the form without saving, then the system discards the entered values and stores nothing.

**Rules**

- A course has a title, a description, a start date, an end date, a location, a capacity, a price in CHF, and a
  registration deadline.
- Only a course administrator (role ADMIN) can create a course.
- Title, start date, end date, capacity, and price are mandatory. Description, location, and registration deadline
  are optional.
- The title has at most 100 characters.
- The capacity is a whole number from 1 to 100.
- The start date must be after today.
- The end date must not be before the start date. A course with the same start and end date lasts one day.
- The registration deadline must not be in the past and must be before the start date.
- The price is in CHF, 0 or more, with at most two decimal places. A price of 0 means the course is free of charge.

#### FR-002 Browse Courses

**Scenarios**

- Given I open the course list, then the system displays the open courses, sorted by start date, with title, start
  date, end date, location, price, and the number of free seats.
- Given I leave the course list without choosing a course, then the system stores nothing.

**Rules**

- A course is open for registration when its start date is after today and its registration deadline is today or
  later. The list shows only open courses.
- The free seats of a course are its capacity minus its registrations with the status Confirmed.
- A course without free seats is still open: it stays in the list and is marked as full.

#### FR-003 Register for Course

**Scenarios**

- Given a course with free seats, when I register, then the system displays a summary with the course, the price, and
  the cancellation conditions (the cancellation fee of FR-005) and asks me to confirm.
- Given the summary, when I confirm, then the system checks again that a free seat is left, stores my registration
  with the status Confirmed, displays a confirmation, and the number of free seats decreases by one.
- Given the summary, when I do not confirm, then the system stores nothing.
- Given I already hold a registration for a course with the status Confirmed or Waiting, when I register again, then
  the system rejects the registration and displays the existing registration with its status.
- Given the registration deadline passed since the list was displayed, when I register, then the system displays a
  message that registration for this course is closed.
- Given I hold a confirmed registration for another course whose dates overlap, when I register and the registration
  would be confirmed, then the system rejects it with a message that names the overlapping course.
- Given another participant took the last free seat after the check, when I confirm, then the system informs me that
  the last seat was just taken and checks my registration again as if I had just registered.

**Rules**

- When I register, the system checks in this order, and the first failed check decides the result: I hold no
  registration for this course with the status Confirmed or Waiting, the registration deadline has not passed, the
  course has a free seat (without one, FR-004 applies), and my dates do not overlap with a confirmed registration.
- A cancelled registration does not count: after cancelling, I may register again and get a new registration.
- Registration is possible until the end of the registration deadline day.
- I cannot hold confirmed registrations for two courses whose date ranges overlap. Both start and end date count as
  course days. The overlap is checked only when the registration would be confirmed: a place on the waiting list may
  overlap with another course.
- When a registration fails, no registration is stored, the free seats and the waiting list of the course are
  unchanged, and the course never has more confirmed registrations than its capacity.

#### FR-004 Waiting List

**Scenarios**

- Given a course without free seats and with a free place on the waiting list, when I register, then the system
  informs me that the course is full, shows the position I would get on the waiting list, and asks me to confirm.
- Given the position on the waiting list, when I confirm, then my registration is stored with the status Waiting and
  its position.
- Given a course without free seats and with a full waiting list, when I register, then the system informs me that
  the course and its waiting list are full and stores nothing.
- Given a registration with position 1, when a seat becomes free, then that registration gets the status Confirmed at
  once, without asking the promoted participant, and every other registration on the waiting list moves up by one
  position.
- Given the registration deadline of the course has passed, when a seat becomes free, then the seat stays free, nobody
  is promoted, and the waiting list stays unchanged.
- Given the first waiting participant holds a confirmed registration for an overlapping course, when a seat becomes
  free, then that waiting registration is not promoted. It is cancelled with a fee of 0, and the next registration on
  the waiting list is considered.
- Given the waiting list is empty, when a seat becomes free, then the seat stays free.

**Rules**

- The waiting list is first come, first served by the time of registration. The first registration has position 1.
- A course has at most 10 registrations with the status Waiting.
- The positions on the waiting list have no gaps and start at 1.

#### FR-005 Cancel Registration

**Scenarios**

- Given a confirmed registration, when I choose to cancel it, then the system calculates the fee and asks me to
  confirm the cancellation with this fee.
- Given a confirmed registration, when I confirm the cancellation, then the registration is kept with the status
  Cancelled, the cancellation date, and the fee, the free seat is handled as described in FR-004, and the system
  displays a confirmation with the fee.
- Given a registration with the status Waiting, when I choose to cancel it, then the system asks me to confirm the
  cancellation without a fee, sets the status to Cancelled with the cancellation date and a fee of 0, and moves every
  later registration on the waiting list up by one position.
- Given I do not confirm the cancellation, then the system changes nothing.
- Given the start date of the course is today or in the past, when I choose to cancel, then the system displays a
  message that the registration can no longer be cancelled.

**Rules**

- I can cancel a registration that I made and that has the status Confirmed or Waiting, from the list of my
  registrations.
- A registration can be cancelled until the day before the start date of the course.
- The fee depends on the number of calendar days from the cancellation date to the start date of the course: 7 days or
  more costs nothing, fewer than 7 days costs 50% of the price. The fee is rounded to 0.05 CHF. Example: for a course
  starting on 15 March, a cancellation on 8 March is free, a cancellation on 9 March costs 50%.
- Cancelling a registration with the status Waiting never costs a fee.
- When a cancellation fails, the registration keeps its status, and the waiting list and the free seats of the course
  are unchanged.

#### FR-006 View My Registrations

**Scenarios**

- Given I open the list of my registrations, then the list shows the course title, the start date, the end date, the
  location, and the status of each registration, sorted by start date.
- Given I choose to include past courses, then the list adds the registrations for courses whose end date is before
  today.
- Given I have no registration to show, then the system displays a message that there are no registrations and offers
  a way to the course list.

**Rules**

- I see only my own registrations, never those of other participants.
- By default, the list shows the registrations for courses whose end date is today or later, with every status.
- A registration shows one of these statuses: Confirmed; Waiting together with the current position on the waiting
  list; Cancelled together with the cancellation fee in CHF, where a fee of 0 is shown as "free of charge".

## Non-Functional Requirements (NFR)

| ID      | Title         | Requirement                                                                        | Category  | Priority | Status |
|---------|---------------|------------------------------------------------------------------------------------|-----------|----------|--------|
| NFR-001 | Response Time | Every page of the application loads within 2 seconds with 50 concurrent users.     | Performance | Medium | Open   |
| NFR-002 | Authentication | Every page except the login page requires a signed-in user.                       | Security  | High     | Open   |

## Constraints (C)

| ID    | Title           | Constraint                                                                          | Category  | Priority | Status |
|-------|-----------------|-------------------------------------------------------------------------------------|-----------|----------|--------|
| C-001 | Technology      | The application uses Java, Spring Boot, Vaadin Flow, jOOQ, Flyway, and PostgreSQL.  | Technical | High     | Open   |
| C-002 | No Notification | The first release sends no emails or other notifications.                           | Business  | High     | Open   |
| C-003 | Currency        | All prices and fees are in Swiss francs (CHF).                                      | Business  | High     | Open   |
