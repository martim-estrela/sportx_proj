package org.sportx.sportx.DTO;

public class SubcategoryDTO {
    private int id;
    private String name;
    private int categoryId;

    public SubcategoryDTO(int id, String name, int categoryId) {
        this.id = id;
        this.name = name;
        this.categoryId = categoryId;
    }

    // Getters e setters
    public int getId() {return id;}
    public void setId(int id) {this.id = id;}
    public String getName() {return name;}
    public void setName(String name) {this.name = name;}
    public int getCategoryId() {return categoryId;}
}
