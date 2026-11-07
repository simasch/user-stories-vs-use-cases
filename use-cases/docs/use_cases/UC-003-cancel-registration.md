# Use Case: Cancel Registration

## Overview

**Use Case ID:** UC-003  
**Use Case Name:** Cancel Registration  
**Primary Actor:** Participant  
**Goal:** Give up a seat or a place on the waiting list and know the cancellation fee  
**Trigger:** The Participant can no longer attend a course  
**Status:** Approved  

**Requirements:** [FR-004, FR-005, NFR-002, C-002, C-003](../requirements.md)

## Preconditions

- Participant is signed in
- Participant holds at least one registration with the status Confirmed or Waiting (UC-002)

## Main Success Scenario

1. Participant opens the list of own registrations (UC-004).
2. Participant selects a registration with the status Confirmed and chooses to cancel it.
3. System checks that the course has not started (BR-001).
4. System calculates the cancellation fee (BR-002) and asks the Participant to confirm the cancellation with this fee.
5. Participant confirms the cancellation.
6. System sets the status of the registration to Cancelled and stores the cancellation date and the fee.
7. System gives the free seat to the first registration on the waiting list (BR-004) and sets its status to Confirmed.
8. System displays a confirmation of the cancellation with the fee.

## Alternative Flows

### A1: Cancel a Place on the Waiting List

**Trigger:** The selected registration has the status Waiting (step 2)  
**Flow:**

1. System asks the Participant to confirm the cancellation without a fee (BR-003).
2. Participant confirms the cancellation.
3. System sets the status of the registration to Cancelled with a fee of 0.
4. System moves every later registration on the waiting list up by one position.
5. Use case ends.

### A2: Course Already Started

**Trigger:** The start date of the course is today or in the past (step 3)  
**Flow:**

1. System displays a message that the registration can no longer be cancelled.
2. Use case ends.

### A3: Participant Keeps the Registration

**Trigger:** Participant does not confirm the cancellation (step 5)  
**Flow:**

1. System changes nothing.
2. Use case ends.

### A4: Waiting List Is Empty

**Trigger:** The course has no registration with the status Waiting (step 7)  
**Flow:**

1. The seat stays free.
2. Use case continues at step 8.

### A5: Registration Deadline Passed

**Trigger:** The registration deadline of the course has passed (BR-005) (step 7)  
**Flow:**

1. The seat stays free and the waiting list stays unchanged.
2. Use case continues at step 8.

### A6: First Waiting Participant Has an Overlapping Course

**Trigger:** The participant of the first registration on the waiting list holds a confirmed registration for an overlapping course (BR-006) (step 7)  
**Flow:**

1. System sets that waiting registration to Cancelled with a fee of 0.
2. Use case continues at step 7.

## Postconditions

### Success Postconditions

- The registration has the status Cancelled with its cancellation date and fee stored
- The freed seat is held by the first eligible registration of the waiting list, or stays free
- The positions on the waiting list have no gaps and start at 1

### Failure Postconditions

- The registration keeps its status
- The waiting list and the free seats of the course are unchanged

## Business Rules

### BR-001: Cancellation Period

A registration can be cancelled until the day before the start date of the course. From the start date on, it can
no longer be cancelled.

### BR-002: Cancellation Fee

The fee depends on the number of calendar days from the cancellation date to the start date of the course:
7 days or more costs nothing, fewer than 7 days costs 50% of the price. The fee is rounded to 0.05 CHF.
Example: for a course starting on 15 March, a cancellation on 8 March is free, a cancellation on 9 March costs 50%.

### BR-003: Waiting List Is Free of Charge

Cancelling a registration with the status Waiting never costs a fee.

### BR-004: Promotion from the Waiting List

When a seat becomes free, the registration with position 1 on the waiting list gets the status Confirmed. Every
other registration on the waiting list moves up by one position. The promotion happens at once, without asking the
promoted participant.

### BR-005: No Promotion After the Registration Deadline

After the registration deadline of the course, a free seat stays free and nobody is promoted.

### BR-006: Promotion Skips Overlapping Courses

A waiting registration whose participant holds a confirmed registration for an overlapping course (UC-002 BR-004) is
not promoted. It is cancelled with a fee of 0, and the next registration on the waiting list is considered.
