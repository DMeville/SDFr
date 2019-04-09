// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "DM/SDFMask"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_Texture0("Texture 0", 3D) = "white" {}
		_Sharpness("Sharpness", Float) = 1
		_Offset("Offset", Range( -0.01 , 0.01)) = 0
		_SDFExtents("SDFExtents", Vector) = (0,0,0,0)
		_SDFCenter("SDFCenter", Vector) = (0,0,0,0)
		_Falloff("Falloff", Float) = 0.001
		_Albedo("Albedo", 2D) = "white" {}
		_Color("Color", Color) = (0,0,0,0)
		[Toggle]_InvertMask("InvertMask", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Transparent+0" }
		Cull Off
		CGPROGRAM
		#pragma target 3.5
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
			float3 worldPos;
		};

		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform float4 _Color;
		uniform float _InvertMask;
		uniform float _Sharpness;
		uniform sampler3D _Texture0;
		uniform float3 _SDFCenter;
		uniform float3 _SDFExtents;
		uniform float _Offset;
		uniform float _Falloff;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			float4 tex2DNode160 = tex2D( _Albedo, uv_Albedo );
			o.Albedo = ( tex2DNode160 * _Color * i.vertexColor ).rgb;
			o.Alpha = 1;
			float3 ase_worldPos = i.worldPos;
			float3 temp_output_18_0_g16 = _SDFCenter;
			float3 temp_output_19_0_g16 = _SDFExtents;
			float temp_output_23_0_g17 = temp_output_19_0_g16.x;
			float clampResult4_g17 = clamp( tex3D( _Texture0, ( ( ase_worldPos + temp_output_18_0_g16 + temp_output_23_0_g17 ) / ( temp_output_23_0_g17 * 2.0 ) ) ).r , 0.0 , 1.0 );
			float temp_output_10_0_g16 = ( _Sharpness * ( clampResult4_g17 + _Offset ) );
			float clampResult14_g16 = clamp( ( 1.0 - temp_output_10_0_g16 ) , 0.0 , 1.0 );
			float clampResult15_g16 = clamp( ( 1.0 - ( distance( max( ( abs( ( ase_worldPos - temp_output_18_0_g16 ) ) - ( ( temp_output_19_0_g16 * float3( 2,2,2 ) ) * float3( 0.5,0.5,0.5 ) ) ) , float3( 0,0,0 ) ) , float3( 0,0,0 ) ) / _Falloff ) ) , 0.0 , 1.0 );
			float temp_output_155_0 = ( clampResult14_g16 * clampResult15_g16 );
			clip( ( ( tex2DNode160.a * _Color.a * i.vertexColor.a ) * lerp(( 1.0 - temp_output_155_0 ),temp_output_155_0,_InvertMask) ) - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16400
1927;57;1586;1005;285.1721;1631.354;1.34574;True;False
Node;AmplifyShaderEditor.Vector3Node;51;-246.2032,-974.3667;Float;False;Property;_SDFCenter;SDFCenter;5;0;Create;True;0;0;False;0;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;50;-252.3636,-823.6789;Float;False;Property;_SDFExtents;SDFExtents;4;0;Create;True;0;0;False;0;0,0,0;5,5,5;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TexturePropertyNode;6;-220.821,-1177.127;Float;True;Property;_Texture0;Texture 0;1;0;Create;True;0;0;False;0;None;9347007cf4259bd40a79044b49f5f7eb;False;white;LockedToTexture3D;Texture3D;0;1;SAMPLER3D;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-237.8524,-540.8162;Float;False;Property;_Sharpness;Sharpness;2;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-324.7277,-652.8872;Float;False;Property;_Offset;Offset;3;0;Create;True;0;0;False;0;0;-0.01;-0.01;0.01;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;105;-175.1704,-449.925;Float;False;Property;_Falloff;Falloff;6;0;Create;True;0;0;False;0;0.001;0.09;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;155;150.0257,-907.499;Float;False;SDFMask;-1;;16;7f48b3af2d1db7b44b993218bbe1dd86;0;6;17;SAMPLER3D;0;False;18;FLOAT3;0,0,0;False;19;FLOAT3;0,0,0;False;20;FLOAT;0;False;21;FLOAT;1;False;22;FLOAT;0.05;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;149;465.7201,-914.6823;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;160;190.4453,-1536.723;Float;True;Property;_Albedo;Albedo;7;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;161;273.8773,-1346.607;Float;False;Property;_Color;Color;8;0;Create;True;0;0;False;0;0,0,0,0;0.4258633,0.6226414,0.5677931,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;162;316.277,-1175.647;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;164;718.3913,-1107.255;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;166;711.5526,-783.1017;Float;False;Property;_InvertMask;InvertMask;9;0;Create;True;0;0;False;0;0;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;163;726.5987,-1319.255;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;165;945.4357,-959.541;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1216.872,-1212.53;Float;False;True;3;Float;ASEMaterialInspector;0;0;Standard;DM/SDFMask;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;155;17;6;0
WireConnection;155;18;51;0
WireConnection;155;19;50;0
WireConnection;155;20;30;0
WireConnection;155;21;21;0
WireConnection;155;22;105;0
WireConnection;149;0;155;0
WireConnection;164;0;160;4
WireConnection;164;1;161;4
WireConnection;164;2;162;4
WireConnection;166;0;149;0
WireConnection;166;1;155;0
WireConnection;163;0;160;0
WireConnection;163;1;161;0
WireConnection;163;2;162;0
WireConnection;165;0;164;0
WireConnection;165;1;166;0
WireConnection;0;0;163;0
WireConnection;0;10;165;0
ASEEND*/
//CHKSM=4EBB0133356C9E101CCB1D96E7B9B13D1021B492