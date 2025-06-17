/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.dao;

import com.example.model.Staff;
import java.util.List;

/**
 *
 * @author ravib
 */

//THIS IS A INTERFACEEE !!!!!
public interface StaffDAO {

    List<Staff> getAllStaff();

    // Get only available barbers (for appointment dropdown)
    List<Staff> getAvailableBarbers();
    
    Staff getStaffById(int id);

    boolean addStaff(Staff staff);

    boolean updateStaff(Staff updatedStaff);

    boolean deleteStaff(int id);
    
    // Check if staff exists (for validation)
    boolean staffExists(int id);
}
