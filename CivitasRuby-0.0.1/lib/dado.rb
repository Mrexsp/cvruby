# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require 'singleton'

module Civitas
  class Dado
    include Singleton
    def initialize
      @ultimoResultado = 0
      @debug = false
    
      @@SalidaCarcel = 5
    end
    
    def setDebug(modoDebug)
      @debug = modoDebug
      Diario.instance.ocurre_evento("modo dado debug pasa a #{modoDebug}")
    end
    
    def tirar
      if !@debug
        @ultimoResultado = rand(6)+1
      else
        @ultimoResultado = 1
      end
      return @ultimoResultado
    end
    
    def quienEmpieza(n)
      return rand(n)
    end
    
    def salgoDeLaCarcel
      return tirar >= @@SalidaCarcel
    end
    
    attr_accessor :debug
    attr_reader :ultimoResultado
    private :initialize
  end
end
