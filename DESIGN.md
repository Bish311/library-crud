# DESIGN.md — Library CRUD Application

## Overview

This application is a Spring Boot MVC project that manages two related entities: **Author** and **Book**, connected through a One-to-Many relationship (one author can write multiple books). I chose these entities because they naturally demonstrate JPA relationship mapping, foreign key constraints, and inner join queries in a straightforward way that mirrors real-world library cataloging. The app supports Create, Read, and Update operations for both entities, uses an H2 in-memory database for persistence, JSP pages with JSTL for the view layer, and includes JUnit 5 + Mockito unit tests for repository and service layers.

---

## ER Diagram

```
┌──────────────────┐              ┌──────────────────┐
│     AUTHOR       │              │      BOOK        │
├──────────────────┤              ├──────────────────┤
│ id (PK)     LONG │──┐           │ id (PK)     LONG │
│ name      STRING │  │  1..*     │ title     STRING │
│ nationality STR  │  └─────────→ │ genre     STRING │
└──────────────────┘              │ price     DOUBLE │
                                  │ author_id (FK)   │
                                  └──────────────────┘
         Author 1 ────────── * Book
```

- `Author.id` is the primary key, auto-generated via `IDENTITY` strategy.
- `Book.author_id` is a foreign key referencing `Author.id` with `nullable = false`.
- The relationship is mapped in Java as `@OneToMany(mappedBy = "author", cascade = CascadeType.ALL)` on the Author side and `@ManyToOne` + `@JoinColumn` on the Book side.

---

## Layer Breakdown

- **Model (`dev.bish.librarycrud.model`)**
  - `Author.java` — JPA entity with `@Entity`, `@Id`, `@GeneratedValue(IDENTITY)`, `@Column(nullable = false)`, and `@OneToMany` for the books list.
  - `Book.java` — JPA entity with `@Entity`, `@Id`, `@GeneratedValue(IDENTITY)`, `@Column(nullable = false, unique = true)` on title, and `@ManyToOne` + `@JoinColumn(name = "author_id")` for the author reference.

- **Repository (`dev.bish.librarycrud.repository`)**
  - `AuthorRepository` — extends `JpaRepository<Author, Long>`, adds `existsByName(String name)` derived query.
  - `BookRepository` — extends `JpaRepository<Book, Long>`, adds a custom JPQL inner join query: `@Query("SELECT b.title, a.name FROM Book b INNER JOIN b.author a")` returning `List<Object[]>`.

- **Service (`dev.bish.librarycrud.service`)**
  - `AuthorService` — `findAll()`, `findById(Long)`, `save(Author)`, `update(Long, Author)`. The `findById` throws `ResourceNotFoundException` when the author does not exist.
  - `BookService` — `findAll()`, `findById(Long)`, `save(Book)`, `update(Long, Book)`, `findBooksWithAuthors()`. The `findById` throws `ResourceNotFoundException` when the book does not exist.

- **Controller (`dev.bish.librarycrud.controller`)**
  - `HomeController` — `GET /` redirects to `/books`.
  - `BookController` — handles `GET /books`, `GET /books/add`, `POST /books/add`, `GET /books/edit/{id}`, `POST /books/edit/{id}`. Uses both `BookService` and `AuthorService` (for the author dropdown in forms).
  - `AuthorController` — handles `GET /authors`, `GET /authors/add`, `POST /authors/add`, `GET /authors/edit/{id}`, `POST /authors/edit/{id}`.

- **Exception Handling (`dev.bish.librarycrud.exception`)**
  - `ResourceNotFoundException` — custom exception extending `RuntimeException`.
  - `GlobalExceptionHandler` — `@ControllerAdvice` that catches `ResourceNotFoundException` and `DataIntegrityViolationException`, forwarding readable messages to `error.jsp`.

---

## data.sql Strategy

The `data.sql` file in `src/main/resources/` seeds the database with 10 authors and 10 books on every application startup. Because Hibernate's DDL auto-generation (`create-drop`) runs before Spring's SQL initialization by default, the property `spring.jpa.defer-datasource-initialization=true` is required to ensure Hibernate creates the `AUTHOR` and `BOOK` tables first, and only then does Spring execute the `INSERT` statements in `data.sql`. Without this flag, the inserts would fail because the tables would not exist yet.

---

## Challenges

1. **Package naming conflict with Spring Initializr** — Spring Initializr generated the base package as `dev.bish.library_crud` (with an underscore), but the project spec required `dev.bish.librarycrud`. I had to manually rename the directory structure under `src/main/java` and `src/test/java`, then update every `package` declaration across all Java files. Missing even one file caused `ClassNotFoundException` at startup, which taught me to always verify package consistency after refactoring.

2. **data.sql conflicting with @DataJpaTest** — The repository integration tests use `@DataJpaTest`, which still loads `data.sql` on startup because `spring.sql.init.mode=always` is set. This caused unique constraint violations when my test tried to insert a book with the same title as one already seeded by `data.sql`. I fixed this by using unique test-specific titles (e.g., "Test Java Guide by Bish" instead of "Java Guide by Bish") and adjusting assertions to account for the 10 pre-seeded rows.

3. **JSP not rendering with JAR packaging** — Initially I overlooked the WAR packaging requirement. When I accidentally tested with JAR packaging, JSP pages returned 404 errors because embedded Tomcat in JAR mode cannot discover JSP files. Switching to `<packaging>war</packaging>` in `pom.xml` and adding the `ServletInitializer` class resolved this immediately. This was a good reminder that JSPs require WAR deployment with the Jasper compiler available.
