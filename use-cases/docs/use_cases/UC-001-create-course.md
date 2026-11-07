# Use Case: Create Course

## Overview

**Use Case ID:** UC-001  
**Use Case Name:** Create Course  
**Primary Actor:** Course Administrator  
**Goal:** Publish a new course so that participants can register for it  
**Trigger:** The Course Administrator decides to offer a new course  
**Status:** Approved  

**Requirements:** [NFR-002, C-003](../requirements.md)

## Preconditions

- Course Administrator is signed in with the role ADMIN

## Main Success Scenario

1. Course Administrator chooses to create a new course.
2. System displays an empty course form.
3. Course Administrator enters title, description, start date, end date, location, capacity, price, and registration deadline.
4. Course Administrator saves the course.
5. System checks the input against BR-001 to BR-006.
6. System stores the course with all seats free and shows it in the course list.

## Alternative Flows

### A1: Invalid Input

**Trigger:** One or more fields violate BR-001 to BR-005 (step 5)  
**Flow:**

1. System marks every invalid field with a message that names the violated rule.
2. System keeps all entered values.
3. Use case continues at step 3.

### A2: Duplicate Course

**Trigger:** A course with the same title and the same start date already exists (step 5)  
**Flow:**

1. System displays a message that this course already exists.
2. Use case continues at step 3.

### A3: Course Administrator Discards the Form

**Trigger:** Course Administrator leaves the form without saving (step 3)  
**Flow:**

1. System discards the entered values.
2. Use case ends.

### A4: No Registration Deadline Entered

**Trigger:** The registration deadline field is empty (step 5)  
**Flow:**

1. System sets the registration deadline to the day before the start date (BR-004).
2. Use case continues at step 6.

## Postconditions

### Success Postconditions

- The course is stored with all its attributes
- The course is open for registration (UC-002) with free seats equal to its capacity and an empty waiting list

### Failure Postconditions

- No course is stored

## Business Rules

### BR-001: Mandatory Fields

Title, start date, end date, capacity, and price are mandatory. Description, location, and registration deadline are
optional. The title has at most 100 characters.

### BR-002: Capacity

The capacity is a whole number from 1 to 100.

### BR-003: Course Dates

The start date must be after today. The end date must not be before the start date. A course with the same start and
end date lasts one day.

### BR-004: Registration Deadline

The registration deadline must not be in the past and must be before the start date. When the field is empty, the
registration deadline is the day before the start date.

### BR-005: Price

The price is in CHF, 0 or more, with at most two decimal places. A price of 0 means the course is free of charge.

### BR-006: No Duplicate Course

Two courses must not have the same title (ignoring upper and lower case) and the same start date.
