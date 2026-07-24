# KB Cloud Native DevOps Learning Framework

## Why this project exists

The objective of this repository is **not** to learn Docker, Kubernetes, Jenkins, Terraform, or AWS.

The objective is to become an engineer who understands:

- Why a technology exists
- What problem it solves
- What happens when it fails
- How to troubleshoot it
- How to explain it confidently in interviews

This project focuses on understanding rather than memorization.

---

# Traditional Learning

Most courses follow this approach.

Definition

↓

Commands

↓

Example

↓

Assignment

↓

Next Topic

The problem with this approach is that concepts are quickly forgotten because they were never connected to a real engineering problem.

---

# Our Learning Philosophy

We learn technologies in reverse.

Problem

↓

Pain

↓

Questions

↓

Limitations

↓

Need

↓

Technology

↓

Implementation

↓

Failure

↓

Debugging

↓

Reflection

↓

Documentation

↓

Interview

This sequence ensures that every concept has context before implementation.

---

# Engineering Thinking

Before introducing a technology, we first identify the engineering problem.

Example:

Instead of asking

"What is Docker?"

we ask

"Our application works on my laptop but not on another machine.

Why?"

Only after understanding the problem do we introduce Docker.

---

Instead of asking

"What is Kubernetes?"

we ask

"My application runs successfully.

How do I keep it available if it crashes?

How do I scale it automatically?

How do I update it without downtime?"

Only then do Pods, Deployments and Services make sense.

---

Instead of asking

"What is Jenkins?"

we ask

"Why are developers deploying manually?

How do we eliminate repetitive deployment work?"

---

Instead of asking

"What is Terraform?"

we ask

"Why are engineers creating infrastructure differently?

How do we make infrastructure repeatable?"

---

# Build Experience, Not Definitions

Interviewers rarely hire engineers because they know definitions.

They hire engineers who can explain:

- why they made a decision
- what failed
- how they investigated
- how they fixed it
- what they learned

Therefore every milestone intentionally creates failures.

---

# Failure Driven Learning

Every milestone contains intentional failures.

Example:

Build

↓

Break

↓

Observe

↓

Hypothesis

↓

Debug

↓

Fix

↓

Verify

↓

Document

↓

Interview

Failures become interview stories.

---

# Documentation Philosophy

Every milestone produces four deliverables.

1. Working Code

2. Architecture Decision Record (ADR)

3. Incident Reports

4. Interview Notes

This ensures that implementation and learning remain connected.

---

# Interview Philosophy

We never memorize answers.

Instead we answer from experience.

Bad answer:

"Docker is a containerization platform."

Good answer:

"While containerizing my FastAPI application I discovered that the container was running but wasn't reachable because the application was listening on 127.0.0.1 instead of 0.0.0.0..."

Experience is easier to remember than definitions.

---

# The Goal

At the end of this project I should be able to answer any interview question by recalling:

- a project
- a decision
- a failure
- a debugging session

rather than memorizing documentation.

This repository is therefore an Engineering Experience Lab rather than simply a learning repository.