package parkinglot.common;

public class CarDto {
    private Long id;
    private String licensePlate;
    private String parkingSpot;
    private String ownerName;
    private Long ownerId;

    public CarDto(Long id, String licensePlate, String parkingSpot, String ownerName, Long ownerId) {
        this.id = id;
        this.licensePlate = licensePlate;
        this.parkingSpot = parkingSpot;
        this.ownerName = ownerName;
        this.ownerId = ownerId;
    }

    public Long getId() {
        return id;
    }

    public String getLicensePlate() {
        return licensePlate;
    }

    public String getParkingSpot() {
        return parkingSpot;
    }

    public String getOwnerName() {
        return ownerName;
    }

    public Long getOwnerId() {
        return ownerId;
    }
}