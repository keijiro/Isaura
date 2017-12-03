Shader "Isaura/Aura (Mesh)"
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

            half4 Vertex(
                float4 position : POSITION,
                half4 color : COLOR,
                out float4 sv_position : SV_Position
            ) : COLOR
            {
                sv_position = UnityObjectToClipPos(position);
                return color;
            }

            half4 Fragment(half4 color : COLOR) : SV_Target
            {
                return color;
            }

            ENDCG
        }
    }
}
