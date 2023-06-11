package com.customermanager.model;

import java.time.LocalDate;

public class CustomerType {
    private int typeId;
    private String typeName;
    private LocalDate deleteAt;

    public CustomerType() {
    }

    public CustomerType(int typeId, String typeName, LocalDate deleteAt) {
        this.typeId = typeId;
        this.typeName = typeName;
        this.deleteAt = deleteAt;
    }

    public int getTypeId() {
        return typeId;
    }

    public void setTypeId(int typeId) {
        this.typeId = typeId;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public LocalDate getDeleteAt() {
        return deleteAt;
    }

    public void setDeleteAt(LocalDate deleteAt) {
        this.deleteAt = deleteAt;
    }
}
