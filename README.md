# Library CRUD — Spring Boot Application

A Spring Boot MVC application that manages **Authors** and **Books** with full Create, Read, and Update operations. Uses JPA for persistence, JSP + JSTL for views, and H2 as the in-memory database.

---

## Prerequisites

- Java 17 (OpenJDK 17 LTS)
- Maven 3.9+ (or use the included `mvnw` wrapper)

---

## How to Run

```bash
./mvnw spring-boot:run
```

The application starts on **http://localhost:8080**. The home page redirects to the Books list.

---

## H2 Console

The H2 database console is available at:

```
http://localhost:8080/h2-console
```

Use the following connection settings:
- **JDBC URL:** `jdbc:h2:mem:librarydb`
- **Username:** `sa`
- **Password:** *(leave blank)*

---

## How to Run Tests

```bash
./mvnw test
```

This runs all unit tests:
- `BookRepositoryTest` — `@DataJpaTest` integration tests for the custom join query and persistence.
- `BookServiceTest` — `@MockitoExtension` unit tests for save, findById (exception path), and update.
- `AuthorServiceTest` — `@MockitoExtension` unit tests for save and findById (exception path).

---

## Project Structure

```
library-crud/
├── pom.xml
├── README.md
├── DESIGN.md
├── src/
│   ├── main/
│   │   ├── java/dev/bish/librarycrud/
│   │   │   ├── LibraryCrudApplication.java
│   │   │   ├── ServletInitializer.java
│   │   │   ├── model/          (Author, Book)
│   │   │   ├── repository/     (AuthorRepository, BookRepository)
│   │   │   ├── service/        (AuthorService, BookService)
│   │   │   ├── controller/     (HomeController, BookController, AuthorController)
│   │   │   └── exception/      (ResourceNotFoundException, GlobalExceptionHandler)
│   │   ├── resources/
│   │   │   ├── application.properties
│   │   │   ├── data.sql
│   │   │   └── static/css/style.css
│   │   └── webapp/WEB-INF/jsp/  (7 JSP views)
│   └── test/java/dev/bish/librarycrud/
│       ├── repository/BookRepositoryTest.java
│       └── service/ (BookServiceTest, AuthorServiceTest)
└── .gitignore
```

---

## Tech Stack

| Component        | Version            |
| ---------------- | ------------------ |
| Java             | 17 (LTS)           |
| Spring Boot      | 3.5.14             |
| Build Tool       | Maven 3.9.7        |
| Packaging        | WAR                |
| Database         | H2 (in-memory)     |
| View Layer       | JSP + JSTL         |
| Testing          | JUnit 5 + Mockito  |

## Full Project Report

For detailed implementation instructions, ER Diagrams, code snippets, challenge reflections, and application screenshots, please read the [SUBMISSION.md](./SUBMISSION.md) document. A PDF version (`SUBMISSION.pdf`) is also generated for final grading.

---
## GitHub Repository

[https://github.com/Bish311/library-crud.git](https://github.com/Bish311/library-crud.git)
