package com.greensense.util; // Make sure this matches your package name
import org.mindrot.jbcrypt.BCrypt;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String role = request.getParameter("role");

        // --- Admin OTP Verification Logic ---
        if ("admin".equals(role)) {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("generatedOtp") == null) {
                response.getWriter().println("Error: Please generate an OTP first.");
                return;
            }

            int generatedOtp = (int) session.getAttribute("generatedOtp");
            long otpTimestamp = (long) session.getAttribute("otpTimestamp");
            int userOtp = Integer.parseInt(request.getParameter("otp"));

            // Check if OTP is older than 5 minutes (300,000 milliseconds)
            if (System.currentTimeMillis() - otpTimestamp > 300000) {
                response.getWriter().println("Error: OTP has expired. Please generate a new one.");
                return;
            }

            if (generatedOtp != userOtp) {
                response.getWriter().println("Error: Invalid OTP.");
                return;
            }

            // OTP is verified, remove it from session
            session.removeAttribute("generatedOtp");
            session.removeAttribute("otpTimestamp");
        }
        // --- End of Admin OTP Verification ---

        // --- Standard Registration Logic (for both citizen and verified admin) ---
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        User newUser = new User();
        newUser.setFullName(fullName);
        newUser.setEmail(email);
        newUser.setPassword(hashedPassword);
        newUser.setRole(role); // Use the role from the form

        UserDAO userDAO = new UserDAO();
        boolean success = userDAO.addUser(newUser);

        if (success) {
            response.sendRedirect("index.jsp?login=true");
        } else {
            response.getWriter().println("Registration failed! The email might already be in use.");
        }
    }
}