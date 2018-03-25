Shader "Hidden/Isaura/Isaura Effect"
{
    Properties
    {
        _MainTex("", 2D) = "" {}
        _AuraTex("", 2D) = "" {}
        _Color("", Color) = (1, 1, 1)
    }

    HLSLINCLUDE

    #include "PostProcessing/Shaders/StdLib.hlsl"

    TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);

    TEXTURE2D_SAMPLER2D(_AuraTex, sampler_AuraTex);
    float4 _AuraTex_TexelSize;

    half _Threshold;
    half _Thickness;
    half4 _Color;

    half Contour(float2 uv)
    {
        float4 duv = _AuraTex_TexelSize.xyxy * float4(1, 1, -1, 0) * _Thickness;

        half3x3 m = half3x3(
            SAMPLE_TEXTURE2D(_AuraTex, sampler_AuraTex, uv - duv.xy).r,
            SAMPLE_TEXTURE2D(_AuraTex, sampler_AuraTex, uv - duv.wy).r,
            SAMPLE_TEXTURE2D(_AuraTex, sampler_AuraTex, uv - duv.zy).r,
            SAMPLE_TEXTURE2D(_AuraTex, sampler_AuraTex, uv - duv.xw).r,
            SAMPLE_TEXTURE2D(_AuraTex, sampler_AuraTex, uv         ).r,
            SAMPLE_TEXTURE2D(_AuraTex, sampler_AuraTex, uv + duv.zw).r,
            SAMPLE_TEXTURE2D(_AuraTex, sampler_AuraTex, uv + duv.zy).r,
            SAMPLE_TEXTURE2D(_AuraTex, sampler_AuraTex, uv + duv.wy).r,
            SAMPLE_TEXTURE2D(_AuraTex, sampler_AuraTex, uv + duv.xy).r
        );

        m = m > _Threshold;

        half gx = m._11 + m._12 * 2 + m._13 - m._31 - m._32 * 2 - m._33;
        half gy = m._11 + m._21 * 2 + m._31 - m._13 - m._23 * 2 - m._33;

        return saturate(sqrt(gx * gx + gy * gy));
    }

    float4 Fragment(VaryingsDefault input) : SV_Target
    {
        float4 src = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, input.texcoord);
        return src + Contour(input.texcoord) * _Color;
    }

    ENDHLSL

    SubShader
    {
        Cull Off ZWrite Off ZTest Always
        Pass
        {
            HLSLPROGRAM
            #pragma vertex VertDefault
            #pragma fragment Fragment
            ENDHLSL
        }
    }
}
