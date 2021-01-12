push!(LOAD_PATH,"../src/") # necessary for unregistered packages

using Documenter
using StartUpDG

makedocs(
    sitename = "StartUpDG.jl",
    repo = "https://github.com/jlchan/StartUpDG.jl",
    modules=[StartUpDG],
    pages = [
        "Home" => "index.md",        
        "`RefElemData`" => "RefElemData.md",
        "`MeshData`" => "MeshData.md",
        "Fieldname aliases" => "fieldaliases.md",
        "Example: computing DG derivatives" => "ex_dg_deriv.md",
        "Timestepping" => "tstep_usage.md",
        "Reference" => "index_refs.md",
        "Authors" => "authors.md",
    ]
)

deploydocs(
    repo = "github.com/jlchan/StartUpDG.jl",
)
