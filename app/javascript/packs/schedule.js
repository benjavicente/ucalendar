// Gloabales
var inputs, schedule_table_and_links, params, term_field, yaer, period

var host = window.location.origin
console.log(host)

const schedule_request = new XMLHttpRequest()
schedule_request.addEventListener("load", scheduleLoaded)


function getTarget(year, period, format="") {
  return new URL ([host, "term", year || 0, period || 0, "schedule"].join("/") + (format ? `.${format}` : ""))
}

function scheduleLoaded(_event) {
  // Cabia la tabla
  schedule_table_and_links.innerHTML = schedule_request.response
  // Cambiar URL
  var t = getTarget(year, period)
  t.search = params.toString()
  window.history.replaceState({}, '', t.toString())
}

function sendScheduleRequest() {
  var target = getTarget(year, period, 'xml')
  target.search = params
  schedule_request.open("GET", target)
  schedule_request.send()
}

function onInputChange(event) {
  [year, period] = term_field.value.split('-')
  if (event.target.checkValidity()) {
    var params_values = []
    inputs.forEach(function(input_element){
      var value = input_element.value
      if (/[\w\d]{5,8}-\d+/.test(value)) {
        params_values.push(`cs[]=${value}`)
      }
      else if (/\d{5,6}/.test(value)){
        params_values.push(`nrc[]=${value}`)
      }
    })
    params = "?" + params_values.join("&")
    sendScheduleRequest()
  }
}


document.addEventListener("DOMContentLoaded", function() {
  // Obtiene los parámetros en orden
  var search_params = []
  decodeURI(window.location.search).slice(1).split('&').forEach(function(element) {
    var [key, value] = element.split("=")
    console.log(key, value)
    console.log(element)
    if ( (key === "cs[]" && /[\w\d]{5,8}-\d+/.test(value)) || (key === "ncr[]" && /\d{5,6}/.test(value)) ) {
      search_params.push(value)
    }
  })
  // Añade el se4lector de semestre
  term_field = document.getElementById('period')
  term_field.addEventListener('change', onInputChange)
  // Añade los parametros y los eventos a los inputs
  inputs = Array.from(document.getElementsByClassName('inputs')[0].elements)
  schedule_table_and_links = document.getElementById('schedule_table_and_links')
  inputs.forEach( function(input_element, index) {
    if (search_params.length > 0) {
      input_element.value = search_params.pop()
    }
    input_element.addEventListener('change', onInputChange)
  })
})

