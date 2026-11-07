# Requirements: Course Registration

## Vision

A course provider offers courses (for example, "Spring Boot Fundamentals" or "jOOQ Deep Dive"). Today, people
register by email and an employee keeps the list of participants in a spreadsheet. The new web application lets
course administrators publish courses and lets participants register for a course, see their registrations, and
cancel them.

## Functional Requirements (FR)

| ID     | Title                 | User Story                                                                                                           | Priority | Status |
|--------|-----------------------|----------------------------------------------------------------------------------------------------------------------|----------|--------|
| FR-001 | Create Course         | As a course administrator, I want to create a course so that participants can register for it.                       | High     | Open   |
| FR-002 | Browse Courses        | As a participant, I want to see the courses that are open for registration so that I can choose one.                | High     | Open   |
| FR-003 | Register for Course   | As a participant, I want to register for a course so that I have a seat.                                             | High     | Open   |
| FR-004 | Waiting List          | As a participant, I want to be put on the waiting list when a course is full so that I can still get a seat later.   | High     | Open   |
| FR-005 | Cancel Registration   | As a participant, I want to cancel my registration so that my seat is free for somebody else.                        | High     | Open   |
| FR-006 | View My Registrations | As a participant, I want to see my registrations so that I know which courses I attend.                              | Medium   | Open   |

### Acceptance Criteria

#### FR-001 Create Course

- A course has a title, a description, a start date, an end date, a location, a capacity, a price in CHF, and a
  registration deadline.
- Title, start date, end date, capacity, and price are mandatory.
- The capacity must be greater than 0.
- The end date must not be before the start date.
- Only a course administrator can create a course.

#### FR-002 Browse Courses

- The list shows title, start date, location, price, and the number of free seats.
- Courses that already started are not shown.

#### FR-003 Register for Course

- Given a course with free seats, when I register, then my registration is confirmed and the number of free seats
  decreases by one.
- Given I am already registered for a course, when I register again, then the system rejects the registration.
- Registration is not possible after the registration deadline.

#### FR-004 Waiting List

- Given a course without free seats, when I register, then I am put on the waiting list.
- When a confirmed participant cancels, the first participant on the waiting list gets the seat.

#### FR-005 Cancel Registration

- I can cancel a registration that I made.
- If I cancel less than 7 days before the start of the course, I pay 50% of the price as a cancellation fee.

#### FR-006 View My Registrations

- The list shows the course title, the start date, and the status of each registration.

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
