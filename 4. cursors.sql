-- Cursor management (implicit and explicit, with and without parameters)

DECLARE
    -- Implicit cursors
    CURSOR hoteluri_cur IS
        SELECT id_hotel, nume_hotel, adresa_hotel
        FROM Hoteluri;

    CURSOR rezervari_utilizator_cur (v_id_utilizator NUMBER) IS
        SELECT id_rezervare, id_hotel, data_check_in, data_check_out
        FROM Rezervari
        WHERE id_utilizator = v_id_utilizator;

    CURSOR recenzii_hotel_cur (v_id_hotel NUMBER) IS
        SELECT id_recenzii, nota_acordata
        FROM Recenzii_Hotel
        WHERE id_hotel = v_id_hotel;

    -- Explicit cursors
    TYPE rezervari_cur_type IS REF CURSOR;
    v_rezervari_cur rezervari_cur_type;

    TYPE hoteluri_cur_type IS REF CURSOR;
    v_hoteluri_cur hoteluri_cur_type;

    TYPE recenzii_cur_type IS REF CURSOR;
    v_recenzii_cur recenzii_cur_type;

    v_id_utilizator NUMBER := 1; 
    v_id_hotel NUMBER := 1; 
BEGIN
    -- Use implicit cursors and loops here (as in your code)
    -- Use explicit cursors with OPEN, FETCH, CLOSE
END;
/
