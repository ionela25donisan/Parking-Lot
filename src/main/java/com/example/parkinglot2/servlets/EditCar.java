package com.example.parkinglot2.servlets;

import com.example.parkinglot2.common.CarDto;
import com.example.parkinglot2.common.UserDto;
import com.example.parkinglot2.ejb.CarsBean;
import com.example.parkinglot2.ejb.UsersBean;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

@WebServlet(name = "EditCar", value = "/EditCar")
public class EditCar extends HttpServlet {

    private static final Logger LOG = Logger.getLogger(EditCar.class.getName());

    @Inject
    private UsersBean usersBean;

    @Inject
    private CarsBean carsBean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        LOG.info("EditCar doGet called");

        String idParam = request.getParameter("id");
        LOG.info("ID parameter: " + idParam);

        if (idParam == null || idParam.isEmpty()) {
            LOG.warning("No ID parameter provided!");
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Car ID is required");
            return;
        }

        try {
            Long carId = Long.valueOf(idParam);
            CarDto car = carsBean.findById(carId);

            if (car == null) {
                LOG.warning("Car not found with ID: " + carId);
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Car not found");
                return;
            }

            List<UserDto> users = usersBean.findAllUsers();

            LOG.info("Car found: " + car.getLicensePlate());
            LOG.info("Users found: " + users.size());

            request.setAttribute("car", car);
            request.setAttribute("users", users);
            request.getRequestDispatcher("/WEB-INF/pages/editCar.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            LOG.warning("Invalid ID format: " + idParam);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid car ID format");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        LOG.info("EditCar doPost called");

        Long carId = Long.valueOf(request.getParameter("car_id"));
        String licensePlate = request.getParameter("license_plate");
        String parkingSpot = request.getParameter("parking_spot");
        Long ownerId = Long.valueOf(request.getParameter("owner_id"));

        LOG.info("Updating car: " + carId);
        carsBean.updateCar(carId, licensePlate, parkingSpot, ownerId);

        response.sendRedirect(request.getContextPath() + "/Cars");
    }
}