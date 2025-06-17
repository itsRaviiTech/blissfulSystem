package com.example.model;

import java.time.LocalDate;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Time;

public class Appointment {

    private int id;
    private String name;
    private String phone;
    private LocalDate date;
    private String service;
    private String time;
    private int staffid;
    private String staffName;
    private Time apptTime;
    private Date apptDate;

    private String addons;
    private BigDecimal price;
    private String status;

    public Appointment() {
    }

    public Appointment(int id, String name, String phone, LocalDate date, String service, String time, String status) {
        this.id = id;
        this.name = name;
        this.phone = phone;
        this.date = date;
        this.service = service;
        this.time = time;
        this.status = status;
    }

    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }

    public String getStaffName() {
        return staffName;
    }

    public void setStaffid(int staffid) {
        this.staffid = staffid;
    }

    public int getStaffid() {
        return staffid;
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

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public String getService() {
        return service;
    }

    public void setService(String service) {
        this.service = service;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getAddons() {
        return addons;
    }

    public void setAddons(String addons) {
        this.addons = addons;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Time getApptTime() {
        return apptTime;
    }

    public void setApptTime(Time apptTime) {
        this.apptTime = apptTime;
    }

    public Date getApptDate() {
        return apptDate;
    }

    public void setApptDate(Date apptDate) {
        this.apptDate = apptDate;
    }

    @Override
    public String toString() {
        return "Appointment{"
                + "id=" + id
                + ", name='" + name + '\''
                + ", phone='" + phone + '\''
                + ", date=" + date
                + ", service='" + service + '\''
                + ", time='" + time + '\''
                //                + ", barber='" + barber + '\''
                + ", addons='" + addons + '\''
                + ", price=" + price
                + '}';
    }

}
