/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.dao;

/**
 *
 * @author ravib
 */
import com.example.model.Staff;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StaffDAOImpl implements StaffDAO {
    private final Connection connection;
    
    public StaffDAOImpl() {
        this.connection = DatabaseConnection.getConnection();
    }

    @Override
    public List<Staff> getAllStaff() {
        List<Staff> staffList = new ArrayList<>();
        String query = "SELECT * FROM staff";
        
        try (PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Staff staff = extractStaffFromResultSet(rs);
                staffList.add(staff);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return staffList;
    }
    
    public static List<Staff> getAll() throws SQLException {
        String sql = "SELECT * FROM staff";
        try(Connection c = DatabaseConnection.getConnection();
            PreparedStatement p = c.prepareStatement(sql);
            ResultSet rs = p.executeQuery()) {
          List<Staff> list = new ArrayList<>();
          while(rs.next()) {
            Staff s = new Staff();
            s.setId(rs.getInt("staff_id"));
            s.setUserId(rs.getInt("id"));
            s.setName(rs.getString("name"));
            s.setUsername(rs.getString("username"));
            s.setExpertise(rs.getString("expertise"));
            s.setAvailable(rs.getBoolean("available"));
            s.setDescription(rs.getString("description"));
            list.add(s);
          }
          return list;
        }
    }
    
    @Override
    public List<Staff> getAvailableBarbers() {
        List<Staff> barbers = new ArrayList<>();
        String query = "SELECT * FROM staff WHERE available = true";
        
        try (PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Staff staff = extractStaffFromResultSet(rs);
                barbers.add(staff);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return barbers;
    }

    @Override
    public Staff getStaffById(int id) {
        Staff staff = null;
        String query = "SELECT * FROM staff WHERE id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    staff = extractStaffFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return staff;
    }

    @Override
    public boolean addStaff(Staff staff) {
        String query = "INSERT INTO staff (name, username, expertise, available, description) VALUES (?, ?, ?, ?, ?)";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, staff.getName());
            ps.setString(2, staff.getUsername());
            ps.setString(3, staff.getExpertise());
            ps.setBoolean(4, staff.isAvailable());
            ps.setString(5, staff.getDescription());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateStaff(Staff staff) {
        String query = "UPDATE staff SET name=?, username=?, expertise=?, available=?, description=? WHERE id=?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, staff.getName());
            ps.setString(2, staff.getUsername());
            ps.setString(3, staff.getExpertise());
            ps.setBoolean(4, staff.isAvailable());
            ps.setString(5, staff.getDescription());
            ps.setInt(6, staff.getId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteStaff(int id) {
        String query = "DELETE FROM staff WHERE id=?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean staffExists(int id) {
        String query = "SELECT id FROM staff WHERE id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Staff extractStaffFromResultSet(ResultSet rs) throws SQLException {
        Staff staff = new Staff();
        staff.setId(rs.getInt("id"));
        staff.setName(rs.getString("name"));
        staff.setUsername(rs.getString("username"));
        staff.setExpertise(rs.getString("expertise"));
        staff.setAvailable(rs.getBoolean("available"));
        staff.setDescription(rs.getString("description"));
        return staff;
    }
}
