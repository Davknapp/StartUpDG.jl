@testset "1D boundary utilities" begin
    rd = RefElemData(Line(), N=3)
    md = MeshData(uniform_mesh(Line(), 2)..., rd)
    left(x, tol = 1e-13) = abs(x[1]+1) < tol
    right(x, tol = 1e-13) = abs(x[1]-1) < tol

    boundary_dict = tag_boundary_faces(md, Dict(:left => left, :right => right))
    @test boundary_dict == Dict(:left=>[1],:right=>[4])
end

@testset "2D boundary utilities" begin
    rd = RefElemData(Tri(), N=3)
    md = MeshData(uniform_mesh(Tri(), 1)..., rd)
    on_bottom_boundary(xy, tol = 1e-13) = abs(xy[2]+1) < tol
    on_top_boundary(xy, tol = 1e-13) = abs(xy[2]-1) < tol

    boundary_dict = tag_boundary_faces(md, Dict(:bottom => on_bottom_boundary, :top => on_top_boundary))
    @test boundary_dict == Dict(:bottom=>[1],:top=>[4])

    boundary_dict = tag_boundary_faces(md, nothing)
    @test boundary_dict == Dict(:entire_boundary => [1,2,4,5])

    # test named tuple version
    boundary_dict = tag_boundary_faces(md, (; :bottom => on_bottom_boundary, :top => on_top_boundary))
    @test boundary_dict == (; :bottom=>[1],:top=>[4])

    # test node tagging
    boundary_nodes = tag_boundary_nodes(rd, md, (; :bottom => on_bottom_boundary, :top => on_top_boundary))
    @test all(on_bottom_boundary.(zip(md.xf[boundary_nodes.bottom], md.yf[boundary_nodes.bottom])))

    boundary_nodes = tag_boundary_nodes(rd, md, Dict(:bottom => on_bottom_boundary, :top => on_top_boundary))
    @test all(on_bottom_boundary.(zip(md.xf[boundary_nodes[:bottom]], md.yf[boundary_nodes[:bottom]])))
end