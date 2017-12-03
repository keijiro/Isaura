Shader "Hidden/Isaura/Composite"
{
    Properties
    {
        _MainTex("", 2D) = "" {}
        _BufferTex("", 2D) = "" {}
    }
    SubShader
    {
        Cull Off ZWrite Off ZTest Always

        Pass
        {
            CGPROGRAM

            #pragma vertex vert_img
            #pragma fragment Fragment

            #include "UnityCG.cginc"

            sampler2D _MainTex;

            sampler2D _BufferTex;
            float4 _BufferTex_TexelSize;

            half Contour(float2 uv)
            {
                float4 duv = _BufferTex_TexelSize.xyxy * float4(1, 1, -1, 0);

                half s11 = tex2D(_BufferTex, uv - duv.xy).r;
                half s21 = tex2D(_BufferTex, uv - duv.wy).r;
                half s31 = tex2D(_BufferTex, uv - duv.zy).r;

                half s12 = tex2D(_BufferTex, uv - duv.xw).r;
                half s22 = tex2D(_BufferTex, uv         ).r;
                half s32 = tex2D(_BufferTex, uv + duv.zw).r;

                half s13 = tex2D(_BufferTex, uv + duv.zy).r;
                half s23 = tex2D(_BufferTex, uv + duv.wy).r;
                half s33 = tex2D(_BufferTex, uv + duv.xy).r;

                s11 = s11 > 0.5;
                s21 = s21 > 0.5;
                s31 = s31 > 0.5;

                s12 = s12 > 0.5;
                s22 = s22 > 0.5;
                s32 = s32 > 0.5;

                s13 = s13 > 0.5;
                s23 = s23 > 0.5;
                s33 = s33 > 0.5;

                half gx = s11 + s12 * 2 + s13 - s31 - s32 * 2 - s33;
                half gy = s11 + s21 * 2 + s31 - s13 - s23 * 2 - s33;

                return saturate(sqrt(gx * gx + gy * gy));
            }

            half4 Fragment(v2f_img input) : SV_Target
            {
                half4 s = tex2D(_MainTex, input.uv);
                return s + Contour(input.uv) * half4(2, 0.4, 0.4, 0);
            }

            ENDCG
        }
    }
}
