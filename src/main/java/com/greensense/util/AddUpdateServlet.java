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

@WebServlet("/addUpdate")
public class AddUpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("user_role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        Update newUpdate = new Update();
        newUpdate.setTitle(request.getParameter("title"));
        newUpdate.setContent(request.getParameter("content"));
        newUpdate.setAdminId((int) session.getAttribute("user_id"));

        UpdateDAO updateDAO = new UpdateDAO();
        updateDAO.addUpdate(newUpdate);

        response.sendRedirect("admin_dashboard.jsp");
    }
}