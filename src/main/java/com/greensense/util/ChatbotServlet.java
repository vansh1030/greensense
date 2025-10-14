package com.greensense.util;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/chatbot")
public class ChatbotServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userMessage = request.getParameter("message").toLowerCase();
        String botResponse = "I'm sorry, I don't understand. You can ask me things like 'how to complain', 'contact info', or 'view updates'.";

        if (userMessage.contains("complain") || userMessage.contains("report")) {
            botResponse = "To file a complaint, please register or log in, then navigate to the 'Submit Complaint' section.";
        } else if (userMessage.contains("update")) {
            botResponse = "You can see all the latest news and updates by clicking on the 'View Latest Updates' link on the homepage.";
        } else if (userMessage.contains("cleanup") || userMessage.contains("join") || userMessage.contains("collaborate")) {
            botResponse = "That's great! Check out our 'Collaborations & Events' page for information on upcoming cleanup drives and how to get involved.";
        } else if (userMessage.contains("contact") || userMessage.contains("help")) {
            botResponse = "For assistance, please refer to the contact information listed on our collaboration pages.";
        } else if (userMessage.contains("hello") || userMessage.contains("hi")) {
            botResponse = "Hello there! How can I assist you?";
        }

        // Respond with JSON
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print("{\"reply\": \"" + botResponse + "\"}");
        out.flush();
    }
}