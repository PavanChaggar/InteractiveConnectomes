### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 6a18f3e0-8110-11eb-360e-d998359b8bd9
begin
	using Pkg
	using DelimitedFiles
	using SparseArrays
	using Plots
	using Statistics
	using PlutoUI
	using LightGraphs
	using SimpleWeightedGraphs
	gr()
end;

# ╔═╡ f19c508e-8110-11eb-316f-61ac2ad98a86
csv_path = "/scratch/oxmbm-shared/Code-Repositories/Connectomes/all_subjects"

# ╔═╡ 6b782118-8115-11eb-38f8-9b6b1a7a4cc8
subject_dir = "/scratch/oxmbm-shared/Code-Repositories/Connectomes/standard_connectome/scale1/subjects/"

# ╔═╡ 80447dd6-8114-11eb-32fa-4ff09d65bb38
subjects = Int.(readdlm(csv_path));

# ╔═╡ 8da93f1a-9213-11eb-0e92-a5cadeb4b24d
typeof(subjects)

# ╔═╡ f4ac3174-811d-11eb-0557-6144bd583355
function norm_adjacency(file, filter)
	A = sparse(readdlm(file))
	symA = 0.5 * (A + A')
	norm = symA/maximum(symA)
	return norm .* (norm .> filter)
end

# ╔═╡ d3b7cfee-811f-11eb-35b2-852b9f47a030
function get_laplacian(A)
	return Array(laplacian_matrix(SimpleWeightedGraph(A)))
end

# ╔═╡ 65156eda-8119-11eb-00b2-03e89962cbd1
@bind filter Slider(0.0:0.01:0.5)

# ╔═╡ 7d0b8dfe-818b-11eb-3114-1d5ec2c08288
md"##### filter: $filter"

# ╔═╡ 02cd0bba-8188-11eb-1592-2db5261340d1
begin
	@bind node Slider(1:83)
end

# ╔═╡ 48f4c178-8188-11eb-036f-0dd6250453ee
md"##### node: $node"

# ╔═╡ 1346f3f0-811c-11eb-3a72-3f54bef729fc
begin 
	@bind n Slider(10:10:170, default=10)
end

# ╔═╡ 4d53ed3c-8112-11eb-02cd-fffa8c33742e
begin
	m1 = Array{Float64}(undef, 83, 83, n)

	for (i, j) ∈ enumerate(rand(1:170, n))
		file = subject_dir * string(subjects[j]) * "/fdt_network_matrix"
		m1[:,:,i] = norm_adjacency(file, filter)
	end
	
	m2 = Array{Float64}(undef, 83, 83, n-10)
	
	for (i, j) ∈ enumerate(rand(1:170, n-10))
		file = subject_dir * string(subjects[j]) * "/fdt_network_matrix"
		m2[:,:,i] = norm_adjacency(file, filter)
	end
end

# ╔═╡ 7006a5fe-811c-11eb-3b19-a9e4e1c7dd5b
begin
	avg_adj = mean(m1, dims=3)[:,:]
	heatmap(avg_adj, title="Avg. Adjacency Matrix")
end

# ╔═╡ b1d3486e-8187-11eb-2b35-6f1b74643ec3
begin

	bar(avg_adj[node,:])
	plot!(ones(83) * filter)
end

# ╔═╡ 24edbc06-9215-11eb-34da-2598e6afb0e5
mean(m1, dims=3)[:,:]

# ╔═╡ d28e03c0-8121-11eb-31e3-69beeca2592f
begin
	mean_degree = mean(degree(Graph(mean(m1 ,dims=3)[:,:])))
	md"##### mean degree: $mean_degree"
end

# ╔═╡ 23807444-8121-11eb-181a-b15814c9a6e0
begin
	L = Array{Float64}(undef, 83, 83, n)

	for i ∈ 1:n
		L[:,:,i] = get_laplacian(m1[:,:,i])
	end
end

# ╔═╡ e4c9d628-8120-11eb-1a28-47c114097976
begin
	avg_lap = mean(L, dims=3)[:,:]
	heatmap(avg_lap, title="Avg. Laplacian Matrix")
end

# ╔═╡ 8821166c-8115-11eb-222e-51e91bc765ef
@bind x Slider(1:n)

# ╔═╡ 728a7110-818b-11eb-1fff-25ce18c50fb2
md"##### subject number: $x"

# ╔═╡ ba1a9d86-8120-11eb-281f-3d2a8ded3f14
md"##### number of subects: $n"

# ╔═╡ a175c2e4-8cb8-11eb-3e2f-b76c99bed435
begin
	avg_adj2 = mean(m2, dims=3)[:,:]
	bar(abs.(avg_adj[node,:] .- avg_adj2[node,:]), ylims=(0,0.02))
end

# ╔═╡ Cell order:
# ╠═6a18f3e0-8110-11eb-360e-d998359b8bd9
# ╠═f19c508e-8110-11eb-316f-61ac2ad98a86
# ╠═6b782118-8115-11eb-38f8-9b6b1a7a4cc8
# ╠═80447dd6-8114-11eb-32fa-4ff09d65bb38
# ╠═8da93f1a-9213-11eb-0e92-a5cadeb4b24d
# ╠═f4ac3174-811d-11eb-0557-6144bd583355
# ╠═d3b7cfee-811f-11eb-35b2-852b9f47a030
# ╠═4d53ed3c-8112-11eb-02cd-fffa8c33742e
# ╠═23807444-8121-11eb-181a-b15814c9a6e0
# ╟─728a7110-818b-11eb-1fff-25ce18c50fb2
# ╟─8821166c-8115-11eb-222e-51e91bc765ef
# ╠═7006a5fe-811c-11eb-3b19-a9e4e1c7dd5b
# ╠═24edbc06-9215-11eb-34da-2598e6afb0e5
# ╟─e4c9d628-8120-11eb-1a28-47c114097976
# ╟─d28e03c0-8121-11eb-31e3-69beeca2592f
# ╟─7d0b8dfe-818b-11eb-3114-1d5ec2c08288
# ╟─65156eda-8119-11eb-00b2-03e89962cbd1
# ╟─b1d3486e-8187-11eb-2b35-6f1b74643ec3
# ╟─48f4c178-8188-11eb-036f-0dd6250453ee
# ╟─02cd0bba-8188-11eb-1592-2db5261340d1
# ╟─ba1a9d86-8120-11eb-281f-3d2a8ded3f14
# ╟─1346f3f0-811c-11eb-3a72-3f54bef729fc
# ╟─a175c2e4-8cb8-11eb-3e2f-b76c99bed435
