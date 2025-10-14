package com.greensense.util;

import java.sql.Timestamp;

public class TruckRoute {
    private int routeId;
    private int truckId;
    private String sourceLocation;
    private String destinationLocation;
    private Timestamp departureTime;
    private Timestamp arrivalTime;
    private String status;

    public TruckRoute(int routeId, int truckId, String source, String dest, Timestamp depart, Timestamp arrive, String status) {
        this.routeId = routeId;
        this.truckId = truckId;
        this.sourceLocation = source;
        this.destinationLocation = dest;
        this.departureTime = depart;
        this.arrivalTime = arrive;
        this.status = status;
    }

    // Add all Getters and Setters here...
    public int getRouteId() { return routeId; }
    public int getTruckId() { return truckId; }
    public String getSourceLocation() { return sourceLocation; }
    public String getDestinationLocation() { return destinationLocation; }
    public Timestamp getDepartureTime() { return departureTime; }
    public Timestamp getArrivalTime() { return arrivalTime; }
    public String getStatus() { return status; }
}