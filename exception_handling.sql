-- Exception handling examples (at least 2 implicit, 2 explicit)

-- 1) Insert new user with email check
DECLARE
    v_id_utilizator NUMBER;
    v_email_exist NUMBER := 0;
BEGIN
    SELECT COUNT(*)
    INTO v_email_exist
    FROM Utilizatori
    WHERE adresa_email = 'mihai.ioncu@gmail.com';

    IF v_email_exist = 0 THEN
        INSERT INTO Utilizatori (id_utilizator, nume_complet, parola, adresa_email, telefon, data_nastere, domiciliul)
        VALUES (Utilizatori_seq.NEXTVAL, 'Nume Test', 'parola123', 'tet@example.com', '0712345678', TO_DATE('01-01-2000', 'DD-MM-YYYY'), 'Adresa Test');
        DBMS_OUTPUT.PUT_LINE('Utilizatorul a fost inserat cu succes.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Adresa de email este folosita de catre alt utilizator.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: ' || SQLERRM);
END;
/

-- 2) Update review with validation
DECLARE
    v_nota_acordata NUMBER(3, 1) := 8.5;
    v_id_recenzii NUMBER := 1;
BEGIN
    UPDATE Recenzii_Hotel
    SET nota_acordata = v_nota_acordata
    WHERE id_recenzii = v_id_recenzii;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Recenzia specificata nu a fost gasita.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Nota recenziei a fost actualizata.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: ' || SQLERRM);
END;
/

-- 3) List bookings using cursor
DECLARE
    CURSOR rezervari_cur IS
        SELECT id_rezervare, id_hotel, data_check_in, data_check_out
        FROM Rezervari
        WHERE id_utilizator = 1;
    v_rezervare rezervari_cur%ROWTYPE;
BEGIN
    OPEN rezervari_cur;
    LOOP
        FETCH rezervari_cur INTO v_rezervare;
        EXIT WHEN rezervari_cur%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Rezervare: ' || v_rezervare.id_rezervare || ' pentru hotelul: ' || v_rezervare.id_hotel);
    END LOOP;
    CLOSE rezervari_cur;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista rezervari pentru acest utilizator.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: ' || SQLERRM);
END;
/

-- 4) Delete hotel data with exception
DECLARE
    v_id_hotel NUMBER := 10;
    hotel_not_found EXCEPTION;
BEGIN
    UPDATE Hoteluri
    SET nume_hotel = NULL, adresa_hotel = NULL, numar_de_stele = NULL, numar_de_camere = NULL, pret_mediu_pe_noapte = NULL
    WHERE id_hotel = v_id_hotel;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE hotel_not_found;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Datele despre hotel au fost sterse cu succes.');
EXCEPTION
    WHEN hotel_not_found THEN
        DBMS_OUTPUT.PUT_LINE('Hotelul specificat nu a fost gasit.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('A aparut o eroare: ' || SQLERRM);
END;
/
