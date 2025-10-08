-- Trigger 1: Update average price after insert/update reservation
CREATE OR REPLACE TRIGGER update_average_price
AFTER INSERT OR UPDATE ON Rezervari
FOR EACH ROW
DECLARE
    total_price NUMBER;
    average_price NUMBER;
BEGIN
    -- calculation logic
END;
/

-- Trigger 2: Delete reviews when hotel is deleted
CREATE OR REPLACE TRIGGER delete_reviews_on_hotel_delete
BEFORE DELETE ON Hoteluri
FOR EACH ROW
BEGIN
    DELETE FROM Recenzii_Hotel
    WHERE id_hotel = :OLD.id_hotel;
END;
/

-- Trigger 3: Check room availability before insert reservation
CREATE OR REPLACE TRIGGER check_room_availability
BEFORE INSERT ON Rezervari
FOR EACH ROW
DECLARE
    total_reservations NUMBER;
    total_rooms_available NUMBER;
BEGIN
    -- check logic
END;
/
