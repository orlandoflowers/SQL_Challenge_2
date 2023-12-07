CREATE TABLE INSCRITOS(cantidad INT, fecha DATE, fuente VARCHAR);
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 44, '01/01/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 56, '01/01/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 39, '01/02/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 81, '01/02/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 12, '01/03/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 91, '01/03/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 48, '01/04/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 45, '01/04/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 55, '01/05/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 33, '01/05/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 18, '01/06/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 12, '01/06/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 34, '01/07/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 24, '01/07/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 83, '01/08/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 99, '01/08/2021', 'Página' );

SELECT * FROM inscritos;

--1) Cuantos registros hay ok
SELECT COUNT(*) AS cantidad FROM inscritos;

--2) Cuantos inscritos hay en total ok
SELECT SUM(cantidad) as suma FROM inscritos;

--3. ¿Cuál o cuáles son los registros de mayor antigüedad?ok
SELECT * FROM inscritos WHERE fecha = (SELECT MIN(fecha) FROM inscritos);

--4. ¿Cuántos inscritos hay por día? (entendiendo un día como una fecha distinta de ahora en adelante) ok
SELECT fecha, SUM(cantidad) AS suma_por_dia FROM inscritos GROUP BY fecha ORDER BY fecha;

--5. ¿Cuántos inscritos hay por fuente? ok
SELECT fuente, SUM(cantidad) AS suma_por_cantidad FROM inscritos GROUP BY fuente ORDER BY fuente;

--6 ¿Qué día se inscribió la mayor cantidad de personas? Y ¿Cuántas personas se inscribieron en ese día? ok
SELECT fecha, SUM(cantidad) AS maximo_diario
FROM inscritos
GROUP BY fecha
HAVING SUM(cantidad) = (
    SELECT MAX(total_cantidad)
    FROM (
        SELECT SUM(cantidad) AS total_cantidad
        FROM inscritos
        GROUP BY fecha
    ) AS max_totals
);

--7. ¿Qué días se inscribieron la mayor cantidad de personas utilizando el blog? ¿Cuántas personas fueron? Si se puede usar limit
SELECT fecha, SUM(cantidad) AS maximo_diario
FROM inscritos
WHERE fuente = 'Blog'
GROUP BY fecha
HAVING SUM(cantidad) = (
    SELECT MAX(total_cantidad)
    FROM (
        SELECT SUM(cantidad) AS total_cantidad
        FROM inscritos
        WHERE fuente = 'Blog'
        GROUP BY fecha
    ) AS max_totals
);



--8. ¿Cuál es el promedio de personas inscritas por día?ok
SELECT fecha, AVG(cantidad) AS suma_por_dia FROM inscritos GROUP BY fecha ORDER BY fecha;


--9. ¿Qué días se inscribieron más de 50 personas?
SELECT fecha, SUM(cantidad) AS total_cantidad
FROM inscritos
GROUP BY fecha
HAVING SUM(cantidad) > 50
ORDER BY fecha;






--10. ¿Cuál es el promedio diario de personas inscritas a partir del tercer día en adelante, considerando únicamente las fechas posteriores o iguales a la indicada?

SELECT fecha, AVG(cantidad) AS suma_por_dia FROM inscritos GROUP BY fecha ORDER BY fecha OFFSET 2;
