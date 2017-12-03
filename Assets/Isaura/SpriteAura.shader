Shader "Isaura/Aura (Sprite)"
{
    Properties
    {
        _Exponent("Exponent", Range(0.01, 10)) = 1
    }
    SubShader
    {
        Pass
        {
            ZWrite Off ZTest Always Blend One One

            CGPROGRAM

            #pragma vertex Vertex
            #pragma fragment Fragment

            #include "UnityCG.cginc"

            half _Exponent;

            half2 Vertex(
                float4 position : POSITION,
                half2 texcoord : TEXCOORD,
                out float4 sv_position : SV_Position
            ) : TEXCOORD
            {
                sv_position = UnityObjectToClipPos(position);
                return texcoord;
            }

            half4 Fragment(half2 texcoord : TEXCOORD) : SV_Target
            {
                half l = length(texcoord.xyxy - 0.5) * 2;
                return pow(saturate(1 - l), _Exponent);
            }

            ENDCG
        }
    }
}
