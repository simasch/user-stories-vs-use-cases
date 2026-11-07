# Use Case: Register for Course

## Overview

**Use Case ID:** UC-002  
**Use Case Name:** Register for Course  
**Primary Actor:** Participant  
**Goal:** Get a seat in a course, or a place on its waiting list when the course is full  
**Trigger:** The Participant wants to attend a course  
**Status:** Approved  

**Requirements:** [NFR-002, C-003](../requirements.md)

## Preconditions

- Participant is signed in
- At least one course exists (UC-001)

## Main Success Scenario

1. Participant opens the course list.
2. System displays the open courses (BR-001) with title, start date, end date, location, price, and free seats (BR-007).
3. Participant selects a course and chooses to register.
4. System checks in this order, and the first failed check decides the flow: the Participant holds no registration for this course with the status Confirmed or Waiting (BR-002), the registration deadline has not passed (BR-003), the course has a free seat, and the dates do not overlap with a confirmed registration (BR-004).
5. System displays a summary with the course, the price, and the cancellation conditions (UC-003 BR-002).
6. Participant confirms the registration.
7. System checks again that a free seat is left.
8. System stores the registration with the status Confirmed and displays a confirmation.

## Alternative Flows

### A1: Course Is Full

**Trigger:** The course has no free seat and the waiting list is not full (BR-006) (step 4)  
**Flow:**

1. System informs the Participant that the course is full and shows the position the Participant would get on the waiting list (BR-005).
2. Participant confirms the place on the waiting list.
3. System stores the registration with the status Waiting and its position on the waiting list.
4. Use case ends.

### A2: Waiting List Is Full

**Trigger:** The course has no free seat and the waiting list is full (BR-006) (step 4)  
**Flow:**

1. System informs the Participant that the course and its waiting list are full.
2. Use case ends.

### A3: Already Registered

**Trigger:** The Participant already holds a registration for this course with the status Confirmed or Waiting (BR-002) (step 4)  
**Flow:**

1. System displays the existing registration with its status.
2. Use case ends.

### A4: Overlapping Course

**Trigger:** The course has a free seat and the Participant holds a confirmed registration for another course whose dates overlap (BR-004) (step 4)  
**Flow:**

1. System displays a message that names the overlapping course.
2. Use case ends.

### A5: Registration Deadline Passed

**Trigger:** The registration deadline of the course has passed since the list was displayed (BR-003) (step 4)  
**Flow:**

1. System displays a message that registration for this course is closed.
2. Use case ends.

### A6: Participant Does Not Confirm

**Trigger:** Participant cancels the summary (step 6)  
**Flow:**

1. System stores nothing.
2. Use case ends.

### A7: Last Seat Taken in the Meantime

**Trigger:** Another participant took the last free seat after step 4 (step 7)  
**Flow:**

1. System informs the Participant that the last seat was just taken.
2. Use case continues at step 4.

### A8: Participant Leaves the Course List

**Trigger:** Participant does not select a course (step 3)  
**Flow:**

1. Use case ends.

## Postconditions

### Success Postconditions

- A registration of the Participant for the course is stored with the status Confirmed, or with the status Waiting and a position on the waiting list
- The free seats of the course are reduced by one when the registration is Confirmed

### Failure Postconditions

- No registration is stored
- The free seats and the waiting list of the course are unchanged
- The course never has more confirmed registrations than its capacity

## Business Rules

### BR-001: Open Course

A course is open for registration when its start date is after today and its registration deadline is today or
later. The course list shows only open courses, sorted by start date. A course without free seats is still open
and is marked as full.

### BR-002: One Registration per Course

A Participant holds at most one registration with the status Confirmed or Waiting per course. A cancelled
registration does not count: after cancelling, the Participant may register again and gets a new registration.

### BR-003: Registration Deadline

Registration is possible until the end of the registration deadline day.

### BR-004: No Overlapping Courses

A Participant cannot hold confirmed registrations for two courses whose date ranges overlap. Both start and end date
count as course days. This rule is checked only when the registration would be confirmed; a place on the waiting list
may overlap with another course.

### BR-005: Waiting List Order

The waiting list is first come, first served by the time of registration. The first registration on the waiting list
has position 1.

### BR-006: Waiting List Size

A course has at most 10 registrations with the status Waiting.

### BR-007: Free Seats

The free seats of a course are its capacity minus its registrations with the status Confirmed.
