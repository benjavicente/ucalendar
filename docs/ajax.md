# Ayudantía AJAX

- [¿Qué es AJAX?](#qué-es-ajax)
- [Cómo funciona](#cómo-funciona)
- [Aplicando AJAX en Rail => remote: true](#aplicando-ajax-en-rail--remote-true)
- [Ejercicio ayudantía](#ejercicio-ayudantía)
  - [Gemas a utilizar](#gemas-a-utilizar)
  - [Agregar JQuery a nuestra app](#agregar-jquery-a-nuestra-app)
    - [Archivos necesarios](#archivos-necesarios)
    - [Modificando nuestro Controller](#modificando-nuestro-controller)
    - [Modificando nuestro Form](#modificando-nuestro-form)
  - [Modificando nuestro Index](#modificando-nuestro-index)
  - [Crear una partial view para el objeto Task](#crear-una-partial-view-para-el-objeto-task)
    - [Agrear AJAX a nuestra acción New](#agrear-ajax-a-nuestra-acción-new)
      - [views/tasks/new.js.erb](#viewstasksnewjserb)
    - [Agregar AJAX a nuestra acción Create](#agregar-ajax-a-nuestra-acción-create)
      - [views/tasks/create.js.erb`](#viewstaskscreatejserb)
    - [Agregar AJAX a nuestra acción Edit](#agregar-ajax-a-nuestra-acción-edit)
      - [views/tasks/edit.js.erb](#viewstaskseditjserb)
    - [Agregar AJAX a nuestra acción Update](#agregar-ajax-a-nuestra-acción-update)
      - [views/tasks/update.js.erb](#viewstasksupdatejserb)
    - [Agregar AJAX a nuestra acción Destroy](#agregar-ajax-a-nuestra-acción-destroy)
      - [views/tasks/destroy.js.erb](#viewstasksdestroyjserb)
    - [Consideraciones](#consideraciones)

## ¿Qué es AJAX?
AJAX, acrónimo de **A**synchronous **J**avaScript **A**nd **X**ML (JavaScript asíncrono y XML), es una técnica de desarrollo web para 
crear aplicaciones interactivas o **RIA** (Rich Internet Applications). Estas aplicaciones se ejecutan en el cliente, es 
decir, en el navegador de los usuarios mientras se mantiene la comunicación asíncrona con el servidor en segundo plano. 
De esta forma es posible realizar cambios sobre las páginas sin necesidad de recargarlas, mejorando la interactividad, 
velocidad y usabilidad en las aplicaciones.

## Cómo funciona

![alt text](https://www.w3schools.com/whatis/img_ajax.gif "Diagrama AJAX")
1. An event occurs in a web page (the page is loaded, a button is clicked)
2. An XMLHttpRequest object is created by JavaScript
3. The XMLHttpRequest object sends a request to a web server
4. The server processes the request
5. The server sends a response back to the web page
6. The response is read by JavaScript
7. Proper action (like page update) is performed by JavaScript <br>

Fuente: https://www.w3schools.com/whatis/whatis_ajax.asp

## Aplicando AJAX en Rail => remote: true

Rails proporciona distintas herramientas para facilitar el uso de AJAX. Una de estas es utlizar remote: true.
Al incluirlo en nuestros links o forms estaremos declarando desde un principio que el request lo queremos realizar
mediante JS y no con HTML. Además, evita que se realice la acción predeterminada.

## Ejercicio ayudantía

Crear un programa tipo **To-Do app**, donde pueda crear, editar y eliminar instancias de mi modelo, sin tener que
refrescar o trasladarme de página para poder visualizar los cambios.

Para esto crearemos un modelo llamado Task (lo haré con `scaffold` ya que supongo que muchos han trabajado con esto).

### Gemas a utilizar

```Gemfile
gem 'jquery-rails'
```

### Agregar JQuery a nuestra app

En `app/assets/javascripts/application.js`, agregar

``` js

//= require jquery3
//= require jquery_ujs
```

Si están corriendo Rails 5.1 o mayor, y tienen incluído `//= require rails-ujs`, no es necesario agregar `//= require jquery_ujs`.

#### Archivos necesarios

```tree
+app
    +controllers
        tasks_controller.rb
    +views
        +tasks
            _form_html.erb
            task.html.erb
            create.js.erb
            destroy.js.erb
            edit.js.erb
            index.html.erb
            new.js.erb
            update.js.erb
```

### Modificando nuestro Controller

```ruby
# controllers/tasks_controller.rb
class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    @tasks = Task.all
  end
  
  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.js
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.js
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.js
      format.json { head :no_content }
    end
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end
  
    def task_params
      params.require(:task).permit(:name)
    end
end
```

En este caso, agregamos `format.js` a cada acción para que esta pueda responder con JavaScript.

### Modificando nuestro Form

```erb
<!-- views/tasks/_form.html.erb -->
<%= form_with(model: task, class: 'default-form') do |form| %>
  <% if task.errors.any? %>
    <div id="error_explanation">
      <h2><%= pluralize(task.errors.count, "error") %> prohibited this task from being saved:</h2>

      <ul>
      <% task.errors.full_messages.each do |message| %>
        <li><%= message %></li>
      <% end %>
      </ul>
    </div>
  <% end %>

  <div class="field">
    <%= form.label :name %>
    <%= form.text_field :name %>
  </div>

  <div class="actions">
    <%= form.submit %>
  </div>
<% end %>
```
Al form le agregamos la clase `default-form`, la cual cambiaremos cuando tengamos que usarlo para crear y editar una
instancia, y así poder diferenciarlos.

Notar que estamos usando `form_with`, en el cual se incluye por default `remote: true`, por lo que no es necesario
escribirlo. Si tienen declarado `local: true`, borrenlo, ya que les sobreescribe `remote: true` y hará que su form se
procese con HTML.

En el caso que estén usando `form_for` o `form_tag`, deben declarar `remote: true`.

### Modificando nuestro Index
 
````erb
<!-- views/tasks/index.html.erb -->
<h1>Tasks</h1>

<div class="my-tasks">
<% @tasks.each do |task| %>
    <%= render task %>
<% end %>
</div>

<%= link_to 'New Task', new_task_path, remote: true, class: 'new-task-button' %>
````

Si se fijan, le asignaos la clase `my-tasks` al div principal de nuestro index y `new-task-button` al link,
para así acceder a estos más adelante. Además, incluimos `remote: true` en el `link_to`.

### Crear una partial view para el objeto Task

```erb
<!-- views/tasks/_task.html.erb -->
<div id="<%= task.id %>" >
  <h3><%= task.name %></h3>

  <ul>
   <li><%= link_to 'Edit Task', edit_task_path(task), remote: true %></li>
   <li><%= link_to 'Delete Task', task, remote: true, method: :delete %></li>
  </ul>
</div>
```
En el div del principio le aisgnamos como id el id del task que está mostrando.
Estos nos servirá más adelante para poder acceder facilmente a este.

### Agrear AJAX a nuestra acción New

```js
// views/tasks/new.js.erb
$(".new-task-button").after(" <%= j render partial: 'form', locals: {task: @task} %> ");
$(".default-form").addClass("create-form").removeClass("default-form");
$(".new-task-button").hide();
```

Este código correrá cuando llamemos al método new de TasksController.

Para que entiendan un poco mejor el código, la primera linea va a encontrar el link que tiene la clase `new-task-button`
y abajo renderizará la view parcial tasks/_form.html.erb. La `j` es un abreviado de `escape-javascript`.

La segunda linea le egrega la clase `create-form` y le remueve `default-form` a el form que acabamos de renderizar.
Finalmente, la tercera línea esconde nuestro `new-task-button`.


### Agregar AJAX a nuestra acción Create

```js
// views/tasks/create.js.erb
$(".create-form").hide();
$(".my-tasks").append("<%= j render partial: 'task', locals: {task: @task} %>");
$(".new-task-button").show();
```

Esto hará que, al hacer submit en nuestro `create-form`, se esconda, se agregue nuestra nueva task al listado en nuestro
index y que vuelva a mostrarse nuestro new-task-button.

### Agregar AJAX a nuestra acción Edit

```js
// views/tasks/edit.js.erb
$("div#<%= @task.id %>").html(" <%= j render partial: 'form', locals: {task: @task} %> ");
$(".default-form").addClass('update-form').removeClass('default-form').attr("id", "<%= @task.id %>");
```

Esta línea hace que el contenido dentro del `div` con el id igual al id del task que queremos editar, se reemplace por
nuestro form. Luego, al form que acabamos de renderizar, le agregaremos la clase `update-form` y el id de nuestro
`task`. Así podremos diferenciar este form de uno del método `create`, y, además, podremos diferenciar cada form para
`update` uno del otro.

### Agregar AJAX a nuestra acción Update

```js
// views/tasks/update.js.erb
$("div#<%= @task.id %>").html("<%= j render partial: 'task', locals: {task: @task} %>");
```

Al hacer submit, el form se reemplazará por el contenido del task
que acabamos de editar.

### Agregar AJAX a nuestra acción Destroy

```js
// views/tasks/destroy.js.erb
$("div#<%= @task.id %>").fadeOut();
```

Esta línea permitirá que el task que estamos eliminando deje de visualizarse en la pantalla.

## Consideraciones
* Recuerden que deben crear los archivos *.js.erb, y ahí escribir su código. No se confundan con los *html.erb.
* Recuerden que los archivos *.js.erb solo modifican su view. Todo procesamiento lo sigue realizando, en segundo plano,
el controlador.
* El código implementado en cada *js.erb es solo una alternativa de como actualizar la view. Pueden conseguir el mismo
efecto de muchas maneras (revisar la [documentación de jquery](https://api.jquery.com/)).
* Pueden crear sus propios métodos personalizados y lograr distintos efectos. Investiguen en cómo hacerlo.
* Si actualizan algún task y luego refrescan la página, estos cambiaran su orden. Esto se debe a que se
están ordenando según la última fecha de edición. Pueden configurar el método index del controlador para que se ordenen
según su fecha de creación, para que así mantengan su orden.
    