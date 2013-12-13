require "Practica12/Matriz.rb"

class MatrizDSL
	def initialize(valor, &block)
		@operandos = []
		@operacion = valor;
		
		instance_eval &block
		
		if(@salida == "consola") 
			puts @resultado.to_s 
		elsif(@salida == "fichero") 
			File.open('pruebas.txt','a+') do |x|
				x.puts @resultado.to_s 
			end 
		end
	end

	def option(opcion)
		if(opcion == "densa")
			@tipo_operandos = MatrizDensa
		elsif opcion == "dispersa"
			@tipo_operandos = MatrizDispersa
		elsif opcion=="console"
			@salida = "consola"
		elsif opcion=="file"
			@salida = "fichero"
		end
	end

	def operand(operando)
		@operandos.push(@tipo_operandos.new(operando))
		if @operandos.size > 1
			case @operacion
				when "suma" then
					@resultado = @operandos[0] + @operandos[1]
				when "multiplicar" then
					@resultado = @operandos[0] * @operandos[1]
			end
		end
	end

	def resultado
		@resultado
	end

end
