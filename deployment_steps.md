# GreenSense Waste Management System - Deployment Guide

## Prerequisites
- Java 25 JDK installed
- Apache Tomcat 10.1 or later
- MySQL 8.0 or later
- Git (for version control)

## Database Setup
1. Install MySQL Server
2. Create a database user with appropriate permissions
3. Run the SQL script to set up the database:
   ```sql
   mysql -u root -p < sql_setup.sql
   ```
4. Update the database credentials in `src/main/java/com/greensense/util/DBUtil.java`:
   - Change `USER` and `PASSWORD` to match your MySQL setup

## Build the Project
1. Compile the Java classes:
   ```bash
   javac -cp "src/main/webapp/WEB-INF/lib/*" src/main/java/com/greensense/util/*.java -d build/classes
   ```

2. Copy the compiled classes to the webapp:
   ```bash
   cp -r build/classes/* src/main/webapp/WEB-INF/classes/
   ```

## Deploy to Tomcat
1. Install Apache Tomcat 10.1
2. Create a WAR file:
   ```bash
   cd src/main/webapp
   jar -cvf greensense.war .
   ```
3. Copy the WAR file to Tomcat's webapps directory:
   ```bash
   cp greensense.war /path/to/tomcat/webapps/
   ```
4. Start Tomcat:
   ```bash
   /path/to/tomcat/bin/startup.sh
   ```

## Access the Application
- Open your browser and go to: `http://localhost:8080/greensense`
- Default admin login: admin@greensense.com / admin123
- Default citizen login: john@example.com / citizen123

## Troubleshooting
- Ensure all JAR dependencies are in `WEB-INF/lib/`
- Check Tomcat logs for errors: `/path/to/tomcat/logs/`
- Verify database connection in DBUtil.java
- Make sure MySQL service is running

## Production Considerations
- Use environment variables for database credentials
- Implement HTTPS
- Set up proper logging
- Configure session management
- Set up backup procedures for the database
