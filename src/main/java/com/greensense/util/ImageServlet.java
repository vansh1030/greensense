package com.greensense.util;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/images/*")
public class ImageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    // The base path where images are stored. MUST match your ComplaintServlet.
    private final String imageBasePath = "C:/waste_management_uploads";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String requestedImage = request.getPathInfo();

        if (requestedImage == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND); // Not found.
            return;
        }

        File imageFile = new File(imageBasePath, requestedImage);

        if (!imageFile.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND); // Not found.
            return;
        }

        // Get the MIME type of the file
        String contentType = getServletContext().getMimeType(imageFile.getName());
        if (contentType == null) {
            contentType = "application/octet-stream"; // Default content type
        }

        response.setContentType(contentType);
        response.setContentLength((int) imageFile.length());
        Files.copy(imageFile.toPath(), response.getOutputStream());
    }
}