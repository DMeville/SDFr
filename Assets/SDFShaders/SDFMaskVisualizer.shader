// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "DM/SDFMaskVisualizer"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_SDF("SDF", 3D) = "white" {}
		_SDFCenter("SDFCenter", Vector) = (0,0,0,0)
		_SDFExtents("SDFExtents", Vector) = (0,0,0,0)
		_Sharpness("Sharpness", Float) = 1
		_Offset("Offset", Range( -0.05 , 0.05)) = 0
		_Falloff("Falloff", Range( 0.01 , 1)) = 0.001
		[Toggle]_InvertMask("InvertMask", Float) = 1
		[Toggle]_UseTransparency("UseTransparency", Float) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#pragma target 3.5
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float3 worldPos;
		};

		uniform float _InvertMask;
		uniform float _Sharpness;
		uniform sampler3D _SDF;
		uniform float3 _SDFCenter;
		uniform float3 _SDFExtents;
		uniform float _Offset;
		uniform float _Falloff;
		uniform float _UseTransparency;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldPos = i.worldPos;
			float3 temp_output_18_0_g58 = _SDFCenter;
			float3 temp_output_19_0_g58 = _SDFExtents;
			float3 temp_output_23_0_g60 = temp_output_19_0_g58;
			float clampResult4_g60 = clamp( tex3D( _SDF, ( ( ase_worldPos + temp_output_18_0_g58 + temp_output_23_0_g60 + float3(0,0,0) ) / ( temp_output_23_0_g60 * 2.0 ) ) ).r , 0.0 , 1.0 );
			float temp_output_25_0_g58 = ( _Sharpness * ( clampResult4_g60 + _Offset ) );
			float clampResult14_g58 = clamp( ( 1.0 - temp_output_25_0_g58 ) , 0.0 , 1.0 );
			float clampResult15_g58 = clamp( ( 1.0 - ( distance( max( ( abs( ( ase_worldPos - temp_output_18_0_g58 ) ) - ( ( temp_output_19_0_g58 * float3( 2,2,2 ) ) * float3( 0.5,0.5,0.5 ) ) ) , float3( 0,0,0 ) ) , float3( 0,0,0 ) ) / _Falloff ) ) , 0.0 , 1.0 );
			float temp_output_172_0 = ( clampResult14_g58 * clampResult15_g58 );
			float temp_output_153_0 = lerp(( 1.0 - temp_output_172_0 ),temp_output_172_0,_InvertMask);
			float3 temp_cast_0 = (temp_output_153_0).xxx;
			o.Emission = temp_cast_0;
			o.Alpha = 1;
			clip( lerp(1.0,( 1.0 - lerp(( 1.0 - temp_output_172_0 ),temp_output_172_0,_InvertMask) ),_UseTransparency) - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16400
1927;57;1586;1005;746.2523;1493.94;1.32246;True;False
Node;AmplifyShaderEditor.Vector3Node;51;-246.2032,-974.3667;Float;False;Property;_SDFCenter;SDFCenter;2;0;Create;True;0;0;False;0;0,0,0;10,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;21;-237.8524,-540.8162;Float;False;Property;_Sharpness;Sharpness;4;0;Create;True;0;0;False;0;1;223.61;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-324.7277,-652.8872;Float;False;Property;_Offset;Offset;5;0;Create;True;0;0;False;0;0;0;-0.05;0.05;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;105;-175.1704,-449.925;Float;False;Property;_Falloff;Falloff;6;0;Create;True;0;0;False;0;0.001;0.01;0.01;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;6;-220.821,-1177.127;Float;True;Property;_SDF;SDF;1;0;Create;True;0;0;False;0;None;9347007cf4259bd40a79044b49f5f7eb;False;white;LockedToTexture3D;Texture3D;0;1;SAMPLER3D;0
Node;AmplifyShaderEditor.Vector3Node;50;-252.3636,-823.6789;Float;False;Property;_SDFExtents;SDFExtents;3;0;Create;True;0;0;False;0;0,0,0;5,5,5;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.FunctionNode;172;150.0257,-907.499;Float;False;SDFMask;-1;;58;7f48b3af2d1db7b44b993218bbe1dd86;0;6;17;SAMPLER3D;0;False;18;FLOAT3;0,0,0;False;19;FLOAT3;0,0,0;False;20;FLOAT;0;False;21;FLOAT;1;False;22;FLOAT;0.05;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;149;472.5588,-969.3918;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;153;650.1539,-939.8287;Float;False;Property;_InvertMask;InvertMask;7;0;Create;True;0;0;False;0;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;158;875.6808,-810.4594;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;157;882.5196,-885.6851;Float;False;Constant;_Float1;Float 1;9;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;156;1052.118,-824.1384;Float;False;Property;_UseTransparency;UseTransparency;8;0;Create;True;0;0;False;0;0;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1311.246,-1036.093;Float;False;True;3;Float;ASEMaterialInspector;0;0;Standard;DM/SDFMaskVisualizer;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;172;17;6;0
WireConnection;172;18;51;0
WireConnection;172;19;50;0
WireConnection;172;20;30;0
WireConnection;172;21;21;0
WireConnection;172;22;105;0
WireConnection;149;0;172;0
WireConnection;153;0;149;0
WireConnection;153;1;172;0
WireConnection;158;0;153;0
WireConnection;156;0;157;0
WireConnection;156;1;158;0
WireConnection;0;2;153;0
WireConnection;0;10;156;0
ASEEND*/
//CHKSM=48DE5D2CE7DDA7A99409FC10A11F8F3CF5FEE13D