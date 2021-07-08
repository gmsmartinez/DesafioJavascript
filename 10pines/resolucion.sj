 function Disponibilidad(finesDeSemana, diasDeLaSemana, fechasDelMes){
  //esta propiedad indica que esta disponible sabados y domingos
  //es un booleano del tipo true | false
  this.finesdesemana = finesDeSemana;
  //esta propiedad indica una lista de dias de la semana
  // ['lunes', 'martes', 'miercoles', 'jueves', 'viernes']
  this.diasDeLaSemana = diasDeLaSemana;
  //Esta propiedad nos indica dias de un mes
  //es una lista que va del [1,2,3...,31]
  this.fechasDelMes = fechasDelMes;
}
Disponibilidad.prototype.DisponibilidadData = function(){
  var finesdesemana = 'no'
  if(this.finesdesemana){finesdesemana = 'si'}
  var diasdelasemana = this.diasDeLaSemana.toString()
  var diasdelmes = 'no hay dias del mes'
  if(this.fechasDelMes.length > 0){
    diasdelmes = this.fechasDelMes.toString()
  }
  return 'fines de semana: ' + finesdesemana + '\ndias de la semana: ' + diasdelasemana + '\ndias del mes: ' + diasdelmes
}


function Persona(nombre = '', disponibilidad = null){
  this.nombre = nombre;
  this.disponibilidad = disponibilidad;
}
Persona.prototype.PersonaData = function() {
  console.log('Nombre ', this.nombre)
  console.log(this.disponibilidad.DisponibilidadData())
};
// ahora voy a crear 3 empleados y sus dias disponibles
// primera persona Juan
var DisponibilidadJuan = new Disponibilidad(false, ['martes'], [])
var juan = new Persona('Juan', DisponibilidadJuan);
// segunda persona Marta
var DisponibilidadMarta = new Disponibilidad(true, ['lunes','martes','miercoles'], [])
var Marta = new Persona('Marta', DisponibilidadMarta);
// tercera persona Ana
var DisponibilidadAna = new Disponibilidad(true, ['lunes','martes','viernes'], [1,2,3,5])
var Ana = new Persona('Ana', DisponibilidadAna)
//mostramos los empleados y su disponibilidad
juan.PersonaData()
Marta.PersonaData()
Ana.PersonaData()

// creo una lista con mis empleados para usarlos de ejemplo
let EMPLEADOS = [juan, Marta, Ana]
// estas funciones sirven para ver si un empleado puede trabajar todos los dias que se necesitan
function isInArray(value, array) {
  return array.indexOf(value) > -1;
}
function aux(listA, listB){
  var result = true
  listB.forEach(function(element){
    result = result && isInArray(element, listA)
  })
  return result
}    

// ahora una funcion simple que calcula que empleados van a estar disponibles dado 
// una serie de fechas y una lista de empleados 
    //ejemplo1 DisponibilidadA = {diasDeSemana: ['lunes','martes']}
    //ejemplo2 DisponibilidadB = {diasDeSemana:['martes']}
    //ejemplo3 DisponibilidadC = {finesDeSemana: true, diasDelMes:[2,5] }    
function EmpleadosDisponibles(empleados, disponibilidadRequerida){
  var resultFinesDeSemana = []
  var resultDiasDeLaSemana = []
  var resultDiasDelMes = []
  var grupoDisponible = []
  //vamos con la parte mas simple / trabaja los fines de semana?
  if(disponibilidadRequerida.finesDeSemana){
    resultFinesDeSemana = empleados.filter(function(empleado) {
      return empleado.disponibilidad.finesdesemana
    })
  }
  if(disponibilidadRequerida.diasDeSemana){
    resultDiasDeLaSemana = empleados.filter(function(empleado){
      if(!empleado.disponibilidad.diasDeLaSemana) return false
      return aux(empleado.disponibilidad.diasDeLaSemana, disponibilidadRequerida.diasDeSemana)
    })
  }
  var grupoDisponible = resultDiasDeLaSemana.filter(function(n) {
    return resultFinesDeSemana.indexOf(n) !== -1;
  })
  return grupoDisponible
}    


var grupoDisponibilidadA = EmpleadosDisponibles(EMPLEADOS,{diasDeSemana: ['lunes','martes'], finesDeSemana: true})
 // el resultado tiene que ser solo son Ana y Maria
 
//DESCOMENTAR ESTA LINEA PARA VER EL RESULTADO
console.log("RESULTADOR DEL GRUPO ::", grupoDisponibilidadA) 
      