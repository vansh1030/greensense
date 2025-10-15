package com.greensense.util;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/updateTruckRoute")
public class UpdateTruckRouteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int routeId = Integer.parseInt(request.getParameter("routeId"));
        int truckId = Integer.parseInt(request.getParameter("truckId"));
        String source = request.getParameter("source");
        String destination = request.getParameter("destination");
        String status = request.getParameter("status");

        TruckDAO truckDAO = new TruckDAO();
        truckDAO.updateTruckRoute(routeId, truckId, source, destination, status);

        // Redirect back to the dashboard
        response.sendRedirect("dashboard");
    }
}
