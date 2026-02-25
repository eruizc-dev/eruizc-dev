---
name: spec-writer
description: Guide for writing minimal, elegant specifications across all 9 layers. Use when creating or updating specifications for any layer.
---

# Spec writing

This skill helps you write specs for the Layered SDD framework. Write minimal, elegant specifications that give AI agents exactly what they need—no more, no less.


Layer 1: Functional/Business ← What to build, for whom
         ↓
Layer 2: Non-Functional ← Performance, scalability, reliability
         ↓
Layer 3: UX ← All interfaces (UI, CLI, mobile, chatbot)
         ↓
Layer 4: Data Design ← Entities, relationships (tech-agnostic)
         ↓
Layer 5: Security ← Auth, authorization, encryption, compliance
         ↓
Layer 6: Testing ← Test strategy, coverage, test types
         ↓
Layer 7: Architecture ← System structure, patterns (abstract)
         ↓
Layer 8: Integrations ← External APIs, internal services
         ↓
Layer 9: Implementation ← Concrete tech (MOST FLEXIBLE)

## Key Principles

1. **Minimal and elegant**: Every line must serve a purpose
2. **Just enough detail**: Enough for AI to generate code, not implementation details
3. **Layer separation**: Keep concerns in the right layer
4. **Living documents**: Specs evolve, they're never "done"
5. **Only required layers**: Dont write all the layers if you dont have to. Focus on what the user is asking

## Process

1. **Understand the requirement**: Ask clarifying questions if needed
2. **Identify affected layers**: Which of the 9 layers need updates?
3. **Read existing specs**: Check what's already defined
4. **Write minimally and only for required layers**:
   - Layer 1: Functionality, acceptance criteria
   - Layer 2: Measurable targets ONLY (no implementation)
   - Layer 3: Wireframes/images and interactions ONLY (use Markdown + images)
   - Layer 4: Entities and relationships ONLY (no SQL)
   - Layer 5: Security requirements ONLY (no implementation)
   - Layer 6: Test strategy ONLY (not individual test cases)
   - Layer 7: Architecture patterns ONLY (use Markdown + diagrams)
   - Layer 8: Integration contracts ONLY (not client code)
   - Layer 9: Tech choices ONLY (not complete config files)
5. **Validate**: Check against minimalism checklist
6. **Reference examples**: Point user to relevant example files

## Format Guidelines

- Layer 1, 3, 7: Use Markdown (supports images, diagrams)
- Layer 0, 2, 4, 5, 6, 8, 9: YAML or Markdown
- When in doubt: Markdown (more flexible)

## Minimalism Checklist

Before completing:
- [ ] Can AI generate working code from this?
- [ ] Is every line necessary?
- [ ] Have I removed obvious details?
- [ ] Is it the most elegant, clear and possibily short way of framing it?
- [ ] Am I specifying WHAT not HOW (except Layer 9)?

## Folder Structure

Store specs in `specs/` at the project root. One file per layer, named by layer number:
- `specs/L1-functional.md`, `specs/L4-data.yaml`, etc.

## Anti-Patterns to Avoid

- Don't write 300-line user stories with every step
- Don't specify implementation in Layer 1-7
- Don't copy-paste boilerplate
- Don't future-proof with unused fields
- Don't explain basic concepts to AI
- Don't describe what an image shows better
