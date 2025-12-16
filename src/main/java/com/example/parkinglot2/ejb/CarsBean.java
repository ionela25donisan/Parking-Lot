package com.example.parkinglot2.ejb;

import com.example.parkinglot2.common.CarDto;
import org.example.parkinglot.entities.Car;
import org.example.parkinglot.entities.User;
import jakarta.ejb.EJBException;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

@Stateless
public class CarsBean {

    private static final Logger LOG = Logger.getLogger(CarsBean.class.getName());

    @PersistenceContext
    private EntityManager entityManager;

    // READ ALL
    public List<CarDto> findAllCars() {
        LOG.info("findAllCars");
        try {
            TypedQuery<Car> typedQuery = entityManager.createQuery("SELECT c FROM Car c", Car.class);
            List<Car> cars = typedQuery.getResultList();
            return copyCarsToDto(cars);
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }

    private List<CarDto> copyCarsToDto(List<Car> cars) {
        List<CarDto> carDtos = new ArrayList<>();
        for (Car car : cars) {
            CarDto carDto = new CarDto(
                    car.getId(),
                    car.getLicensePlate(),
                    car.getParkingSpot(),
                    car.getOwner().getUsername(),
                    car.getOwner().getId() // IMPORTANT!!!
            );
            carDtos.add(carDto);
        }
        return carDtos;
    }

    // CREATE
    public void createCar(String licensePlate, String parkingSpot, Long userId) {
        LOG.info("createCar");

        Car car = new Car();
        car.setLicensePlate(licensePlate);
        car.setParkingSpot(parkingSpot);

        User user = entityManager.find(User.class, userId);
        user.getCars().add(car);
        car.setOwner(user);

        entityManager.persist(car);
    }

    // READ BY ID
    public CarDto findById(Long carId) {
        LOG.info("findById: " + carId);
        Car car = entityManager.find(Car.class, carId);

        return new CarDto(
                car.getId(),
                car.getLicensePlate(),
                car.getParkingSpot(),
                car.getOwner().getUsername(),
                car.getOwner().getId() // IMPORTANT!!!
        );
    }

    // UPDATE
    public void updateCar(Long carId, String licensePlate, String parkingSpot, Long userId) {
        LOG.info("updateCar: " + carId);

        Car car = entityManager.find(Car.class, carId);
        car.setLicensePlate(licensePlate);
        car.setParkingSpot(parkingSpot);

        // Dacă owner-ul s-a schimbat
        if (!car.getOwner().getId().equals(userId)) {

            // Elimină din vechiul owner
            car.getOwner().getCars().remove(car);

            // Setează noul owner
            User newOwner = entityManager.find(User.class, userId);
            newOwner.getCars().add(car);
            car.setOwner(newOwner);
        }
    }

    // DELETE
    public void deleteCarsByIds(List<Long> carIds) {
        LOG.info("deleteCarsByIds: " + carIds.size() + " cars");

        for (Long carId : carIds) {
            Car car = entityManager.find(Car.class, carId);

            car.getOwner().getCars().remove(car);

            entityManager.remove(car);
        }
    }
}
