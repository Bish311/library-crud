package dev.bish.librarycrud.repository;

import dev.bish.librarycrud.model.Author;
import dev.bish.librarycrud.model.Book;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

@DataJpaTest
public class BookRepositoryTest {

    @Autowired
    private BookRepository bookRepository;

    @Autowired
    private AuthorRepository authorRepository;

    @Test
    public void findBooksWithAuthorNamesReturnsCorrectRows() {
        Author author = new Author();
        author.setName("Bishwayan");
        author.setNationality("Indian");
        authorRepository.save(author);

        Book book = new Book();
        book.setTitle("Spring Boot by Bishwayan");
        book.setGenre("Education");
        book.setPrice(49.99);
        book.setAuthor(author);
        bookRepository.save(book);

        List<Object[]> results = bookRepository.findBooksWithAuthorNames();
        
        assertNotNull(results);
        // data.sql inserts 10 books, test inserts 1, total should be 11
        assertEquals(11, results.size());
        
        boolean found = false;
        for (Object[] row : results) {
            if ("Spring Boot by Bishwayan".equals(row[0]) && "Bishwayan".equals(row[1])) {
                found = true;
                break;
            }
        }
        assertTrue(found);
    }

    @Test
    public void saveAndFindBookPersistsCorrectly() {
        Author author = new Author();
        author.setName("Bish");
        author.setNationality("Indian");
        authorRepository.save(author);

        Book book = new Book();
        book.setTitle("Test Java Guide by Bish");
        book.setGenre("Education");
        book.setPrice(29.99);
        book.setAuthor(author);
        Book savedBook = bookRepository.save(book);

        assertNotNull(savedBook.getId());
        assertEquals("Test Java Guide by Bish", savedBook.getTitle());
        
        Book retrievedBook = bookRepository.findById(savedBook.getId()).orElse(null);
        assertNotNull(retrievedBook);
        assertEquals("Test Java Guide by Bish", retrievedBook.getTitle());
    }
}
