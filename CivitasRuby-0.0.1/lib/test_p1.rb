# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative "casilla.rb"
require_relative "dado.rb"
require_relative "diario.rb"
require_relative "mazo_sorpresas.rb"
require_relative "estados_juego.rb"
require_relative "operaciones_juego.rb"
require_relative "sorpresa.rb"
require_relative "tablero.rb"
require_relative "tipo_casilla.rb"
require_relative "tipo_sorpresa.rb"

module Civitas
  jugadores = Array.new(4,0)
  for i in 0..99
    jugadores[Dado.instance.quienEmpieza(4)] += 1
  end
  puts "Numero de veces que cada jugador empieza:"
  puts jugadores
  
  puts "Tiradas con Debug"
  Dado.instance.setDebug(true)
  for i in 0..4
    puts Dado.instance.tirar
  end
  
  puts "Tiradas sin debug"
  Dado.instance.setDebug(false)
  for i in 0..4
    puts Dado.instance.tirar
  end
  
  puts "Ultima tirada #{Dado.instance.ultimoResultado}"
  
  puts "Tirada de carcel: #{Dado.instance.salgoDeLaCarcel}"
  puts "Ultima tirada #{Dado.instance.ultimoResultado}"
  
  puts "Valores al azar de enums"
  puts Tipo_Casilla.const_get(:CALLE)
  puts Tipo_Sorpresa.const_get(:IRCARCEL)
  puts Estados_juego.const_get(:DESPUES_CARCEL)
  
  mazoPrueba = MazoSorpresas.new
  primera = Sorpresa.new("Primera")
  mazoPrueba.alMazo(primera)
  segunda = Sorpresa.new("Segunda")
  mazoPrueba.alMazo(segunda)
  puts "Usando siguiente:"
  puts (mazoPrueba.siguiente).nombre
  
  puts "Usando siguiente tras inhabilitar segunda:"
  mazoPrueba.inhabilitarCartaEspecial(segunda)
  puts (mazoPrueba.siguiente).nombre
  
  puts "Usando siguiente tras habilitar segunda:"
  mazoPrueba.habilitarCartaEspecial(segunda)
  puts (mazoPrueba.siguiente).nombre
  puts (mazoPrueba.siguiente).nombre

  puts "Existencia de eventos pendientes = #{Diario.instance.eventos_pendientes}"
  puts "Leer evento = #{Diario.instance.leer_evento}"
  
  tablerop = Tablero.new(3)
  tablerop.aniadeCasilla(Casilla.new("Atarfe"))
  tablerop.aniadeCasilla(Casilla.new("Almunecar"))
  tablerop.aniadeCasilla(Casilla.new("Niguelas"))
  tablerop.aniadeCasilla(Casilla.new("Albolote"))
  tablerop.aniadeJuez
  
  puts "Tiradas en debug: "
  Dado.instance.setDebug(true)
  inicio = 1
  for i in 0..10
    inicio = tablerop.nuevaPosicion(inicio,Dado.instance.tirar)
    puts tablerop.casillas[inicio].nombre
  end
  
  puts "Tiradas sin debug: "
  Dado.instance.setDebug(false)
  inicio = 1
  for i in 0..10
    tirada = Dado.instance.tirar
    puts tirada
    inicio = tablerop.nuevaPosicion(inicio,tirada)
    puts tablerop.casillas[inicio].nombre
  end
    
  
end