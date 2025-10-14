package com.greensense.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class ComplaintDAO {

    public boolean addComplaint(Complaint complaint) {
        String sql = "INSERT INTO complaints (citizen_id, description, category, image_path, latitude, longitude, status) VALUES (?, ?, ?, ?, ?, ?, 'submitted')";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, complaint.getCitizenId()); // You'll need to add this field to Complaint.java
            pstmt.setString(2, complaint.getDescription());
            pstmt.setString(3, complaint.getCategory()); // And this field
            pstmt.setString(4, complaint.getImagePath());
            pstmt.setDouble(5, complaint.getLatitude()); // And this field
            pstmt.setDouble(6, complaint.getLongitude()); // And this field

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Complaint> getAllComplaints() {
        List<Complaint> complaintList = new ArrayList<>();
        String sql = "SELECT c.*, u.full_name FROM complaints c JOIN users u ON c.citizen_id = u.user_id ORDER BY c.submitted_at DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                int id = rs.getInt("complaint_id");
                String description = rs.getString("description");
                String imagePath = rs.getString("image_path");
                String status = rs.getString("status");
                Timestamp submittedAt = rs.getTimestamp("submitted_at");
                String citizenName = rs.getString("full_name");

                // Note: Update your Complaint constructor to match this
                Complaint complaint = new Complaint(id, description, imagePath, status, submittedAt, citizenName);
                complaintList.add(complaint);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return complaintList;
    }
    public boolean updateComplaintStatus(int complaintId, String status) {
        String sql = "UPDATE complaints SET status = ? WHERE complaint_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, status);
            pstmt.setInt(2, complaintId);

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public int getResolvedComplaintsCount() {
        String sql = "SELECT COUNT(*) FROM complaints WHERE status = 'resolved'";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    public List<Complaint> getComplaintsByStatus(String status) {
        List<Complaint> complaintList = new ArrayList<>();
        String sql;
        // Special case for "unresolved" which includes two statuses
        if ("unresolved".equalsIgnoreCase(status)) {
            sql = "SELECT c.*, u.full_name FROM complaints c JOIN users u ON c.citizen_id = u.user_id WHERE c.status IN ('submitted', 'in_progress') ORDER BY c.submitted_at DESC";
        } else {
            sql = "SELECT c.*, u.full_name FROM complaints c JOIN users u ON c.citizen_id = u.user_id WHERE c.status = ? ORDER BY c.submitted_at DESC";
        }

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            if (!"unresolved".equalsIgnoreCase(status)) {
                pstmt.setString(1, status);
            }

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                // ... create and add complaint objects to list (same as getAllComplaints)
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return complaintList;
    }

    public int getComplaintCountByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM complaints WHERE status = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, status);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
 // Gets all complaints submitted by a specific user
    public List<Complaint> getComplaintsByCitizenId(int citizenId) {
        List<Complaint> complaintList = new ArrayList<>();
        String sql = "SELECT * FROM complaints WHERE citizen_id = ? ORDER BY submitted_at DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, citizenId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Complaint complaint = new Complaint();
                complaint.setId(rs.getInt("complaint_id"));
                complaint.setDescription(rs.getString("description"));
                complaint.setStatus(rs.getString("status"));
                complaint.setSubmittedAt(rs.getTimestamp("submitted_at"));
                complaintList.add(complaint);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return complaintList;
    }

    // Gets counts of complaints (total, resolved, pending) for a specific user
    public int[] getComplaintCountsByCitizenId(int citizenId) {
        int[] counts = new int[3]; // Index 0: Total, 1: Resolved, 2: Pending
        String sql = "SELECT " +
                     "COUNT(*) as total, " +
                     "SUM(CASE WHEN status = 'resolved' THEN 1 ELSE 0 END) as resolved, " +
                     "SUM(CASE WHEN status IN ('submitted', 'in_progress') THEN 1 ELSE 0 END) as pending " +
                     "FROM complaints WHERE citizen_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, citizenId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                counts[0] = rs.getInt("total");
                counts[1] = rs.getInt("resolved");
                counts[2] = rs.getInt("pending");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return counts;
    }
}