package com.greensense.util;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/updateStatus")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1 MB
                 maxFileSize = 1024 * 1024 * 10,   // 10 MB
                 maxRequestSize = 1024 * 1024 * 15) // 15 MB
public class UpdateComplaintStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int complaintId = Integer.parseInt(request.getParameter("complaintId"));
        String newStatus = request.getParameter("status");

        ComplaintDAO complaintDAO = new ComplaintDAO();

        if ("resolved".equals(newStatus)) {
            // Handle file upload for resolution image
            Part filePart = request.getPart("resolutionImage");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = complaintId + "_" + System.currentTimeMillis() + "_" + Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String uploadDir = getServletContext().getRealPath("/uploads/resolved/");
                Path uploadPath = Paths.get(uploadDir);
                if (!Files.exists(uploadPath)) {
                    Files.createDirectories(uploadPath);
                }
                Path filePath = uploadPath.resolve(fileName);
                try (InputStream fileContent = filePart.getInputStream()) {
                    Files.copy(fileContent, filePath, StandardCopyOption.REPLACE_EXISTING);
                }
                // Update complaint with image path
                complaintDAO.updateComplaintStatusWithImage(complaintId, newStatus, "uploads/resolved/" + fileName);
            } else {
                // No image uploaded, just update status
                complaintDAO.updateComplaintStatus(complaintId, newStatus);
            }
        } else {
            // Update status without image
            complaintDAO.updateComplaintStatus(complaintId, newStatus);
        }

        // Redirect back to the dashboard
        response.sendRedirect("dashboard");
    }
}
