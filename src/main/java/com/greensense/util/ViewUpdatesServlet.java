package com.greensense.util;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/viewUpdates")
public class ViewUpdatesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UpdateDAO updateDAO = new UpdateDAO();
        List<Update> updatesList = updateDAO.getAllUpdates();

        request.setAttribute("updates", updatesList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("view_updates.jsp");
        dispatcher.forward(request, response);
    }
}