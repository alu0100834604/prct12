require "Practica12/Matriz.rb"
require "Practica12/Fraccion.rb"
require "Practica12/MatrizDSL.rb"

describe MatrizDSL do
 before :each do
	@ejemplo = MatrizDSL.new("suma") do 
		option "densa" 
                option "file"

		operand [[1,2,3],[4,5,6],[7,8,9]]
		operand [[1,1,1],[1,1,1],[1,1,1]]
	end

        @ejemplo2 = MatrizDSL.new("suma") do
                option "densa"
		option "console"

                operand [[3,4],[5,6]]
                option "dispersa"
		operand ({ "0-0"=>Fraccion.new(1,2)  })
        end



  end  

describe "Operacion con DSL" do
	it "operacion con dsl" do
		@ejemplo.resultado.should ==  Matriz.new( [[2,3,4],[5,6,7],[8,9,10]] )
	end
	it "sumar dispersa y densa con fracciones" do
                @ejemplo2.resultado.should == MatrizDispersa.new([[Fraccion.new(7,2), 4], [5, 6]])
	end
end

end
