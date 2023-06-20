package com.customermanager.demo_order;

public enum EStatus {
    PAID(1,"Đã thanh toán"), UNPAID(2,"Chưa thanh toán");
    private int id;
    private String name;
    EStatus(int id, String name) {
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
    public static EStatus getStatusById(int id) {
        for (EStatus eStatus : values()) {
            if (eStatus.getId() == id) {
                return eStatus;
            }
        }
        return null;
    }
    public static EStatus getStatusByName(String name) {
        for (EStatus eStatus : EStatus.values()) {
            if (eStatus.toString().equals(name)) {
                return eStatus;
            }
        }
        return null;
    }

}
