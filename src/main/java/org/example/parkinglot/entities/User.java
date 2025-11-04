package org.example.parkinglot.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "users")
public class User {
    @Column(name = "username")
    private String username;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    @Column(name = "id", nullable = false)
    private Long id;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

}