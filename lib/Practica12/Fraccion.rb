#Clase que define una fracción, con las operaciones suma y resta, mcd y mcm
class Fraccion
   #Lectura de atributos para el numerador y el denominador
   attr_reader :num, :denom
   include Comparable

   #Máximo común divisor
   def mcd(x,y)
      y == 0 ? x: mcd(y, x%y)
   end

   #Mínimo común múltiplo
   def mcm(x,y)
      z = x / mcd(x,y) * y 
   end 
  
   #Inicialización de la fracción con numerador y denominador
   def initialize(num, denom)
      raise TypeError, "El denominador no puede ser cero" if denom.eql? 0

      d = mcd(num, denom)
      @num = num / d
      @denom = denom / d
   end

   #Valor absoluto
   def abs
      to_f.abs
   end

   #Recíproco
   def reciprocal
      Fraccion.new(@denom,@num)
   end

   #Convierte a string
   def to_s
      "#@num/#@denom"
   end

   #Convierte a Float
   def to_f
      Float(@num)/@denom
   end

   #Suma de fracciones
   def + (other)
	((other.is_a? Numeric)?  Fraccion.new( other * @denom + @num, @denom ) : Fraccion.new( @num * other.denom + other.num * @denom, @denom * other.denom ))
   end

   #Resta de fracciones
   def - (other)
      Fraccion.new( @num * other.denom - other.num * @denom, @denom * other.denom )
   end

   #Multiplicación de fracciones
   def * (other)
      ((other.is_a? Numeric)? Fraccion.new( @num * other , @denom ) : Fraccion.new( @num * other.num , @denom * other.denom ))

   end

   #Módulo de fracciones
   def % (other)
=begin
      temp = self / other
      self - temp
      Fraccion.new( @num * other.num , @denom * other.denom )
=end
   end

   #Operador de - (unario)
   def -@
      ((@num==@num.abs)? Fraccion.new(-@num,@denom) : Fraccion.new(@num,-@denom))
   end

   #Operador de división
   def / (other)
      Fraccion.new( @num * other.denom , @denom * other.num )
   end
   
   #Operador de comparación, en conjunción con la interfaz comparable
   def <=>(other)
      Float(@num)/@denom <=> Float(other.num)/other.denom
   end
end
