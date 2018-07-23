Shader "Unlit/Linear Gradient"
{
    Properties
    {
        _ColorCount ("Number of Colors", float) = 2
        _Angle ("Angle", float) = 0
        _TintColor ("Tint Color", Color) = (1, 1, 1, 1)
        [KeywordEnum(None, Fast, Accurate)] _AngleMethod ("Angle Method", int) = 0
    }
    SubShader
    {
        Tags { 

            "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"
        }

        Cull Off
        LOD 100

        ZWrite Off
        Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog
         
            #include "UnityCG.cginc"
            #include "cginc-gradient-helper.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 texcoord : TEXCOORD0;
            };

            struct v2f
            {
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
                float2 texcoord : TEXCOORD0;
            };
         
            v2f vert (appdata v)
            {
                v2f o;
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.texcoord = v.texcoord;
                return o;
            }

            float _ColorCount;
            float _Angle;
            fixed4 _GradientColors[5];
            float _GradientPosition[5];
            fixed4 _TintColor;
            int _AngleMethod;

            fixed4 frag (v2f i) : SV_Target
            {

                if (_AngleMethod == 0) { /* No angle-adjustment */
                    
                    return sampleGradientColor (_GradientColors, _GradientPosition, _ColorCount, rotateUV(i.texcoord, _Angle * DEGREE_2_RADIAN).y) * _TintColor;

                } else if (_AngleMethod == 1) { /* Fast angle-adjustment */

                    float2 scale = float2 (unity_ObjectToWorld [0][0], unity_ObjectToWorld [1][1]);
                    float2 uv;

                    if (scale.x == scale.y) {

                        uv = rotateUV(i.texcoord, _Angle * DEGREE_2_RADIAN);

                    } else if (scale.x < scale.y) {

                        uv = rotateUV(float2 (i.texcoord.x, (i.texcoord.y - 0.5) * scale.y / scale.x + 0.5), _Angle * DEGREE_2_RADIAN);

                    } else {

                        uv = rotateUV(float2 ((i.texcoord.x - 0.5) * scale.x / scale.y + 0.5, i.texcoord.y), _Angle * DEGREE_2_RADIAN);
                    }

                    return sampleGradientColor (_GradientColors, _GradientPosition, _ColorCount, uv.y) * _TintColor;

                } else {  /* Opimized angle-adjustment */

                    float2 scale = float2 (unity_ObjectToWorld [0][0], unity_ObjectToWorld [1][1]);

                    float adjustedAngle = atan(tan(_Angle * DEGREE_2_RADIAN) * scale.x / scale.y);
                    return sampleGradientColor (_GradientColors, _GradientPosition, _ColorCount, rotateUV(i.texcoord, adjustedAngle).y) * _TintColor;
                }
            }

            ENDCG
        }
    }

    CustomEditor "FD.Shaders.Editor.FDGradientLinearEditor"
}
