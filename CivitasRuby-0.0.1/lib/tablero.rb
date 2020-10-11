# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module Civitas
  class Tablero
    def initialize(num)
      if(num>=1)
        @numCasillaCarcel=num
      else
        @numCasillaCarcel=1
      end
      
      @casillas = Array.new() 
      #@casillas=["Salida"]
      @casillas.push(Casilla.new("Salida"))#asi se crea
      @porSalida=0
      @tieneJuez=false
    end
    #metodos privados
    #comprueba el tamaño y si tiene juez
    def correcto
      return @casillas.size > @numCasillaCarcel || @tieneJuez  
    end
    
    
    def correcto2(numCasilla)
      return correcto() && numCasilla <= @casillas.size && numCasilla > 0
    end
    
    private :correcto, :correcto2
    
    #Metodos get
    attr_accessor :carcel
    attr_reader :casillas, :numCasillaCarcel
    
    def getCasilla(indiceCasilla)
      return @casillas[indiceCasilla]      
    end
    
    
    #metodos publicos
    #añade casilla
    def aniadeCasilla(nCasilla)
      if @casillas.size == @numCasillaCarcel
        puts "he puesto carcel en #{@casillas.size}"
        @casillas.push(Casilla.new("Carcel")) 
      end  
        @casillas.push(nCasilla)
        if @casillas.size == @numCasillaCarcel
          puts "he puesto carcel en #{@casillas.size}"
          @casillas.push(Casilla.new("Carcel"))        
        end
      
    end
    
    #añade juez
    def aniadeJuez
      if !@tieneJuez
        @casillas.push(Casilla.new("Juez"))
        @tieneJuez=true
      end
    end
    
    #Calcula la nueva posicion
    def nuevaPosicion(actual, tirada)
      if correcto
        nuevapos = actual + tirada
        if nuevapos >= @casillas.size
          @porSalida++
          nuevapos=nuevapos % @casillas.size
        end
        return nuevapos
      
      else
        return 1
      end
    end
    
    #calcula tirada necesaria
    def calcularTirada(origen, destino)
      tirada=destino-origen
      if tirada<0
        tirada=tirada+@casillas.size
      end
      return tirada 
    end
  end
end
