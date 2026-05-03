package dev.bish.librarycrud.service;

import dev.bish.librarycrud.exception.ResourceNotFoundException;
import dev.bish.librarycrud.model.Book;
import dev.bish.librarycrud.repository.BookRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class BookServiceTest {

    @Mock
    private BookRepository bookRepository;

    @InjectMocks
    private BookService bookService;

    @Test
    public void saveBookCallsRepository() {
        Book book = new Book();
        book.setTitle("Hibernate by Bishwayan");
        
        bookService.save(book);
        
        verify(bookRepository).save(book);
    }

    @Test
    public void findByIdThrowsWhenBookMissing() {
        when(bookRepository.findById(1L)).thenReturn(Optional.empty());
        
        assertThrows(ResourceNotFoundException.class, () -> {
            bookService.findById(1L);
        });
    }

    @Test
    public void updateBookSavesUpdatedFields() {
        Book existingBook = new Book();
        existingBook.setId(1L);
        existingBook.setTitle("Old Title");
        
        when(bookRepository.findById(1L)).thenReturn(Optional.of(existingBook));
        
        Book updatedBook = new Book();
        updatedBook.setTitle("New Title by Bish");
        updatedBook.setGenre("Tech");
        updatedBook.setPrice(99.99);
        
        bookService.update(1L, updatedBook);
        
        verify(bookRepository).save(existingBook);
    }
}
