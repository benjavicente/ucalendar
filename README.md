# UCalendar

Implementación en Rails de [uc-nrc-icalendar](https://github.com/benjavicente/uc-nrc-icalendar).

## SetUp

Para crear el entorno de desarrollo:

```bash
bundle install
yarn install
rails db:setup
```

Crear un archivo `.env` con:

```env
POSTGRES_PASSWORD=
```

## Administración

Para que se pueda obtener los cursos, primero se tiene que crear un
periodo en la base de datos. Para hacer esto se puede usar la página
de administración (`/admin`), y crear uno en la sección _Terms_.

## Creación de calendarios 

TODO

## Obtener los calendarios externamente

```js
`HOST/term/${year}/${period}/schedule.ics?cs[]=${course_section}&nrc[]=${nrc}`
```

Donde `year` es el año, `period` el periodo (`1`, `2` o `tav`),
`course_section` es el curso con su sección (ej `MAT1610-1`) y
`nrc` el `nrc` del curso (ej `14778`).

## Links de interés

- [Busca Cursos](http://buscacursos.uc.cl/)
- [dbdiagram.io database](https://dbdiagram.io/d/5fd964db9a6c525a03bb3aee)
- [Percent-encoding](https://en.wikipedia.org/wiki/Percent-encoding)

### Icalendar

- [Icalendar.org](https://icalendar.org/)
- [icalendar recurrence](https://icalendar.org/iCalendar-RFC-5545/3-3-10-recurrence-rule.html)
- [icalendar ex-dates](https://icalendar.org/iCalendar-RFC-5545/3-8-5-1-exception-date-times.html)
