Shader "Hidden/Isaura/Update"
{
    Properties
    {
        _MainTex("", 2D) = "white" {}
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

            half4 Fragment(v2f_img input) : SV_Target
            {
                half4 s = tex2D(_MainTex, input.uv);
                return s * 0.93;
            }

            ENDCG
        }
    }
}
