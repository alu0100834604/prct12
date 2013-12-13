require "Practica12/Fraccion.rb"
#Clase madre, implementa las operaciones comunes suma y resta, acceso y modificación
#de elementos.  
class Matriz
   #accesores de filas, columnas y la matriz interna
   attr_reader :filas,:columnas, :matriz

#Inicializa una matriz. Usa como valor de entrada un vector de vectores
def initialize( valor_entrada) 
        @filas = valor_entrada.length
	@columnas = valor_entrada[0].length
   	@matriz =  Array.new(filas){Array.new(columnas)}

   	@filas.times{ |i|
       		@columnas.times{ |j|
          		matriz[i][j] = valor_entrada[i][j]
       		}
   	}
end


#Multiplicación entre matrices
def *(m2)
        dimensiones=[[@filas, @columnas],[m2.filas, m2.columnas]]
        filas_final = dimensiones[0][0]
        columnas_final = dimensiones[1][1]
        resultado = Array.new(filas_final){Array.new(columnas_final)}
      	@filas.times { |i|
                m2.columnas.times { |j|
                        temp = Array.new(dimensiones[0][0])
                        val1 = @matriz[i][0]
                        val2 = m2.[](0,j)
			#temp[0] = @matriz[i][0] * m2[0][j];
			temp[0] = val1 * val2;
                        1.upto(@columnas-1) do |k|
                                val1 = @matriz[i][k]
                                val2 = m2.[](k,j)
				temp2 =  val1 * val2
                                temp[k] = temp2
                        end
                        resultado[i][j] = temp.reduce(:+)
               }
        }
        return Matriz.new(resultado)
end

#Suma de matrices
def +(m2)
	filas_final = @filas
	columnas_final = @columnas
	resultado = Array.new(filas_final){Array.new(columnas_final, 0)}
	@filas.times { |i| 
		@columnas.times { |j|
			resultado[i][j] = @matriz[i][j] +m2.matriz[i][j]
		}
	}
	return Matriz.new(resultado)
end

#Sobrecarga del operador de modificación sobre un elemento de la matriz
def []=(i,j,x)
   @matriz[i][j] = x
end

#Sobrecarga del operador de acceso a un elemento de la matriz
def [](i,j)  
  @matriz[i][j]
end

#Sobrecarga del operador de comparación
#Comprueba si una matriz es igual a otra dada
def == (other)
 	filas_final = @filas
	columnas_final = @columnas
	resultado = true
	@filas.times { |i| 
		@columnas.times { |j|
			resultado &= (self.[](i,j) == other.[](i,j))
		}
	}
	return(resultado)
end 

#Función que nos dice el porcentaje de ceros presentes
def porcentaje_ceros()
   ceros = 0;
   @filas.times { |i| 
	@columnas.times { |j|
          if(@matriz[i][j] == 0)
		ceros += 1
          end
  	}
   }
   porcentaje = Float(ceros)/(@filas * @columnas)
end

#Función que calcula el máximo elemento de una matriz
def maximo()
	maximo = matriz[0][0];
	@filas.times { |i| 
		@columnas.times { |j|
			if(matriz[i][j] > maximo)
				maximo = @matriz[i][j]
			end
		}
	}
	return maximo
end

#Función que calcula el minimo elemento de una matriz
def minimo()
	mimino = matriz[0][0];
	@filas.times { |i| 
		@columnas.times { |j|
			if(matriz[i][j] < minimo)
				maximo = @matriz[i][j]
			end
		}
	}
	return minimo
end
end

# Matriz dispersa.                      
# Hereda de Matriz.
# Representa matrices con más de un 60% de ceros
# Se han implementado la suma y la multiplicación, para permitir hacer
# sumas y multiplicaciones con MatrizDensa y MatrizDispersa. Se ha implementado
# una función de acceso a los elementos y para modificarlos
class MatrizDispersa < Matriz
	#atributo de lectura: hash interno
	attr_reader :hash_no_nulos
	#Inicializa una matriz. Usa como valor de entrada un vector de vectores
	#O un array con la concatenación x-y como clave
	#Añade a la representación interna solo los elementos distintos de 0
	def initialize(matriz_entrada)
		if(matriz_entrada.is_a?Hash)
			@hash_no_nulos = {};
			i = 0
			j = 0
			matriz_entrada.each do |key,val|
				arr_key = key.split("-");
				if(arr_key[0].to_i > i)
					i = arr_key[0].to_i
				end
				if(arr_key[1].to_i > j)
					j = arr_key[1].to_i
				end
				if(val != 0 && val != nil)
					@hash_no_nulos[key] = val;
				end
			end
			@filas = i
			@columnas = j
		else
			@hash_no_nulos = {}
			@filas = matriz_entrada.length
			@columnas = matriz_entrada[0].length
			@filas.times { |i| 
				@columnas.times { |j|
					if(matriz_entrada[i][j] != 0)
						@hash_no_nulos[i.to_s+"-"+j.to_s] = matriz_entrada[i][j]
					end
				}
			}
		end
	end

	#Sobrecarga del operador de modificación sobre un elemento de la matriz
	def []=(i,j,x)
		if(x != 0)
	   		@hash_no_nulos[i.to_s+"-"+j.to_s] = x
		end
	end

	#Sobrecarga del operador de acceso a un elemento de la MatrizDispersa
	def [](i,j)
	  val = @hash_no_nulos[i.to_s+"-"+j.to_s]
	  val = (val == nil)?0:val
	end

	#comprueba el número de ceros presentes en la matriz
	#Si es inferior al 60%, esta función devuelve al propio objeto (self)
	#Si es superior o igual, devuelve una MatrizDispersa
	#Usado para que al hacer una operación se pueda devolver el tipo adecuado
	def comprobar_tipo_return()
		if(porcentaje_ceros > 0.6)
			return self
		elsif
		   	matriz =  Array.new(@filas){Array.new(@columnas)}
			@filas.times { |i| 
				@columnas.times { |j|
			  		matriz[i][j] = self.[](i,j)
				}
			}
			devolucion = MatrizDensa.new(matriz)
			return (devolucion)
		end
	end

	#Función que nos dice el porcentaje de ceros en la matriz
	def porcentaje_ceros()
		return(Float(@filas*@columnas - @hash_no_nulos.length)/@filas*@columnas)
	end

	# sobrecarga del operador de suma para matriz dispersa
	# Comprueba el tipo de datos devuelto para devolver un tipo MatrizDensa o MatrizDispersa
	# Según la cantidad de ceros
	def +(other)
		#puts(other.class)
		#devolucion = Matriz
		if((other.is_a?MatrizDensa))
			filas_final = @filas
			columnas_final = @columnas
			resultado = Array.new(filas_final){Array.new(columnas_final, 0)}
			@filas.times { |i| 
				@columnas.times { |j|
					resultado[i][j] = self.[](i,j) +other.matriz[i][j]
				}
			}
			return MatrizDensa.new(resultado).comprobar_tipo_return()						
		elsif(other.is_a?MatrizDispersa)
			hash_final = {}
			@hash_no_nulos.each do |key,valor|
				hash_final[key]=valor
			end
			other.hash_no_nulos.each do |key,valor|
				valor_final = valor
				if(hash_final[key] != nil)
					valor_final = valor + hash_final[key]
				end
				hash_final[key]=valor_final
			end
			return MatrizDispersa.new(hash_final).comprobar_tipo_return()
		end
	end

	# sobrecarga del operador de multiplicación para matriz dispersa
	# Comprueba el tipo de datos devuelto para devolver un tipo MatrizDensa o MatrizDispersa
	# Según la cantidad de ceros
	def *(other)
		if(other.is_a?MatrizDensa)
			filas_final = @filas
			columnas_final = @columnas
			resultado = Array.new(filas_final){Array.new(columnas_final, 0)}
			dimensiones=[[@filas, @columnas],[other.filas, other.columnas]]
			@filas.times { |i| 
				@columnas.times { |j|
                        		temp = Array.new(dimensiones[0][0])
                        		val1 = self.[](i,0)
		                        val2 = other.[](0,j)
					
					temp[0] = val1 * val2;
		                        1.upto(@columnas-1) do |k|
	                                	val1 = self.[](i,k)
		                                val2 = other.[](k,j)
						temp2 =  val1 * val2
		                                temp[k] = temp2
	                        	end
	                        	resultado[i][j] = temp.reduce(:+)
                        	 
                        	}
                        }
                        
	 		return MatrizDensa.new(resultado).comprobar_tipo_return()
               elsif(other.is_a?MatrizDispersa)
			filas_final = @filas
			columnas_final = @columnas
			resultado2 = {}
			 dimensiones=[[@filas, @columnas],[other.filas, other.columnas]]
			@filas.times { |i| 
				@columnas.times { |j|
                        		temp = Array.new(dimensiones[0][0])
                        		val1 = self.[](i,0)
		                        val2 = other.[](0,j)
					
					temp[0] = val1 * val2;
		                        1.upto(@columnas-1) do |k|
	                                	val1 = self.[](i,k)
		                                val2 = other.[](k,j)
						temp2 =  val1 * val2
		                                temp[k] = temp2
	                        	end
	                        	tmp_reduced = temp.reduce(:+)
                        	 	if( tmp_reduced != nil)
						resultado2[i.to_s+"-"+j.to_s] = tmp_reduced
					end
                        	}
                        }
                        
	 		return MatrizDispersa.new(resultado2).comprobar_tipo_return()
               end	
        end

	# Calcula el elemento con mayor valor de la matriz dispersa (incluyendo 0)
	def maximo()
		maximo = 0;
		@hash_no_nulos.each do |key,valor|
			if (valor > maximo)
				maximo = valor
			end
                end
		return maximo
	end

	# Calcula el elemento con menor valor de la matriz (incluyendo 0)
	def minimo()
		minimo = 0;
		@hash_no_nulos.each do |key,valor|
			if (valor < minimo)
				minimo = valor
			end
                end
		return minimo
	end
end

# Matriz densa. Hereda de Matriz.
# Representa matrices con menos de un 60% de ceros.
# Se han implementado la suma y la multiplicación, para permitir hacer
# sumas y multiplicaciones con MatrizDensa y MatrizDispersa
# Muy parecida a la matriz original

class MatrizDensa < Matriz

	#comprueba el número de ceros presentes en la matriz
	#Si es inferior al 60%, esta función devuelve al propio objeto (self)
	#Si es superior o igual, devuelve una MatrizDispersa
	#Usado para que al hacer una operación se pueda devolver el tipo adecuado
	def comprobar_tipo_return()
		if(porcentaje_ceros < 0.6)
			return self
		elsif
			devolucion = MatrizDispersa.new(@matriz)
			return(devolucion)
		end
	end

	# sobrecarga del operador de suma para matriz densa
	# Comprueba el tipo de datos devuelto para devolver un tipo MatrizDensa o MatrizDispersa
	# Según la cantidad de ceros
	def +(other)
		if((other.is_a?MatrizDispersa))
			filas_final = @filas
			columnas_final = @columnas
			resultado = Array.new(filas_final){Array.new(columnas_final, 0)}
			@filas.times { |i| 
				@columnas.times { |j|
					resultado[i][j] = other.[](i,j) + @matriz[i][j]
				}
			}
			return (MatrizDensa.new(resultado).comprobar_tipo_return())
		elsif(other.is_a?MatrizDensa)
			filas_final = @filas
			columnas_final = @columnas
			resultado = Array.new(filas_final){Array.new(columnas_final, 0)}
			@filas.times { |i| 
				@columnas.times { |j|
					resultado[i][j] = @matriz[i][j] +other.matriz[i][j]
				} 
			}
			devolucion = MatrizDensa.new(resultado).comprobar_tipo_return()
			return (devolucion)			
		end
	end
	
	# sobrecarga del operador de multiplicación para matriz densa
	# Comprueba el tipo de datos devuelto para devolver un tipo MatrizDensa o MatrizDispersa
	# Según la cantidad de ceros
	def *(other)
		if(other.is_a?MatrizDispersa)
			filas_final = @filas
			columnas_final = @columnas
			resultado = Array.new(filas_final){Array.new(columnas_final, 0)}
			dimensiones=[[@filas, @columnas],[other.filas, other.columnas]]
			@filas.times { |i| 
				@columnas.times { |j|
                        		temp = Array.new(dimensiones[0][0])
                        		val1 = self.[](i,0)
		                        val2 = other.[](0,j)
					
					temp[0] = val1 * val2;
		                        1.upto(@columnas-1) do |k|
	                                	val1 = self.[](i,k)
		                                val2 = other.[](k,j)
						temp2 =  val1 * val2
		                                temp[k] = temp2
	                        	end
	                        	resultado[i][j] = temp.reduce(:+)
                        	 
                        	}
                        }
                        
	 		return MatrizDensa.new(resultado).comprobar_tipo_return()
               elsif(other.is_a?MatrizDensa)
			dimensiones=[[@filas, @columnas],[other.filas, other.columnas]]
			filas_final = dimensiones[0][0]
			columnas_final = dimensiones[1][1]
			resultado = Array.new(filas_final){Array.new(columnas_final)}
			@filas.times { |i| 
				other.columnas.times { |j|
				        temp = Array.new(dimensiones[0][0])
				        val1 = @matriz[i][0]
				        val2 = other.[](0,j)
					#temp[0] = @matriz[i][0] * m2[0][j];
					temp[0] = val1 * val2;
				        1.upto(@columnas-1) do |k|
				                val1 = @matriz[i][k]
				                val2 = other.[](k,j)
						temp2 =  val1 * val2
				                temp[k] = temp2
				        end
				        resultado[i][j] = temp.reduce(:+)
				}
			}
			return MatrizDensa.new(resultado).comprobar_tipo_return()
               end	
        end
end
