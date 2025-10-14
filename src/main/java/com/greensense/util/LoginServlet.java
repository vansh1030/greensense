package com.greensense.util;

import java.io.IOException;
import org.mindrot.jbcrypt.BCrypt;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByEmail(email);

        if (user != null && BCrypt.checkpw(password, user.getPassword())) {
            // User exists and password is correct
            HttpSession session = request.getSession();
            session.setAttribute("user_id", user.getId());
            session.setAttribute("user_role", user.getRole());
            session.setAttribute("user_name", user.getFullName());
            
            if ("admin".equals(user.getRole())) {
                response.sendRedirect("dashboard"); // Correct redirect to AdminDashboardServlet
            } else {
                response.sendRedirect("citizenDashboard"); // Correct redirect to CitizenDashboardServlet
            }
        } else {
            // User not found or password incorrect
            response.sendRedirect(request.getContextPath() + "/index.jsp?error=true"); // Redirect back to homepage with error
        }
    }
}