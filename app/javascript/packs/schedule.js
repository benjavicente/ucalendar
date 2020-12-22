// Globals
var inputs, schedule_table_and_links, params

const schedule_request = new XMLHttpRequest()
schedule_request.addEventListener("load", scheduleLoaded)

const target = new URL("http://localhost:3000/t/s.xml")


document.addEventListener("DOMContentLoaded", function() {
  inputs = Array.from(document.getElementsByClassName('inputs')[0].elements)
  schedule_table_and_links = document.getElementById('schedule_table_and_links')
  inputs.forEach( function(input_element) {
    input_element.addEventListener('change', onInputChange)
  })
})


function scheduleLoaded(_event) {
  schedule_table_and_links.innerHTML = schedule_request.response
  // Cambiar URL
  var t = new URL(window.location.href)
  t.search = params.toString()
  window.history.replaceState({}, '', t.toString())
}

function sendScheduleRequest() {
  target.search = params
  schedule_request.open("GET", target)
  schedule_request.send()
}


function onInputChange(event) {
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
