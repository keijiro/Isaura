Shader "Isaura/Marker"
{
    SubShader
    {
        Pass
        {
            ZWrite Off ZTest Always Blend One One

            CGPROGRAM

            #pragma vertex Vertex
            #pragma fragment Fragment

            #include "UnityCG.cginc"

            half Vertex(
                float4 position : POSITION,
                half3 normal : NORMAL,
                out float4 sv_position : SV_Position
            ) : COLOR
            {
                sv_position = UnityObjectToClipPos(position);
                return mul(UNITY_MATRIX_V, mul(unity_ObjectToWorld, normal)).z;
            }

            half4 Fragment(half color : COLOR) : SV_Target
            {
                return color;
            }

            ENDCG
        }
    }
}
