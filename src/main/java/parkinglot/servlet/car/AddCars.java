package parkinglot.servlet.car;

import jakarta.annotation.security.DeclareRoles;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.HttpConstraint;
import jakarta.servlet.annotation.ServletSecurity;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import parkinglot.ejb.CarsBean;
import parkinglot.ejb.UsersBean;

import java.io.IOException;

@DeclareRoles({"WRITE_CARS"})
@ServletSecurity(value = @HttpConstraint(rolesAllowed = {"WRITE_CARS"}))
@WebServlet(name = "AddCars", value = "/AddCar")
public class AddCars extends HttpServlet {

    @Inject
    private UsersBean usersBean;

    @Inject
    private CarsBean carsBean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("users", usersBean.findAllUsers());
        request.getRequestDispatcher("/WEB-INF/pages/car/addCar.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String licensePlate = request.getParameter("license_plate");
        String parkingSpot = request.getParameter("parking_spot");
        String ownerIdStr = request.getParameter("owner_id");

        // Validare: license plate nu e gol
        if (licensePlate == null || licensePlate.trim().isEmpty()) {
            request.setAttribute("errorMessage", "License plate is required");
            request.setAttribute("users", usersBean.findAllUsers());
            request.getRequestDispatcher("/WEB-INF/pages/car/addCar.jsp").forward(request, response);
            return;
        }

        // Convertește la uppercase IMEDIAT
        licensePlate = licensePlate.trim().toUpperCase();

        // Validare: lungime
        if (licensePlate.length() < 2 || licensePlate.length() > 20) {
            request.setAttribute("errorMessage", "License plate must be between 2 and 20 characters");
            request.setAttribute("users", usersBean.findAllUsers());
            request.getRequestDispatcher("/WEB-INF/pages/car/addCar.jsp").forward(request, response);
            return;
        }

        // Validare: doar litere și cifre (DUPĂ convertire la uppercase)
        if (!licensePlate.matches("^[A-Z0-9]+$")) {
            request.setAttribute("errorMessage", "License plate must contain only letters and numbers (no special characters)");
            request.setAttribute("users", usersBean.findAllUsers());
            request.getRequestDispatcher("/WEB-INF/pages/car/addCar.jsp").forward(request, response);
            return;
        }

        // Validare: parking spot
        if (parkingSpot == null || parkingSpot.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Parking spot is required");
            request.setAttribute("users", usersBean.findAllUsers());
            request.getRequestDispatcher("/WEB-INF/pages/car/addCar.jsp").forward(request, response);
            return;
        }

        // Validare: owner
        if (ownerIdStr == null || ownerIdStr.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Owner is required");
            request.setAttribute("users", usersBean.findAllUsers());
            request.getRequestDispatcher("/WEB-INF/pages/car/addCar.jsp").forward(request, response);
            return;
        }

        try {
            Long userId = Long.parseLong(ownerIdStr);
            carsBean.createCar(licensePlate, parkingSpot.trim(), userId);
            response.sendRedirect(request.getContextPath() + "/Cars");
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid owner ID");
            request.setAttribute("users", usersBean.findAllUsers());
            request.getRequestDispatcher("/WEB-INF/pages/car/addCar.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error creating car: " + e.getMessage());
            request.setAttribute("users", usersBean.findAllUsers());
            request.getRequestDispatcher("/WEB-INF/pages/car/addCar.jsp").forward(request, response);
        }
    }
}