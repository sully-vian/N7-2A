# Ecrire les tests de l'algorithme du pas de Cauchy
using Test

"""
Tester la solution donnée par la fonction cauchy

# Entrées

	- cauchy :  (Function) la fonction à tester

# Les cas de test (dans l'ordre)

	- fct 1 : x011, x012
	- fct 2 : x021, x022, x023

"""
function tester_cauchy(cauchy::Function)

	Test.@testset "Pas de Cauchy" begin
		g = [3; 4]
		Test.@testset "a < 0" begin
			H = [-1 0; 0 -2]
			Δ = 1
			sol = cauchy(g, H, Δ)
			Test.@test (sol == -1 / 5 * g)
		end

		Test.@testset "a = 0" begin
			H = [0 0; 0 0]
			Δ = 1
			sol = cauchy(g, H, Δ)
			Test.@test (sol == -1 / 5 * g)
		end

		Test.@testset "a > 0" begin
			H = I
			Test.@testset "t < Δ/∥g∥" begin
				Δ = 11
				sol = cauchy(g, H, Δ)
				Test.@test (sol == -g)
			end
			Test.@testset "t >= Δ/∥g∥" begin
				Δ = 5
				sol = cauchy(g, H, Δ)
				Test.@test (sol == -g)
			end
		end
	end
end
