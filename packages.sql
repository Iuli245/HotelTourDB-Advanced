-- Package: Gestionare_Proceduri
CREATE OR REPLACE PACKAGE Gestionare_Proceduri AS
    PROCEDURE Adauga_Utilizator (
        p_nume_complet IN VARCHAR2,
        p_parola IN VARCHAR2,
        p_adresa_email IN VARCHAR2,
        p_telefon IN VARCHAR2,
        p_data_nastere IN DATE,
        p_domiciliul IN VARCHAR2
    );

    PROCEDURE Adauga_Rezervare (
        p_id_utilizator IN NUMBER,
        p_id_hotel IN NUMBER,
        p_data_check_in IN DATE,
        p_data_check_out IN DATE,
        p_numar_adulti IN NUMBER,
        p_numar_copii IN NUMBER,
        p_numar_de_camere_rezervate IN NUMBER
    );

    PROCEDURE Sterge_Utilizator (
        p_id_utilizator IN NUMBER
    );
END Gestionare_Proceduri;
/

-- Package Body: Gestionare_Proceduri
CREATE OR REPLACE PACKAGE BODY Gestionare_Proceduri AS
    -- procedures implementation (as in your code)
END Gestionare_Proceduri;
/

-- Package: Gestionare_Functii
CREATE OR REPLACE PACKAGE Gestionare_Functii AS
    FUNCTION Verifica_Existenta_Utilizator (p_adresa_email IN VARCHAR2) RETURN BOOLEAN;
    FUNCTION Obtinere_Nota_Medie_Hotel (p_id_hotel IN NUMBER) RETURN NUMBER;
    FUNCTION Verifica_Disponibilitate_Hotel (p_id_hotel IN NUMBER, p_data_check_in IN DATE, p_data_check_out IN DATE) RETURN BOOLEAN;
END Gestionare_Functii;
/

-- Package Body: Gestionare_Functii
CREATE OR REPLACE PACKAGE BODY Gestionare_Functii AS
    -- functions implementation (as in your code)
END Gestionare_Functii;
/
