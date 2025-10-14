package com.greensense.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class UpdateDAO {

    public boolean addUpdate(Update update) {
        String sql = "INSERT INTO updates (title, content, created_by_admin_id) VALUES (?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, update.getTitle());
            pstmt.setString(2, update.getContent());
            pstmt.setInt(3, update.getAdminId()); // You'll need to add this field to Update.java

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Update> getAllUpdates() {
        List<Update> updatesList = new ArrayList<>();
        String sql = "SELECT * FROM updates ORDER BY created_at DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                String title = rs.getString("title");
                String content = rs.getString("content");
                Timestamp createdAt = rs.getTimestamp("created_at");
                updatesList.add(new Update(title, content, createdAt));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return updatesList;
    }
 // Gets the most recent 'x' number of updates
    public List<Update> getRecentUpdates(int limit) {
        List<Update> updatesList = new ArrayList<>();
        String sql = "SELECT * FROM updates ORDER BY created_at DESC LIMIT ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, limit);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                String title = rs.getString("title");
                String content = rs.getString("content");
                Timestamp createdAt = rs.getTimestamp("created_at");
                updatesList.add(new Update(title, content, createdAt));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return updatesList;
    }
}
