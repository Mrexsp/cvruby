# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
module Civitas
  class MazoSorpresas
    attr_accessor :debug
    
    def initialize
      @sorpresas
      @cartasEspeciales 
      @barajada
      @usadas
      @ultimaSorpresa
      @debug = false
      init
    end
    
    def MazoSorpresas.new2(debug)
      objeto = MazoSorpresas.new
      objeto.debug = debug
      
      if objeto.debug
        Diario.instance.ocurre_evento("modo mazo debug activado")
      end
      objeto
    end
    
    def init
      @sorpresas = Array.new
      @cartasEspeciales = Array.new
      @barajada = false
      @usadas = 0
    end
    
    def alMazo(sorpresa)
      if !@barajada
        @sorpresas.push(sorpresa) 
      end
    end
    
    def siguiente
      if !@barajada || @usadas == @sorpresas.size
        if !@debug
          @sorpresas.shuffle
        end
        @usadas = 0
        @barajada = true
      end
      @usadas += 1
      @ultimaSorpresa = @sorpresas.shift
      @sorpresas.push(@ultimaSorpresa)
      
      return @ultimaSorpresa
    end
    
    def inhabilitarCartaEspecial(sorpresa)
      if @sorpresas.include?(sorpresa)
        @cartasEspeciales.push(sorpresa)
        @sorpresas.delete(sorpresa)
      end  
    end
    
    def habilitarCartaEspecial(sorpresa)
      if @cartasEspeciales.include?(sorpresa)
        @sorpresas.push(sorpresa)
        @cartasEspeciales.delete(sorpresa) 
        Diario.instance.ocurre_evento("Carta #{sorpresa.nombre} inhabilitada")
      end  
    end
    
    private :init
  end
end