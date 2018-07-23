Shader "Unlit/Angle Gradient"
{
    Properties
    {
        _ColorCount ("Number of Colors", float) = 2
        _CenterX ("Center X", float) = 0.5
        _CenterY ("Center Y", float) = 0.5
        _TintColor ("Tint Color", Color) = (1, 1, 1, 1)
        _Aspect ("Aspect", float) = 1
        [KeywordEnum(Scale, UserSpecified)] _AspectMethod ("Aspect Method", int) = 0
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
            fixed4 _GradientColors[5];
            float _GradientPosition[5];
            float _CenterX;
            float _CenterY;
            fixed4 _TintColor;
            float _Aspect;
            int _AspectMethod;

            fixed4 frag (v2f i) : SV_Target
            {
                float2 uv = i.texcoord;
                float aspect = 1;

                if (_AspectMethod == 0) {

                    float2 scale = float2 (unity_ObjectToWorld [0][0], unity_ObjectToWorld [1][1]);
                    aspect = scale.x / scale.y;

                } else {

                    aspect = _Aspect;
                }

                float2 d = float2((_CenterX - uv.x) * aspect, _CenterY - uv.y);
                float angle = angleOf (d);

                return sampleGradientColor (_GradientColors, _GradientPosition, _ColorCount, angle * INVERSE_DOUBLE_PI) * _TintColor;
            }

            ENDCG
        }
    }

    CustomEditor "FD.Shaders.Editor.FDGradientLinearEditor"
}
