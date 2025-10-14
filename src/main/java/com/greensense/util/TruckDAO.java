package com.greensense.util;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TruckDAO {
    public List<TruckRoute> getAllRoutes() {
        List<TruckRoute> routes = new ArrayList<>();
        String sql = "SELECT * FROM truck_routes ORDER BY departure_time DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                // You will need to create the TruckRoute.java class next
                routes.add(new TruckRoute(
                    rs.getInt("route_id"),
                    rs.getInt("truck_id"),
                    rs.getString("source_location"),
                    rs.getString("destination_location"),
                    rs.getTimestamp("departure_time"),
                    rs.getTimestamp("arrival_time"),
                    rs.getString("status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return routes;
    }
}