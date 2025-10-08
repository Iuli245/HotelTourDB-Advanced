-- Interaction with Oracle Server using SQL and PL/SQL
-- Control structures and basic queries

-- 1) Display all users with ID < 100
set serveroutput on
DECLARE
    CURSOR cur_utilizatori IS
        SELECT id_utilizator, nume_complet FROM Utilizatori;
    v_id_utilizator utilizatori.id_utilizator%type;
    v_nume_utilizator utilizatori.nume_complet%type;
BEGIN
    OPEN cur_utilizatori;
    LOOP
        FETCH cur_utilizatori INTO v_id_utilizator, v_nume_utilizator;
        EXIT WHEN cur_utilizatori%NOTFOUND;
        IF v_id_utilizator < 100 THEN
            DBMS_OUTPUT.PUT_LINE('ID Utilizator: ' || v_id_utilizator || ', Nume Utilizator: ' || v_nume_utilizator);
        END IF;
    END LOOP;
    CLOSE cur_utilizatori;
END;
/

-- 2) Display total number of bookings per hotel
set serveroutput on
DECLARE
    v_total_rezervari NUMBER := 0;
BEGIN
    FOR rec_hotel IN (SELECT id_hotel, nume_hotel FROM Hoteluri) LOOP
        FOR rec_rezervare IN (SELECT * FROM Rezervari WHERE id_hotel = rec_hotel.id_hotel) LOOP
            v_total_rezervari := v_total_rezervari + 1;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('Hotelul ' || rec_hotel.nume_hotel || ' are ' || v_total_rezervari || ' rezervari.');
        v_total_rezervari := 0; 
    END LOOP;
END;
/

-- 3) Calculate average hotel rating
DECLARE
    CURSOR cur_recenzii_hotel IS
        SELECT id_hotel, AVG(nota_acordata) AS nota_medie
        FROM Recenzii_Hotel
        GROUP BY id_hotel;
    v_id_hotel recenzii_hotel.id_hotel%TYPE;
    v_nota_medie NUMBER(4,2);
BEGIN
    OPEN cur_recenzii_hotel;
    LOOP
        FETCH cur_recenzii_hotel INTO v_id_hotel, v_nota_medie;
        EXIT WHEN cur_recenzii_hotel%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Hotelul cu ID ' || v_id_hotel || ' are o medie a recenziilor de ' || v_nota_medie);
    END LOOP;
    CLOSE cur_recenzii_hotel;
END;
/

-- 4) Check existence of hotel with average price in a given range
DECLARE
    v_pret_min hoteluri.pret_mediu_pe_noapte%TYPE := &Pret_minim_disponibil;
    v_pret_max hoteluri.pret_mediu_pe_noapte%TYPE := &Pret_maxim_disponibil;
BEGIN
    FOR rec_hotel IN (SELECT * FROM Hoteluri WHERE pret_mediu_pe_noapte BETWEEN v_pret_min AND v_pret_max) LOOP
        DBMS_OUTPUT.PUT_LINE('Hotelul ' || rec_hotel.nume_hotel || ' are un preț mediu pe noapte de '|| rec_hotel.pret_mediu_pe_noapte);
    END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nu există hoteluri cu prețul mediu pe noapte cuprins în intervalul specificat.');
END;
/

-- 5) Update check-in/check-out dates using ID
DECLARE
    v_id_rezervare rezervari.id_rezervare%TYPE := &id_rezervare;
    v_numar_rezervari_actualizate NUMBER := 0;
BEGIN
    UPDATE Rezervari SET data_check_out = TO_DATE('2024-02-10', 'YYYY-MM-DD') WHERE id_rezervare = v_id_rezervare;
    v_numar_rezervari_actualizate := SQL%ROWCOUNT;
    IF v_numar_rezervari_actualizate > 0 THEN
        COMMIT; 
        DBMS_OUTPUT.PUT_LINE('Rezervarea cu ID-ul ' || v_id_rezervare || ' a fost actualizata cu succes.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Nu exista nicio rezervare cu ID-ul specificat (' || v_id_rezervare || '). Nicio actualizare nu a fost efectuata.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('A intervenit o eroare în timpul actualizarii rezervarii.');
END;
/
