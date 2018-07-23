Shader "Unlit/Radial Gradient"
{
    Properties
    {
        _ColorCount ("Number of Colors", float) = 2
        _CenterX ("Center X", float) = 0.5
        _CenterY ("Center Y", float) = 0.5
        _AspectX ("Aspect X", float) = 1
        _AspectY ("Aspect Y", float) = 1
        _TintColor ("Tint Color", Color) = (1, 1, 1, 1)
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
            float _AspectX;
            float _AspectY;
            fixed4 _TintColor;

            fixed4 frag (v2f i) : SV_Target
            {
                float2 uv = i.texcoord;
                float2 d = float2 ((_CenterX - uv.x) * _AspectX, (_CenterY - uv.y) * _AspectY);

                return sampleGradientColor (_GradientColors, _GradientPosition, _ColorCount, sqrt(d.x*d.x + d.y*d.y) * 2) * _TintColor;

                /*
                float2 uv = i.texcoord;
                float2 scale = float2 (unity_ObjectToWorld [0][0], unity_ObjectToWorld [1][1]);

                float2 d;

                if (scale.x == scale.y) {

                    d.x = (_CenterX - uv.x);
                    d.y = (_CenterY - uv.y);

                } else if (scale.x > scale.y) {

                    d.x = (_CenterX - uv.x) * scale.x / scale.y;
                    d.y = _CenterY - uv.y;

                } else {

                    d.x = (_CenterX - uv.x);
                    d.y = (_CenterY - uv.y) * scale.y / scale.x;
                }

                d *= float2 (_AspectX, _AspectY);

                return sampleGradientColor (_GradientColors, _GradientPosition, _ColorCount, sqrt(d.x*d.x + d.y*d.y) * 2) * _TintColor;*/
            }

            ENDCG
        }
    }

    CustomEditor "FD.Shaders.Editor.FDGradientLinearEditor"
}
