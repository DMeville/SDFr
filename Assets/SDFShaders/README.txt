SDF Shader only works when:
1) SDFBaker component Center is (0,0,0) (but you can move the object position)
2) SDFBaker component object rotation is 0,0,0.  We sample the sdf in worldspace so it needs to be axis aligned
