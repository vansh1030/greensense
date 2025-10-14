package com.greensense.util;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/submitComplaint")
@MultipartConfig // IMPORTANT: This annotation is required for file uploads
public class ComplaintServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    // IMPORTANT: Change this path to the folder you created on your computer
    private final String uploadPath = "C:\\waste_management_uploads";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // --- File Upload Logic (remains the same) ---
        Part filePart = request.getPart("photo");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        File uploadDir = new File("C:/waste_management_uploads");
        if (!uploadDir.exists()) uploadDir.mkdir();
        File file = new File(uploadDir, fileName);
        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }
        // --- End of File Upload Logic ---

        Complaint complaint = new Complaint();
        complaint.setCitizenId((int) session.getAttribute("user_id"));
        complaint.setDescription(request.getParameter("description"));
        complaint.setCategory(request.getParameter("category"));
        complaint.setImagePath(fileName); // Save only the filename
        complaint.setLatitude(Double.parseDouble(request.getParameter("latitude")));
        complaint.setLongitude(Double.parseDouble(request.getParameter("longitude")));

        ComplaintDAO complaintDAO = new ComplaintDAO();
        boolean success = complaintDAO.addComplaint(complaint);

        if (success) {
        	response.sendRedirect("citizenDashboard"); // This is correct
        } else {
            response.getWriter().println("Failed to submit complaint.");
        }
    }
}