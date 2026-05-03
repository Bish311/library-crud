package dev.bish.librarycrud.service;

import dev.bish.librarycrud.exception.ResourceNotFoundException;
import dev.bish.librarycrud.model.Author;
import dev.bish.librarycrud.repository.AuthorRepository;
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
public class AuthorServiceTest {

    @Mock
    private AuthorRepository authorRepository;

    @InjectMocks
    private AuthorService authorService;

    @Test
    public void findByIdThrowsWhenAuthorMissing() {
        when(authorRepository.findById(1L)).thenReturn(Optional.empty());
        
        assertThrows(ResourceNotFoundException.class, () -> {
            authorService.findById(1L);
        });
    }

    @Test
    public void saveAuthorCallsRepository() {
        Author author = new Author();
        author.setName("Bishwayan");
        
        authorService.save(author);
        
        verify(authorRepository).save(author);
    }
}
