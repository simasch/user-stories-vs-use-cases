# Requirements: Course Registration

## Vision

A course provider offers courses (for example, "Spring Boot Fundamentals" or "jOOQ Deep Dive"). Today, people
register by email and an employee keeps the list of participants in a spreadsheet. The new web application lets
course administrators publish courses and lets participants register for a course, see their registrations, and
cancel them.

## Functional Requirements

The functional requirements are specified as use cases, see [use_cases.puml](use_cases.puml) and
[use_cases/](use_cases).

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
