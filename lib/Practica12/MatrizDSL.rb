require "Practica12/Matriz.rb"

class MatrizDSL
	def initialize(valor, &block)
		@operandos = []
		@operacion = valor;
		puts(valor)
		instance_eval &block
	end

	def option(opcion)
		puts "opc"
		puts opcion
		if(opcion == "densa")
			puts "Matrizdensa-"
			@tipo_operandos = MatrizDensa
		elsif opcion == "dispersa"
			puts "Dispersa-"
			@tipo_operandos = MatrizDispersa
		elsif opcion=="console"
			puts "Consola-"
			@salida = "consola"
		end
	end

	def operand(operando)
		puts "opr"
		puts operando
		@operandos.push(@tipo_operandos.new(operando))
		puts "tamano:" << @operandos.size
		if @operandos.size > 1
			puts "hay dos"
			case @operacion
				when "suma" then
					@resultado = @operandos[0] + @operandos[1]
				when "multiplicar" then
					@resultado = @operandos[0] * @operandos[1]
			end
			@operandos.each{ |x| 
				puts x.class
			}
		end
	end

	def resultado
#		[[2,3,4],[5,6,7],[8,9,10]]
		@resultado
	end

end

ejemplo = MatrizDSL.new("suma") do 
  option "densa" 
  option "console"

  operand [[1,2,3],[4,5,6],[7,8,9]]  
  operand [[1,1,1],[1,1,1],[1,1,1]]  
end
