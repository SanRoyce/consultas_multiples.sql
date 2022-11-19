CREATE DATABASE desafio3_daniel_sanjuan_034;

CREATE TABLE usuarios(
   id SERIAL,
   email VARCHAR,
   nombre VARCHAR,
   apellido VARCHAR,
   rol VARCHAR
);

insert into usuarios(id, email, nombre, apellido, rol)
VALUES (1, 'danielsanjuan034@gmail.com', 'daniel', 'san juan', 'administrador');

insert into usuarios(id, email, nombre, apellido, rol)
VALUES (2, 'fernandomuñoz@gmail.com', 'fernando', 'muñoz', 'usuario');

insert into usuarios(id, email, nombre, apellido, rol)
VALUES(3, 'enzomonsalves@gmail.com', 'enzo', 'monsalves', 'usuario');

insert into usuarios(id, email, nombre, apellido, rol)
VALUES(4, 'cristianvenegas@gmail.com', 'cristian', 'venegas', 'usuario');

insert into usuarios(id, email, nombre, apellido, rol)
VALUES(5, 'consueloanguita@gmail.com', 'consuelo', 'anguita', 'usuario');



CREATE TABLE post(
   id SERIAL,
   titulo VARCHAR;
   contenido TEXT;
   fecha_creacion TIMESTAMP;
   fecha_actualizacion TIMESTAMP;
   destacado BOOLEAN;
   usuario_id BIGINT
);

insert into post(id, titulo, contenido, fecha_creacion, fecha_actualizacion, destacado, usuario_id)
values(1, 'prueba', 'documentos', '01-05-2022', '07-05-2022', true, 1);

insert into post(id, titulo, contenido, fecha_creacion, fecha_actualizacion, destacado, usuario_id)
values(2, 'test', 'archivos', '01-06-2022', '07-06-2022', true, 1);

insert into post(id, titulo, contenido, fecha_creacion, fecha_actualizacion, destacado, usuario_id)
values(3, 'prueba', 'documentos', '01-04-2022', '07-04-2022', true, 2);

insert into post(id, titulo, contenido, fecha_creacion, fecha_actualizacion, destacado, usuario_id)
values(4, 'test', 'archivos', '01-03-2022', '07-03-2022', true, 2);

insert into post(id, titulo, contenido, fecha_creacion, fecha_actualizacion, destacado, usuario_id)
values(5, 'prueba', 'documentos', '01-07-2022', '07-07-2022', true, null);



CREATE TABLE comentarios   (
   id SERIAL,
   contenido TEXT;
   fecha_creacion TIMESTAMP;
   usuario_id BIGINT,
   post_id BIGINT
);


insert into comentarios(id, contenido, fecha_creacion, usuario_id, post_id)
VALUES(1, 'texto 1', '01-01-2022', 1, 1);

insert into comentarios(id, contenido, fecha_creacion, usuario_id, post_id)
VALUES(2, 'texto 2', '01-02-2022', 2, 1);

insert into comentarios(id, contenido, fecha_creacion, usuario_id, post_id)
VALUES(3, 'texto 3', '01-02-2022', 3, 1);

insert into comentarios(id, contenido, fecha_creacion, usuario_id, post_id)
VALUES(4, 'texto 4', '01-02-2022', 1, 2);

insert into comentarios(id, contenido, fecha_creacion, usuario_id, post_id)
VALUES(5, 'texto 5', '01-02-2022', 2, 2);


2R:
SELECT u.nombre, u.email, p.titulo, p.contenido from usuarios as u join post as p on u.id = p.usuario_id;

3R:
SELECT u.id, p.titulo, p.contenido from post as p join usuarios as u on p.usuario_id = u.id where u.rol = 'administrador';

4R:
SELECT u.id, u.email, count(p.id) FROM usuarios u left join post p on u.id = p.usuario_id group by u.id, u.email;

5R:
SELECT u.email from usuarios u join post p on u.id = p.usuario_id group by u.email order by count(p.id) desc;

6R:
SELECT nombre, MAX(fecha_creacion) from (SELECT p.contenido, p.fecha_creacion, u.nombre from usuario u join post on u.id = p.usuario_id) as resultado group by nombre;

7R:
SELECT titulo, contenido from post p join (SELECT post_id, count(post_id) FROM comentarios group by post_id order by count(post_id) desc limit 1) as resultado on p.id = resultado.post_id;

8R:
SELECT p.titulo, p.contenido, c.contenido, u.email from comentarios as c join post as p on c.post_id = p.id join usuarios as u in u.id = c.usuario_id order by p.id;

9R:
SELECT fecha_creacion, contenido, usuario_id FROM comentarios c join usuarios u on c.usuario_id = u.id where c fecha_creacion = (SELECT MAX(fecha_creacion) FROM comentarios);

10R:
SELECT u.email from usuarios u left join comentarios c on u.id = c.usuario_id group by u.email HAVING count(c.id) = 0;