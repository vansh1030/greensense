package com.greensense.util;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/viewCollaborations")
public class ViewCollaborationsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Collaboration> collaborationsList = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM collaborations ORDER BY created_at DESC");
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                String title = rs.getString("title");
                String description = rs.getString("description");
                String contactInfo = rs.getString("contact_info");
                collaborationsList.add(new Collaboration(title, description, contactInfo));
            }

            request.setAttribute("collaborations", collaborationsList);
            RequestDispatcher dispatcher = request.getRequestDispatcher("view_collaborations.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}