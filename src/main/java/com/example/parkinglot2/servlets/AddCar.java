package com.example.parkinglot2.servlets;

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

@WebServlet(name = "AddCar", value = "/AddCar")
public class AddCar extends HttpServlet {

    private static final Logger LOG = Logger.getLogger(AddCar.class.getName());

    @Inject
    private UsersBean usersBean;

    @Inject
    private CarsBean carsBean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        LOG.info("=== AddCar doGet START ===");
        LOG.info("UsersBean injected: " + (usersBean != null));

        List<UserDto> users = usersBean.findAllUsers();

        LOG.info("Number of users found: " + users.size());
        for (UserDto user : users) {
            LOG.info("User: ID=" + user.getId() + ", Username=" + user.getUsername());
        }

        request.setAttribute("users", users);

        LOG.info("=== AddCar doGet END ===");

        request.getRequestDispatcher("/WEB-INF/pages/addCar.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String licensePlate = request.getParameter("license_plate");
        String parkingSpot = request.getParameter("parking_spot");
        Long ownerId = Long.valueOf(request.getParameter("owner_id"));

        carsBean.createCar(licensePlate, parkingSpot, ownerId);

        response.sendRedirect(request.getContextPath() + "/Cars");
    }
}