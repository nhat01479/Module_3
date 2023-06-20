package com.customermanager.model;

public enum ERole {
    ADMIN(1, "Admin"), USER(2, "User");
    private int id;
    private String name;

    ERole(int id, String name) {
        this.id = id;
        this.name = name;
    }
    public int getId() {
        return this.id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public static ERole getEroleByName(String name) {
       for (ERole eRole: ERole.values()) {
           if (eRole.toString().equals(name)){
               return eRole;
           }
       }
       return null;
   }
}
