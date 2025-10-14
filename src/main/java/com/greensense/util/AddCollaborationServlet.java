package com.greensense.util;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/addCollaboration")
public class AddCollaborationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("user_role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String contactInfo = request.getParameter("contactInfo");
        int adminId = (int) session.getAttribute("user_id");

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(
                "INSERT INTO collaborations (title, description, contact_info, posted_by_admin_id) VALUES (?, ?, ?, ?)")) {

            pstmt.setString(1, title);
            pstmt.setString(2, description);
            pstmt.setString(3, contactInfo);
            pstmt.setInt(4, adminId);
            pstmt.executeUpdate();

            response.sendRedirect("admin_dashboard.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}