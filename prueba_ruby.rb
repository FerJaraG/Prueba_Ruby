def read_alum(file_name)
	file = File.open(file_name, 'r')
	alum = file.readlines.map(&:chomp).map { |lines| lines.split(', ') }
	file.close
	alum
end

def menu
	puts ''
	puts '1.- Promedio de Alumnos'
	puts '2.- Inasistencia de Alumnos'
	puts '3.- Alumnos Aprobados'
	puts '4.- Salir'
	puts ''
end

def transforma_hash
	alumnos = read_alum('alumnos.csv')
	h = {}
	alumnos.each do |a|
	  key = a.first
	  a.shift
	  h[key] = a 
	end
	return h
end

def promedios
	b = transforma_hash

	b.each do |llave,valor|
		suma = 0
		promedio = 0
		valor.each do |x|
			suma += x.to_i
		end
		promedio = suma.to_f / valor.length
		puts "El promedio de #{llave} es: #{promedio}"
	end
end

def inasistencias
	b = transforma_hash

	b.each do |llave,valor|
		suma = 0
			valor.each do |x|
				if x == 'A'
					suma += 1
				end
			end
		puts "La cantidad de inasistencias de #{llave} es: #{suma}"
	end
end

def aprobados(nota)
	b = transforma_hash

	b.each do |llave,valor|
		suma = 0
		promedio = 0
			valor.each do |x|
				suma += x.to_i
			end

		promedio = suma.to_f / valor.length
		
		if promedio >= nota.to_f
			puts "Felicidades #{llave}, aprobaste con un #{promedio}"
		end
	end
end

menu

while opcion = gets.chomp

	case opcion

		when '1'
				promedios
				menu

		when '2'
				inasistencias
				menu

		when '3'
				puts 'Ingrese la nota minima para aprobar'
				nota = gets
				if nota == "\n"
					nota = 5
					aprobados(nota)
				else
					aprobados(nota)
				end
				menu

		when '4'
			puts 'Saliendo'
			break

		else
			puts 'La opcion ingresada no es valida'
			menu
	end
end

