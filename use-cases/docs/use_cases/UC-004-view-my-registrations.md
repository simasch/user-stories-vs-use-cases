# Use Case: View My Registrations

## Overview

**Use Case ID:** UC-004  
**Use Case Name:** View My Registrations  
**Primary Actor:** Participant  
**Goal:** Know for which courses the Participant holds a seat, waits for a seat, or has cancelled  
**Trigger:** The Participant wants to check own registrations  
**Status:** Approved  

**Requirements:** [FR-006, NFR-002](../requirements.md)

## Preconditions

- Participant is signed in

## Main Success Scenario

1. Participant opens the list of own registrations.
2. System displays the registrations of the Participant (BR-001, BR-002) sorted by start date, each with course title, start date, end date, location, and status (BR-003).

## Alternative Flows

### A1: No Registrations

**Trigger:** The Participant has no registration to show (step 2)  
**Flow:**

1. System displays a message that there are no registrations and offers a way to the course list (UC-002).
2. Use case ends.

### A2: Show Past Courses

**Trigger:** Participant chooses to include past courses (step 2)  
**Flow:**

1. System adds the registrations for courses whose end date is before today.
2. Use case ends.

## Postconditions

### Success Postconditions

- The Participant sees the requested registrations

### Failure Postconditions

_None — the use case changes no data._

## Business Rules

### BR-001: Default Selection

By default, the list shows the registrations for courses whose end date is today or later, with every status.

### BR-002: Own Registrations Only

A Participant sees only own registrations, never those of other participants.

### BR-003: Status Display

A registration shows one of these statuses: Confirmed; Waiting together with the current position on the waiting
list; Cancelled together with the cancellation fee in CHF, where a fee of 0 is shown as "free of charge".
