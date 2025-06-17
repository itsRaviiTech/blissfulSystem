/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.model;

public class Staff {

    private int id;
    private String name;
    private String username;
    private String expertise;
    private boolean available;
    private String description;

    // Constructors
    public Staff() {
    }

    public Staff(int id, String name, String username, String expertise, boolean available, String description) {
        this.id = id;
        this.name = name;
        this.username = username;
        this.expertise = expertise;
        this.available = available;
        this.description = description;
    }
    
    public Staff(String name, String username, String expertise, boolean available, String description) {
        this.name = name;
        this.username = username;
        this.expertise = expertise;
        this.available = available;
        this.description = description;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getExpertise() {
        return expertise;
    }

    public void setExpertise(String expertise) {
        this.expertise = expertise;
    }

    public boolean isAvailable() {
        return available;
    }

    public void setAvailable(boolean available) {
        this.available = available;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
