-- Ejericio 1 obtener usuario,localizacion y la reputacion en orden desendente
SELECT TOP (200) DisplayName, Location, Reputation
FROM Users
ORDER BY Reputation DESC;

-- Ejercicio 2 los posts con sus usuarios
SELECT TOP (200) Posts.Title, Users.DisplayName
FROM Posts 
INNER JOIN Users ON Posts.OwnerUserId = Users.Id 
Where Posts.Title IS NOT NULL AND Posts.Title IS NOT NULL;

--Ejercicio 3 Calcular promedio de score 
SELECT TOP (200) Users.DisplayName, AVG(Posts.Score) AS promedio_score
FROM Posts 
INNER JOIN Users ON Posts.OwnerUserId = Users.Id
Where Posts.OwnerUserId IS NOT NULL
GROUP BY Users.DisplayName
ORDER BY promedio_score DESC;

--Ejercicio 4 usuarios que han hecho mas de 100 comentarios
SELECT TOP (200) Users.DisplayName
FROM Users
WHERE Users.Id IN (
SELECT Comments.UserId
FROM Comments 
GROUP BY Comments.UserId
HAVING COUNT(Comments.Id) > 100
)
ORDER BY Users.DisplayName, Users.Id;

--Ejercicio 5 actualizar locacion null a 'desconocido'

UPDATE Users
SET Location = 'Desconocido'
WHERE Location IS NULL OR Location = '';
PRINT 'La actualizacion se realizo exitosamente';
 --para visualizar los cambios 
 SELECT TOP (200) Id,DisplayName, Location
 FROM Users 
 WHERE Location = 'Desconocido';

 --Ejercicio 6 eliminar todos los comentarios de users con - de 100 de reputacion
DELETE Comments
FROM Comments
JOIN Users ON Comments.UserId = Users.Id
WHERE Users.Reputation < 100;
PRINT 'numero de comentarios eliminados:' + CAST(@@ROWCOUNT AS NVARCHAR (10));

--Ejercicio 7 mostrar nr total de posts, comments y badges (medallas)
SELECT TOP (200) Users.DisplayName,
(SELECT COUNT(*) FROM Posts WHERE OwnerUserId = Users.Id) AS todos_posts,
(SELECT COUNT(*) FROM Comments WHERE Users.Id = Users.Id) AS todos_comentarios,
(SELECT COUNT(*) FROM Badges WHERE Users.Id = Users.Id) AS todos_medallas
FROM Users
ORDER BY todos_posts DESC, Users.DisplayName;

--Ejercicio 8 las 10 publicaciones mas populares basadas en la score

SELECT TOP 10 
Title, 
Score
FROM Posts
WHERE Title IS NOT NULL
ORDER BY
Score DESC

--Ejercicio 9 los 5 comentarios mas recientes fecha de forma descendente
SELECT TOP 5 Text ,CreationDate 
FROM Comments
ORDER BY CreationDate DESC