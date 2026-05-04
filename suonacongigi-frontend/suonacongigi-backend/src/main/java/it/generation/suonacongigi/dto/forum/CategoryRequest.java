package it.generation.suonacongigi.dto.forum;

import jakarta.validation.constraints.NotBlank;




// Questo DTO rappresenta la richiesta di creazione o modifica di una categoria del forum, 
// contenente il titolo della categoria, l'id della categoria a cui appartiene e il contenuto del post iniziale del thread.

public record CategoryRequest(
    @NotBlank String name,
    String description
) {}